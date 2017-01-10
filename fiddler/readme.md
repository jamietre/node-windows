### fiddler

Fiddler is a network monitoring tool that is useful but has a really annoying shortcoming: there's no way to define a universal configuration for things like filters. Since a lot of network traffic you pretty much always don't care about this can be frustrating.

### what to do

Fiddler is extensible. You can surely write a plugin to deal with this. I didn't have time for that.

Instead of doing something robust and easy to install, I took the quick and dirty approach and edited the `CustomRules.js` file. You can find this in `c:/users/{username}/Documents/Fiddler2/Scripts/CustomRules.js`. Drop this version over the one on your computer.

This modification will cause fiddler to look in your user home directory for a file `.fiddler/filters.txt` -- typically `c:/users/{username}/.fiddler/filters.txt`. This file can contain strings, or `/regular expressions/`, one per line, of hosts to ignore.

Example `filters.txt`

    google.com
    googleusercontent.com
    gstatic.com
    mail.costar.com
    dropbox.com
    dropboxstatic.com
    gravatar.com
    microsoft.com
    msecnd.net
    snapengage.com
    chartbeat.net
    entrust.net

This will automatically ignore all traffic from those hosts. If you want to match more specifically use a regex:

    /^http://google.com:443$/

You can reload the file during a session by hitting the URL

    http://fiddler/reload

It will show a message in the status bar indicating success.


### merging changes

If you have made changes already to your `CustomRules.js`, or this simply doesn't seem to have version parity with the one you're using already, merge as follows:

1. Add imports:

```
import System.Text;
import System.Text.RegularExpressions
import System.IO;
```

2. Copy  `class Filters { ... }` into it, before or after the `class Handlers { ... }` definition.

3. In `onBeforeRequest` add

```
if (Filters.Matches(oSession)) {
    oSession.Ignore();
    return;
}
```

