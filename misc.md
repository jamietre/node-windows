## Miscellaneous

### handy utilities

`replace` is a node version of the unix utility `sed`. While `sed` is also part of git CLI tools with git for windows, it's useful as a cross-platform dependency since you don't know if `sed` will be available.

    npm install -g replace

On windows, unfortunately, there's a builtin called `replace` also, so you need to invoke the node module like this from the command line:

    replace.cmd <args> <options>

.. or rename/remove the windows one. Type `which replace` to see what I'm talking about.

##### Strip leading whitespace from every line in a file

    replace "^[ \t]+" "" <file-path>


