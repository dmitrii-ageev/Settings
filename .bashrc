#!/usr/bin/env bash

# Defind a funciton set in here
load() {
  # Load all the provided files
  for file in $@; do
    [[ -r "$file" ]] && source $file
  done
}

exist() {
  # Check if command exists
  command -v "$@" &>/dev/null
}

execute() {
  # Execute a command and suppress the output
  $@ &>/dev/null
}

# Function to initialize a Conda-like environment
init_conda_env() {
    local tool_name="$1"  # e.g., "conda" or "mamba"
    local possible_prefixes=("${@:2}")  # Array of root prefixes to check
    local root_prefix=""
    local exe=""

    # Find the first existing root prefix
    for prefix in "${possible_prefixes[@]}"; do
        if [[ -d "$prefix" ]]; then
            root_prefix="$prefix"
            break
        fi
    done

    # If no prefix found, return early
    if [[ -z "$root_prefix" ]]; then
        return 1
    fi

    # Set executable path
    exe="${root_prefix}/bin/${tool_name}"
    if [[ ! -x "$exe" ]]; then
        return 1
    fi

    # Export variables
    export "${tool_name^^}_EXE"="$exe"  # e.g., CONDA_EXE or MAMBA_EXE
    export "${tool_name^^}_ROOT_PREFIX"="$root_prefix"  # e.g., CONDA_ROOT_PREFIX

    # Attempt to initialize shell hook
    local setup
    setup="$("$exe" shell.bash hook 2>/dev/null)"
    if [[ $? -eq 0 ]]; then
        eval "$setup"
        return 0
    fi

    # Update PATH
    export PATH="${root_prefix}/bin:$PATH"
    alias "$tool_name"="$exe"

    # Fallback: source profile.d script if it exists
    load "${root_prefix}/etc/profile.d/conda.sh" && return 0
    load "${root_prefix}/etc/profile.d/${tool_name}.sh" && return 0

    # Ensure clean exit
    return 0
}

# Get the Operating System's name
export OS=$(uname -s)

# Path to your oh-my-bash installation.
export OSH=${HOME}/.oh-my-bash

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
[[ "${TERM_PROGRAM}" == "vscode" ]] && export OSH_THEME=${OSH_THEME:-"demula"}
[[ "$OS" == "Darwin" ]] && export OSH_THEME=${OSH_THEME:-"cupcake"}

#OSH_THEME="brainy"
#OSH_THEME="powerline"
OSH_THEME=${OSH_THEME:-"agnoster"}

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
HIST_STAMPS='yyyy-mm-dd'

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

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

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"
load "${HOME}/.aliases"
load "${HOME}/.bash_aliases"

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
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
[[ "$OS" == "Darwin" ]] && export EDITOR='vim'
[[ "$OS" == "Linux" ]] && export EDITOR='nvim'
alias vi=${EDITOR}

# Preferred pager for local and remote sessions
[[ "$OS" == "Darwin" ]] && export PAGER='more -r'
[[ "$OS" == "Linux" ]] && export PAGER='more --plain'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Disable Terragrunt Telemetry
export TERRAGRUNT_DISABLE_TELEMETRY=true

# Disalbe Terraform Telemetry
export CHECKPOINT_DISABLE=1

# SSH
if [ -f "${HOME}/.ssh/workstation.pem" ]; then
    export SSH_KEY_PATH="${HOME}/.ssh/workstation.pem"
else
    export SSH_KEY_PATH="${HOME}/.ssh/id_rsa"
fi

# GIT
export GIT_SSH_KEY="${GIT_SSH_KEY:-$SSH_KEY_PATH}"
export GIT_SSH_COMMAND='ssh -i ${GIT_SSH_KEY} -o IdentitiesOnly=yes'

# Set Terminal-related settings
export GPG_TTY=$(tty)

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
  load '/etc/bash_completion'
  load '/usr/share/bash-completion/bash_completion'
