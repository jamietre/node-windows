## .gitignore

`.gitignore` shows files to be ignored by `git add`. The basic syntax is

`node_modules/` -- ignore all folders called 'node_modules'
`*.orig` -- ignore all files ending with '.orig'. (Any file without a slash is matched with simple pattern matching.)
`src/**/*.log` -- ignore all files ending with '.log' in the `src` folder, and subfolders. (Any pattern that contains a slash, but doesn't end with a slash, is treated as a glob.)

#### When does it apply?

It is only applied **when you run git add**. So if you update `.gitignore`, anything already tracked in your repo will not be affected. Typically, you want to clean things up when you change `.gitignore`. This will ensure your tracked files are in sync with your `.gitignore`:

    git rm -r --cached .
    git add .

You can check `git status` to see what happened, you should see deletes if files were untracked.

