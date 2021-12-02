#!/bin/bash

git switch main
cp -r ./UltiSnips ..
git switch singleFile
rm -rf ./UltiSnips
mv ../UltiSnips .
git add .
git commit -am "Updating snippets"
