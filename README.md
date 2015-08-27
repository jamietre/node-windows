#Overview
###What is this?

A living document to help you set up an effective Windows-based environment for working with Node.js, and more generally, from a unix-like command line.

Using Node and NPM is a bit of a challenge with Windows. This is for a number of reasons, but most of them have to do with the lack of good information about how to configure your environment correctly. This document hopes to provide a resource to address this void and solve some of these problems, as well as helping you find best-in-class tools and techniques for use in your own environment.

###What is here?

* References to third-party tools and installation instructions for configuring them well
* Profiles you can copy to your own machine as a starting point for your own custom configuration
* Discussion of issues and gotchas specific to working in the Windows environment

###Can I help?

Yes! Please use issues or pull requests to improve this. 


#Quick Start

I'll discuss all these components in more detail (TODO), but I suggest you just walk through the quick install to get your system set up. If you already have some components installed, such as Node, please read the instructions anyway for additional configuration you might need to do.

##Get a decent CLI 

Though Visual Studio integration for Node and NPM is getting pretty good, there are a lot of things that are just easier to do from a command line. Additionally, most examples you'll find involving tools like Node.JS, NPM, and build components aren't coming from the Microsoft world. They will tell you to type stuff. While technically many of them will work from a DOS shell, having a good CLI and Unix shell support will make it vastly easier to navigate this new world. A good shell gives you things like editing, copying/pasting, color highlighting, command history, and so on.

![](./images/conemu-babun.png)
*ConEmu wrapping Babun (mintty + zsh) shell*

So let's proceed by installing a few tools. If you are confused by the terminology around shells and consoles and stuff, [read this.](http://superuser.com/questions/144666/what-is-the-difference-between-shell-console-and-terminal)

###TCC/LE command shell

