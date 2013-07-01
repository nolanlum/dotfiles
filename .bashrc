# .bashrc

case $OSTYPE in
    solaris*)  DOMAINNAME=domainname ;;
    linux-gnu)  DOMAINNAME=dnsdomainname ;;
esac
DOMAIN=$($DOMAINNAME)

###############################################################################
#
# Source configs based on DNS domain
#
###############################################################################
case $DOMAIN in
ocf.berkeley.edu)
    MAIL=/var/mail/${LOGNAME:?}
    if [ `/usr/bin/whoami` != "root" ]; then
        if [ -r /opt/ocf/share/environment/.bashrc ]; then
            source /opt/ocf/share/environment/.bashrc
        fi
    fi
    ;;
CS.Berkeley.EDU | EECS.Berkeley.EDU)
    [[ -z ${MASTER} ]] && export MASTER=${LOGNAME%-*}
    [[ -z ${MASTERDIR} ]] && export MASTERDIR=$(eval echo ~${MASTER})
    [[ -e ${MASTERDIR}/adm/class.bash_profile ]] && . ${MASTERDIR}/adm/class.bash_profile
    ;;
esac

###############################################################################
#
# Source global definitions
#
###############################################################################
if [ -r /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -r /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -r /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -r ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

###############################################################################
#
# Color and format the prompt prettily
#
###############################################################################
# Git niceness to put current git branch into PS1
function parse_git_branch {
    [[ -e `which git 2> /dev/null` && "/" != `git rev-parse --show-toplevel 2>/dev/null` ]] && git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

export PS1='$(parse_git_branch)'"\[\e[35m\][\[\e[0;36m\]\u\[\e[31m\]@\[\e[32m\]\h\[\e[m\] \[\e[35m\]\W\[\e[35m\]]\[\e[m\]\$ "

###############################################################################
#
# Environment variable exports
#
###############################################################################
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export CLICOLOR=1

# Don't export xterm if we already exported screen (probably remote ssh)
[ "$TERM" != "screen-256color" ] && export TERM='xterm-256color'
# Only export screen if we're in tmux.
[ -n "$TMUX" ] && export TERM=screen-256color
export TERM=xterm-256color

###############################################################################
#
# User specific aliases
#
###############################################################################
alias ltmux="(cd $HOME; if tmux has 2> /dev/null; then tmux -u attach; else tmux -u new; fi)"
case $OSTYPE in
    solaris*)   alias ls='ls -G' ;;
    freebsd*)   alias ls='ls -G' ;;
    linux-gnu)  alias ls='ls -lhLHF --color=auto --group-directories-first' ;;
    darwin*)    alias ls="ls -lhLHF" ;;
    *)          alias ls='ls' ;;
esac
alias bldapsearch="ldapsearch -h ldap.berkeley.edu -x -b dc=berkeley,dc=edu"
alias serial="screen -R -- /dev/cu.KeySerial1"
alias ocf-lp="ssh tsunami.ocf.berkeley.edu lp"

###############################################################################
#
# Hostname-specific aliasing
#
###############################################################################
case `hostname` in
    ack2.berkeley.edu)
        # old RHEL doesn't recognize --group-directories-first
        alias ls='ls -lhLHF --color=auto'
        alias vihours='nano ~/hours/`date +%Y-%m`'
    ;;
esac

