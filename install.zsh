#!/usr/bin/env zsh

# Set the installation folder to ~/.zshy
if [[ -v ZSHY_HOME && ! -d ZSHY_HOME ]]; then
  # ZSHY is installed already
  echo "It looks like ZSHY scripts are already installed."
  echo "You might want to upgrade it, maybe (currently upgrading automatically is not supported)"
  return 1
fi

ZSHY_HOME=$HOME/.zshy

# Make sure that git is installed
if ! type "git" > /dev/null; then
  # command does not exist
  echo "git is not available in PATH"
  return 1
fi

# We will store the current path in a variable so that we return to it after installation is done.
__currdir=$(pwd)

# Change to the directory where the installer script is present
cd ${0:a:h}

# Make the directory for installing .zshy
echo "Making directory for storing scripts ($ZSHY_HOME)"
mkdir -p $ZSHY_HOME
if [ $? -ne 0 ]; then
  echo "Creating the scripts home directory ($ZSHY_HOME) failed. Cannot continue!"
  return 1
fi

# copy files in the zsh/scripts to the newly created directory
echo "Copying scripts to scripts home..."
cp -rv zshy/* $ZSHY_HOME

echo "The installer, to make life a bit easy for you, can create a 'bin' directory"
echo "in your home directory and add it to your PATH. It would also create the"
echo "'zshy' directory and the 'init.zsh' file inside it, if it does not exist."
read -k 1 "choice?Do you want to continue? [y/n] "
echo ""
  
binf="$HOME/bin/zshy"
bininit="$binf/init.zsh"

if [[ $choice == "Y" || $choice == "y" ]]; then
  # We have to create the 'bin' directory and the 'zshy' directory in it
  create_bininit="no"
  echo "You opted to create the $bininit file."

  if [[ -d "$binf" ]]; then
    echo "The directory $binf already exists."
    echo -n "Checking for the 'init.zsh' file... "
    if [[ -f "$bininit" ]]; then
      echo "already exists"
    else
      echo "does not exist"
      # We need to create the init file
      create_bininit="yes"
  elif [[ -f "$binf" ]]; then
    echo "The path $binf already exists but is a file."
  else
    echo "The path $binf does not exist. Creating the directory..."
    mkdir -p "$binf"
    if [[ $? -eq 0 ]]; then
      echo "Directory created successfully."
      create_bininit="yes"
    else
      echo "Failed to create directory."
    fi
  fi

  if [[ $create_bininit == "yes" ]]; then
    echo "Creating the file: $bininit"
  
    echo "#!/usr/bin/env zsh\n\n" > "$bininit"
  
    if [ $? -ne 0 ]; then
      echo "Creating the $bininit file failed!"
    else
      echo "# Place your shell initialization instructions such as updates to your \$PATH, aliases," >> "$bininit"
      echo "# custom functions etc. in this file. This file is source'd on each shell initialization\n\n" >> "$bininit"
      echo "...success"
    fi
  fi
else
  echo "You opted to not create the $bininit file."
fi  

# Since this will work only on the next startup, for now, let's initialize the functions right now
echo "Trying to enable the scripts right now."
echo "For complete effect, please close this shell and start a new one"
source $ZSHY_HOME/init.zsh

