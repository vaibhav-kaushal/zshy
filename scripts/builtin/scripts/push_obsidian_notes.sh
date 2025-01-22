#!/usr/bin/env zsh

echo "===== Starting run at $(date +%Y-%m-%d_%H-%M-%S) IST ====="
cd "/Users/vaibhavkaushal/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian"
echo "Currently in $(pwd)"
echo "About to git push"

git add .
git commit -m "Auto-update commit on personal mac at $(date +%Y-%m-%d_%H-%M-%S) IST"
git push origin master
if [[ $? -ne 0 ]]; then
	osascript -e 'display notification "`git push origin master` failed" with title "Obsidian Push Failed"'
fi

echo "About to git pull"
git pull origin master
if [[ $? -ne 0 ]]; then
	osascript -e 'display notification "`git pull origin master` failed" with title "Obsidian Pull Failed"'
fi
