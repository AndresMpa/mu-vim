#!/bin/bash

git switch main
cp -r ./UltiSnips ..
git switch singleFile
rm -rf ./UltiSnips
mv ../UltiSnips .
git add .
if [[ `git status --porcelain` ]]; then
	git commit -am "Updating snippets"
	git push
else
  echo "Ok"
fi