fi


# Start SSH Agent on Linux
if [ "$OS" == "Linux" ]; then
    export SSH_AUTH_SOCK=$(find /tmp -type s -name "agent.*" 2>/dev/null | head -n 1)
    if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)"
    fi
fi

#
# Application settings
#

# >>> conda initialize >>>
# Define possible installation paths for each tool
conda_prefixes=("$HOME/condaforge" "$HOME/miniconda" "$HOME/miniconda3")
mamba_prefixes=("$HOME/mambaforge" "$HOME/minimamba" "$HOME/miniforge3" "$HOME/micromamba")

# Initialize environments in order of preference
if ! init_conda_env "mamba" "${mamba_prefixes[@]}"; then
    if ! init_conda_env "conda" "${conda_prefixes[@]}"; then
        # No environment found; do nothing or log a message if desired
        :
    fi
fi
# <<< conda initialize <<<


# >>> Yandex cloud >>>
# The next line updates PATH for Yandex Cloud CLI.
load "${HOME}/yandex-cloud/path.bash.inc"

# The next line enables shell command completion for yc.
load "${HOME}/yandex-cloud/completion.bash.inc"
# <<< Yandex cloud <<<


# >>> Pulumi >>>
exist "${HOME}/bin/pulumi/pulumi" && \
    export PATH="${PATH}:${HOME}/bin/pulumi" && \
        load "${HOME}/bin/pulumi/completion.bash.inc"
# <<< Pulumi <<<


##
## Autocompletion
##
load /opt/homebrew/share/bash-completion/bash_completion
load /opt/homebrew/etc/profile.d/bash_completion.sh
#autoload -U +X bashcompinit && bashcompinit


##
## AWS Completions
##
if exist aws_completer; then
    complete -C $(which aws_completer) aws
fi


##
## Kubernetes Completions
##
if exist kubectl; then
    export KUBECTL_CONTEXT=${KUBECTL_CONTEXT:-""}
    export KUBECTL_NAMESPACE=${KUBECTL_NAMESPACE:-"default"}
    source <(kubectl completion bash)
    alias kubectl='kubectl --context="$KUBECTL_CONTEXT" --namespace="$KUBECTL_NAMESPACE"'
    alias k=kubectl
    complete -o default -F __start_kubectl k
    alias ks='kubectl -n kube-system'
    complete -o default -F __start_kubectl ks
fi


##
## Helm Completions
##
exist helm && source <(helm completion bash)


#
# STERN settings
#
if exist stern; then
    source <(stern --completion bash)
    alias stern='stern --context="$KUBECTL_CONTEXT" --namespace="$KUBECTL_NAMESPACE"'
    alias log=stern
    complete -o default -F __start_stern log
    alias logs=stern
    complete -o default -F __start_stern logs
fi


##
## GoLang Settings
##
if [ -d "${CONDA_ROOT_PREFIX:-$MAMBA_ROOT_PREFIX}/envs/golang" ]; then
    export GOPATH="${CONDA_ROOT_PREFIX:-$MAMBA_ROOT_PREFIX}/envs/golang"
    export GOROOT="${GOPATH}/go"
    export PATH="${PATH}:${GOPATH}/bin"
    exist gocomplete && complete -o nospace -C gocomplete go
fi


##
## Initialise 'The Fuck' - command line error fixer
##
exist thefuck && eval $(thefuck --alias)


##
## Initialise 'Cloud Nuke' - AWS Resource Purifier
##
exist cloud-nuke && export DISABLE_TELEMETRY=true

# Set terminal colours
[[ -r ~/.dir_colors ]] && [[ "$OS" == "Darwin" ]] && eval $(gdircolors ~/.dir_colors)
[[ -r ~/.dir_colors ]] && [[ "$OS" == "Linux" ]] && eval $(dircolors ~/.dir_colors)

# Exit with the zero code
true
