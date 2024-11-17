#!/bin/zsh

emacs -Q --script ~/Sites/lab-files-site/build-site.el
cd ~/Sites/lab-files-site/
git pull origin main
git add -A
git commit -m "building the site again"
git push origin main