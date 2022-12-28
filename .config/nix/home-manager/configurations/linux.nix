{pkgs, ...}: {
  home.username = "arichter";
  home.homeDirectory = "/home/arichter";

  imports = [
    ./modules/common.nix
  ];

  #-------------------------------------------------------------------------------------------------
  # gpg-agent
  #
  # Note: home-manager supports this service on Linux only at the moment.
  #-------------------------------------------------------------------------------------------------
  services.gpg-agent = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableSshSupport = true;
    enableZshIntegration = true;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    pinentryFlavor = "curses";

    # Note
    #
    # In programs.zsh, we set the "gpg-agent" oh-my-zsh plugin to be loaded. It will ensure that the
    # agent is running and focusing the correct terminal.
  };
}
