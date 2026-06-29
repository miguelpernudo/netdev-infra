{ config, pkgs, ... }:

{
  boot.loader = {
  
    systemd-boot = {
      enable = true;
      configurationLimit = 5; # Change it if you want. 
      editor = false; # Prevent kernel param editing at boot.
    };

    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd.systemd.enable = true;

  boot.kernelPackages = pkgs.linuxPackages;
 
  # Or boot.kernelPackages = pkgs.linux_(kernel_version)_hardened; 
  
  # Replace the default glibc allocator with a hardened one.
  environment.memoryAllocator.provider = "scudo";
  environment.variables.SCUDO_OPTIONS = "";        # Even if it's empty, must be defined.
  systemd.coredump.enable = false;

  security = {
    protectKernelImage = true;
    # forcePageTableIsolation = true;
    
    # Prevent privilege escalation via setuid binaries not explicitly listed.
    # Any suid binary not in the allowlist gets stripped of its suid bit.
    wrappers = {
      # NixOS adds ping, su, etc. by default. Add custom ones here if needed.
      # app = { source = "${pkgs.app}/bin/app"; owner = "admin"; group = "admin"; setuid = true; };
    };
  };

  boot.blacklistedKernelModules = [
    # Exclude kernel modules that you consider unnecessary and/or potentially insecure.
    
    # Audio.
    "soundcore" 
    "snd" 
    "snd_timer" 
    "snd_pcm" 
    "snd_hwdep"
    
    "snd_hda_intel" 
    "snd_hda_codec" 
    "snd_hda_core"
    "snd_hda_codec_generic" 
    "snd_hda_codec_realtek" 
    "snd_hda_codec_hdmi"
    "snd_intel_dspcfg"
    "snd_intel_sdw_acpi"
    "snd_hda_scodec_component"

    # Video.
    "i915"                
    "drm_display_helper"  
    "drm_buddy"           
    "ttm"                
    "intel_gtt"          
    "video"              
    "cec"                
    "mei_hdcp"           
    "mei_pxp"
  ];

  boot.kernelParams = [
    "strict_devmem=1"
  ];

  ### Sysctl
  boot.kernel.sysctl = {

    # Some debugging tools would break at level 2 so change it to 1 if needed.
    "kernel.kptr_restrict" = 2;

    # Prevents reading arbitrary kernel/physical memory.
    "kernel.perf_event_paranoid" = 3;

    # Hides kernel addresses and boot info from users.
    "kernel.dmesg_restrict" = 1;

    # Disable sysrq key combinations entirely.
    "kernel.sysrq" = 0;

    # Prevent unprivileged processes from tracing other processes with ptrace.
    # Set it to 2 if you're having trouble debugging.
    "kernel.yama.ptrace_scope" = 3;

    "kernel.unprivileged_bpf_disabled" = 1;

    # Harden the BPF JIT compiler against JIT spraying attacks.
    "net.core.bpf_jit_harden" = 2;

    # Prevent creating hard links to files you do not own.
    "fs.protected_hardlinks" = 1;

    # Prevent creating symlinks in sticky directories to files you do not own.
    "fs.protected_symlinks" = 1;

    # Restrict FIFO creation in sticky world-writable directories.
    "fs.protected_fifos" = 2;

    # Restrict regular file creation in sticky world-writable directories.
    "fs.protected_regular" = 2;

    ### Network

    # Reject packets claiming to come from loopback or broadcast addresses
    # on external interfaces.
    "net.ipv4.conf.all.rp_filter"     = 1;
    "net.ipv4.conf.default.rp_filter" = 1;

    # Ignore broadcast pings.
    "net.ipv4.icmp_echo_ignore_broadcasts" = 1;

    # Ignore bogus ICMP error responses.
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

    # Enable TCP SYN cookie protection against SYN flood attacks.
    "net.ipv4.tcp_syncookies" = 1;

    # Do not accept IPv6 router advertisements unless explicitly wanted.
    "net.ipv6.conf.all.accept_ra"     = 0;
    "net.ipv6.conf.default.accept_ra" = 0;

    # Log packets from impossible source addresses.
    "net.ipv4.conf.all.log_martians"      = 1;
    "net.ipv4.conf.default.log_martians"  = 1;

    
    "net.ipv4.conf.all.accept_redirects"      = 0;
    "net.ipv4.conf.default.accept_redirects"  = 0;
    "net.ipv4.conf.all.secure_redirects"      = 0;
    "net.ipv4.conf.default.secure_redirects"  = 0;
    "net.ipv6.conf.all.accept_redirects"      = 0;
    "net.ipv6.conf.default.accept_redirects"  = 0;
    "net.ipv4.conf.all.send_redirects"        = 0;
    "net.ipv4.conf.default.send_redirects"    = 0;
    "net.ipv4.ip_forward"                     = 1;
    "net.ipv6.conf.all.forwarding"            = 0;
  };
}
