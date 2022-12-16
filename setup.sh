#!/usr/bin/env bash

CodeSpacesDotfilesConfig () {
  echo "Dotsourcing config files"
  rm ~/.bashrc
  ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
}

InstallHomeBrew () {
  if [ ! -d /opt/homebrew ]
  then
    echo "Installing Brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew already installed"
  fi
}

InstallXcodeCLI () {
  echo "Checking Command Line Tools for Xcode"
  # Only run if the tools are not installed yet
  # To check that try to print the SDK path
  xcode-select -p &> /dev/null
  if [ $? -ne 0 ]; then
    echo "Command Line Tools for Xcode not found. Installing from softwareupdate..."
  # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
    PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
    softwareupdate -i "$PROD" --verbose;
  else
    echo "Command Line Tools for Xcode have been installed."
  fi
}

InstallBrewCaskApps () {
  if [ -f $HOME/Brewfile ]
  then
    echo "Installing apps"
    /opt/homebrew/bin/brew bundle install
  elif [ -f $HOME/repos/dotfiles/Brew/Brewfile ]
  then
    echo "Installing apps from dotfiles bundle location"
    /opt/homebrew/bin/brew bundle --file=$HOME/repos/dotfiles/Brew/Brewfile
  else
    echo "Brewfile not found in Dotfiles repo"
    /opt/homebrew/bin/brew bundle install
  fi
}

CloneDotfiles () {
  if [ ! -d $HOME/repos/dotfiles ]
  then
    echo "Cloning dotfiles"
    git clone https://github.com/michaelsainz/dotfiles.git $HOME/repos/dotfiles
    cd $HOME/repos/Dotfiles
    git switch initial
    cd $HOME
  fi
}

DotfilesConfig () {
  if [ -d "$HOME/repos/dotfiles" ]
  then
    echo "Linking dotfiles"
    mkdir $HOME/.zsh
    mkdir $HOME/.config
    ln -s $HOME/repos/dotfiles/.zshrc $HOME/.zshrc
    ln -s $HOME/repos/dotfiles/.zsh/aliases.zsh $HOME/.zsh/aliases.zsh
    ln -s $HOME/repos/dotfiles/.zsh/nvm.zsh $HOME/.zsh/nvm.zsh
    ln -s $HOME/repos/dotfiles/.zsh/starship.zsh $HOME/.zsh/starship.zsh
    ln -s $HOME/repos/dotfiles/.zsh/functions.zsh $HOME/.zsh/functions.zsh
    ln -s $HOME/repos/dotfiles/.bashrc $HOME/.bashrc
    ln -s $HOME/repos/dotfiles/.gitconfig $HOME/.gitconfig
    ln -s $HOME/repos/dotfiles/.config/starship.toml $HOME/.config/starship.toml
  fi
}

# Bash symlinking for Codespaces
# -----------------------------------------------------------------------------
if [ "$CODESPACES" == "true" ]
then
  echo "CodeSpaces environment detected"
  CodeSpacesDotfilesConfig
fi

while true; do
  case "$1" in
    -i|--init)
      echo "Installing Software"
      InstallXcodeCLI
      InstallHomeBrew
      CloneDotfiles
      DotfilesConfig
      InstallBrewCaskApps
      shift
      ;;
    -d|--dotfiles)
      DotfilesConfig
      shift
      ;;
    *)
      break
      ;;
  esac
done
