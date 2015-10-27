## NPM Module Format

This is an overview of best practices for structuring NPM modules. We propose the following:

##### Script configuration

Each module should include at a minimum the following npm scripts. `build`, `lint` and `format` are conventions we use 

* `build`: should cause the module to be built completely such that it can be used by an ECMA5-only capable consumer. Note that *build* is not a predefined script hook so it must be invoked with `npm run build`.
* `test`: should run all unit tests, only if linting succeeds
* `pretest`: should run prerequisites for unit tests, typically as `lint`.
* `lint`: should run only the syntax validation scripts
* `format`: run scripts to automatically format source files, only if linting succeeds
* `prepublish`: should, [by convention](https://github.com/npm/npm/issues/3059), invoke the build script, most likely just as `npm run build`, and possibly other tasks required before publication

If a pre-event script fails, sich as `pretest`, the actual script invoked will not run. Therefore, if `pretest` runs linting, then running `npm test` will not run the actual tests if linting fails, 

#####Module Structure

* `src` folder contains module source files in whatever format (ES2015, TypeScript, etc).
* `test` folder contains unit tests 
* `dist` folder contains compiled files in ECMA5 format. There is a one-to-one relationship between files in `dist` and files in `src`.
* `dist/map` contains source map files named `filename.js.map`, mapping one-to-one to files in `dist`
* `assets` contains any non-javascript assets. 
* `assets/css` contains css
* `assets/images` contains images
* `assets/templates` contains templates such as handlebars
* `assets/html` contains html files
* ... etc

Rationale for `assets` folder location: the `dist` folder should be completely rebuildable from scratch when running `npm run build`. If non-javascript assets are distributed under the `dist` folder, then either they must be copied from another location on build, or the `dist` folder must be checked into source control, and is no longer safe to delete, and must be cleaned to avoid committing compiled code to source control.

Therefore the simplest solution is to keep the assets folder at the same level as the `dist` folder. This avoids the need to copy files to the output folder on a build, and avoids needing to maintain the actual `dist` folder in any way. Since all non-javascript assets should only be directly referred to by the code itself, using relative paths such as `../assets/css/style.css` will easily locate the files. 

#####Other conventions

* Module names always are scoped, probably with the organization name .e.g `@frobozz`
* Optional repository field should be populated.
* `main` should link to the entry point in `dist` *unless* the source is ECMA5, in which case in should just link to `src`, and there may be no build. 
* linting should be applied against the source, ensure that the `.jshintrc` contains directives needed to lint ES6
* The `.gitignore` file should explicitly exclude the `dist` and `node_modules` folders
* The `.npmignore` file should explicitly exclude the `src` folder
 
#####Example

######package.json 
	
	{
	  "name": "@frobozz/utility.strings",
	  "version": "1.0.7",
	  "description": "A set of utilities for manipulating strings",
	  "main": "dist/index.js",
	  "scripts": {
	    "pretest": "jshint src",
	    "test": "mocha test",
	    "build": "gulp build",
	    "prepublish": "npm run build"
	  },
	  "keywords": [],
	  "author": "Frobozz Magic Cave Company",
	  "license": "Copyright 2015",
	  "dependencies": {
	    "any-promise": "^0.1.0",
	    "babel-runtime": "^5.8.20",
	    "underscore": "^1.8.0"
	  },
	  "devDependencies": {
	    "babel": "^5.8.21",
	    "bluebird": "^2.10.0",
	    "gulp-babel": "^5.2.1",
	    "gulp-sourcemaps": "^1.5.2",
	    "mocha": "^2.3.2"
	  },
	  "repository": {
	    "type": "git",
	    "url": "http://tfs-git:8080/tfs/frobozz-code/common/_git/utility-strings"
	  }
	}

######.gitignore

    dist/
    node_modules/

######.npmignore

	.gitignore
	test/
	src/

######.jshintrc

	{
		"esnext": "true",
		"asi": true,
		"node": true,
		"predef": ["-Promise"]
	}

#####gulpfile.js

	var gulp = require('gulp');
	var babel = require('gulp-babel');
	var sourcemaps = require('gulp-sourcemaps');
	var rimraf = require('rimraf')
	var path = require('path')
	
	gulp.task('watch', function () {
		gulp.watch('./src/**/*.js', function(evt) {
			// evt.type = add, change, delete
			// evt.path
			rimraf(path.join(__dirname, 'dist/*'), function() {
				build()	
			})
			
		})
	});
	
	function build() {
		return gulp.src('src/**/*.js')
	     	.pipe(sourcemaps.init())
	        .pipe(babel({ 
	        	optional: ['runtime']
	         }))
	        .pipe(sourcemaps.write('.'))
	        .pipe(gulp.dest('./dist'));
	}
	
	gulp.task('build', function () {
	    return build()
	});
	
	gulp.task('default', ['build']);
