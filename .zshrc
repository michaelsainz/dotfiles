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
export PATH="/usr/local/git/bin:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/go/bin:/opt/homebrew/bin:$PATH"

#   Set Default Text Editor
#   ------------------------------------------------------------
export EDITOR=/usr/local/bin/code

#   Set TTY for GPG
export GPG_TTY=$(tty)

#   SSH Forwarding for Secretive Agent
export SSH_AUTH_SOCK=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh
[[ -f ~/.zsh/nvm.zsh ]] && source ~/.zsh/nvm.zsh
[[ -f ~/.env ]] && source ~/.env

#   Starship Prompt
eval "$(starship init zsh)"
