```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install zsh
brew install tmux
brew install fzf
brew install font-hack-nerd-font
brew install autossh
brew install ncdu
brew install neovim
brew install node
brew install postgresql
brew install ripgrep

./install.sh

cat << EOF > ~/.ipython/profile_default/ipython_config.py
heredoc> c = get_config()
c.InteractiveShellApp.extensions.append("autoreload")
EOF
```
