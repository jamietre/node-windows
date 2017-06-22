# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jamiet/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

r-delregion() {
    if ((REGION_ACTIVE)) then
       zle kill-region
    else
       zle $1
    fi
}

r-deselect() {
    ((REGION_ACTIVE = 0))
    zle $1
}

r-select() {
  ((REGION_ACTIVE)) || zle set-mark-command
  zle $1
}

for key kcap seq mode widget (
    sleft   kLFT    $'\e[1;2D' select backward-char
    sright  kRIT    $'\e[1;2C' select forward-char
    sup     kri     $'\e[1;2A' select up-line-or-history
    sdown   kind    $'\e[1;2B' select down-line-or-history

    send    kEND    $'\E[1;2F' select end-of-line
    send2   x       $'\E[4;2~' select end-of-line

    shome   kHOM    $'\E[1;2H' select beginning-of-line
    shome2  x       $'\E[1;2~' select beginning-of-line

    left    kcub1   $'\EOD' deselect backward-char
    right   kcuf1   $'\EOC' deselect forward-char

    end     kend    $'\EOF' deselect end-of-line
    end2    x       $'\E4~' deselect end-of-line

    home    khome   $'\EOH' deselect beginning-of-line
    home2   x       $'\E1~' deselect beginning-of-line

# \E[1;  = ctrl
# \e[1;  = shift

# these are default xterm bindings - but we want to use command key, so have to
# define custom esc sequeeces in iTerm2

#   csleft  x       $'\E[1;6D' select backward-word
#   csright x       $'\E[1;6C' select forward-word
#   csend   x       $'\E[1;6F' select end-of-line
#   cshome  x       $'\E[1;6H' select beginning-of-line

#   cleft   x       $'\E[1;5D'   deselect backward-word
#   cright  x       $'\E[1;5C'   deselect forward-word

    csleft  x       $'\Ecsleft' select backward-word
    csright x       $'\Ecsright' select forward-word
    csend   x       $'\Ecsend' select end-of-line
    cshome  x       $'\Ecshome' select beginning-of-line

    cleft   x       $'\Ecleft'   deselect backward-word
    cright  x       $'\Ecright'   deselect forward-word


    del     kdch1   $'\E[3~' delregion delete-char
    del2    x       $'^D' delregion delete-char
    bs      x       $'^?' delregion backward-delete-char

  ) {
  eval "key-$key() r-$mode $widget"
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}

### PROMPT


function git_prompt_info() {
  echo $(node ~/.scripts/prompt-strings git-prompt)
}

function precmd() {
   parts=$(git_prompt_info)
   short_path=${parts[(ws:+:)1]}
   git_info=${parts[(ws:+:)2]}
}

PROMPT='$fg_bold[green]$short_path$fg_bold[cyan]$git_info$reset_color > '
