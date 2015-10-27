### node-inspector

Debugging nodeJS is necessary. You can also debug already-running processes, which is very helpful when working with 3rd party stuff.

##### To debug a node.js app in one step

    >node-debug index.js

This will start node inspector, launch your default browser to the debugger URL, and start the app with `--debug-brk`.

##### To manually start the debugger and attach it your app:

Start node-inspector:

    > node-inspector
    Node Inspector v0.12.2
    Visit http://127.0.0.1:8080/?ws=127.0.0.1:8080&port=5858 to start debugging.

Now start your node app with the `--debug-brk` flag, most likely from another CLI:

    node --debug-brk index.js

Finally, point your browser to the URL you got from node-inspector. It will be paused on the first line; click play to start debugging.
 
##### To attach the debugger to an existing process

To debug an already-running node process, first get the PID of your process

    tasklist | grep node

.. hopefully there's only one.. then send this signal:

    node -e "process._debugProcess(PID)"


where PID is the PID you got from tasklist. Now you can start node-inspector:

    node-inspector

and browse to the URL it provides.


##### Debugging mocha

Mocha by default starts a new process, but you can still debug using this special entry point:

    > node-debug _mocha

