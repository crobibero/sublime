autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git

humanize_time() {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d days ' $D
  (( $H > 0 )) && printf '%d hrs ' $H
  (( $M > 0 )) && printf '%d mins ' $M
  (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%d secs\n' $S
}

precmd() {
	vcs_info

	if [ $timer ]; then
		local timer_show=$(($SECONDS - $timer))
		if [ -n "$TTY" ] && [ $timer_show -ge 3 ]; then
			export ZSH_COMMAND_EXEC_TIME=$(humanize_time "$timer_show")
		fi
		unset timer
	fi
}

preexec() {
	timer=${timer:-$SECONDS}
	export ZSH_COMMAND_EXEC_TIME=""
}

# Name	Number
# black	0
# red	1
# green	2
# yellow	3
# blue	4
# magenta	5
# cyan	6
# white	7
# https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg

autoload -U colors
setopt prompt_subst
zstyle ':vcs_info:git*' formats '%F{blue}%b%f in %F{2}%r/%S%f'
zstyle ':vcs_info:git:*' actionformats '%F{red}%a%f ⇋ %F{yellow}%b%f in %F{2}%r/%S%f'

NEWLINE=$'\n'
RPROMPT='${vcs_info_msg_0_}'
PROMPT='%F{cyan}%n%f %B%F{black}@%f%b %F{magenta}%M%f in %F{yellow}%~'
PROMPT+='%f%(1j.%F{cyan} %j%f.) %F{39}${ZSH_COMMAND_EXEC_TIME}%f${NEWLINE}%(?.%F{green}➜%f.%F{red}➜%f) '
