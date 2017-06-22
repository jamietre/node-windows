## Making iterm2 (mac) work like windows

NOTE: I just started using a mac at work. These are some notes on making the keyboard comfortable to u


### Keyboard

`~/Library/KeyBindings/DefaultKeyBinding.dict` is generally used by apps for key bindings and supercedes system bindings

`KeyBindingsEditor` app is useful for editing this.

To override ctrl+left, ctrl+right you must disable system binding:

https://apple.stackexchange.com/questions/18043/how-can-i-make-ctrlright-left-arrow-stop-changing-desktops-in-lion


* In System Keyboard prefs, switch Command and Control
* In ITerm2:
	* use xterm2 default keybindings in profile
	* remove alt+left, alt+right bindings (so these can change tabs)
	* add escape sequences for "cleft" and "cright" for command+left, command+right
	* ditto csleft, csright, cshome, csend


https://superuser.com/questions/349439/how-to-bind-command-key-in-zsh/740174

### prompt

* install zsh
* example `scripts/.zshrc`
