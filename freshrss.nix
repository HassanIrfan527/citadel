{ config, pkgs, ... }:

{
  # Enable Podman backend
  virtualisation = {
    oci-containers = {
      backend = "podman";
      containers = {
        freshrss = {
          image = "freshrss/freshrss:latest";
          autoStart = true;
          ports = [
            "127.0.0.1:8080:80" # Strictly bound to localhost (safe & uncompromised)
          ];
          environment = {
            TZ = "Asia/Karachi";
            CRON_MIN = "1,31";
          };
          volumes = [
            "/var/lib/freshrss/data:/var/www/FreshRSS/data:Z"
            "/var/lib/freshrss/extensions:/var/www/FreshRSS/extensions:Z"
          ];
        };
      };
    };
  };

  # Ensure the data storage directories exist
  systemd.tmpfiles.rules = [
    "d /var/lib/freshrss/data 0755 root root -"
    "d /var/lib/freshrss/extensions 0755 root root -"
  ];
}
