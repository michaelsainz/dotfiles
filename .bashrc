#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

set -o allexport; source ~/.env; set +o allexport

#   Set Paths
#   ------------------------------------------------------------
export PATH="/usr/local/git/bin:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/go/bin:$PATH"

#   Set Default Text Editor
#   ------------------------------------------------------------
export EDITOR=/usr/bin/nano

[[ -f ~/.bash/aliases.zsh ]] && source ~/.bash/aliases.zsh
[[ -f ~/.bash/functions.zsh ]] && source ~/.bash/functions.zsh
[[ -f ~/.bash/starship.zsh ]] && source ~/.bash/starship.zsh
[[ -f ~/.bash/nvm.zsh ]] && source ~/.bash/nvm.zsh
[[ -f ~/.env ]] && source ~/.env
