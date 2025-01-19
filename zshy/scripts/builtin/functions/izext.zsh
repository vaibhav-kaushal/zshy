#!/usr/bin/env zsh

function izext() {
  local curr_dir
	if [ -z "$1" ]; then
		echo "Supply git repo address please"
	else
		echo "Install directory is: $ZEXT_INSTALL_DIR"
    echo "going to run 'git clone $1' in $ZEXT_INSTALL_DIR/installed/functions"

    curr_dir=$(pwd)
    cd $ZEXT_INSTALL_DIR/installed/functions 
    git clone $1
    if [[ $? -ne 0 ]]; then
      echo "looks like that failed"
      cd $curr_dir
      return 1
    fi

    pr magenta "You should remove the .git folder from the newly created folder."
    pr blue --no-newline "Do you want to remove the .git folder from the target directory? [y/n] "
    read -k 1 choice
    echo ""

    if [[ $choice == "y" || $choice == "Y" ]]; then
      cd $ZEXT_INSTALL_DIR/installed/functions
      pr green "You should now 'cd' to the newly created directory and run 'rm -rf .git' there."
      return 0
    else
      echo "You chose not to delete the .git directory from the newly created directory."
      echo "If you do want to do that, remember the function are located here: $ZEXT_INSTALL_DIR/installed/functions"
      cd $curr_dir
    fi
	fi	
}

function izext_oneliner() {
	echo "izext: installs extensions to this scripts system"
}