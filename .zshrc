umask 022

HISTFILE="$HOME/.zsh-history"
HISTSIZE=100000
SAVEHIST=100000

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin
export JAVA_HOME=/Library/Java/Home
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export PERL_BADLANG=0
export TZ=JST-9
export SVN_SSH="ssh -2"
export SVN_EDITOR=vim
export EDITOR=vim
export LESS='-g -i -M -R -S -W -z-4 -x4'

autoload -U compinit; compinit -u
autoload colors; colors
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

compctl -k _ssh_hosts ssh
compctl -S ':' -k _ssh_hosts + -f scp
compctl -c man
compctl -c sudo
compctl -l '' nohup exec nice eval time sudo man

# Options
setopt auto_cd
setopt auto_remove_slash
setopt pushd_ignore_dups
setopt auto_pushd
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt prompt_subst
setopt correct
setopt braceccl
setopt list_packed

# vcs
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' formats "%F{blue}%s%F{white}-%F{blue}%b"
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}+"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}-"
zstyle ':vcs_info:git:*' formats "%F{blue}%b%c%u"

# color aliases
local        BLACK=$'%{\e[0;30m%}'
local          RED=$'%{\e[0;31m%}'
local        GREEN=$'%{\e[0;32m%}'
local        BROWN=$'%{\e[0;33m%}'
local         BLUE=$'%{\e[0;34m%}'
local         CYAN=$'%{\e[0;36m%}'
local   LIGHT_GRAY=$'%{\e[0;37m%}'
local    DARK_GRAY=$'%{\e[1;30m%}'
local    LIGHT_RED=$'%{\e[1;31m%}'
local  LIGHT_GREEN=$'%{\e[1;32m%}'
local       YELLOW=$'%{\e[1;33m%}'
local   LIGHT_BLUE=$'%{\e[1;34m%}'
local LIGHT_PURPLE=$'%{\e[1;35m%}'
local   LIGHT_CYAN=$'%{\e[1;36m%}'
local        WHITE=$'%{\e[1;37m%}'
local      DEFAULT=$'%{\e[1;m%}'

# zstyles
# highlight completion candidates
LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors di=34 ln=35 so=32 pi=33 ex=31 bd=46 34 cd=43 su=41 sg=46 tw=42 ow=43
# Upper case will match when you type lower case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# set prompt
vcs_msg0='${vcs_info_msg_0_}'
PROMPT="%(?.$YELLOW.$RED)%(!.#.$) $WHITE"
RPROMPT="$RED%(?..%?) $vcs_msg0 $YELLOW$USER$WHITE@$GREEN%m$LIGHT_GRAY:$LIGHT_PURPLE%~$WHITE"

# agent forwarding
if [ "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/auth_sock" ]; then
    if [ ! -S $HOME/.ssh/auth_sock ]; then
        ln -fs $SSH_AUTH_SOCK $HOME/.ssh/auth_sock
        export SSH_AUTH_SOCK=$HOME/.ssh/auth_sock
    fi
fi

# my aliases
alias         cp='cp -v'
alias         rm='rm -v'
alias         mv='mv -v'
alias         ls='ls -FG --color=auto'
alias          l='ls -lh'
alias         ll='ls -l'
alias         la='ls -Al'
alias          s='screen -D -RR'
alias          h='history'
alias      tailf='tail -F'
alias        vim='vim -p'
alias       grep='grep --color=auto'
alias          e='echo $?'
alias       motd='cat /etc/motd'
alias       wget='wget --content-disposition'
alias    json_pp='python -m json.tool'
alias dstat-full='dstat -tclmdrn'

# key bind
bindkey -e

# find grep functions
function find-grep {
    find . -type f ! -path '*/.svn*' ! -path '*/.git*' -print0 | xargs -0 grep -i -n --color=auto --binary-files=without-match -e "$@"
}

function f {
    find $@ ! -path '*/.svn*' ! -path '*/.git*'
}

cmd2screen_window () {
    if [[ "$TERM" = "screen" ]]; then
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})

        case $cmd[1] in
            fg)
                if [ $#cmd == 1 ]; then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*)
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if [[ $#cmd == 2 ]]; then
                    cmd[1]=$cmd[2]
                fi
                ;&
            *)
                echo -n "k$cmd[1]\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
            echo -n "k$cmd[1]\\") 2>/dev/null
    fi
}
add-zsh-hook preexec cmd2screen_window

# export PATH="$HOME/.rbenv/bin:$PATH"
# export PATH="$HOME/.plenv/bin:$PATH"
# eval "$(plenv init -)"
# export PATH=/usr/local/opt/mysql@5.6/bin/:$PATH
# export LD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$LD_LIBRARY_PATH
# export CPATH=/usr/local/opt/openssl/include:$CPATH
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home

