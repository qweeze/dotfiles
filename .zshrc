autoload -U colors && colors
PROMPT="%m %{${fg_bold[red]}%}:: %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[blue]}%}»%{${reset_color}%} "

# limitless zsh history
HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=$HISTSIZE

# auto start tmux
if [ -z "$TMUX" ]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi

# fzf
source <(fzf --zsh)

# aliases
alias vi=nvim
alias ls="ls --color=auto"

# socksproxy
socksproxy () {
    if [[ "$1" == "start" ]]
    then
	    echo "Starting SOCKS5 proxy at localhost:1080"
	    pkill -f sockstunnel
	    bash -c "exec -a sockstunnel autossh -M 0 -D 1080 -q -C -N qweeze@box &"
    elif [[ $1 == "stop" ]]
    then
	    echo "Stopping SOCKS5 proxy"
	    pkill -f sockstunnel
    else
	    echo "Usage: socksproxy [start|stop]"
    fi
}

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"

export REQUESTS_CA_BUNDLE="$HOME/tochka/ca.pem"
export SSL_CERT_FILE="$HOME/tochka/ca.pem"
export BAT_THEME="gruvbox-dark"

# ipdb debugger
export PYTHONBREAKPOINT=ipdb.set_trace


# Ctrl+F for fast cd
hiderun() {
    tput cuu 1  # Move cursor up one line.
    tput sc  # Save cursor position.
    "$@"  # Execute the given command.
    tput rc  # Restore the cursor position.
    tput ed  # Clear to the end of the screen.
}
cd_with_fzf() {                                                                                                                                                         ~
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}
bindkey -s '^f' 'hiderun cd_with_fzf\n'


venv() {
    curr_dir=$(pwd)
    while [[ $curr_dir != '/' ]]; do
        if [[ -d "$curr_dir/venv" ]]; then
            source "$curr_dir/venv/bin/activate"
            break
        elif [[ -d "$curr_dir/.venv" ]]; then
            source "$curr_dir/.venv/bin/activate"
            break
        fi
        curr_dir=$(dirname $curr_dir)
    done
}

# activate venv if exists in current project
venv


[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
