# Color scheme for ls and others
source $HOME/.nix-profile/share/LS_COLORS

# Make autocompletion use LS_COLORS as well
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Make autocompletion work for ..<TAB>
zstyle ':completion:*' special-dirs true

# Syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout

ZSH_HIGHLIGHT_STYLES[path]=fg=white

ZSH_HIGHLIGHT_STYLES[alias]=fg=221,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=221,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=221,bold

ZSH_HIGHLIGHT_STYLES[function]=fg=213,bold

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=75,bold
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=75,bold

ZSH_HIGHLIGHT_STYLES[comment]=fg=36

ZSH_HIGHLIGHT_STYLES[globbing]=fg=208

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=70
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=70

# Keybindings
bindkey '^H' backward-kill-word # CTRL+Backspace

# GPG helpers
function gpg-focus() {
   pkill pinentry-curses
   _gpg-agent_update-tty_preexec # Provided by the gpg-agent oh-my-zsh plugin
}

function gpg-reset() {
   gpgconf --kill gpg-agent
   gpg-focus
}

# Use alt-e or esc-e to tab-select through the output of a previous command.
#
# Use-case: ls or find was the previous command, and you now want to edit one of them.
#
# Source: https://www.zsh.org/mla/users/2004/msg00893.html
_jh-prev-result () {
    hstring=$(eval `fc -l -n -1`)
    set -A hlist ${(@s/
/)hstring}
    compadd - ${hlist}
}
zle -C jh-prev-comp menu-complete _jh-prev-result
bindkey '\ee' jh-prev-comp
