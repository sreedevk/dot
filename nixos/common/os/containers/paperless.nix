{ pkgs
, opts
, config
, ...
}:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports;
    [
      paperless-app
      paperless-db
      paperless-redis
    ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.documents}/consume 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.documents}/export  0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.documents}/data    0755    ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.documents}/media   0755   ${opts.adminUID} ${opts.adminGID} -"

    # PAPERLESS GPT
    "d ${opts.paths.documents}/gpt_hocr                  0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.documents}/gpt_pdf                   0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/paperless_gpt         0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/paperless_gpt/prompts 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    paperless-app = {
      autoStart = true;
      image = "paperless-ngx/paperless-ngx:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      dependsOn = [
        "paperless-db"
        "paperless-redis"
      ];
      volumes = [
        "${opts.paths.documents}/consume:/usr/src/paperless/consume"
        "${opts.paths.documents}/export:/usr/src/paperless/export"
        "${opts.paths.documents}/data:/usr/src/paperless/data"
        "${opts.paths.documents}/media:/usr/src/paperless/media"
      ];
      ports = [ "${opts.ports.paperless-app}:8000" ];
      environmentFiles = [ config.age.secrets.paperless_env.path ];
      environment = {
        PAPERLESS_REDIS = "redis://${opts.hostname}:${opts.ports.paperless-redis}";
        PAPERLESS_DBENGINE = "mariadb";
        PAPERLESS_DBHOST = "${opts.hostname}";
        PAPERLESS_DBUSER = "paperless";
        PAPERLESS_TIME_ZONE = opts.timeZone;
        PAPERLESS_OCR_LANGUAGE = "eng";
        PAPERLESS_DBPORT = opts.ports.paperless-db;
        PAPERLESS_URL = "https://docs.nullptr.sh";
        USERMAP_UID = opts.adminUID;
        USERMAP_GID = opts.adminGID;
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    paperless-db = {
      autoStart = true;
      image = "docker.io/library/mariadb:11";
      volumes = [ "paperless_db:/var/lib/mysql" ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      ports = [ "${opts.ports.paperless-db}:3306" ];
      environmentFiles = [ config.age.secrets.paperless_env.path ];
      environment = {
        MARIADB_HOST = "${opts.hostname}";
        MARIADB_DATABASE = "paperless";
        MARIADB_USER = "paperless";
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    paperless-gpt = {
      autoStart = opts.autostart-non-essential-services;
      image = "icereed/paperless-gpt:latest";
      environmentFiles = [ config.age.secrets.paperless_gpt_env.path ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      dependsOn = [
        "ollama"
        "paperless-app"
      ];
      ports = [
        "${opts.ports.paperless-gpt}:8080"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/paperless_gpt/prompts:/app/prompts"
        "${opts.paths.documents}/gpt_hocr:/app/hocr"
        "${opts.paths.documents}/gpt_pdf:/app/pdf"
      ];
      environment = {
        AUTO_OCR_TAG = "paperless-gpt-ocr-auto";
        AUTO_TAG = "paperless-gpt-auto";
        CREATE_LOCAL_HOCR = "true";
        CREATE_LOCAL_PDF = "true";
        LLM_LANGUAGE = "English";
        LLM_MODEL = "qwen3:8b";
        LLM_PROVIDER = "ollama";
        LOCAL_HOCR_PATH = "/app/hocr";
        LOCAL_PDF_PATH = "/app/pdf";
        MANUAL_TAG = "paperless-gpt";
        OCR_PROCESS_MODE = "image"; # image / pdf / whole_pdf
        OCR_PROVIDER = "llm";
        OLLAMA_HOST = "http://${opts.lanAddress}:${opts.ports.ollama-api}";
        PAPERLESS_BASE_URL = "http://${opts.lanAddress}:${opts.ports.paperless-app}";
        PAPERLESS_PUBLIC_URL = "https://docs.nullptr.sh";
        PDF_COPY_METADATA = "true";
        PDF_OCR_COMPLETE_TAG = "paperless-gpt-ocr-complete";
        PDF_OCR_TAGGING = "true";
        PDF_REPLACE = "false";
        PDF_SKIP_EXISTING_OCR = "true";
        PDF_UPLOAD = "true";
        TOKEN_LIMIT = "1000";
        VISION_LLM_MODEL = "minicpm-v";
        VISION_LLM_PROVIDER = "ollama";
      };
    };

    paperless-redis = {
      autoStart = true;
      image = "docker.io/library/redis:7";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      ports = [ "${opts.ports.paperless-redis}:6379" ];
      volumes = [
        "paperless_redis:/data"
      ];
    };
  };
}
