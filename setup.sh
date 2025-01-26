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

ResetEnv () {
  [[ -d ~/.config ]] && rm -rf ~/.config
  [[ -f ~/.bashrc ]] && rm -rf ~/.bashrc
  [[ -f ~/.zshrc ]] && rm -rf ~/.zshrc
  [[ -f ~/.gitconfig ]] && rm -rf ~/.gitconfig
}

DotfilesConfig () {
  if [ -d "$HOME/repos/dotfiles" ]
  then
    echo "Linking dotfiles"
    mkdir $HOME/.config
    mkdir $HOME/.config/ghostty

    if [ "$SHELL" == "/bin/bash" ]
    then
      ln -s $HOME/repos/dotfiles/.bashrc $HOME/.bashrc
      ln -s $HOME/repos/dotfiles/.config/aliases.sh $HOME/.config/aliases.sh
      ln -s $HOME/repos/dotfiles/.config/nvm.sh $HOME/.config/nvm.sh
      ln -s $HOME/repos/dotfiles/.config/starship.sh $HOME/.config/starship.sh
      ln -s $HOME/repos/dotfiles/.config/functions.sh $HOME/.config/functions.sh
      ln -s $HOME/repos/dotfiles/.config/ghostty/config $HOME/.config/ghostty/config
    fi
    if [ "$SHELL" == "/bin/zsh" ]
    then
      ln -s $HOME/repos/dotfiles/.zshrc $HOME/.zshrc
      ln -s $HOME/repos/dotfiles/.config/aliases.sh $HOME/.config/aliases.sh
      ln -s $HOME/repos/dotfiles/.config/nvm.sh $HOME/.config/nvm.sh
      ln -s $HOME/repos/dotfiles/.config/starship.zsh $HOME/.config/starship.zsh
      ln -s $HOME/repos/dotfiles/.config/functions.sh $HOME/.config/functions.sh
      ln -s $HOME/repos/dotfiles/.config/ghostty/config $HOME/.config/ghostty/config

    fi
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
    -r|--reset)
      ResetEnv
      shift
      ;;
    *)
      break
      ;;
  esac
done
