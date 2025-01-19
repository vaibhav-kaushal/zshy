#!/usr/bin/env zsh

function zx() {
	case $1 in
	r | run)
		shift
		local funcdirpath
		local funcfilepath
		if [[ $# -eq 0 ]]; then
			debugmsg "zx r got no args"
			__zx_usage "$0" "$1"
			return
		fi

		funcdirpath="$ZEXT_INSTALL_DIR/installed/extensions/$1"
		funcfilepath="$ZEXT_INSTALL_DIR/installed/extensions/$1/$1.zsh"

		# Check that the directory exists
		if [ -e "$funcdirpath" ]; then
			# Path exists, check if it is a file.
			if [ -f "$funcdirpath" ]; then
				# It is a file.
				echo "$0 is a file. It should have been a directory."
				return 2
			fi

			# Should be a directory
			if [ -d "$funcdirpath" ]; then
				# Check that it is not a symbolic link
				if [ -L "$funcdirpath" ]; then
					echo "'$0' is a symlink to a directory. Symlinks are not supported."
					return 2
				fi
			else
				echo "'$0' does not seem to be installed!"
				return 4
			fi
		else
			echo "Function does not seem to be installed: $funcdirpath"
			return 5
		fi

		# Looks like it is installed.
		# Check that the script exists
		if [ -e "$funcdirpath" ]; then
			# Path exists, check if it is a file.
			if [ -f "$funcfilepath" ]; then
				# It is a file. Execute it
				shift
				source $funcfilepath
			else
				echo "$funcfilepath needs to be a file. It is not!"
			fi
		else
			echo "Function $1 does not seem to be installed properly. File $funcfilepath does not exist"
			return 5
		fi
		;;
	i | install)
		shift
		local curr_dir
		if [ -z "$1" ]; then
			echo "Supply git repo address please"
		else
			echo "Install directory is: $ZEXT_INSTALL_DIR"
			echo "going to run 'git clone $1' in $ZEXT_INSTALL_DIR/installed/extensions"

			curr_dir=$(pwd)
			cd $ZEXT_INSTALL_DIR/installed/extensions
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
				cd $ZEXT_INSTALL_DIR/installed/extensions
				pr green "You should now 'cd' to the newly created directory and run 'rm -rf .git' there."
				return 0
			else
				echo "You chose not to delete the .git directory from the newly created directory."
				echo "If you do want to do that, remember the function are located here: $ZEXT_INSTALL_DIR/installed/extensions"
				cd $curr_dir
			fi
		fi
		;;
	c | check)
		shift
		local funcdirpath
		local funcfilepath
		if [[ $# -eq 0 ]]; then
			debugmsg "zx c got no args"
			__zx_usage "$0" "$1"
			return
		fi

		funcdirpath="$ZEXT_INSTALL_DIR/installed/extensions/$1"
		funcfilepath="$ZEXT_INSTALL_DIR/installed/extensions/$1/$1.zsh"
		# Check that the directory exists
		if [ -e "$funcdirpath" ]; then
		  # Must not be a symbolic link
			if [ -L "$funcdirpath" ]; then
				return 1
			fi

			# Must be a directory
			if [ -d "$funcdirpath" ]; then
				# file must be present
				if [ -f "$funcfilepath" ]; then
					return 0
				else
					return 2
				fi
			else
				return 3
			fi
		else
			return 4
		fi
		;;
	help | *)
		echo "$0 helps you work with the Zsh eXtensions."
		;;
	esac

}

function __zx_usage() {
	if [[ $# -ne 2 ]]; then
		echo "You are not supposed to run this function manually"
		return
	fi

	case $2 in
	r | run)
		echo "$1 $2 allows you run an extension installed by the user"
		echo "Usage: $1 $2 program program_args"
		echo "  The program is the name of the installed function"
		;;
	i | install)
		echo "$1 $2 allows you to install an extension in the extensions directory"
		echo "Usage: $1 $2 repo_address"
		echo "  The repo_address is a git repository address that is accessible from the current env"
		echo "  Please ensure that you are able to access that repository."
		;;
	c | check)
	  echo "$1 $2 will test if the extension is installed or not (returns 0 if it is installed)"
		echo "Usage $1 $2 ext_name "
		echo "  The ext_name is the name of the extension which you want to check if it is installed"
		;;
	*)
		echo "You are not supposed to call this function manually"
		;;
	esac
}
