###Environment

This section discusses the command line environment and options other than the DOS shell. You can also use Powershell which is much improved, and fully supports Node.  However, this guide is oriented more towards shells that provide a unix-like environment, so we don't specifically discuss Powershell. Because most reference work related to node.js assumes you are using a bash shell, with unix-like shell commands, we'll work towards getting something like that functional in Windows. 


#Quick Start

I'll discuss all these components in more detail (TODO), but I suggest you just walk through the quick install to get your system set up. If you already have some components installed, such as Node, please read the instructions anyway for additional configuration you might need to do.

* Download & install [TCC/LE](https://jpsoft.com/tccle-cmd-replacement.html)

##[Git for Windows](https://git-for-windows.github.io/) -- [github](https://github.com/git-for-windows) 

The first thing is to install git. Git for windows isn't just the actual `git` program, it also includes a complete unix-like shell (msysgit) which gives you a suite of Unix command-line tools to augment the DOS toolset.

You may already have git on your computer in some older or other form. No matter what, you should download the latest version of Git for Windows (formerly MSYSGIT), version 2.5 as of this writing.. This also includes the MSYS package, a collection of unix-like utilities that make life easier, and also make it likely that when you type in some shell command you read in an online example, it will work.

* Download and install [Git for Windows](https://git-scm.com/download/win)
* During installation, choose options 
	* **Use Git and optional Unix tools from the Windows Command Prompt**
	* **Checkout as-is, commit as-is**
	* **Use Windows' default console windows** 
	* Do not check **enable file system caching** unless you are brave

The installation process will alter your path based on the fist choice; if you selected the "use Git an optional Unix tools.." as above, then the binaries will be available to you from the command line automatically.

##Get a decent CLI 

Though Visual Studio integration for Node and NPM is interesting, there are a lot of things that are just easier to do from a command line. Additionally, most examples you'll find involving tools like Node.JS, NPM, and build components aren't coming from the Microsoft world. They will tell you to type stuff. While technically many of them will work from a DOS shell, having a good CLI and Unix shell support will make it vastly easier to navigate this new world. 

Everything will work from a DOS shell, but using an alternative can give you things like editing, copying/pasting, color highlighting, command history, and so on.

So let's proceed by installing a few tools. If you are confused by the terminology around shells and consoles and stuff, [read this.](http://superuser.com/questions/144666/what-is-the-difference-between-shell-console-and-terminal)

###TCC/LE command shell

The shell I recommend using is [TCC/LE](https://jpsoft.com/tccle-cmd-replacement.html). This is free commercial software; the company offers a paid version with more features. For the most part, the free version is fine. It's also extensible with plugins.

TCC/LE is a DOS compatible shell, and has good UI integration features, such command-line editing using standard Windows behavior, and copy/paste capabilities. It is also extensible with a plugin architecture, which gives us a lot of flexibility to improve it.

#####Why not CygWin/Babun like you used to recommend?

Technically, CygWin is not compatible with node. While most of the time it works, in fact, there are scenarios where it does not handle file path and native OS integration correctly. This will manifest itself with some package failing to install in some confusing way. It's really just better not to have to worry about this on top of everything else. CygWin actually runs on top of the DOS shell, and manages its own processes, whereas TCC/LE is an actual DOS shell with extensions.  As a result, CygWin is slower, and there can be problems with the way it interacts with Windows.

#####Other alternatives?

You can also use the git bash mintty console that comes with Git for Windows. A lot of people are perfectly happy with this. It is better than the DOS shell, but not a lot. It doesn't support editing of command lines.


##[ConEmu](http://www.fosshub.com/ConEmu.html) - [github](https://github.com/Maximus5/ConEmu)

ConEmu is a console manager. This is different from a console or a shell; it provides GUI management of your shells and adds UI integration features. It provides a tabs for managing multiple active shells, and some other nice interaction with Windows such as clipboard support, resizing, font selection, and so on. You can also use it to automatically invoke your favorite shell by default whenever some other app asks for a shell.  

If you have installed Git and TCC before you install ConEmu, it will automatically be aware of them.
	
#####Install ConEmu

* Download & run [ConEmu Preview Installer (32-bit, 64-bit)](http://www.fosshub.com/ConEmu.html)
*  On first run, I suggest you choose "Enable automatic updates" and select "Preview" (so-called "stable" updates are rare). You can leave everything else.


When you are done, launch ConEmu by clicking the icon. From the options, choose "Startup" and select "Specified Named Task," and choose "{TCC}". Now, ConEmu will open a TCC shell by default.

##Node & NPM

After you've got your shell up and running it's time to install nodejs.


#####Install correct platform version of [Node.js](https://nodejs.org/)

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

#####Update [npm](https://www.npmjs.com/package/npm) 

Node Package Manager (npm) is installed automatically when you install Node. However, it's probably not the latest version, and we actually want to use the cutting edge `npm@3` release. 

#####Install NPM@3

NPM@3 is in beta release right now, so you have to ask for it specifically. This will get you the latest announced version of the beta.

	> npm install -g npm@v3.x-latest
	> npm --version
    3.3.0

Sometimes, there's even a newer version than the latest announced one, you can look at [npm releases here](https://github.com/npm/npm/releases). If want to install a cutting edge version, or perhaps roll back to a specific version, you can do it as follows:

    > npm install -g npm@3.3.1

Note that once you've installed npm globally, to update it, you need to remove it and re-install it with npm. Implausibly, this works. See the discussion under "more detailed instructions" below to understand why. But really all you need to do is:

    > npm remove -g npm
    > npm install -g npm@3.3.1

Sometimes, removing npm will fail, for reasons unknown. If this happens, you can almost always solve it by removing traces of it from your roaming profile, and installing again:
    
    > rm %APPDATA%/npm/npm
    > rm %APPDATA%/npm/npm.cmd
    > npm install -g npm@3.3.1
 
(In fact you can just do this anytime without even using `npm remove` to update... it just doesn't seem that clean :)


#####Configuring npm

I find it useful to see output when NPM is installing things, especially to the extent that we are using beta software, it's nice to see what's happening:

    > npm set loglevel=http 

