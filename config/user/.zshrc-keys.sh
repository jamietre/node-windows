
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
    sleft   kLFT 	$'\e[1;2D' select backward-char
    sright  kRIT 	$'\e[1;2C' select forward-char
    sup     kri  	$'\e[1;2A' select up-line-or-history
    sdown   kind 	$'\e[1;2B' select down-line-or-history
    send    kEND 	$'\E[1;2F' select end-of-line
    shome   kHOM 	$'\E[1;2H' select beginning-of-line
    left    kcub1 	$'\EOD' deselect backward-char
    right   kcuf1 	$'\EOC' deselect forward-char
    end     kend 	$'\EOF' deselect end-of-line
    home    khome 	$'\EOH' deselect beginning-of-line
    csleft  x 		$'\E[1;6D' select backward-word
    csright x 		$'\E[1;6C' select forward-word
    csend   x 		$'\E[1;6F' select end-of-line
    cshome  x 		$'\E[1;6H' select beginning-of-line
    del     kdch1 	$'\E[3~' delregion delete-char
    bs      x   	$'^?' delregion backward-delete-char

  ) {
  eval "key-$key() r-$mode $widget"
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}