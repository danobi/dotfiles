# Git status config
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{blue}git:%F{red}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%f"
ZSH_THEME_GIT_PROMPT_CLEAN=
ZSH_THEME_GIT_PROMPT_DIRTY=*

# Import git helpers
source "${HOME}/.zsh-helpers/git.zsh"

# Put it all together
PROMPT='%(?::%F{red}[%?]%f )%F{cyan}[%~]%f$(git_prompt_info) $ '
