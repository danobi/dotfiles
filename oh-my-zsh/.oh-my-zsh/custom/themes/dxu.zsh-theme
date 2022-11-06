local ret_status="%(?::%{$fg[red]%}[%?] )"
PROMPT='${ret_status}%{$fg[cyan]%}[%~]%{$reset_color%}$(git_prompt_info) $ '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
