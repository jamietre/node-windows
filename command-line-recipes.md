## Command Line Recipes

Windows users are used to finding a GUI tool to do most things. A lot of common problems can be more easily solved from the command line. Here are some useful receipts.

### Test HTTP servers/REST endpoints

#### Send simple JSON

    curl -H "Content-Type: application/json" -d '{"username":"xyz","password":"xyz"}' http://localhost:5000/api/method

#### Send a file

Using `@-` as the target of `-d` will send stdin as the post body. Alternate syntax is `@filename.json`, however, this may not work on windows.

    curl -H "Content-Type: application/json" -d @- http://localhost:5000/api/method <package.json

