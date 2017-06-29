# Some custom zsh configuraiton for windows-like keyboard inline editing behavior

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

    del     kdch1   $'\E[3~' delregion delete-char
    del2    x       $'^D' delregion delete-char
    bs      x       $'^?' delregion backward-delete-char

# \E[1;  = ctrl
# \e[1;  = shift

# these are default xterm bindings using CTRL key


#   csleft  x       $'\E[1;6D' select backward-word
#   csright x       $'\E[1;6C' select forward-word
#   csend   x       $'\E[1;6F' select end-of-line
#   cshome  x       $'\E[1;6H' select beginning-of-line

#   cleft   x       $'\E[1;5D'   deselect backward-word
#   cright  x       $'\E[1;5C'   deselect forward-word

# I want to use command key instead of control, but the command key can't be captured
# by the terminal directly. So in iTerm set up "csleft", "csright", etc to emit
# custom escape sequences.

    csleft  x       $'\Ecsleft' select backward-word
    csright x       $'\Ecsright' select forward-word
    csend   x       $'\Ecsend' select end-of-line
    cshome  x       $'\Ecshome' select beginning-of-line

    cleft   x       $'\Ecleft'   deselect backward-word
    cright  x       $'\Ecright'   deselect forward-word


  ) {
  eval "key-$key() r-$mode $widget"
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}

### PROMPT

# this sets up a prompt:

# [last-two/segments] git-status>

# this uses a helper node script prompt-strings.js to get git info. I'm sure you
# could do this with a shell script but javascript is so much easier.

function git_prompt_info() {
  echo $(node ~/.scripts/prompt-strings git-prompt)
}

function precmd() {
   parts=$(git_prompt_info)
   short_path=${parts[(ws:____:)1]}
   git_info=${parts[(ws:____:)2]}
}

# lanch gitkraken

PROMPT='[%{$fg_bold[green]%}$short_path%{$reset_color%}]%{$fg_bold[cyan]%}$git_info%{$reset_color%}> '

### Run another script with local aliases

source ~/.bash_profile
