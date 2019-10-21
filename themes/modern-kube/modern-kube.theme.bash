# Modified version of the modern time theme in bash-it
# add kube namespace and gcp project

SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"
SCM_GIT_CHAR="${bold_green}±${normal}"
SCM_SVN_CHAR="${bold_cyan}⑆${normal}"
SCM_HG_CHAR="${bold_red}☿${normal}"

case $TERM in
	xterm*)
	TITLEBAR="\[\033]0;\w\007\]"
	;;
	*)
	TITLEBAR=""
	;;
esac

PS3=">> "

is_vim_shell() {
	if [ ! -z "$VIMRUNTIME" ]
	then
		echo "[${cyan}vim shell${normal}]"
	fi
}

modern_scm_prompt() {
	CHAR=$(scm_char)
	if [ $CHAR = $SCM_NONE_CHAR ]
	then
		return
	else
		echo "[$(scm_char)][$(scm_prompt_info)]"
	fi
}

modern_current_time_prompt() {
	echo "[$(date '+%l:%M%p')]"
}

modern_current_ns_prompt() {
	echo "*$(kubectl config current-context)"
}

modern_current_gcp_prompt() {
	echo "|☁$(gcloud config get-value project)"
}

prompt() {
	if [ $? -ne 0 ]
	then
		# Yes, the indenting on these is weird, but it has to be like
		# this otherwise it won't display properly.

		PS1="${TITLEBAR}${bold_red}┌─${reset_color}$(modern_scm_prompt)$(modern_current_ns_prompt)$(modern_current_gcp_prompt)$(modern_current_time_prompt)[${cyan}\W${normal}]$(is_vim_shell)
${bold_red}└─▪${normal} "
	else
		PS1="${TITLEBAR}┌─$(modern_scm_prompt)$(modern_current_ns_prompt)$(modern_current_gcp_prompt)$(modern_current_time_prompt)[${cyan}\W${normal}]$(is_vim_shell)
└─▪ "
	fi
}
PS2="└─▪ "



safe_append_prompt_command prompt
