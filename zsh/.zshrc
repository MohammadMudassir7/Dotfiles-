# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme to powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  z
  zoxide
  fzf
  autojump
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Aliases
alias cd='z'
alias dh -f='du -h'
alias top='btop'
alias ls='lsd'
alias la='lsd -la'
alias ll='lsd -l'
alias l='lsd'
alias y='yazi'

# Environment settings for modern terminal apps
export TERM="xterm-kitty"
export EDITOR="nvim"
export VISUAL="nvim"

# FZF default options
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Enable auto-completion and key bindings
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

# For fzf key bindings and auto-completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Powerlevel10k instant prompt in quiet mode
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt.zsh" ]] && source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt.zsh"

# Modern settings for zsh
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt autocd
setopt extended_glob
setopt hist_ignore_dups
setopt share_history
setopt inc_append_history
setopt interactive_comments

# Use modern ls color scheme for lsd
export LSD_COLORS="di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33:cd=1;33:or=1;31"

# Tmux integration: adjust TERM if in tmux
if [[ -n "$TMUX" ]]; then
  export TERM=screen-256color
fi

# Custom prompt configuration for powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# End of .zshrc

