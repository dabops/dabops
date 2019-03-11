#!/bin/bash
# Simple script that generate a Node.js microservice
# You must specify the complete url of the git repository and the name of your project

git=$1
nameOfTheProject=$2
circleCiPath=".circleci/"
circleCiConfig="$circleCiPath/config.yml"

defaultTemplateCI="# Javascript Node CircleCI 2.0 configuration file
#
# Check https://circleci.com/docs/2.0/language-javascript/ for more details
#
version: 2
jobs:
  $nameOfTheProject:
    docker:
      # User of the circleci official node version 9.2
      - image: circleci/node:9.2

    steps:
      # Checkout code
      - checkout

      - restore_cache:
          key: dependency-cache-{{ checksum 'package.json' }}

      # install all dependencies
      - run:
          name: npm-install
          command: npm install

      - save_cache:
          key: dependency-cache-{{ checksum 'package.json' }}
          paths:
            - ./node_modules

      # run tests suit
      - run:
          name: test
          command: npm test

workflows:
  version: 2
  tagged-build:
    jobs:
      - $nameOfTheProject
"

dockerFile="# Pull an LTS Alpine linux (~5MB) environment with
# Node already install on it.
FROM node:lts-alpine

# Create the folder 'app' under /usr/src/
# We add a '/' after 'app' to specify the type of
# app (ie: a folder)
RUN mkdir -p /usr/src/app/

# We specify the newly created folder app that
# it's where our command should be executed
WORKDIR /user/src/app/

# We copy the package.json in the 'app' folder
COPY package.*json /user/src/app/

# We install our dependencies
RUN npm install

# Security reason
RUN npm i npm@latest

# We copy our project in the 'app' folder
COPY . .

# We expose to our docker environment (network) the port
# we are using within the application. (ie 80)
EXPOSE 80

# We specify how we start our application
# CF package.json
CMD [ \"npm\", \"start\" ]
"

npmInit="{
  \"name\": \"$nameOfTheProject\",
  \"version\": \"1.0.0\",
  \"description\": \"[![CircleCI](https://circleci.com/gh/dabops/$nameOfTheProject.svg?style=svg)](https://circleci.com/gh/dabops/$nameOfTheProject)\",
  \"main\": \"index.js\",
  \"scripts\": {
    \"test\": \"mocha\"
  },
  \"repository\": {
    \"type\": \"git\",
    \"url\": \"git+$git\"
  },
  \"author\": \"\",
  \"license\": \"ISC\",
  \"bugs\": {
    \"url\": \"${git::-4}/issues\"
  },
  \"homepage\": \"${git::-4}#readme\",
  \"dependencies\": {
    \"mocha\": \"^6.0.2\"
  }
}"

cd microservices
mkdir "$nameOfTheProject"
cd "$nameOfTheProject"
git clone "$git"
mkdir "$circleCiPath"

echo "$defaultTemplateCI" >> "$circleCiConfig"
echo "$dockerFile" >> "Dockerfile"

echo "$npmInit" >> "package.json"
npm install


touch "index.js"

mkdir test
echo "var assert = require('assert');
describe('Array', function() {
  describe('#indexOf()', function() {
    it('should return -1 when the value is not present', function() {
      assert.equal([1, 2, 3].indexOf(4), -1);
    });
  });
});
" >> "test/test.js"

npm test

echo "$nameOfTheProject" >> ../../repositories.txt
