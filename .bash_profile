# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

case $HOSTNAME in
ack*.berkeley.edu)
    PATH=$HOME/vim/bin:$HOME/python/bin:$PATH
;;
*.ocf.berkeley.edu)
    PATH=$PATH:$HOME/local/bin
;;

export PATH
