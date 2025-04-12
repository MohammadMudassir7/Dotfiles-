#   Core Environment & Performance Settings
# -------------------------------------------------------------------------
export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export BACKGROUND="dark"  # Preference for dark mode

#   Productivity Aliases & Functions
# -------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'
alias ll='lsd -la'
alias la='lsd -A'
alias lh='lsd -lah'
alias lt='lsd -lat'
alias ltr='lsd -latr'
alias ls="lsd"
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias n='nvim'
alias vim='nvim'
alias e='$EDITOR'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias y='yazi'
alias k='kitty'
alias path='echo -e ${PATH//:/\\n}'
alias ports='netstat -tulanp'
alias df='duf --only local'
alias dfa='duf --all'
alias du='du -h'
alias free='free -m'
alias meminfo='free -m -l -t'
alias cpuinfo='lscpu'
alias ip='ip -c'
alias ps\?='ps aux | grep'
alias zshrc='$EDITOR ~/.zshrc'
alias vimrc='$EDITOR ~/.config/nvim/init.vim'
alias tmuxconf='$EDITOR ~/.tmux.conf'
alias gitconf='$EDITOR ~/.gitconfig'
alias update='sudo apt update'
alias upgrade='sudo apt full-upgrade -y && sudo apt autoremove -y'
alias cat='batcat'
alias top='btop'
alias zen='flatpak run app.zen_browser.zen'
alias installed='sudo apt list --installed'
mkcd() {
  mkdir -p "$1" && cd "$1"
}

#   Terminal Title & Window Management
# -------------------------------------------------------------------------
set_title() {
  echo -ne "\033]0;${PWD/#$HOME/~}\007"
}
precmd_functions+=(set_title)

#   Kitty Terminal Integration (if running in kitty)
# -------------------------------------------------------------------------
if [ -n "$KITTY_WINDOW_ID" ]; then
    alias kitty_ls='kitty @ lsd'
    alias kitty_focus='kitty @ focus-window'
fi

#   Session Management Functions
# -------------------------------------------------------------------------
save_session() {
  pwd > ~/.zsh_session
  history -n -r -100 >> ~/.zsh_session
  echo "Session saved."
}
restore_session() {
  if [[ -f ~/.zsh_session ]]; then
    cd "$(head -n 1 ~/.zsh_session)"
    echo "Session restored to $(pwd)"
  fi
}

#   Development Environment & Language Support
# -------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use
node_init() {
  unfunction node npm yarn pnpm
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
}
node() { node_init; node "$@"; }
npm() { node_init; npm "$@"; }
yarn() { node_init; yarn "$@"; }
pnpm() { node_init; pnpm "$@"; }
if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  if command -v pyenv-virtualenv-init &> /dev/null; then 
    eval "$(pyenv virtualenv-init -)"
  fi
fi
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Enable Powerlevel10k instant prompt. Initialization code that may require
# console input must go above this block.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
# **** SOURCE ZINIT SCRIPT HERE ****
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k 
zinit ice deapth=1; zinit light romkatv/Powerlevel10k 

# Add in zsh plugins 
zinit light zsh-users/zsh-syntax-highlighting 
zinit light zsh-users/zsh-completions  
zinit light zsh-users/zsh-autosuggestions 
zinit light Aloxaf/fzf-tab 

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo 
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found 

# Load completions
autoload -U compinit && compinit
zinit cdreplay -q 

# To customize prompt, run p10k configure or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh 

# Keybinding 
bindkey -e 
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history 
SAVEHIST=$HISTSIZE
HISTDUP=erase 
setopt appendhistory 
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups 
setopt hist_save_no_dups 
setopt hist_ignore_dups 
setopt hist_find_no_dups 

# Completion styling 
zstyle ':completion:' matcher-list  'm:{a-z}={A-Za-z}'
zstyle ':completion:' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:' menu no 
zstyle ':fzf-tab:complete:cd:' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell Integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
[[ -f ~/.zshrc.kitty ]] && source ~/.zshrc.kitty

#   Docker Shortcuts
# -------------------------------------------------------------------------
alias dps='docker ps'
alias dimg='docker images'
alias drun='docker run'
alias dexec='docker exec -it'
alias dlogs='docker logs'
alias dcomp='docker-compose'
alias dstart='docker start'
alias dstop='docker stop'

#   Git Shortcuts (cleanly aligned for easy editing)
# -------------------------------------------------------------------------
alias gs='git status'      # Show status
alias ga='git add'         # Add changes
alias gc='git commit'      # Commit changes
alias gp='git push'        # Push changes
alias gl='git pull'        # Pull changes
alias gd='git diff'        # Show diff
alias gb='git branch'      # List branches
alias gco='git checkout'   # Checkout branch
alias gm='git merge'       # Merge branch
alias gr='git rebase'      # Rebase branch
alias gcl='git clone'      # Clone repository

# -----Yazi Setup ------
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  local cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
