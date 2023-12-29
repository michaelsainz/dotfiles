#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH/ZSH configurations and aliases
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
export PATH="/usr/local/git/bin:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/go/bin:/Applications/Docker.app/Contents/Resources/bin/:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$(brew --prefix)/opt/python@3.12/libexec/bin:$PATH"

#   Set Default Text Editor
#   ------------------------------------------------------------
export EDITOR=/usr/local/bin/code

#   Set TTY for GPG
#   ------------------------------------------------------------
export GPG_TTY=$(tty)

#   SSH Forwarding for Secretive Agent
#   ------------------------------------------------------------
export SSH_AUTH_SOCK=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

#   Sourcing files for aliases and functions
#   ------------------------------------------------------------
[[ -f ~/.config/aliases.sh ]] && source ~/.config/aliases.sh
[[ -f ~/.config/functions.sh ]] && source ~/.config/functions.sh
[[ -f ~/.config/starship.zsh ]] && source ~/.config/starship.zsh
[[ -f ~/.config/nvm.sh ]] && source ~/.config/nvm.sh

#   ESP-IDF export script
#   ------------------------------------------------------------
export IDF_PATH=$HOME/esp/esp-idf
alias get_idf='. $HOME/esp/esp-idf/export.sh'

#   Starship Prompt
#   ------------------------------------------------------------
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh
eval "$(starship init zsh)"
