## MSYS2 + Git Cmd + ZSH

This is the most holy-grailish config I've yet found on windows.

1) Install MSYS2

2) Copy from c:\program files\git:

    git-cmd.exe
    
3) Make folder `mingw64/bin` 

    git-cmd.exe 
      fails otherwise - how can we fix this?

To fix wierd terminal icon:

   Remove /etc/zsh/zprofile


### Git Credential Manager:

https://github.com/Microsoft/Git-Credential-Manager-for-Windows/releases/tag/v1.0.0

This will not install unless Git for Windows is installed already? ... and puts its files under a symlink from ~/bin

This seems OK if odd. But onc installed