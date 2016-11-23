#!/bin/bash

# Variables to get from command line
[ ! -z "$1" ] || die "You must pass the folder path"
[ ! -z "$2" ] || die "You must pass an origin repository"

cd ${1}
git init
git add .
git commit -m 'Initial commit'
git remote add origin ${2}
git push  origin master
