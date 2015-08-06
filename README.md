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

Though Visual Studio integration for Node and NPM is getting pretty good, there are a lot of things that are just easier to do from a command line. Additionally, most examples you'll find involving tools like Node.JS, NPM, and build components aren't coming from the Microsoft world. They will tell you to type stuff. While technically many of them will work from a DOS shell, having a good CLI and Unix shell support will make it vastly easier to navigate this new world.

![](./images/conemu-babun.png)
*ConEmu wrapping Babun (mintty + zsh) shell*

So let's proceed by installing a few tools. If you are confused by the terminology around shells and consoles and stuff, [read this.](http://superuser.com/questions/144666/what-is-the-difference-between-shell-console-and-terminal)

#####[Babun](http://babun.github.io/) - [github](https://github.com/babun/babun)

Babun is a set of tools. It basically sets you up with Cygwin, mintty (a console replacement), and a nice zsh configuration (a bash shell) among other things. It has a simple package manager called *pact* to manage versions of its own components. It's really not anything new itself, but rather, puts a lot of useful things, in a nice configuration, under one roof. Don't worry if you don't know what Cygwin, zsh, or bash are, it will become clear in time.
	
* Download & extract `.zip` file, click into `babun-{version}` and double-click `install.bat`.

#####[ConEmu](http://www.fosshub.com/ConEmu.html) - [github](https://github.com/Maximus5/ConEmu)

ConEmu is a console manager. This is different from a console or a shell. Think of it as lipstick for your favorite console. It provides a tabbed UI, and some other nice interaction with Windows such as clipboard support, resizing, font selection, and so on. You can also use it to automatically invoke your favorite shell by default whenever some other app asks for a shell.  
	
* Download & run [ConEmu Preview Installer (32-bit, 64-bit)](http://www.fosshub.com/ConEmu.html)
*  On first run, I suggest you choose "Enable automatic updates" and select "Preview" (so-called "stable" updates are rare). You can leave everything else.

You will need to add a profile for the babun shell. If you like, you can just import my settings from [./config/conemu/conemu.xml](config/conemu/conemu.xml); just click "Import" in the settings dialog. This includes some font and color customizations. It uses a fantastic free font called [DejaVu Sans Mono](http://dejavu-fonts.org/wiki/Download). If you don't have this installed, it will just warn you and fall back to another font. Alternatively, you can set up the profile as follows:

* Choose "Settings" from within the console, select "Startup > Tasks" from the menu.
* Click "+" to create a new task/command group, and enter the following:
	* Name: Babun
	* Check "Default task for new console" and "Default shell"
	* Task Parameters: `/icon "%userprofile%\.babun\cygwin\bin\mintty.exe" /dir "%userprofile%" `
	* Commands: `"%userprofile%\.babun\cygwin\bin\mintty.exe"`


![](./images/conemu-settings.png)

When you are done, click "Startup" and select "Specified Named Task," and choose "{Babun}". Now, ConEmu will open a Babun shell by default.

####Update a few things

Launch ConEmu by clicking the icon. The first time you run Babun it may take a minute as it checks that versions of its core libraries are up to date. However, it doesn't automatically update the Cygwin tools. For the most part this doesn't matter, but you want to make sure your `git` client is up to date:

    { ~ } pact upate git

Finally, I suggest using the custom zsh configuration provided in this repository. This adds good inline editing/selection to the command line (e.g. shift-cursor to select text) and a few useful aliases. The easiest way to do this is to first clone it. From within your shell, do the following:

    { ~ } git clone https://github.com/jamietre/node-windows.git



##Get Node and Stuff

####[Node.js](https://nodejs.org/) 

#####Install correct platform version of NodeJS

Just [download](https://nodejs.org/download/) and run the correct system installer (32 or 64 bit MSI, probably 64).

#####Install NPM globally

	> npm install -g npm
 
#####Fix NPM path

In most cases you need to correct your path so `c:\Users\{username}\AppData\npm` is before `c:\Program Files\nodejs`. If not corrected, the version of NPM that is installed when you installed Node will always supersede updates that you later install. [Click here](https://github.com/npm/npm/wiki/Troubleshooting#upgrading-on-windows) for more information about this.

Check your path:
	* Start -> "View advanced system settings"
	* click "Environment Variables"
	* Find the NPM path. It could be in `Path` under User Variables, or part of the System Variables path. If the NPM path is under User Variables, copy it and delete it from there. If it is under System Variables, and it appears after the `nodejs` path, then cut it from it's location there.
	* Either way, paste it just before `c:\Program Files\nodejs;` in the System Path. In the end, it should only appear once, under System Path, before the nodejs path. 




##Other Stuff

#####[Markdown Editors](http://www.sitepoint.com/best-markdown-editors-windows/)

Get a Windows app for editing markdown. It comes up a lot, and I hope we adopt it as our standard for documentation. I like [Markdown Pad 2](http://markdownpad.com/) - there's a free version, and a pay-for-pro option with more features. The [article](http://www.sitepoint.com/best-markdown-editors-windows/) linked above compares a number of options for Windows. Find one you like. 


#####[Cygwin](http://www.cygwin.com)

Cygwin is a collection of linux/unix tools compiled to run on Windows, including things that you can't live without like `git`. It also has lots of things that maybe you can live without, but you'll wonder why you did once you get used to them, like, `grep` and `which`.  

Cygwin is installed by Babun automatically, you probably don't need to think about it too much. But you can use the Cygwin installer to update everything if you don't want to use the pact tool to update individual packages:

* Run the [cygwin installer.](http://cygwin.com/setup-x86.exe)
* Change the default directory to `C:\Users\{username}\.babun\cygwin` -- this is where Babun installs Cygwin
* Click "Next" until it starts. Since you pointed to an existing Cygwin installation, the default behavior is just to update everything. Just let it do it's thing with default options.  





##Problems

There are issues with mintty 2.1.3 and ConEmu, see [this](https://github.com/Maximus5/ConEmu/issues/239). Probably will be fixed in next mintty release. A workaround is to add -d to the invocation for mintty in ConEmu:

* Commands: `"%userprofile%\.babun\cygwin\bin\mintty.exe" -d`






