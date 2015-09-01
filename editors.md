##Other Useful Things

####[Markdown Editors](http://www.sitepoint.com/best-markdown-editors-windows/)

Get a Windows app for editing markdown. It comes up a lot, and I hope we adopt it as our standard for documentation. I like [Markdown Pad 2](http://markdownpad.com/) - there's a free version, and a pay-for-pro option with more features. The [article](http://www.sitepoint.com/best-markdown-editors-windows/) linked above compares a number of options for Windows. Find one you like. 

The `.zsh-launchers.sh` script is preconfigured to use MarkdownPad for `.md` files. If you use something else, it is trivial to edit it to support your tool.


#More Detailed Instructions

For the most part, all these tools are well used and you can find good tutorials online. Here I will expand a little bit on usage from the basic installation instructions above, but please consider this a quick start guide only. *TODO links to good references*

####[Cygwin](http://www.cygwin.com)

Cygwin is a collection of linux/unix tools compiled to run on Windows, including things that you can't live without like `git`. It also has lots of things that maybe you can live without, but you'll wonder why you did once you get used to them, like, `grep` and `which`.  

Cygwin is installed by Babun automatically, you probably don't need to think about it too much. But you can use the Cygwin installer to update everything if you don't want to use the pact tool to update individual packages. If you have any trouble with a command-line tool, this is probably the first thing to try.

* Run the [cygwin installer.](http://cygwin.com/setup-x86.exe)
* Change the default directory to `C:\Users\{username}\.babun\cygwin` -- this is where Babun installs Cygwin
* Click "Next" until it starts. Since you pointed to an existing Cygwin installation, the default behavior is just to update everything. Just let it do it's thing with default options.  



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




Make sense? 



##Problems


**If you get a strange error dialog when launching Windows Explorer** from the command line, disable *aggressive mode* in ConEmu Settings -> Integration -> Default Term

**Conflicting version of git/git bash** -- you may have Git installed separately, as a result of installing Git for Windows previously, or as installed by something that depends on it. Try typing:

    which git

to see where `git` is being loaded from; if it's not what you expect, delete it.
