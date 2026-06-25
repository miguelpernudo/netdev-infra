{ config, pkgs, lib, ...}:

{
  security.sudo.enable = lib.mkDefault false;
  
  security.doas = {
    enable = true;
    extraRules = [{
      groups = [ "wheel" ];
      persist = true;
      keepEnv = true;
    }];
  };

  #security.doas.extraConfig = ''
  #  # Rules if needed.
  #'';
  
  # 'sudo' = 'doas'
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "sudo" ''exec doas "$@"'')
  ];
}
