# Path to your oh-my-bash installation.
export OSH=$HOME/.oh-my-bash

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
#OSH_THEME="brainy"
OSH_THEME="agnoster"
#OSH_THEME="powerline"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
  kubectl
  makefile
  pip
  pip3
  terraform
  system
  git_flow
  git_flow_avh
  awscli
  conda
  docker
  docker-compose
  todo
  npm
  nvm
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  misc
  chmod
  general
  terraform
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  aws
  ansible
  git
  bash-preexec
  bashmarks
  kubectl
  progress
  pyenv
  npm
  nvm
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source $OSH/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Set editor
export EDITOR=nvim
export PAGER=more

# Set the path
export PATH="${PATH}:${HOME}/bin"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set history settings
HISTSIZE=100000
HISTFILESIZE=100000
HISTIGNORE="ls:ls -la:ls -al:ll:lll:ps:ps ax:top:&:[bf]g:jobs:exit:pwd:clear:mount:umount: *"
HISTFORMAT="%F %T "

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth


# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Disable noclobber option
set +o noclobber

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/user/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/user/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/user/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/user/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/user/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/user/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# >>> Yandex cloud >>>
# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/home/user/yandex-cloud/path.bash.inc' ]; then source '/home/user/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/user/yandex-cloud/completion.bash.inc' ]; then source '/home/user/yandex-cloud/completion.bash.inc'; fi
# <<< Yandex cloud <<<

# >>> Pulumi >>>
export PATH="${PATH}:${HOME}/bin/pulumi"
if [ -f '/home/user/bin/pulumi/completion.bash.inc' ]; then source '/home/user/bin/pulumi/completion.bash.inc'; fi
# <<< Pulumi <<<
#
# Set terminal colours
eval $(dircolors ~/.oh-my-bash/dircolors)
