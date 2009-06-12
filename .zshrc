######################################################################
#	eisregen's zshrc file, v0.1 - based on:
#           jdong's zshrc file v0.2.1 , based on:
#		      mako's zshrc file, v0.1
#
# 
######################################################################

autoload -U promptinit compinit
compinit
promptinit

# next lets set some enviromental/shell pref stuff up
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST		# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME		# tries to resume command of same name
unsetopt BG_NICE		# do NOT nice bg commands
setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history
# setopt HASH_CMDS		# turns on hashing

setopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile


PATH="/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/usr/sbin:$PATH"
TZ="Europe"
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="`hostname`"
PAGER='vimpager'
EDITOR='vi'

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"

prompt walters

if [ -z $ONDESK ] ; then
	# if term isn't the deskterm
	#PS1="$(print '%# %{\e[0;31m%}%*%{\e[0m%}') | "
	PS1="$(print '[%{\e[0;31m%}%# @ lapt%{\e[0m%}')] | "
else
	PROMPT="> "
	RPROMPT=""
fi


LC_ALL='de_DE.UTF-8'
LANG='de_DE.UTF-8'
LC_CTYPE="de_DE.UTF-8"

unsetopt ALL_EXPORT

#autoload -U compinit
#compinit
#bindkey "^?" backward-delete-char
#bindkey '^[OH' beginning-of-line
#bindkey '^[OF' end-of-line
#bindkey '^[[5~' up-line-or-history
#bindkey '^[[6~' down-line-or-history
#bindkey "^r" history-incremental-search-backward
#bindkey ' ' magic-space    # also do history expansion on space
#bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps ax -o pid,s,nice,stime,args | sed "/ps/d"'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command' 
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') 
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show



#########################################################################

## functions
# help functions
function distrohelp
{
	echo "   .:: keybindings ::."
	echo "        apps"
	echo "            alt.esc    dmenu"
	echo "            alt.F1     terminal"
	echo "            alt.F2     gmrun"
	echo "            alt.F3     rox ~"
	echo "            alt.F5     gedit"
	echo "            alt.F6     sonata"
	echo "        sys"
	echo "            alt.F7     volume down"
	echo "            alt.F8     volume up"
	echo "        mpd"
	echo "            alt.F9     mpd play/pause"
	echo "            alt.F10    mpd stop"
	echo "            alt.F11    mpd prev"
	echo "            alt.F12    mpd next"
}

function aliaspacman
{
	echo "pacman aliases:"
	echo "pac     -  install"
	echo "pacy    -  install + update"
	echo "pacs    -  search installables"
	echo "pacu    -  install loc pkg"
	echo "pacr    -  rm pkg inc cfgs & deps"
	echo "pacqs   -  search installed"
	echo "pacqdt  -  list not longer reqd pkgs"
	echo "paclear -  clr cache compl"
	echo "upgrade -  upgrade entire sys"

	echo "aur     -  install from AUR"
}

# service ctrls
function srv_start
{
	for arg in $*; do
	sudo /etc/rc.d/$arg start
	done
}

function srv_restart
{
	for arg in $*; do
	sudo /etc/rc.d/$arg restart
	done
}

function srv_stop
{
	for arg in $*; do
	sudo /etc/rc.d/$arg stop
	done
}

# useful

#Translate a Word  - USAGE: translate house [german]  # See dictionary.com for available languages (there are many).
function translate
{
	if [ $# == 0 ]; then
		return
	fi

	if [ $# == 1 ]; then
		ARG2="german"
	else
		ARG2=$2
	fi

	TRANSLATED=`lynx -dump "http://dictionary.reference.com/browse/${1}" | grep -i -m 1 -w "${ARG2}:" | sed 's/^[ \t]*//;s/[ \t]*$//' | awk 'BEGIN { FS = "German:" } { print "german: "$2 }'`
	if [[ ${#TRANSLATED} != 0 ]] ;then
    	echo "\"${1}\" in ${TRANSLATED}"
    else
    	echo "Sorry, I can not translate \"${1}\" to ${ARG2}"
	fi
}

function extract
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       unrar e $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# fun
function sayhello
{
	echo "#-- ur >>fortune-cookie<< 4 2day --#"
#	fortune -o linux prog-style men-women paradoxum
	fortune -ae chucknorris paradoxum linuxcookie goedel linux
	echo ""
}

#########################################################################

## filebindings
alias -s jpg=feh
alias -s jpeg=feh
alias -s png=feh
alias -s gif=feh
alias -s rar=extract
alias -s tar=extract
alias -s gz=extract
alias -s zip=extract
alias -s bz2=extract

#########################################################################

## aliases

# file operations
alias ls='ls --color=auto --group-directories-first'
alias la='ls -lAh --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'

alias nwst='ls -lht . | sed -n 2p'

alias rmr='rm -r'
alias srm='sudo rm'
alias srmr='sudo rmr'

alias smkdir='sudo mkdir'

alias smount='sudo mount'
alias sumount='sudo umount'

alias cp='rsync -h --progress'
alias cpr='rsync -hr --progress'
alias scp='sudo rsync -h --progress'
alias scpr='sudo rsync -rh --progress'


# pacman
alias pac="sudo pacman -S"		# install
alias pacy="sudo pacman -Sy"		# install + update
alias pacs="sudo pacman -Ss"		# search installable
alias pacu="sudo pacman -U"		# install local pkg
alias pacr="sudo pacman -Rsn"		# remove given pkgs & cfgs & deps
alias pacqs="sudo pacman -Qs"		# search installed
alias pacqdt="sudo pacman -Qdt"		# show not longer required pkgs
alias paclear="sudo pacman -Scc"	# clr cache completely
alias upgrade="sudo pacman -Syu"	# upgrades the whole system
alias aur="sudo yaourt"		

# utils
alias grepi='grep -i'
alias svi='sudo vi'
alias deskterm='zsh -c "ONDESK=true urxvt -name deskterm"'

# vm's
alias vm_winxp='VirtualBox --startvm winxp'

# sync
alias sync_projects='unison /home/eisregen/Projekte ssh://ArchDesk/Projekte'


## start on open
if [ -z $ONDESK ] ; then
	# if term isn't the deskterm
	sayhello
fi
