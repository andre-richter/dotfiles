# dotfiles

Built around `nix` and its `home-manager` using `flakes`.

The git repository is managed according to [this guide], but important steps are outlined below.

[this guide]: https://www.atlassian.com/git/tutorials/dotfiles

## Prerequisites

1. Nix package manager installed.
1. [SauceCodePro Regular] nerdfont is installed system-wide. Needed for glyphs in [starship].

[SauceCodePro Regular]: https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf
[starship]: https://www.starship.rs

### macOS

1. iTerm2 settings:
    1. Profiles -> Colors:
        1. Background: #232323
        1. Deactivate `Bold`
        1. Deactivate `Brighten bold text`
    1. Profiles -> Text: SauceCodePro; Size 15
    1. Keys -> Key Bindings: CTRL+Backspace sends `^H`. If not set, zsh can't capture it for
       deleting words.
1. System Settings:
   1. Allgemein -> Teilen -> Entfernte Anmeldung (ssh)

### Ubuntu

1. Terminal
    1. Set font to SauceCodePro; Size 12
    1. Select `GNOME Dark` as profile and change background to #232323

## Setting the repository up on a fresh system

First, open a shell, set the following alias, clone and checkout the repo:

```bash
alias git-dotfiles='git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME'
git clone --bare https://github.com/andre-richter/dotfiles.git $HOME/repos/dotfiles
git-dotfiles checkout
git-dotfiles config --local status.showUntrackedFiles no
```

If the above step fails because there is a clash with already existing files in `$HOME`, it is
ideally possible to delete the existing files to resolve the situation.

From now on, if anything changes in `$HOME` that should be picked up by version control, just use
the `git-dotfiles` alias instead of `git`:

```bash
git-dotfiles add XYZ
git-dotfiles commit
...
```

### Restart the daemon

Needed because `flakes` are activated through `.config/nix/nix.conf` which has just been checked
out. Not entirely if this is really needed...

```bash
# macOS
sudo launchctl stop org.nixos.nix-daemon
sudo launchctl start org.nixos.nix-daemon

# Ubuntu
sudo systemctl restart nix-daemon
```

## First install

```bash
# macOS
nix run .config/nix/home-manager switch -- --flake .config/nix/home-manager#mac

# Ubuntu
nix run .config/nix/home-manager switch -- --flake .config/nix/home-manager#linux
```

The value after the `#` must match one of the `homeConfigurations` declared in
`.config/nix/home-manager/flake.nix`.

### Switch login shell to nix-provided zsh

Manual steps are needed to make the OS use the nix-provided zsh binary.

```bash
sudo bash -c "echo $HOME/.nix-profile/bin/zsh >> /etc/shells"
chsh -s $HOME/.nix-profile/bin/zsh
```

Now log out of your OS and login again. Make a quick sanity check that the running ZSH is in fact the one from nix:

```bash
echo $SHELL
```

## Switching after home-manager has been installed

From now on, whenever something in the home-manager scripts changed, the following command will work:

```bash
home-manager switch --flake ~/.config/nix/home-manager#mac

home-manager switch --flake ~/.config/nix/home-manager#linux
```

Sometimes, you will need to restart your shell for changes to become effective.

## Resources

- https://www.chrisportela.com/posts/home-manager-flake/
- https://www.bekk.christmas/post/2021/16/dotfiles-with-nix-and-home-manager
- https://www.atlassian.com/git/tutorials/dotfiles
- https://github.com/nix-community/home-manager/blob/master/templates/standalone/flake.nix
- https://github.com/burke/b
