
###[TCC/LE](https://jpsoft.com/tccle-cmd-replacement.html) 

TCC/LE is a CMD replacement. It has nice editing/history features, is extensible. It integrates nicely with ConEmu. Here are some basic features:

###Configuration

The  file `tcmd.ini` in the folder from which TCC/LE launches, usually `C:\Program Files\JPSoft\TCCLE14x64` has settings which can configure the default behavior.  This is old-school windows-style INI file. 

These are typically managed from the TCC (paid edition) UI so online documentation is a difficult find, but here is a useful configuration:

	[4NT]
	EditMode=Insert
	UnixPaths=Yes
	AppendToDir=Yes
	CursorIns=15
	CursorOver=100
	AutoCancel=Yes
	DirJunctions=Yes

* *EditMode* is the default editing mode on a command line; "insert" is typical for Windows applications.
* *UnixPaths* allows limited use of forward slashes.
* *AppendToDir* adds a backslash when autocompleting a folder name
* *CursorIns* is the percentage width for the cursor while in insert mode (15% is basically a vertical bar)
* *CursorOver* is the percentage width for the cursor while in overstrike mode (100% is a block)
* *AutoCancel* will allow you to break a script with CTRL+C without the annoying "Do you want to stop this batch file?" prompt.
* *DirJunctions* - [TODO] not sure... I went out of my way to add this but can't find reference now

Some other options you might want:

	PathExt=Yes

[*PathExt*](http://jpsoft.com/help/inistartupdlg.htm) is a boolean which, when enabled, causes TCC to look at the [`PATHEXT`](http://jpsoft.com/help/pathext.htm) environment variable, which is a semicolon-delimited list of file extensions (including the dot), and search for any file matching any extension on this list.
    
Note than when using PathExt, by default, `.BTM` files will probably not be considered executable, and some default behavior (such as running the startup file `tcstart.btm`, below) will not work. [See this](http://jpsoft.com/help/pathext.htm) for more information.

    TCStartPath=D:\Somewhere

[*TCStartPath*](http://jpsoft.com/help/cmdlineopts.htm) defines an alternate location for look for startup files.

###Startup and Exit File

The `tcstart.btm` file will be run automatically if found in your home directory or the application startup folder.  Likewise, the `tcexit.btm` file will be run when leaving a shell in the same circumstances.

###Aliases

You can create aliases for any number of things, like presetting options on commands you use a lot. 

    @alias ls=ls.exe --color=auto

Note that TCC is not smart enough to not search aliases when executing commands; in bash you could just say `alias ls=ls --color=auto`. By using `ls.exe` I avoid a self referential issue. 

###Colors

Sometimes the ansi color scheme gets messed up. This will reset it:

    color 07



