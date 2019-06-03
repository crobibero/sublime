autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() {
    vcs_info
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
PROMPT="%F{cyan}%n%f %B%F{black}@%f%b %F{magenta}%M%f in %F{yellow}%~%f%(1j.%F{blue} %j%f.)${NEWLINE}%(?.%F{green}➜%f.%F{red}➜%f) "
