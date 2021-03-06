# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mdr"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Help history-substring-search
DEBIAN_PREVENT_KEYBOARD_CHANGES=yes

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode cp history-substring-search wd mosh tmux svn-fast-info lol pip colored-man-pages )# zsh-syntax-highlighting)

# User configuration


# Rust PATH
#export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# vim is life
# or is nvim life?
bindkey -M viins '^[' vi-cmd-mode
bindkey -M vicmd '^[' vi-cmd-mode
export EDITOR="nvim"
export SVN_EDITOR="nvim"
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias gvim='nvim-gtk'
  alias vv='nvim-gtk'
  alias dvim='nvim -R -'
fi
alias vimswapclear="rm -r $HOME/.local/share/nvim/swap/*.swp"
alias qvim='echo you probably want vv'
#alias qvim="nvim-qt --geometry 800x730-0+0"; echo but 

# history
HISTFILE=~/.zhistfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd notify extendedglob
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward
bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward
bindkey '^r' history-incremental-search-backward


# highlighting
if [ -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]
then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[alias]=fg=white,bold
    ZSH_HIGHLIGHT_STYLES[builtin]=fg=white,bold
    ZSH_HIGHLIGHT_STYLES[function]=fg=white,bold
    ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=none
    ZSH_HIGHLIGHT_STYLES[hashed-command]=none
    ZSH_HIGHLIGHT_STYLES[path]=none
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
fi


# more aliases
alias gls='ls --group-directories-first --color=tty'
#alias ipython='ipython --pylab=gtk'
alias jd='jbo define'
jf() { jbo filter "$@" | JBO_ESCAPES=always def | less -R; }
alias xclipc='xclip -selection clipboard'
alias sm='make html'

# private config
source $HOME/.zshrc.local


# ls
function lt() {
    if test "x$1" = "x"; then
        ls | tail
    else
        ls | tail -n$1
    fi
}

# tmux
function tm() {
    if test "$1" = "ls"; then
        tmux ls
        return
    fi
    if test "x$1" = "x"; then
        tmux -2 new-session
        return
    fi
    if test `tmux ls |grep $1 |wc -l` -ge 1; then
        tmux a -dt $1
        return
    fi
    conf_file=$HOME/tmux/$1.conf
    if test -f $conf_file; then
        tmux -2 new-session -s $1 "tmux source-file \"$conf_file\" "
    else
        tmux -2 new-session -s $1
    fi
}

# virtualenv
function ve() {
    if test "$1" = "ls"; then
        ls $HOME/ve | cat
        return
    fi
    if test "$1" = "create"; then
        virtualenv $HOME/ve/$2
        return
    fi
    source $HOME/ve/$1/bin/activate
}
export PIPENV_VENV_IN_PROJECT=1

# custom completion
fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit
zstyle ':completion:*' menu select=2

# bring my ssh agent everywhere! (see also, .tmux.conf)
function _ssh_auth_save() {
    sock_file="$HOME/.ssh/ssh-auth-sock.`hostname`"
    if test "$sock_file" != "$SSH_AUTH_SOCK"; then
        ln -sf "$SSH_AUTH_SOCK" "$sock_file"
    fi
    export SSH_AUTH_SOCK="$sock_file"
}
_ssh_auth_save

# make "crop" dir with cropped PNGs
function crop_pngs() {
    mkdir -p crop
    for f in *png; do
        convert $f -trim -bordercolor white -border 10x10 crop/$f
    done
}

# AWS
alias kcgc='kubectl config get-contexts'
alias kcuc='kubectl config use-context'


alias kubectl-evicted-details="kubectl get pod --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains(\"Evicted\"))'"
alias kubectl-evicted-list="kubectl get pod --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains(\"Evicted\")) | \"\(.metadata.name) \(.status.message)\" ' | sed 's/\"//g'"
alias kubectl-evicted-list-uniq="kubectl get pod --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains(\"Evicted\")) | \"\(.metadata.namespace)\" ' | sed 's/\"//g' | sort | uniq"
alias kubectl-evicted-count='kubectl-list-evicted | wc -l'
alias kubectl-evicted-DELETE="kubectl get pod --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains(\"Evicted\")) | \"kubectl delete pod \(.metadata.name) -n \(.metadata.namespace)\"' | xargs -n 1 bash -c"

alias kcce=kubectl-evicted-count
alias kcleu=kubectl-evicted-list-uniq
alias kcle=kubectl-evicted-list
alias kcde=kubectl-evicted-details
alias kcDE=kubectl-evicted-DELETE

# GIT
alias gbc='git branch | cat'

# PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
