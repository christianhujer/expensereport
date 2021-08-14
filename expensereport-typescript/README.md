# expensereport-typescript
The ExpenseReport refactoring example in TypeScript.

## Technologies used
1. Typescript as the main programming language
2. Jest as the testing framework
3. Eslint as the linting tool
4. Prettier as the formatting tool

## Prerequisites
1. NVM installed on your machine from [here](https://github.com/nvm-sh/nvm)

## Setup instructions
```shell
./configure.sh  # will use nvm to install and activate the appropriate version of node
npm test # will run all the tests
npm bulid # will create a build of the project
node build/output.js # will run the compiled output
npm run format:check # runs the linter and formatter rules
npm run format:fix # applies a fix to the fixable issues 
```
