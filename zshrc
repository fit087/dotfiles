# Author  : Andrew Sidlo
# Modified: Apr 23, 2019

# Printing colors

#-----------------------------------------
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
#-----------------------------------------

red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
nc=$'\e[0m'

warn="${yel}WARN :${nc}"
error="${red}ERROR:${nc}"
info="INFO :"

#==============================================================================
# Zsh Setting {{{
#==============================================================================
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

POWERLEVEL9K_MODE="nerdfont-complete"

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='|'
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''
POWERLEVEL9K_PYTHON_ICON="(.py)"
POWERLEVEL9K_JAVA_ICON="(.java)"
POWERLEVEL9K_GO_ICON="(.go)"
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_ETC_ICON=''
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_DIR_NOT_WRITABLE_BACKGROUND='clear'
POWERLEVEL9K_DIR_NOT_WRITABLE_FOREGROUND='magenta'
POWERLEVEL9K_ANACONDA_BACKGROUND='clear'
POWERLEVEL9K_ANACONDA_FOREGROUND='green'
POWERLEVEL9K_ANACONDA_RIGHT_DELIMITER=""
POWERLEVEL9K_ANACONDA_LEFT_DELIMITER=""
POWERLEVEL9K_PYENV_BACKGROUND='clear'
POWERLEVEL9K_PYENV_FOREGROUND='green'
POWERLEVEL9K_VIRTUALENV_BACKGROUND='clear'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='magenta'
POWERLEVEL9K_JAVA_VERSION_FOREGROUND='red'
POWERLEVEL9K_JAVA_VERSION_BACKGROUND='clear'
POWERLEVEL9K_GO_VERSION_FOREGROUND='cyan'
POWERLEVEL9K_GO_VERSION_BACKGROUND='clear'
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir anaconda pyenv java_version go_version vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time background_jobs_joined)
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="clear"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="yellow"
POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"
POWERLEVEL9K_STATUS_OK_BACKGROUND="clear"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
POWERLEVEL9K_TIME_BACKGROUND="clear"
POWERLEVEL9K_TIME_FOREGROUND="cyan"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='clear'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='magenta'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='clear'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='green'

# }}}
#==============================================================================
# Pyenv {{{
#==============================================================================
# Load pyenv automatically by appending
# the following to ~/.zshrc:
# . /Users/asidlo/.pyenv/versions/anaconda3-2018.12/etc/profile.d/conda.sh
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# }}}
#==============================================================================
# Functions {{{
#==============================================================================
function get_go_version {
    if [ -x "$(command -v go)" ]; then
        go version | cut -d' ' -f3 | sed 's/go//g'
    else
        printf "$error go executable not found in path, cannot determine version for GOROOT" >&2
    fi
}

# }}}
#==============================================================================
# Environment Variables {{{
#==============================================================================
# Useful, but is setup now to always be in some sort of virtualenv via pyenv
# and also is buggy when using conda based environments
export PIP_REQUIRE_VIRTUALENV=false
export HISTFILESIZE=1000000000
export HISTSIZE=1000000
export GRADLE_OPTS=-Xmx4096m
export GOPATH=~/Documents/workspace/go
export GOROOT=/usr/local/Cellar/go/$(get_go_version)/libexec
export LESS="-F -X $LESS"
export SCRIPTS_HOME="/Users/asidlo/Documents/Workspace/scripts"
export VISUAL=vim
export EDITOR="$VISUAL"
export PYTHON_CONFIGURE_OPTS="--enable-framework"
export PATH=$PATH:$GOPATH/bin

# }}}
#==============================================================================
# Aliases {{{
#==============================================================================
# Misc Aliases {{{
#==============================================================================
alias cls=clear
alias vi=vim
alias copy=pbcopy
alias csv="column -t -s,"
alias javas="$SCRIPTS_HOME/java-home.sh"
alias zshrc='${=EDITOR} ~/.zshrc'
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias tree="tree -C"


# }}}
#==============================================================================
# Docker Aliases {{{
#==============================================================================
alias dm="docker-machine"

