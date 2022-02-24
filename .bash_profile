# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

###############################################################################
#
# Path extension and integrations
#
###############################################################################

case $OSTYPE in
darwin*)
    PATH=/usr/local/sbin:$HOME/bin:$PATH

    if [ -f ~/.iterm2_shell_integration.bash ]; then
        . ~/.iterm2_shell_integration.bash
    fi

    VSCODE_BINDIR="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    if [ -d "$VSCODE_BINDIR" ]; then
        PATH=$PATH:$VSCODE_BINDIR
    fi

    if [ -d /usr/local/opt/fzf/shell ]; then
        . /usr/local/opt/fzf/shell/completion.bash
        . /usr/local/opt/fzf/shell/key-bindings.bash
    fi

    [ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"

    export N_PREFIX="$HOME/n"
    [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
;;
esac

export PATH

###############################################################################
#
# Miscellaneous niceties
#
###############################################################################
# Disable terminal flow-control since that makes C-s do weird things.
stty ixany
stty ixoff -ixon
stty stop undef
stty start undef

# Multi-terminal history
shopt -s cmdhist
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=100000
HISTIGNORE='ls:bg:fg:history'
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Display uncommitted dotfile changes.
[[ -e `which git 2> /dev/null` && -n "`git status -uno --porcelain`" ]] && \
    echo -e "\nThere are uncommitted dotfile changes:" &&
    git status -suno

# Check to see if upstream master has changed.
[ "`git ls-remote origin -h refs/heads/master | cut -f1`" \
    != "`git rev-list --max-count=1 origin/master`" ] && \
    git pull

