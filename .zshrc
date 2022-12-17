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

if [ -f ~/.env ]; then
  set -o allexport; source ~/.env; set +o allexport
fi

#   Set Paths
#   ------------------------------------------------------------
export PATH="/usr/local/git/bin:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/go/bin:/opt/homebrew/bin:$PATH"

#   Set Default Text Editor
#   ------------------------------------------------------------
export EDITOR=/usr/local/bin/code

#   Set TTY for GPG
export GPG_TTY=$(tty)

#   SSH Forwarding for Secretive Agent
export SSH_AUTH_SOCK=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

[[ -f ~/.config/aliases.sh ]] && source ~/.config/aliases.sh
[[ -f ~/.config/functions.sh ]] && source ~/.config/functions.sh
[[ -f ~/.config/starship.sh ]] && source ~/.config/starship.sh
[[ -f ~/.config/nvm.sh ]] && source ~/.config/nvm.sh

#   Starship Prompt
eval "$(starship init zsh)"
