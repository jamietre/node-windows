## Git Merging

There are a number of different ways to perform merges.

### Fast Forward

### Cherry Picking

This allows you to merge specific commits to the branch. E.g. 

    git checkout master
    git cherry-pick 24054b --no-commit

### Rebasing

This allows you to apply all commits (or a range) onto a branch

##### Catch a feature branch up with master


    git checkout feature
    git rebase master
    git checkout master
    git merge --squash feature_branch

The last step does this:

``Produce the working tree and index state as if a real merge happened (except for the merge information), but do not actually make a commit or move the HEAD, nor record $GIT_DIR/MERGE_HEAD to cause the next git commit command to create a merge commit. This allows you to create a single commit on top of the current branch whose effect is the same as merging another branch (or more in case of an octopus).``

##### Apply all commits from a point forward
  
    git rebase master ^24054b

### Merge your branch to master

Assuming changes are committed to the branch:

    git checkout master
    git pull 
    git merge **some-branch**
    git push origin master