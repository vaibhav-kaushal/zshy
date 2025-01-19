#!/usr/bin/env zsh

export ZEXT_INSTALL_DIR=${0:a:h}

# Run Pre-init script
source ${0:a:h}/pre_init.zsh

# Initialize builtin utilities
source ${0:a:h}/builtin/init.zsh
# Initialize the installed utilities
source ${0:a:h}/installed/init.zsh

# Run Post-init script
source ${0:a:h}/post_init.zsh
