# Initialize Homebrew path
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
BREW_PREFIX=/opt/homebrew

# —————————————————————————————————
#   Basic Environment
# —————————————————————————————————

# Use modern Zsh completion system
autoload -Uz compinit
compinit -C

# Autosuggestions (gray inline suggestions from history) and Syntax Highlighting (color typed commands)
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Enable color in the terminal
autoload -U colors && colors

# History setup
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt INC_APPEND_HISTORY      # immediately append history
setopt SHARE_HISTORY           # share history across terminals
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# —————————————————————————————————
#   Prompt: Colors + Git Branch
# —————————————————————————————————

# Enable prompt substitution
setopt PROMPT_SUBST

# Function to get current Git branch (lightweight, built into git)
git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# SSH host color
if [[ -n "$SSH_TTY" ]]; then
  HOST_COLOR="%B%F{124}"   # bold red
else
  HOST_COLOR="%F{228}"     # yellow
fi

# Build a prompt with colors
PROMPT='%F{166}%n%f'                        # username in cyan
PROMPT+="%F{15}@%f"
PROMPT+="${HOST_COLOR}%m%f"                 # host
PROMPT+="%F{15} in %f"
PROMPT+='%F{71}%1~%f '
PROMPT+='$( git_branch_prompt )'            # git branch segment
PROMPT+=$'%F{228}%#%f '                     # prompt symbol (# or %)

# Helper for git branch prompt segment
git_branch_prompt() {
  branch=$(git_branch)
  if [[ -n $branch ]]; then
    echo "%F{15}on %f%F{153}[$branch]%f "
  fi
}

# —————————————————————————————————
#   Autocompletion Options (Built-In)
# —————————————————————————————————

# Smart completion settings
zstyle ':completion:*' menu select                        # show menu on tab
zstyle ':completion:*' select-prompt '%S>> %p <<<%s'      # nicer selection UI
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}     # colorize completions

# Tab complete files and directories
bindkey '^I' expand-or-complete

# —————————————————————————————————
#   Useful Shell Options
# —————————————————————————————————

setopt AUTO_CD               # just type dirname to cd
setopt AUTO_PUSHD            # pushd on each cd
setopt PUSHD_SILENT
setopt PUSHD_IGNORE_DUPS

# Lazy loading conda
conda() {
  unset -f conda
  source /Users/I589913/miniconda3/etc/profile.d/conda.sh
  conda "$@"
}

# Full load on shell start (uncomment if needed)
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/I589913/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/I589913/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/I589913/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/I589913/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<


# NVM (Node Version Manager) lazy load
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx
  source /opt/homebrew/opt/nvm/nvm.sh
  nvm "$@"
}
node() { nvm; node "$@" }
npm()  { nvm; npm "$@" }
npx()  { nvm; npx "$@" }

# Full load on shell start (uncomment if needed)
# export NVM_DIR="$HOME/.nvm"
#   [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#   [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
