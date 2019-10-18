# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

###############################################################################
#
# Path extension
#
###############################################################################
# Primarily set based on hostname.
case $HOSTNAME in
ack*.berkeley.edu)
    PATH=$HOME/vim/bin:$HOME/python/bin:$PATH:$HOME/local/bin
;;
*.ocf.berkeley.edu)
    PATH=$PATH:$HOME/local/bin
;;
*.EECS.Berkeley.EDU|*.CS.Berkeley.EDU)
    PATH=$HOME/bin:$PATH
;;
esac

# OS X will change the system hostname to correspond to the DNS hostname,
# so include Homebrew paths here.
case $OSTYPE in
darwin*)
    PATH=/usr/local/sbin:$HOME/bin:$PATH
    export GOPATH=$HOME/golang

    if [ -f ~/.iterm2_shell_integration.bash ]; then
        . ~/.iterm2_shell_integration.bash
    fi

    VSCODE_BINDIR="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    if [ -d "$VSCODE_BINDIR" ]; then
        PATH=$PATH:$VSCODE_BINDIR
    fi

    EDITOR="mvim -f"
    VISUAL="mvim -f"
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

# Display uncommitted dotfile changes.
[[ -e `which git 2> /dev/null` && -n "`git status -uno --porcelain`" ]] && \
    echo -e "\nThere are uncommitted dotfile changes:" &&
    git status -suno

# Check to see if upstream master has changed.
[ "`git ls-remote origin -h refs/heads/master | cut -f1`" \
    != "`git rev-list --max-count=1 origin/master`" ] && \
    git pull

