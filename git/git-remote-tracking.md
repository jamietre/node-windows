## Remote Tracking

Some hints for managing forks and tracking upstream changes.

### Sync your local clone with upstream

Add the remote, call it "upstream":

    git remote add upstream https://github.com/whoever/whatever.git

Fetch all the branches of that remote into remote-tracking branches, such as upstream/master:

    git fetch upstream

Make sure that you're on your master branch:

    git checkout master

Rewrite your master branch so that any commits of yours that
aren't already in upstream/master are replayed on top of that
other branch:

    git rebase upstream/master


    