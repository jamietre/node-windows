##Troubleshooting

These are a few things that have come up that are specific to windows:


**If you get a strange error dialog when launching Windows Explorer** from the command line, disable *aggressive mode* in ConEmu Settings -> Integration -> Default Term

**Conflicting version of git/git bash** -- you may have Git installed separately, as a result of installing Git for Windows previously, or as installed by something that depends on it. Try typing:

    which git

to see where `git` is being loaded from; if it's not what you expect, delete it.

**Certificate error accessing remote git repo**:

    fatal: unable to access 'https://github.com/{user}/node-windows.git/': 
    error setting certificate verify locations:
        CAfile: C:/Program Files/Git/mingw64/libexe/ssl/certs/ca-bundle.crt
        CApath: none

(or something) -- just fix the CA path:

    git config --system http.sslcainfo "c:\program files\git\mingw64\ssl\certs\ca-bundle.crt"

This could be specific to your git installation, verify the path to ca-bundle.crt first.