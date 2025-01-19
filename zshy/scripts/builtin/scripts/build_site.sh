#!/usr/bin/env zsh

# Although this file is named build_site.sh, it actually pushes the site, not builds it.

echo "===== Starting run at $(date +%Y-%m-%d_%H-%M-%S) IST ====="
echo "Changing to personal site"
cd $HOME/code/vaibhav-kaushal.github.io

if [ -z "$(git status --porcelain)" ]; then
  echo "Working directory clean. Nothing to do! Still, pushing"
  git push
else
  echo "Uncommited changes. Adding directory."
  git add . 
  echo "Committing"
  git commit -m "Committing at $(date +%Y-%m-%d_%H-%M-%S) IST"
  echo "Pushing..."
  git push
fi

echo "Changing to techrail site"
cd $HOME/code/techrail.in

if [ -z "$(git status --porcelain)" ]; then
  echo "Working directory clean. Nothing to do! Still, pushing"
  git push
else
  echo "Uncommited changes. Adding directory."
  git add . 
  echo "Committing"
  git commit -m "Committing at $(date +%Y-%m-%d_%H-%M-%S) IST"
  echo "Pushing..."
  git push
fi


