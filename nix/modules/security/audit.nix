{ config, pkgs, ... }:
#
#   auditd is a kernel-level syscall logger. You define rules that say
#   "whenever any process calls syscall X on file Y, write a record".
#   Records go to /var/log/audit/audit.log and optionally to journald.
#   Just forensic
#
# What it catches?
#   - Who opened, modified, or deleted a sensitive file and when
#   - Privilege escalation attempts
#   - Failed authentication attempts at the kernel level
#   - Changes to user/group databases (as /etc/passwd)
#   - Loading and unloading of kernel modules
#
{
 environment.systemPackages = with pkgs; [
   audit
 ];

  security.audit = {
    enable = true;
    
    # When the audit log is full:
    # "SYSLOG"  = emit a syslog warning and keep running (better for our situation)
    # "SUSPEND" = stop logging, with the risk of a silent gap in the audit trail
    # "HALT"    = halt the system, high security
    failureMode = "SYSLOG";

    rules = [
      # User and group
      "-w /etc/passwd -p wa -k identity"
      "-w /etc/group -p wa -k identity"
      "-w /etc/shadow  -p wa -k identity"
      "-w /etc/gshadow -p wa -k identity"

      # SSH authorized keys
      "-w /root/.ssh              -p wa -k ssh_keys"
      # add your user's .ssh directory
      # "-w /home/admin/.ssh      -p wa -k ssh_keys"

      # Sudoers changes
      "-w /etc/sudoers -p wa -k sudoers"
      "-w /etc/sudoers.d/ -p wa -k sudoers"

      # NixOS system profile changes
      "-w /nix/var/nix/profiles/system -p wa -k nix_system_profile"

      # Cron jobs
      # "-w /etc/cron.d/ -p wa -k cron"
      # "-w /var/spool/cron/ -p wa -k cron"

      # Log all execve calls by root (every command root runs)
      # This can be very verbose on busy systems
      # "-a always,exit -F arch=b64 -F uid=0 -S execve -k root_commands"
      # "-a always,exit -F arch=b32 -F uid=0 -S execve -k root_commands"

      # Detect setuid/setgid calls (privilege escalation attempts)
      "-a always,exit -F arch=b64 -S setuid -S setgid -S setreuid -S setregid -k setuid_calls"
      "-a always,exit -F arch=b32 -S setuid -S setgid -S setreuid -S setregid -k setuid_calls"

      # Kernel module loading/unloading
      "-w /sbin/insmod -p x -k modules"
      "-w /sbin/rmmod -p x -k modules"
      "-w /sbin/modprobe -p x -k modules"
      "-a always,exit -F arch=b64 -S init_module -S delete_module -k modules"

      # Detect nftables rule changes
      "-w /sbin/nft -p x -k firewall"

      # Time changes
      "-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S clock_settime -k time_change"
      "-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S clock_settime -k time_change"
    ];
  };

  # auditd writes to /var/log/audit/audit.log by default.
  # Forward audit events to journald so they appear in journalctl too,
  # so they are rotated and managed with the rest of the journal.
  services.journald.audit = true;

  # ausearch and aureport: query audit log by key, user, time range, syscall.
  # Example: ausearch -k identity -i (show identity-tagged events, human-readable)
  # Example: aureport --auth (authentication summary report)
}
