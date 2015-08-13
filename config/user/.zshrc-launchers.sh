# Note: I am a total shell scripting noob. Please help me write better code by fixing things that 
# are broken or poorly written! Thanks.

declare -A _editors

# define any editors you want to invoke based on file extension here. The names (e.g. sublime, markdownpad)
# refer to functions that determine how the chosen editor should be invoked. 

_editors[default]=sublime
_editors[md]=markdown
_editors[js]=sublime

# define each editor as an array (space-separated strings)
#
# 1: exe, USE CYGWIN PATHS e.g. forward slashes, /c/...
# 2: arguments, using "$_path" to replace with command line arg
# 3: true|false: create a file if it's missing.
# 4: true|false: spawn new process

_launcher_notepad=('/c/Windows/system32/notepad.exe' '$_path' true true)
_launcher_sublime=('/c/Program Files/Sublime Text 3/subl.exe' '$_path' false false)
_launcher_markdown=('/c/Program Files (x86)/MarkdownPad 2/MarkdownPad2.exe' '$_path >/dev/null' true false)
_launcher_vs=('/c/Program Files (x86)/Microsoft Visual Studio 12.0/Common7/IDE/devenv.exe' '/edit $_path' false false)
_launcher_explorer=('/c/windows/system32/explorer.exe' '/e, $_path' false false)
_launcher_chrome=('/c/Program Files (x86)/Google/Chrome/Application/chrome.exe' '$3' false true)

# set up function to launch your preferred tool here. the function should call _edit_select with up to 
# 2 parameters: 
# $1 the path to be mapped to windows
# $2 the name of the launcher, maps to _launcher_xxxxx
# You are welcome to pass other parameters through as in the chrome launcher; we use the 3rd 
# parameter to map all the options to the basic launcher spec

subl() {
	_edit_select "$1" "sublime"
}

notepad() {
	_edit_select "$1" "notepad"
}

markdown() {
	_edit_select "$1" "markdown"
}

vs() {
	_edit_select "$1" "vs"
}

explore() {
	_edit_select "${1:-.}" "explorer"
}

chrome-debugger() {
	_edit_select "~" "chrome" "--remote-debugging-port=9222 --user-data-dir=\"$(cygpath -w -a $HOME)\\.chrome\" $1"
}

chrome () {
	_edit_select "~" "chrome" "$1"
}

# You shouldn't have to change anything here.

edit() {
	_edit_select "$1" ""
}

_mappath() {
	if [ -n "$1" ]; then
	   cygpath -w -a "$1"
	fi
}


_create_if_missing() {
	if [ -n "$1" ] && [ ! -f "$1" ]; then
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
	if [ -n "$_path" ]; then
		_path=\"$_path\"
	fi

	if [ -z "$2" ]; then
		filename=$(basename "$_path")
		extension="${filename##*.}" 
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
