# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="risto"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git hg svn)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias la='LC_COLLATE="C" ls -AlF --group-directories-first'
alias ll='la'
alias lx='ls -lXF --group-directories-first'

alias topu="top -u $USER"
alias htopu="htop -u $USER"

# Disable circling over menu items after double <TAB>
setopt noautomenu
setopt nomenucomplete

setopt promptsubst

# Enable vi mode
bindkey -v

bindkey "^W" backward-kill-word    # vi-backward-kill-word
bindkey "^H" backward-delete-char  # vi-backward-delete-char
bindkey "^U" kill-line             # vi-kill-line
bindkey "^?" backward-delete-char  # vi-backward-delete-char

# History search
# Vi mode
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward

# Custom colors (vim last256 color scheme)
COLOR_GREEN=$FG[071]
COLOR_RED=$FG[167]
COLOR_GREY=$FG[240]
COLOR_YELLOW=$FG[221]
COLOR_BLUE=$FG[069]
COLOR_PURPLE=$FG[105]

PROMPT_COLOR_PATH=$COLOR_BLUE
PROMPT_COLOR_VCS=$COLOR_PURPLE
PROMPT_COLOR_ERROR=$COLOR_RED
PROMPT_COLOR_MODE=$COLOR_GREY
PROMPT_COLOR_TIME=$COLOR_YELLOW
PROMPT_COLOR_USER="%(!.$COLOR_RED.$COLOR_GREEN)"

# Vi mode indicator
vi_mode="insert"

zle-keymap-select() {
  vi_mode="insert"
  [[ $KEYMAP = vicmd ]] && vi_mode="normal"
  () { return $__prompt_status }
  zle reset-prompt
}
zle-line-init() {
  typeset -g __prompt_status="$?"
}
zle -N zle-keymap-select
zle -N zle-line-init

# VCS customization
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:*:*' max-exports 4
zstyle ':vcs_info:*:*' formats "%{$PROMPT_COLOR_VCS%}|%s:%r| (%b) [%S]" "[" "%R" "] "
zstyle ':vcs_info:*:*' nvcsformats "%{$PROMPT_COLOR_PATH%}[%~]" "" "" ""


PROMPT="%{$PROMPT_COLOR_USER%}[%n@%M]%{$reset_color%} %{$PROMPT_COLOR_MODE%}("'${vi_mode}'")%{$reset_color%} "'${vcs_info_msg_0_}'"%{$reset_color%}
%(?..%{$PROMPT_COLOR_ERROR%}<%?> )%{$reset_color%}%{$PROMPT_COLOR_USER%}%(!.#.$)%{$reset_color%} "
RPROMPT="%{$PROMPT_COLOR_PATH%}"'${vcs_info_msg_1_}${(D)vcs_info_msg_2_}${vcs_info_msg_3_}'"%{$reset_color%}%{$PROMPT_COLOR_TIME%}[%*]%{$reset_color%}"
