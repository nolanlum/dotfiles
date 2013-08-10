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
esac

# OS X will change the system hostname to correspond to the DNS hostname,
# so include MacPorts and android-sdk paths here.
case $OSTYPE in
darwin*)
    PATH=/opt/local/bin:/opt/local/sbin:$PATH
    PATH=/android-sdk/platform-tools:/android-sdk/tools:$PATH
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

