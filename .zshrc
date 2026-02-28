export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="af-magic"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="dd/mm/yyyy"

plugins=(git zsh-autosuggestions zsh-interactive-cd zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
export PATH="/home/winter/.config/emacs/bin:$PATH"

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='hx'
fi

export ARCHFLAGS="-arch $(uname -m)"

alias n='nvim'
alias h='helix'
alias pi='doas xbps-install'
alias su='doas xpbs-íntall -Su'
alias pr='doas xbps-remove'
alias cd='z'
export PATH="$PATH:/home/winter/.spicetify-cli"
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only

# Created by `pipx` on 2026-01-03 06:42:11
export PATH="$PATH:/home/winter/.local/bin"
export PATH="$PATH:/usr/lib/node_modules/prettier"
export PATH="$PATH:/home/winter/.nvm/versions/node/v25.6.1/bin/npm"

export PATH="$PATH:/home/winter/.local/share/bob/nightly/bin/"
#export PATH="$PATH:/home/winter/.local/share/bob/v0.11.6/bin/"
export PATH="$PATH:/home/winter/.cargo/bin"
export PATH="$PATH:/home/winter/ani-cli/"
export PATH="$PATH:/home/winter/.local/bin/statusbar"
export MANPAGER="bat -plman"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


ZSH_HIGHLIGHT_STYLES[default]='fg=#FFFFFF,bg=none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF5555,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#FF79C6,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#50FA7B,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#8BE9FD,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=#BD93F9'
ZSH_HIGHLIGHT_STYLES[command]='fg=#3BFF45,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#FFB86C'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#FFFFFF,bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[path]='fg=#00FFFF,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#00FFFF'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#FFB86C'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#FF5555,bold'

# -----------------------------
# Parameters & Variables
# -----------------------------
ZSH_HIGHLIGHT_STYLES[assign]='fg=#FFFFFF'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[parameter]='fg=#FFFF00'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#BD93F9'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#00FFFF'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#00FFFF'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#00FFFF'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#00FFFF'

# -----------------------------
# Numbers
# -----------------------------
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#FFB86C'
ZSH_HIGHLIGHT_STYLES[argument]='fg=#FFFFFF'

# -----------------------------
# Errors
# -----------------------------
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ADAAAA,bold'
ZSH_HIGHLIGHT_STYLES[command-not-found]='fg=#ADAAAA,bold'
ZSH_HIGHLIGHT_STYLES[error]='fg=#ADAAAA,bold'

# -----------------------------
# Brackets & Patterns
# -----------------------------
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#8BE9FD'

# -----------------------------
# Specials
# -----------------------------
ZSH_HIGHLIGHT_STYLES[comment]='fg=#6272A4,italic'
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#BD93F9'
ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=#BD93F9'
ZSH_HIGHLIGHT_STYLES[math-expression]='fg=#FFB86C'

vterm_printf() {
    if [ -n "$TMUX" ] \
        && { [ "${TERM%%-*}" = "tmux" ] \
            || [ "${TERM%%-*}" = "screen" ]; }; then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}


eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.omp.toml)"
eval "$(zoxide init zsh)"
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
