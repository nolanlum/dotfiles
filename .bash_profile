# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$HOME/vim/bin:$HOME/python/bin:$PATH:$HOME/local/bin
export PATH

export PS1="\[\e[35m\][\[\e[0;36m\]\u\[\e[31m\]@\[\e[32m\]\h\[\e[m\] \[\e[35m\]\W\[\e[35m\]]\[\e[m\]\$ "