The shell I recommend using is [TCC/LE](https://jpsoft.com/tccle-cmd-replacement.html). This is free commercial software; the company offers a paid version with more features. For the most part, the free version is fine. It's also extensible with plugins.

TCC/LE is a DOS compatible shell, and has good UI integration features, such command-line editing using standard Windows behavior, and copy/paste capabilities. It is also extensible with a plugin architecture, which gives us a lot of flexibility to improve it.

* Download & install [TCC/LE](https://jpsoft.com/tccle-cmd-replacement.html)

###[Git for Windows](https://git-for-windows.github.io/) -- [github](https://github.com/git-for-windows) 

You may already have git on your computer in some older or other form. No matter what, you should download the latest version of Git for Windows (formerly MSYSGIT), make sure you are at least at version 2.5. This also includes the MSYS package, a collection of unix-like utilities that make life easier, and also make it likely that when you type in some shell command you read in an online example, it will work.

* Download and install [Git for Windows](https://git-scm.com/download/win)
* During installation, choose options 
	* **Use Git and optional Unix tools from the Windows Command Prompt**
	* **Checkout as-is, commit as-is**
	* **Use Windows' default console windows** 
	* Do not check **enable file system caching** unless you are brave

After it's installed, you will probably need to fix up your path.

#####Why not CygWin/Babun like you used to recommend?

Technically, CygWin is not compatible with node. While most of the time it works, in fact, there are scenarios where it does not handle file path and native OS integration correctly. CygWin actually runs on top of the DOS shell, whereas TCC/LE is an actual DOS shell with extensions.  As a result, CygWin is slower, and there can be problems with the way it interacts with Windows.

###[ConEmu](http://www.fosshub.com/ConEmu.html) - [github](https://github.com/Maximus5/ConEmu)

ConEmu is a console manager. This is different from a console or a shell. Think of it as lipstick for your favorite console. It provides a tabbed UI, and some other nice interaction with Windows such as clipboard support, resizing, font selection, and so on. You can also use it to automatically invoke your favorite shell by default whenever some other app asks for a shell.  
	
#####Install ConEmu

* Download & run [ConEmu Preview Installer (32-bit, 64-bit)](http://www.fosshub.com/ConEmu.html)
*  On first run, I suggest you choose "Enable automatic updates" and select "Preview" (so-called "stable" updates are rare). You can leave everything else.


When you are done, launch ConEmu by clicking the icon. From the options, choose "Startup" and select "Specified Named Task," and choose "{TCC}". Now, ConEmu will open a TCC shell by default.

##Get Node and Stuff

###[Node.js](https://nodejs.org/) 

#####Install correct platform version of NodeJS

Just [download](https://nodejs.org/download/) and run the correct system installer (32 or 64 bit MSI, probably 64).

#####Fix NPM path

In most cases you need to correct your path so `c:\Users\{username}\AppData\npm` is before `c:\Program Files\nodejs`. If not corrected, the version of NPM that is installed when you installed Node will always supersede updates that you later install. [Click here](https://github.com/npm/npm/wiki/Troubleshooting#upgrading-on-windows) for more information about this.

Check your path:

* Start -> "View advanced system settings"
* click "Environment Variables"
* Find the NPM path. It could be in `Path` under "User Variables", or part of the "System Variables" path. 
	* If the NPM path is under "User Variables," copy it and delete it from there. 
	* If it is under "System Variables," and it appears after the `nodejs` path, then cut it from it's location there.
* Either way, paste it just before `c:\Program Files\nodejs;` in the System Path. In the end, it should only appear once, under System Path, before the nodejs path. 

###[NPM](https://www.npmjs.com/package/npm) - [github](https://github.com/npm/npm)

Node Package Manager (NPM) is installed automatically when you install Node. However, it's probably not the latest version, and we actually want to use the cutting edge `npm@3` release. 

#####Install NPM@3

NPM@3 is in beta release right now, so you have to ask for it specifically. This will get you the latest announced version of the beta.

	> npm install -g npm@v3.x-latest
	> npm --version
    3.2.0

Sometimes, there's even a newer version than the latest announced one, you can look at [npm releases here](https://github.com/npm/npm/releases). If want to install a cutting edge version, or perhaps roll back to a specific version, you can do it as follows:

    > npm install -g npm@3.2.1

Note that once you've installed npm globally, to update it, you need to remove it and re-install it with npm. Implausibly, this works. See the discussion under "more detailed instructions" below to understand why. But really all you need to do is:

    > npm remove -g npm
    > npm install -g npm@3.2.1

#####Configuring NPM

I find it useful to see output when NPM is installing things, especially to the extent that we are using beta software, it's nice to see what's happening:

    > npm set loglevel=http 

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




##Understanding the Node architecture

Some things with Node can be confusing, but it generally makes more sense if you understand where things go. To make this easier let's define some terminology:

* **node home** is where the nodejs app lives, typically `c:\program files\nodejs`. 
* **npm home** is the where global npm modules are installed... *including npm itself* if you install a newer version than the one distributed with Node. 

When we rearranged the paths before while installing node, this was to ensure that in your search path, the things in the *npm home* are found before searching the *node home*. That is, things you install globally will take precedence over things that were installed with nodejs itself.

When you install npm using `npm install -g npm@3.2.1`, it puts it in the *npm home* and future invocations of `npm` will use that one. This also means you can safely uninstall npm, since it will just fall back to the original version that came with nodejs.

Sometimes things go wrong uninstalling. If so just delete `%APPDATA%\local\roaming\
npm\npm` and try installing again.

Make sense? 

##Using NPM

####Important npm concepts

*Installing globally doesn't mean you share package dependencies among projects.* It means you are installing an executable command that should be available in your path, such as `npm` or `grunt`. For the most part, you will only need to install general-purpose tools globally; simple package dependencies should just be installed normally. So unless the installation instructions for a thing say to install globally, don't.

####Basic things you will do with npm:

* `npm install packagename` - install a package to the project in the current directory
* `npm install -g gulp` - install something globally.
* `npm remove packagename` - uninstall a package
* `npm init` - configure `package.json` in the current folder, will populate with everything currently installed.
* `npm --version` - what version of npm am I running?

*TODO -- much more*

##Problems


**If you get a strange error dialog when launching Windows Explorer** from the command line, disable *aggressive mode* in ConEmu Settings -> Integration -> Default Term

**Conflicting version of git/git bash** -- you may have Git installed separately, as a result of installing Git for Windows previously, or as installed by something that depends on it. Try typing:

    which git

to see where `git` is being loaded from; if it's not what you expect, delete it.
