{ pkgs, ... }:
let
  flaresolverr-deploy-apply = pkgs.writeShellScriptBin "flaresolverr-deploy-apply" ''
    ${pkgs.k3s}/bin/k3s kubectl --validate=false apply -f /etc/k3s/deployments/flaresolverr.deployment.yaml
    ${pkgs.k3s}/bin/k3s kubectl --validate=false apply -f /etc/k3s/services/flaresolverr.service.yaml
  '';

  flaresolverr-deploy-delete = pkgs.writeShellScriptBin "flaresolverr-deploy-delete" ''
    ${pkgs.k3s}/bin/k3s kubectl delete -f /etc/k3s/deployments/flaresolverr.deployment.yaml
    ${pkgs.k3s}/bin/k3s kubectl delete -f /etc/k3s/services/flaresolverr.service.yaml
  '';
in
{

  networking.firewall.allowedTCPPorts = [ 30191 ];

  systemd.services.flaresolverr-depl = {
    description = "Deploy flaresolverr to k3s cluster";
    after = [ "network.target" ];
    wants = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${flaresolverr-deploy-apply}/bin/flaresolverr-deploy-apply";
      ExecStop = "${flaresolverr-deploy-delete}/bin/flaresolverr-deploy-delete";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
  };

  environment.etc = {
    "k3s/services/flaresolverr.service.yaml" = {
      enable = true;
      text = ''
        apiVersion: v1
        kind: Service
        metadata:
          name: flaresolverr-service
        spec:
          selector:
            app: flaresolverr
          ports:
            - protocol: TCP
              name: http
              port: 8191
              targetPort: 8191
              nodePort: 30191
          type: NodePort
      '';
    };

    "k3s/deployments/flaresolverr.deployment.yaml" = {
      enable = true;
      text = ''
        apiVersion: apps/v1
        kind: Deployment
        metadata:
          name: flaresolverr-depl
          labels:
            app: flaresolverr
        spec:
          replicas: 2
          selector:
            matchLabels:
              app: flaresolverr
          template:
            metadata:
              labels:
                app: flaresolverr
            spec:
              containers:
              - name: flaresolverr
                image: ghcr.io/flaresolverr/flaresolverr:latest
                ports:
                - containerPort: 8191
      '';
    };
  };
}
