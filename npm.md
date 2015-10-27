##Node and NPM

####Important npm concepts

You will frequently see instructions to install something "globally" with npm, e.g.

	npm install -g rimraf

The `-g` flag says install it globally. In npm parlance, globally simply means it's a command line tool, like `grunt` *Installing globally doesn't mean you are sharing something among projects.*

In this example, [rimraf](https://github.com/isaacs/rimraf) is an npm package that gives you the ability to delete a folder and all its children. It has been set up to allow global installation, so you can use it from the command line, e.g.

    rimraf node_modules 

Even though `rimraf` (and `gulp` and `grunt` and lots of other things) can be installed globally, you will still see them as dependencies of other modules. When you install something that has `rimraf` as a dependency, even if you happen to have it installed already globally, it will still install it in the `node_modules` folder of your project. The dependencies of your project are completely independent of the modules you've installed globally. They could be (and often are) completely different versions.

###Understanding the Node architecture

Understanding where things live is useful for understanding the overall architecture. 

* **node home** is where the nodejs app lives, typically 
    
	`c:\program files\nodejs`

	node also includes npm as part of the default installation.    

* **npm home** is the where global npm modules are installed, typically

	`c:\users{username}\appdata\roaming\npm

	npm itself is typically installed here, along with all other global modules, unless you never updated it from your initial node installation. 

The location of `npm` itself is a little confusing. When you first install node, it comes with a version of `npm` so that you can install packages at all. But it's often out of date. The first thing you'll want to do after installing `node` is to update npm:

    npm install -g npm@latest

This is no different than the command you use to install any node package globally. `npm` itself is written in Javascript and is distributed as a node package, it is installed the same as any other.  

When we rearranged the paths before [./environment.md](while installing node), this was to ensure that in your search path, the things in the *npm home* are found before searching the *node home*. That is, things you install globally will take precedence over things that were installed with nodejs itself.

So when you install npm using `npm install -g npm@latest`, it puts it in the *npm home* and future invocations of `npm` will use that one, because it appears before the node home in your search path. This also means you can safely uninstall npm globally:

    npm remove npm -g


since it will just fall back to the original version that came with nodejs. For example, after a clean node install"

    > npm --version
    2.14.7

    > which npm
    c:\program files\nodejs\npm.cmd

    > npm install -g npm@latest
    > npm version
    3.3.9

    > which npm
    c:\users\{username}\appdata\roaming\npm\npm.cmnd

    > npm uninstall -g npm
    > npm --version
    2.14.7
    > which npm
    c:\program files\nodejs\npm.cmd

Sometimes things go wrong uninstalling. If so just delete `%APPDATA%\roaming
npm\npm*` and try installing again.


#### Basic things you will do with npm:

* `npm init` - configure `package.json` in the current folder, will populate with everything currently installed.
* `npm install packagename --save` - install a package to the project in the current directory, and add it as a dependency 
* `npm install -g packagename` - install something globally.
* `npm remove packagename` - uninstall a package from the current project
* `npm update packagename` - update to the current version
* `npm --version` - what version of npm am I running?

* `npm clear cache` - sometimes things get messed up. Try this firsst. 
