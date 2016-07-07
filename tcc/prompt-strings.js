
var spawn = require('child_process').spawn;
var arg = process.argv[process.argv.length-1].toLowerCase();

app(arg)


function app(arg) {
    switch(arg) {
        case "git-prompt": 
            var path = shortPath();
            function outputPrompt(status) {
                var fmt ="[$E[0;32m"+ path + "$E[0;37m]$E[0;36m"+status+"$e[0m$g ";
                console.log(fmt);
            }

            gitStatus(outputPrompt);
            break;
        case "git-status":
            return gitStatus(console.log.bind.console);
            break;
        case "short-path":
            return shortPath();
            break;
    }
}
    

function gitStatus(done) {
    
    //var child = spawn("git", ["status","-s","-b","--porcelain"]);
    var child = spawn("git", ["status","-s","-b","--porcelain"]);
    var stdout="";
    var stderr="";

    child.stdout.on('data', function(e) {
        stdout+=e;
    });

    child.stderr.on('data', function(e) {
        stderr+=e;
    });

    child.on('close', function(e) {
        if (!stdout && stderr && stderr.indexOf("Not a git repository")<=0) {
            done(' ?')
        } else {
            done(parseStatus(stdout));
        }
    });
    
}

// last 2 segments of path
function shortPath() {
    var parts = process.cwd().replace(/\\/g, '/').split('/');
    return parts.slice(-2).join('/');
}

function parseStatus(text) {
    var lines = text.replace(/\r\n/g, '\n')
        .replace(/\n\n/g,'\n')
        .replace(/^\s+|\s+$/, '') // final newline
        .split('\n');

   // format ## master...origin/master [ahead 2]
   // format ## master...origin/master [behind 2]

    var branch = "";
    var offset = "";
    var changed = "";

    if (lines.length)
    {
        if (lines.length > 1)
        {
            changed = "*";
        }

        var text = lines[0];
        var pos = text.indexOf("...");
        
        if (pos >= 0) {
            branch = text.substring(3, pos);
        } else {
            branch = text.substring(3);
        }

        pos = text.indexOf("[", Math.max(pos, 0));
        if (pos >= 0) {
            offset = text.substring(pos).trim().replace("ahead ", "+").replace("behind ", "-");
        }

        if (branch)
        {
            branch = " " + changed + branch + offset;
        }
    }
    return branch;
}


