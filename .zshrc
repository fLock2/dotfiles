source /home/flock/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
# antigen theme minimal 
antigen theme spaceship-prompt/spaceship-prompt
# Tell Antigen that you're done.
antigen apply 

alias in="paru -S"
#alias dup="paru -Syu"
alias dup="sudo pacman -Sy && sudo powerpill -Su && paru -Su"
alias rp="paru -R"
alias fuck='sudo $(fc -ln -1)'
alias gcl="git clone"
alias gcm="git commit -m"
alias gpl="git pull"
alias gph="git push origin master"
alias gad="git add"
alias grm="git remove"
alias srst="scrot ~/Pictures/Screenshots/%b%d::%H%M%S.png" 
alias crst="scrot -s ~/Pictures/Screenshots/%b%d::%H%M%S.png"
alias vim="nvim"
alias ncmpcpp="ncmpcpp-ueberzug"
alias xref="xrdb ~/.Xresources"
alias listpkg="comm -23 <(paru -Qqett | sort) <(paru -Qqg base -g base-devel | sort | uniq)"
alias ls="exa -la"
alias lock="betterlockscreen -l"
# Copy file with a progress bar
cpp()
{
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

	# Extracts any archive(s) (if unp isn't installed)
extract () {
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}
