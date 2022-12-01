# .bashrc

###############################################################################
#
# Source configs based on arch
#
###############################################################################
case $MACHTYPE in
    arm64-apple*|aarch64-apple*)
        # Set PATH, MANPATH, etc., for Homebrew.
        eval "$(/opt/homebrew/bin/brew shellenv)"
        ;;
    x86_64-apple*)
        # Set PATH, MANPATH, etc., for Homebrew.
        eval "$(/usr/local/bin/brew shellenv)"
        ;;
esac

###############################################################################
#
# Source configs based on OS
#
###############################################################################
case $OSTYPE in
    darwin*)
        if type brew &>/dev/null; then
            HOMEBREW_PREFIX="$(brew --prefix)"
            if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
                source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
            else
                for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
                    [[ -r "$COMPLETION" ]] && source "$COMPLETION"
                done
            fi
        fi

        [ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
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
    [[ -e `which git 2> /dev/null` && ! "$HOME" -ef `git rev-parse --show-toplevel 2>/dev/null` ]] && git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

export PS1='$(parse_git_branch)'"\[\e[35m\][\[\e[0;36m\]\u\[\e[31m\]@\[\e[32m\]\h\[\e[m\] \[\e[35m\]\W\[\e[35m\]]\[\e[m\]\\$ "

###############################################################################
#
# Environment variable exports
#
###############################################################################
case $OSTYPE in
    linux-gnu)  EDITOR="vim" ;;
    darwin*)    EDITOR="mvim -f" ;;
esac
export VISUAL="$EDITOR"
export PAGER="less"
export CLICOLOR=1

# Don't export xterm if we already exported screen (probably remote ssh)
[ "$TERM" != "screen-256color" ] && export TERM='xterm-256color'
# Only export screen if we're in tmux.
[ -n "$TMUX" ] && export TERM=screen-256color

###############################################################################
#
# User specific aliases
#
###############################################################################
alias ltmux="(cd $HOME; if tmux has 2> /dev/null; then exec tmux -u attach; else exec tmux -u new; fi)"
LS='ls -lhALHF --color=auto --group-directories-first'
case $OSTYPE in
    linux-gnu)  alias ls='$LS' ;;
    darwin*)    alias ls='g$LS' ;;
    *)          alias ls='ls' ;;
esac
alias gcb="git checkout \$(git branch --sort=-committerdate --format '%(align:50)%(refname:short) %(end)%(objectname:short) %(contents:subject)' | fzf --height 10 | sed -E 's/ .*$//')"

# start tmux if requsted
[ -f "$HOME/.autotmux" ] && [ -z "$TMUX" ] && ltmux

