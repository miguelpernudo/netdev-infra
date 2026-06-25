{ config, pkgs, ... }:

{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3001;
        domain    = "grafana.CHANGE_YOUR_DOMAIN";
      };
      security = {
        admin_user               = "admin";
        admin_password           = "$__file{${config.sops.secrets.grafana_password.path}}";
        disable_gravatar         = true;
        cookie_secure            = true;
      };
      analytics.reporting_enabled = false;
    };

    provision.datasources.settings.datasources = [{
      name      = "Prometheus";
      type      = "prometheus";
      url       = "http://localhost:${toString config.services.prometheus.port}";
      isDefault = true;
    }];
  };

  services.prometheus = {
    enable = true;
    port   = 9090;

    scrapeConfigs = [
      {
        job_name  = "node";
        static_configs = [{
          targets = [ "localhost:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
    ];

    exporters.node = {
      enable          = true;
      port            = 9100;
      enabledCollectors = [
        "cpu" "diskstats" "filesystem"
        "loadavg" "meminfo" "netdev"
        "systemd" "thermal_zone"
      ];
    };
  };

  services.traefik.dynamicConfigOptions.http = {
    routers.grafana = {
      rule             = "Host(`grafana.CHANGE_YOUR_DOMAIN`)";
      service          = "grafana";
      tls.certResolver = "letsencrypt";
    };
    services.grafana.loadBalancer.servers = [
      { url = "http://127.0.0.1:3001"; }
    ];
  };

  sops.secrets.grafana_password = {};
}
