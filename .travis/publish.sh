#!/bin/bash

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  sed -i "/ENV\ ICE_VERSION/c\ENV\ ICE_VERSION\ $NEW_VERSION" Dockerfile
  git checkout -b gh-pages
  git add . *.html
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  git remote add origin-pages https://${GH_TOKEN}@github.com/MVSE-outreach/resources.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-pages gh-pages 
}

#setup_git
commit_website_files
upload_files
echo "Testing"
