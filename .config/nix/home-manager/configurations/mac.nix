{pkgs, ...}: {
  home.username = "andre";
  home.homeDirectory = "/Users/andre";

  imports = [
    ./modules/common.nix
  ];

  #-------------------------------------------------------------------------------------------------
  # gpg-agent
  #
  # Notes
  #
  # - home-manager supports "services.gpg-agent" on Linux only at the moment. So this needs be
  #   written manually.
  # - In programs.zsh, we set the "gpg-agent" oh-my-zsh plugin to be loaded. It will ensure that the
  #   agent is running and focusing the correct terminal.
  #-------------------------------------------------------------------------------------------------
  home.file.".gnupg/gpg-agent.conf".text = ''
    enable-ssh-support
    grab
    default-cache-ttl 60
    max-cache-ttl 120
    pinentry-program ${pkgs.pinentry-curses}/bin/pinentry-curses
  '';

  # Workaround for https://github.com/NixOS/nixpkgs/issues/155629#issuecomment-1017832958
  programs.gpg.scdaemonSettings = { disable-ccid = true; };
}
