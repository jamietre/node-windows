##Unix Primer

One of the things I mention a lot is "unix command line tools." If you are a Windows native this may mean nothing to you. While this information is easily available online, I want to provide at least a cheat sheat of the most useful tools. (TODO: find good detailed references to link here)

#####Important concepts

*TODO*

* stdin/stdout
* redirecting
* & and fg
* piping

#####Useful bash commands

These are all standard unix tools so don't use this as an authoritative reference.,

* `vi` - editor

* `ls` - list directory contents. By default, files starting with `.` are hidden.
	* `ls -lAh` - show all files, sizes in human-readable format, with details (one file per line)
* `which` - display path to a file found in your path
* `grep` - filter stdin using a regex
* `cd` - change directory
* `man` - show instructions for a command
* `more` - read a file, stopping at each page
* `less` - like more, but you can go pack
* `cat` - display an entire file
* `df` - show free disk space
* `du` - show size of folder contents recursively
	* `du -h --max-depth=2` - show sizes, in human-readable format, only recursing to 2 levels deep
* `alias` - create an alias
	* `alias ls="ls -Ah"` - npw `ls` always shows all files and sizes in human-readable format  
* `set` - show all evironment variables
* `unset name` - clear an environment variable `name`