alias dcb='docker-compose build'
alias dcdn='docker-compose down'
alias dce='docker-compose exec'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'
alias dco=docker-compose
alias dcps='docker-compose ps'
alias dcpull='docker-compose pull'
alias dcr='docker-compose run'
alias dcrestart='docker-compose restart'
alias dcrm='docker-compose rm'
alias dcstart='docker-compose start'
alias dcstop='docker-compose stop'
alias dcup='docker-compose up'
alias dcupd='docker-compose up -d'

# }}}
#==============================================================================
# Tig Aliases {{{
#==============================================================================
alias tib='tig blame -C'
alias til='tig log'
alias tis='tig status'

# }}}
#==============================================================================
# File Aliases {{{
#==============================================================================
alias md="mkdir -p"
alias mv='mv -i'

alias rd=rmdir
alias rm='rm -i'

alias cp='cp -i'

alias l='ls -lFh'
alias lS='ls -1FSsh'
alias la='ls -lAFh'
alias lart='ls -1Fcart'
alias ldot='ls -ld .*'
alias ll='ls -l'
alias lr='ls -tRFh'
alias lrt='ls -1Fcrt'
alias ls='ls -G'
alias lsa='ls -lah'
alias lt='ls -ltFh'
alias ldir="ls -d */"

alias d='dirs -v | head -10'

alias fd='find . -type d -name'
alias ff='find . -type f -name'

# }}}
#==============================================================================
# Git Aliases {{{
#==============================================================================
for git_alias in $(git --list-cmds=alias); do
    alias g$git_alias="git $git_alias"
done

function extract_git_aliases() {
    local git_aliases=(`git --list-cmds=alias`)
    echo "Alias,Command"
    echo "-----,--------------------------------------------------------------------------------"
    for a in $git_aliases; do
        # Trim the desc for pretty output print
        local cmd=$(git config -l | grep "alias.$a=" | cut -d= -f2- | cut -c 1-80)
        echo "$a,$cmd"
    done
}

alias gla="extract_git_aliases | column -t -s,"
alias gal="extract_git_aliases | column -t -s,"

