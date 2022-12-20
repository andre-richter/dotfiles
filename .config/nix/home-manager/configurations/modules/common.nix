{pkgs, ...}:

let
  LS_COLORS = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    rev = "87e57851028f51304417143da54d8cc9a3b492f3";
    hash = "sha256-NLIu6VoQE8dHE0tinCuFbT8R2VLqIlHyRPTu6voHziw=";
  };
  ls-colors = pkgs.runCommand "ls-colors" { } ''
    mkdir -p $out/bin $out/share

    ln -s ${pkgs.coreutils}/bin/ls        $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors

    ${pkgs.coreutils}/bin/dircolors ${LS_COLORS}/LS_COLORS > $out/share/LS_COLORS
  '';
in {
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  #-------------------------------------------------------------------------------------------------
  # bat
  #-------------------------------------------------------------------------------------------------
  programs.bat = {
    enable = true;
    config = { theme = "Monokai Extended Bright"; };
  };

  #-------------------------------------------------------------------------------------------------
  # emacs
  #-------------------------------------------------------------------------------------------------
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
    extraConfig = builtins.readFile ./emacs/extra_config.el;
    extraPackages = epkgs : [
      epkgs.dts-mode
      epkgs.json-mode
      epkgs.lush-theme
      epkgs.markdown-mode
      epkgs.multiple-cursors
      epkgs.nix-mode
      epkgs.toml-mode
      epkgs.yaml-mode
    ];
  };

  #-------------------------------------------------------------------------------------------------
  # fzf
  #-------------------------------------------------------------------------------------------------
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
    enableZshIntegration = true;
  };

  #-------------------------------------------------------------------------------------------------
  # git
  #-------------------------------------------------------------------------------------------------
  programs.git = {
    enable = true;
    userName = "Andre Richter";
    userEmail = "andre.o.richter@gmail.com";
    signing = {
      key = "50E17457";
      signByDefault = false;
    };
    extraConfig = {
      push.default = "simple";
      core.editor = "emacs -nw";
    };
  };

  #-------------------------------------------------------------------------------------------------
  # gpg
  #-------------------------------------------------------------------------------------------------
  programs.gpg = {
    enable = true;
    mutableKeys = false;
    mutableTrust = false;
    publicKeys = [
      {
        source = ./gpg/andre_pub.key;
        trust = "ultimate";
      }
    ];
    settings = import ./gpg/settings.nix;
  };

  #-------------------------------------------------------------------------------------------------
  # starship
  #-------------------------------------------------------------------------------------------------
  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableIonIntegration = false;
    enableZshIntegration = true;
    settings = import ./starship/settings.nix;
  };

  #-------------------------------------------------------------------------------------------------
  # zsh
  #-------------------------------------------------------------------------------------------------
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "emacs";
    initExtra = builtins.readFile ./zsh/init_extra.zsh;
    shellAliases = import ./zsh/shell_aliases.nix;

    # FYI: oh-my-zsh modifies bindkeys so that CTRL+left/right moves the cursor to next word.
    #
    # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
    oh-my-zsh = {
      enable = true;
      plugins = [ "gpg-agent" ];
    };
  };

  #-------------------------------------------------------------------------------------------------
  # Other packages
  #-------------------------------------------------------------------------------------------------
  home.packages = [
    ls-colors
    pkgs.bottom          # binary name is "btm"
    pkgs.pinentry-curses
    pkgs.ripgrep
    pkgs.tig
  ];
}
