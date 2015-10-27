## TCC with ConEmu

You should use the following configuration with ConEmu + TCC

* Keys & Macro -> Controls:
	* Uncheck "Send mouse events to console." This can cause issues with TCC when a process is blocking the console; it can create long input queues that block CTRL+C and cause long streams of cursor movement to happen after the process ends.
* Keys & Macro -> Mark/Copy:
    * Uncheck all "Select text with keyboard" checkboxes; TCC handles this automatically