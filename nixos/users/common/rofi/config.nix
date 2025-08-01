{ ... }:
{
  home.file = {
    ".config/rofi/colors.rasi" = {
      enable = true;
      text = ''
        @import "~/.config/rofi/colors/dracula.rasi"
      '';
    };
    ".config/rofi/fonts.rasi" = {
      enable = true;
      text = ''
        * {
            font: "IosevkaTerm Nerd Font 18";
          }
      '';
    };
    ".config/rofi/theme.rasi" = {
      enable = true;
      text = ''
        configuration {
        	modi:                       "drun,run,filebrowser,window";
            show-icons:                 true;
            display-drun:               "  Apps";
            display-run:                "  Run";
            display-filebrowser:        "  Files";
            display-window:             "  Windows";
        	drun-display-format:        "{name}";
        	window-format:              "{w} · {c} · {t}";
        }

        @import                          "colors.rasi"
        @import                          "fonts.rasi"

        * {
            border-colour:               var(selected);
            handle-colour:               var(selected);
            background-colour:           var(background);
            foreground-colour:           var(foreground);
            alternate-background:        var(background-alt);
            normal-background:           var(background);
            normal-foreground:           var(foreground);
            urgent-background:           var(urgent);
            urgent-foreground:           var(background);
            active-background:           var(active);
            active-foreground:           var(background);
            selected-normal-background:  var(selected);
            selected-normal-foreground:  var(background);
            selected-urgent-background:  var(active);
            selected-urgent-foreground:  var(background);
            selected-active-background:  var(urgent);
            selected-active-foreground:  var(background);
            alternate-normal-background: var(background);
            alternate-normal-foreground: var(foreground);
            alternate-urgent-background: var(urgent);
            alternate-urgent-foreground: var(background);
            alternate-active-background: var(active);
            alternate-active-foreground: var(background);
        }

        window {
            transparency:                "real";
            location:                    center;
            anchor:                      center;
            fullscreen:                  false;
            width:                       800px;
            x-offset:                    0px;
            y-offset:                    0px;
            enabled:                     true;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               10px;
            border-color:                @border-colour;
            cursor:                      "default";
            background-color:            @background-colour;
        }

        mainbox {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     20px;
            border:                      0px solid;
            border-radius:               0px 0px 0px 0px;
            border-color:                @border-colour;
            background-color:            transparent;
            children:                    [ "inputbar", "mode-switcher", "message", "listview" ];
        }

        inputbar {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
            children:                    [ "textbox-prompt-colon", "entry" ];
        }

        prompt {
            enabled:                     true;
            background-color:            inherit;
            text-color:                  inherit;
        }

        textbox-prompt-colon {
            enabled:                     true;
            padding:                     5px 0px;
            expand:                      false;
            str:                         "";
            background-color:            inherit;
            text-color:                  inherit;
        }

        entry {
            enabled:                     true;
            padding:                     5px 20px;
            background-color:            inherit;
            text-color:                  inherit;
            cursor:                      text;
            placeholder:                 "Search...";
            placeholder-color:           inherit;
        }

        num-filtered-rows {
            enabled:                     true;
            expand:                      false;
            background-color:            inherit;
            text-color:                  inherit;
        }

        textbox-num-sep {
            enabled:                     true;
            expand:                      false;
            str:                         "/";
            background-color:            inherit;
            text-color:                  inherit;
        }

        num-rows {
            enabled:                     true;
            expand:                      false;
            background-color:            inherit;
            text-color:                  inherit;
        }

        case-indicator {
            enabled:                     true;
            background-color:            inherit;
            text-color:                  inherit;
        }

        listview {
            enabled:                     true;
            columns:                     1;
            lines:                       8;
            cycle:                       true;
            dynamic:                     true;
            scrollbar:                   false;
            layout:                      vertical;
            reverse:                     false;
            fixed-height:                true;
            fixed-columns:               true;
    
            spacing:                     5px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
            cursor:                      "default";
        }
        scrollbar {
            handle-width:                5px ;
            handle-color:                @handle-colour;
            border-radius:               10px;
            background-color:            @alternate-background;
        }

        element {
            enabled:                     true;
            spacing:                     10px;
            margin:                      0px;
            padding:                     10px;
            border:                      0px solid;
            border-radius:               8px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
            cursor:                      pointer;
        }

        element normal.normal {
            background-color:            var(normal-background);
            text-color:                  var(normal-foreground);
        }

        element normal.urgent {
            background-color:            var(urgent-background);
            text-color:                  var(urgent-foreground);
        }

        element normal.active {
            background-color:            var(active-background);
            text-color:                  var(active-foreground);
        }

        element selected.normal {
            background-color:            var(selected-normal-background);
            text-color:                  var(selected-normal-foreground);
        }

        element selected.urgent {
            background-color:            var(selected-urgent-background);
            text-color:                  var(selected-urgent-foreground);
        }

        element selected.active {
            background-color:            var(selected-active-background);
            text-color:                  var(selected-active-foreground);
        }

        element alternate.normal {
            background-color:            var(alternate-normal-background);
            text-color:                  var(alternate-normal-foreground);
        }

        element alternate.urgent {
            background-color:            var(alternate-urgent-background);
            text-color:                  var(alternate-urgent-foreground);
        }

        element alternate.active {
            background-color:            var(alternate-active-background);
            text-color:                  var(alternate-active-foreground);
        }

        element-icon {
            background-color:            transparent;
            text-color:                  inherit;
            size:                        34px;
            cursor:                      inherit;
        }

        element-text {
            background-color:            transparent;
            text-color:                  inherit;
            highlight:                   inherit;
            cursor:                      inherit;
            vertical-align:              0.5;
            horizontal-align:            0.0;
        }

        mode-switcher{
            enabled:                     true;
            expand:                      false;
            spacing:                     10px;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
        }
        button {
            padding:                     12px;
            border:                      0px solid;
            border-radius:               8px;
            border-color:                @border-colour;
            background-color:            @alternate-background;
            text-color:                  inherit;
            cursor:                      pointer;
        }
        button selected {
            background-color:            var(selected-normal-background);
            text-color:                  var(selected-normal-foreground);
        }

        message {
            enabled:                     true;
            margin:                      0px;
            padding:                     0px;
            border:                      0px solid;
            border-radius:               0px 0px 0px 0px;
            border-color:                @border-colour;
            background-color:            transparent;
            text-color:                  @foreground-colour;
        }

        textbox {
            padding:                     12px;
            border:                      0px solid;
            border-radius:               8px;
            border-color:                @border-colour;
            background-color:            @alternate-background;
            text-color:                  @foreground-colour;
            vertical-align:              0.5;
            horizontal-align:            0.0;
            highlight:                   none;
            placeholder-color:           @foreground-colour;
            blink:                       true;
            markup:                      true;
        }

        error-message {
            padding:                     0px;
            border:                      2px solid;
            border-radius:               8px;
            border-color:                @border-colour;
            background-color:            @background-colour;
            text-color:                  @foreground-colour;
        }
      '';
    };
    ".config/rofi/config.rasi" = {
      enable = true;
      text = ''
        configuration {
        	modi: "drun,run,filebrowser,window";
        	case-sensitive: false;
        	cycle: true;
        	filter: "";
        	scroll-method: 0;
        	normalize-match: true;
        	show-icons: true;
        	icon-theme: "Papirus";
        	steal-focus: false;
        	matching: "normal";
        	tokenize: true;
        	ssh-client: "ssh";
        	ssh-command: "{terminal} -e {ssh-client} {host} [-p {port}]";
        	parse-hosts: true;
        	parse-known-hosts: true;
        	drun-categories: "";
        	drun-match-fields: "name,generic,exec,categories,keywords";
        	drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
        	drun-show-actions: false;
        	drun-url-launcher: "xdg-open";
        	drun-use-desktop-cache: false;
        	drun-reload-desktop-cache: false;
        	drun {
        		parse-user:   true;
        		parse-system: true;
          }

        	run-command: "{cmd}";
        	run-list-command: "";
        	run-shell-command: "{terminal} -e {cmd}";

        	run,drun {
        		fallback-icon: "application-x-addon";
        	}

        	window-match-fields: "title,class,role,name,desktop";
        	window-command: "wmctrl -i -R {window}";
        	window-format: "{w} - {c} - {t:0}";
        	window-thumbnail: false;
        	disable-history: false;
        	sorting-method: "normal";
        	max-history-size: 25;
        	display-window: "Windows";
        	display-windowcd: "Window CD";
        	display-run: "Run";
        	display-ssh: "SSH";
        	display-drun: "Apps";
        	display-combi: "Combi";
        	display-keys: "Keys";
        	display-filebrowser: "Files";
        	terminal: "alacritty";
        	font: "IosevkaTerm Nerd Font 18";
        	sort: false;
        	threads: 0;
        	click-to-exit: true;
          filebrowser {
            directory: "~";
            directories-first: true;
            sorting-method:    "name";
          }
          timeout {
            action: "kb-cancel";
            delay:  0;
          }
          kb-mode-complete:               "";
          kb-row-up:                      "Up,Control+k";
          kb-row-down:                    "Down,Control+j";
          kb-accept-entry:                "Control+m,Return,KP_Enter";
          kb-remove-to-eol:               "Control+Shift+e";
          kb-mode-next:                   "Control+l";
          kb-mode-previous:               "Control+h";
          kb-remove-char-back:            "BackSpace";
        }
        @import                           "theme.rasi"
      '';
    };
  };
}
