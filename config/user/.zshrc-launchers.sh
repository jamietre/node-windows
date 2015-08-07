# Note: I am a total shell scripting noob. Please help me write better code by fixing things that 
# are broken or poorly written! Thanks.

declare -A _editors

# define any editors you want to invoke based on file extension here. The names (e.g. sublime, markdownpad)
# refer to functions that determine how the chosen editor should be invoked. 

_editors[default]=sublime
_editors[md]=markdown
_editors[js]=vs
_editors[json]=vs

# define each editor as an array (space-separated strings)
#
# 1: exe, USE CYGWIN PATHS e.g. forward slashes, /c/...
# 2: arguments, using "$_path" to replace with command line arg
# 3: true|false: create a file if it's missing.
# 4: true|false: spawn new process

_launcher_notepad=('/c/Windows/system32/notepad.exe' '"$_path"' true true)
_launcher_sublime=('/c/Program Files/Sublime Text 3/sublime_text.exe' '"$_path"' false false)
_launcher_markdown=('/c/Program Files (x86)/MarkdownPad 2/MarkdownPad2.exe' '"$_path" >/dev/null' true false)
_launcher_vs=('/c/Program Files (x86)/Microsoft Visual Studio 12.0/Common7/IDE/devenv.exe' '/edit "$_path"' false false)
_launcher_explorer=('/c/windows/system32/explorer.exe' '/e, "$_path"' false false)

# set up any special aliases you want here; our defaults "edit" selects based on extension, and "st" always uses 
# sublime text.

alias edit=_edit
alias st=_edit_sublime 
alias notepad=_edit_notepad
alias md=_edit_markdown
alias vs=_edit_vs
alias ex=_explorer

# if you want an alias to always choose an editor, add a method below for it

_edit_sublime() {
	_edit_select "$1" "sublime"
}

_edit_notepad() {
	_edit_select "$1" "notepad"
}

_edit_markdown() {
	_edit_select "$1" "markdown"
}

_edit_vs() {
	_edit_select "$1" "vs"
}

# You shouldn't have to change anything here.

_edit() {
	_edit_select "$1" ""
}

_explorer() {
	_edit_select "${1:-.}" "explorer"
}

_mappath() {
	cygpath -w -a $1
}


_create_if_missing() {
	if [ ! -f "$1" ]; then
	   touch "$1"
	fi
}

_edit_select() {
	local _path
	local filename
	local extension
	local launcher
	local cmd

	 _path=$(_mappath ${1})
	filename=$(basename "$_path")
	extension="${filename##*.}" 

	if [ -z "$2" ]; then
   		_launcher_var=_launcher_${_editors[$extension]-${_editors[default]}}
	else
		_launcher_var=_launcher_$2
	fi

	launcher=(${(P)_launcher_var})
  
  if [ ! -f ${launcher[1]} ]; then
  	echo "selected launcher \"${launcher[1]}\" was not found; using notepad instead. suggest you check out ~/.zshrc-launchers.sh"
  	 launcher=(${_launcher_notepad})
  fi

  if [ ${launcher[3]}==true ] ; then
	_create_if_missing "$1"
  fi
  
   cmd="\"${launcher[1]}\" ${(e)launcher[2]}"
  #echo $cmd

  if [ ${launcher[4]}==true ] ; then
  	eval "($cmd &) &> /dev/null "
  else
  	eval $cmd
  fi
}