# }}}
#==============================================================================
# }}}
#==============================================================================
# Other Useful Git Aliases {{{
#==============================================================================
# g=git
# ga='git add'
# gaa='git add --all'
# gap='git apply'
# gapa='git add --patch'
# gau='git add --update'
# gav='git add --verbose'
# gb='git branch'
# gbD='git branch -D'
# gba='git branch -a'
# gbd='git branch -d'
# gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
# gbl='git blame -b -w'
# gbnm='git branch --no-merged'
# gbr='git branch --remote'
# gbs='git bisect'
# gbsb='git bisect bad'
# gbsg='git bisect good'
# gbsr='git bisect reset'
# gbss='git bisect start'
# gc='git commit -v'
# 'gc!'='git commit -v --amend'
# gca='git commit -v -a'
# 'gca!'='git commit -v -a --amend'
# gcam='git commit -a -m'
# 'gcan!'='git commit -v -a --no-edit --amend'
# 'gcans!'='git commit -v -a -s --no-edit --amend'
# gcb='git checkout -b'
# gcd='git checkout develop'
# gcf='git config --list'
# gch='git checkout hotfix'
# gcl='git clone --recurse-submodules'
# gclean='git clean -fd'
# gcm='git checkout master'
# gcmsg='git commit -m'
# 'gcn!'='git commit -v --no-edit --amend'
# gco='git checkout'
# gcount='git shortlog -sn'
# gcp='git cherry-pick'
# gcpa='git cherry-pick --abort'
# gcpc='git cherry-pick --continue'
# gcr='git checkout release'
# gcs='git commit -S'
# gcsm='git commit -s -m'
# gd='git diff'
# gdca='git diff --cached'
# gdct='git describe --tags `git rev-list --tags --max-count=1`'
# gdcw='git diff --cached --word-diff'
# gds='git diff --staged'
# gdt='git diff-tree --no-commit-id --name-only -r'
# gdw='git diff --word-diff'
# gf='git fetch'
# gfa='git fetch --all --prune'
# gfl='git flow'
# gflf='git flow feature'
# gflff='git flow feature finish'
# gflfp='git flow feature publish'
# gflfpll='git flow feature pull'
# gflfs='git flow feature start'
# gflh='git flow hotfix'
# gflhf='git flow hotfix finish'
# gflhp='git flow hotfix publish'
# gflhs='git flow hotfix start'
# gfli='git flow init'
# gflr='git flow release'
# gflrf='git flow release finish'
# gflrp='git flow release publish'
# gflrs='git flow release start'
# gfo='git fetch origin'
# gg='git gui citool'
# gga='git gui citool --amend'
# ggpull='git pull origin "$(git_current_branch)"'
# ggpur=ggu
# ggpush='git push origin "$(git_current_branch)"'
# ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
# ghh='git help'
# gignore='git update-index --assume-unchanged'
# gignored='git ls-files -v | grep "^[[:lower:]]"'
# git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
# gk='\gitk --all --branches'
# gke='\gitk --all $(git log -g --pretty=%h)'
# gl='git pull'
# glg='git log --stat'
# glgg='git log --graph'
# glgga='git log --graph --decorate --all'
# glgm='git log --graph --max-count=10'
# glgp='git log --stat -p'
# glo='git log --oneline --decorate'
# globurl='noglob urlglobber '
# glod='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'
# glods='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'' --date=short'
# glog='git log --oneline --decorate --graph'
# gloga='git log --oneline --decorate --graph --all'
# glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
# glola='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --all'
# glols='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --stat'
# glp=_git_log_prettily
# glum='git pull upstream master'
# gm='git merge'
# gma='git merge --abort'
# gmom='git merge origin/master'
# gmt='git mergetool --no-prompt'
# gmtvim='git mergetool --no-prompt --tool=vimdiff'
# gmum='git merge upstream/master'
# gp='git push'
# gpd='git push --dry-run'
# gpf='git push --force-with-lease'
# 'gpf!'='git push --force'
# gpoat='git push origin --all && git push origin --tags'
# gpristine='git reset --hard && git clean -dfx'
# gpsup='git push --set-upstream origin $(git_current_branch)'
# gpu='git push upstream'
# gpv='git push -v'
# gr='git remote'
# gra='git remote add'
# gradle=gradle-or-gradlew
# grb='git rebase'
# grba='git rebase --abort'
# grbc='git rebase --continue'
# grbd='git rebase develop'
# grbi='git rebase -i'
# grbm='git rebase master'
# grbs='git rebase --skip'
# grep='grep --color'
# grh='git reset'
# grhh='git reset --hard'
# grm='git rm'
# grmc='git rm --cached'
# grmv='git remote rename'
# groh='git reset origin/$(git_current_branch) --hard'
# grrm='git remote remove'
# grset='git remote set-url'
# grt='cd $(git rev-parse --show-toplevel || echo ".")'
# gru='git reset --'
# grup='git remote update'
# grv='git remote -v'
# gsb='git status -sb'
# gsd='git svn dcommit'
# gsh='git show'
# gsi='git submodule init'
# gsps='git show --pretty=short --show-signature'
# gsr='git svn rebase'
# gss='git status -s'
# gst='git status'
# gsta='git stash save'
# gstaa='git stash apply'
# gstall='git stash --all'
# gstc='git stash clear'
# gstd='git stash drop'
# gstl='git stash list'
# gstp='git stash pop'
# gsts='git stash show --text'
# gsu='git submodule update'
# gts='git tag -s'
# gtv='git tag | sort -V'
# gunignore='git update-index --no-assume-unchanged'
# gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
# gup='git pull --rebase'
# gupa='git pull --rebase --autostash'
# gupav='git pull --rebase --autostash -v'
# gupv='git pull --rebase -v'
# gwch='git whatchanged -p --abbrev-commit --pretty=medium'
# gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'
# }}}
# =============================================================================

if [ ! -d ~/.nvm ]; then
    echo "Creating directory for nvm at: ~/.nvm"
    mkdir ~/.nvm
fi
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# This loads nvm bash_completion
# [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/asidlo/.sdkman"
[[ -s "/Users/asidlo/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/asidlo/.sdkman/bin/sdkman-init.sh"

# vim:foldmethod=marker
