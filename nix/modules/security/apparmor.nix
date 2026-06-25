{ config, pkgs, ... }:
#
#   Third-party profiles often do not work because the /nix/store. 
#   Write or adapt profiles yourself for each service.
#
# Workflow:
#   1.- After nixos-rebuild, check dmesg or /var/log/audit/audit.log for DENIED lines.
#   2.- Use aa-logprof (from apparmor package) to generate profile rules from denials.
#   3.- Add the profile to extraProfiles below or to a separate file.
{
  security.apparmor = {
    enable = true;

    # Enabling this before you have the profiles for all your services
    # will break them. First set the profiles and then set it to true.
    ##killUnconfinedConfinables = false;

    # Load extra profiles from this map.
    # Key = profile name, value = profile text.
    # NixOS will translate to /nix/store paths
    ##packages = [ pkgs.apparmor-profiles ];

    ##policies = {
      # "example" = {
      #   profile = ''
      #     #include <tunables/global>
      #     profile example ${pkgs.example}/bin/example {
      #       #include <abstractions/base>
      #       /etc/example/** r,
      #       /var/lib/example/** rw,
      #       network inet stream,
      #       # Everything else is denied by default
      #     }
      #   '';
      # };
    ##};
  };

  # For developing and debugging profiles.
  # environment.systemPackages = with pkgs; [
  #  apparmor-utils
  #  apparmor-bin-utils
  # ];
}
