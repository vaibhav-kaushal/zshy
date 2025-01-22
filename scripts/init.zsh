#!/usr/bin/env zsh

# Run Pre-init script
source ${0:a:h}/pre_init.zsh

# Initialize builtin utilities
source ${0:a:h}/builtin/init.zsh

ZSHY_EXT_HOME=""
if [[ -d "$HOME/bin/zshy/extensions" ]]; then
  # Set the ZSHY_EXT_HOME
  ZSHY_EXT_HOME="$HOME/bin/zshy/extensions"
fi
export ZSHY_EXT_HOME

# Initialize the installed utilities
source ${0:a:h}/installed/init.zsh

# Run Post-init script
source ${0:a:h}/post_init.zsh
