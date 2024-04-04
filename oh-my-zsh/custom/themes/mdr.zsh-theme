# mdr theme
# Mike D Richman theme, originally based on "ys"
#
# http://ysmood.org/wp/2013/03/my-ys-terminal-theme/
# Mar 2013 ys

# Directory info
local current_dir='${PWD/#$HOME/~}'

# VCS
MDR_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
MDR_VCS_PROMPT_PREFIX2="%{$fg[cyan]%}"
MDR_VCS_PROMPT_SUFFIX="%{$reset_color%}"
MDR_VCS_PROMPT_DIRTY=" %{$fg[red]%}⚡"
MDR_VCS_PROMPT_CLEAN=" %{$fg[green]%}✅"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${MDR_VCS_PROMPT_PREFIX1}${MDR_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$MDR_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$MDR_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$MDR_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
    # make sure this is a hg dir
    if [ -d '.hg' ]; then
	echo -n "${MDR_VCS_PROMPT_PREFIX1}hg${MDR_VCS_PROMPT_PREFIX2}"
	echo -n $(hg branch 2>/dev/null)
	if [ -n "$(hg status 2>/dev/null)" ]; then
	    echo -n "$MDR_VCS_PROMPT_DIRTY"
	else
	    echo -n "$MDR_VCS_PROMPT_CLEAN"
	fi
	echo -n "$MDR_VCS_PROMPT_SUFFIX"
    fi
}

# Prompt format: \n # USER at MACHINE in DIRECTORY on BRANCH STATE [TIME] \n $
PROMPT="
%{$terminfo[bold]$fg[blue]%}# ${current_dir}%{$reset_color%}\
${hg_info}\
${git_info} \
%{$fg[white]%}[%*]
%{$terminfo[bold]$fg[blue]%}$ %{$reset_color%}"


# vim: ft=zsh sw=4 sts=4
