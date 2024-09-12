# Example for @angular-architects/module-federation

This examples loads a microfrontend into a shell:

![Microfrontend Loaded into Shell](./result.png)

## Important Files

Have a particular look at the following files:

- ``readme.md``: Shows how to install dependencies and how to start the example
- ``projects\ruben\webpack.config.js``: Microfrontend config

## Installation and Usage

- Install packages: ``npm`` || ``yarn`` (!)*
- Start Micro Frontend (remote): ``ng serve ruben -o``
- Make sure ``ruben`` is started before ``shell`` is loaded into the browser

## Create a new Module

- Download this repo as a .zip format
- Extract the downloaded repo and rename folder for the new project name ('module-federation-new-module') or create the project folder and extract files in folder
- Delete .git folder if exists
- Install dependencies with npm: 'npm install'
- Rename project package name
<pre>
    # Package.json file

    "name": "module-federation-new-module",
</pre>
<pre>
    # Package-lock.json file

   	"name": "module-federation-new-module",
    "packages": {
        "": {
            "name": "module-federation-new-module",
        }
    }
</pre>
- Update port number of project
<pre>
    # Package.json file

    "start:new-module": "ng serve new-module -o --port 5001",
    "serve:dist": "serve dist/new-module -l 5001 -s",
</pre>
<pre>
    # Angular.json file

    "options": {
        "publicHost": "http://localhost:5001",
        "port": 5001,
        "extraWebpackConfig": "projects/new-module/webpack.config.js"
    }
</pre>
- Rename app project name (Scripts, tests, build...)
<pre>
    # Package.json file

    "start:new-module": "ng serve new-module -o --port 5001",
    "start": "npm run start:new-module",
    "build:new-module": "ng build new-module --prod",
    "build": "npm run build:new-module",
    "serve:dist": "serve dist/new-module -l 5001 -s",
</pre>
<pre>
    # Angular.json file
    
    "projects": {
		"new-module": {
			"projectType": "application",
			"schematics": {
				"@schematics/angular:application": {
					"strict": true
				}
			},
			"root": "projects/new-module",
			"sourceRoot": "projects/new-module/src",
			"prefix": "app",
			"architect": {
				"build": {
					"builder": "ngx-build-plus:browser",
					"options": {
						"outputPath": "dist/new-module",
						"index": "projects/new-module/src/index.html",
						"main": "projects/new-module/src/main.ts",
						"polyfills": "projects/new-module/src/polyfills.ts",
						"tsConfig": "projects/new-module/tsconfig.app.json",
						"assets": [
							"projects/new-module/src/favicon.ico",
							"projects/new-module/src/assets"
						],
						"styles": [
							"./node_modules/bootstrap/dist/css/bootstrap.min.css",
							"projects/new-module/src/styles.css"
						],
						"scripts": [
							"./node_modules/jquery/dist/jquery.min.js",
							"./node_modules/@popperjs/core/dist/umd/popper.min.js",
							"./node_modules/bootstrap/dist/js/bootstrap.min.js"
						],
						"extraWebpackConfig": "projects/new-module/webpack.config.js",
						"commonChunk": false
					},
					"configurations": {
						"production": {
							"budgets": [
								{
									"type": "initial",
									"maximumWarning": "500kb",
									"maximumError": "1mb"
								},
								{
									"type": "anyComponentStyle",
									"maximumWarning": "2kb",
									"maximumError": "4kb"
								}
							],
							"fileReplacements": [
								{
									"replace": "projects/new-module/src/environments/environment.ts",
									"with": "projects/new-module/src/environments/environment.prod.ts"
								}
							],
							"outputHashing": "all",
							"extraWebpackConfig": "projects/new-module/webpack.prod.config.js"
						},
						"development": {
							"buildOptimizer": false,
							"optimization": false,
							"vendorChunk": true,
							"extractLicenses": false,
							"sourceMap": true,
							"namedChunks": true
						}
					},
					"defaultConfiguration": "production"
				},
				"serve": {
					"builder": "ngx-build-plus:dev-server",
					"configurations": {
						"production": {
							"browserTarget": "new-module:build:production",
							"extraWebpackConfig": "projects/new-module/webpack.prod.config.js"
						},
						"development": {
							"browserTarget": "new-module:build:development"
						}
					},
					"defaultConfiguration": "development",
					"options": {
						"publicHost": "http://localhost:5001",
						"port": 5001,
						"extraWebpackConfig": "projects/new-module/webpack.config.js"
					}
				},
				"extract-i18n": {
					"builder": "ngx-build-plus:extract-i18n",
					"options": {
						"browserTarget": "new-module:build",
						"extraWebpackConfig": "projects/new-module/webpack.config.js"
					}
				},
				"test": {
					"builder": "@angular-devkit/build-angular:karma",
					"options": {
						"main": "projects/new-module/src/test.ts",
						"polyfills": "projects/new-module/src/polyfills.ts",
						"tsConfig": "projects/new-module/tsconfig.spec.json",
						"karmaConfig": "projects/new-module/karma.conf.js",
						"assets": [
							"projects/new-module/src/favicon.ico",
							"projects/new-module/src/assets"
						],
						"styles": [
							"projects/new-module/src/styles.css"
						],
						"scripts": []
					}
				}
			}
		}
	}
</pre>
<pre>
    # Karma.conf.js

    coverageReporter: {
      dir: require('path').join(__dirname, '../../coverage/new-module'),
    }
</pre>
<pre>
    # App.e2e-spec.ts file
    # App.component.spec.ts file
    # README.md file

    Update 'ruben' for 'new-module' where you find the case in this files
</pre>
- Configure Webpack
<pre>
    # Webpack.config.js file
    # Update remote module name in 'name' property
    # Update remote module exposed route in 'exposes', update the route and module name with your new module name

    const { shareAll, withModuleFederationPlugin } = require('@angular-architects/module-federation/webpack');

    module.exports = withModuleFederationPlugin({
        name: 'new-module',
        exposes: {
            './Module': './projects/new-module/src/app/new-module/new-module.module.ts',
        },
        shared: {
            ...shareAll({ singleton: true, strictVersion: true, requiredVersion: 'auto' }),
        },
    });
</pre>
- Update project module folder 'projects/ruben' -> 'projects/new-module'
- Update test module folder 'projects/ruben/test' -> 'projects/new-module/new-module'
- Rename all test file names in 'projects/new-module/new-module' for new-module names, example 'test.module.ts' -> 'new-module.module.ts'
    - new-module.component.ts
        - Update component selector name 'app-new-module-component'
        - Update component new paths names example, templateUrl: './test.component.html' -> templateUrl: './new-module.component.html'
        - Update component name 'NewModuleComponent'
    - new-module.routes.ts
        - Update new module routes constant variable name 'NEW_MODULE_ROUTES'
        - Update first component route path and component name
    - new-module.module.ts
        - Update new module RouterModule routes variable import
        - Update declaration component name 'NewModuleComponent'
        - Update module class name 'NewModuleModule'
    - app.component.ts
        - Update TestModule import for NewModuleModule import
    - home.component.html
        - Update home title with new module name
        - Update test component link route '/new-module-component'
        - Update test component link text 'New module component'
    - index.html
        - Update title with the new module title
- In the host app (Shell) you need to declare the new module to consume it
    - decl.d.ts
        - declare module 'new-module/Module';
    - mf.manifest.json
        - "new-module": "http://localhost:5001/remoteEntry.js"