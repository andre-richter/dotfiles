# This enables maintaining a Rust installation outside of nix/home-manager through a classic rustup
# install.
#
# Note: Ensure to do a customized install and deselect PATH setting. Otherwise, rustup tries to
# modify .zshenv and fails due to permissions.
. "$HOME/.cargo/env"
