##Node and NPM


###Understanding the Node architecture

Some things with Node can be confusing, but it generally makes more sense if you understand where things go. To make this easier let's define some terminology:

* **node home** is where the nodejs app lives, typically `c:\program files\nodejs`. 
* **npm home** is the where global npm modules are installed... *including npm itself* if you install a newer version than the one distributed with Node. 

When we rearranged the paths before while installing node, this was to ensure that in your search path, the things in the *npm home* are found before searching the *node home*. That is, things you install globally will take precedence over things that were installed with nodejs itself.

When you install npm using `npm install -g npm@3.2.1`, it puts it in the *npm home* and future invocations of `npm` will use that one. This also means you can safely uninstall npm, since it will just fall back to the original version that came with nodejs.

Sometimes things go wrong uninstalling. If so just delete `%APPDATA%\local\roaming\
npm\npm` and try installing again.



####Important npm concepts

*Installing globally doesn't mean you share package dependencies among projects.* It means you are installing an executable command that should be available in your path, such as `npm` or `grunt`. For the most part, you will only need to install general-purpose tools globally; simple package dependencies should just be installed normally. So unless the installation instructions for a thing say to install globally, don't.

####Basic things you will do with npm:

* `npm install packagename` - install a package to the project in the current directory
* `npm install -g gulp` - install something globally.
* `npm remove packagename` - uninstall a package
* `npm init` - configure `package.json` in the current folder, will populate with everything currently installed.
* `npm --version` - what version of npm am I running?

*TODO -- much more*