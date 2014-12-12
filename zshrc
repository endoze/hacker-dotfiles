export PATH="$HOME/.rbenv/bin:$PATH"
export ANTIGEN=$HOME/.antigen.zsh
export DOTFILES=$HOME/.dotfiles
export PROJECTS=~/Projects
export DEFAULT_USER="endoze"
export ZSH_THEME="bira"
export DISABLE_AUTO_UPDATE="false"
export DISABLE_AUTO_TITLE=true

# setup rbenv
eval "$(rbenv init -)"

source $ANTIGEN

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  bundler
  git
  rails
EOBUNDLES

antigen theme bira

antigen apply

setopt completealiases

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# ENVIRONMENT VARIABLES
export CLICOLOR="YES"
export LSCOLORS=ExFxCxDxBxegedabagacad
export EDITOR="vim"

# SHELL FUNCTIONS
extract () {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2) tar -jxvf $1 ;;
      *.tar.gz) tar -zxvf $1 ;;
      *.bz2) bunzip2 $1 ;;
      *.dmg) hdiutil mount $1 ;;
      *.gz) gunzip $1 ;;
      *.tar) tar -xvf $1 ;;
      *.tbz2) tar -jxvf $1 ;;
      *.tgz) tar -zxvf $1 ;;
      *.zip) unzip $1 ;;
      *.ZIP) unzip $1 ;;
      *.pax) cat $1 | pax -r ;;
      *.pax.Z) uncompress $1 --stdout | pax -r ;;
      *.Z) uncompress $1 ;;
      *) echo "'$1' cannot be extracted/mounted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

_rspec_command () {
  if [ -e "bin/rspec" ]
  then
    bin/rspec $@
  else
    bundled_rspec $@
  fi
}

_run_without_bundle () {
  $@
}

_attach_completion () {
  declare -a tmux_sessions
  tmux_sessions=(`tmux list-sessions 2> /dev/null | awk -F: '{print $1}'`)
  _arguments '1:sessions:($tmux_sessions)'
}
compdef _attach_completion attach
compdef _attach_completion switch
compdef _attach_completion tmk

_tmux_new () {
  session_name=$1
  shift
  tmux new -n $session_name -s $session_name
}

_docker_container_completion () {
  declare -a container_names
  container_names=(`docker ps | awk '{if (NR!=1) print $NF}' | awk -F/ '{print$1}'`)
  _arguments '1:container:($container_names)'
}
compdef _docker_container_completion dsh

# ALIASES
alias attach='tmux attach-session -t'
alias attack='siege -t20s -b -c5'
alias c='clear'
alias dps="docker ps"
alias drun='docker run -i -t --rm'
alias ds="docker start"
alias dsh="sudo docker-enter"
alias fs='foreman start'
alias gmp='github-markdown-preview'
alias gpu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gpu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gunapply='git stash show -p | git apply -R'
alias gunapply='git stash show -p | git apply -R'
alias gupp='git fetch -p && gup'
alias knife='nocorrect bundled_knife'
alias mod="git status --porcelain | sed -ne 's/^ M //p'"
alias mux='nocorrect mux'
alias nobundle=_run_without_bundle $@
alias proj='cd ~/Projects'
alias pubkey='pbcopy < ~/.ssh/id_rsa.pub'
alias r='source ~/.zshrc'
alias rspec=_rspec_command
alias server='ruby -run -e httpd . -p 8080'
alias socks='ssh -ND 1080'
alias switch='tmux switch-client -t'
alias tf='tail -f'
alias tls='tmux ls'
alias tmk='tmux kill-session -t'
alias tns='_tmux_new'
alias whereami='curl http://remote-ip.herokuapp.com'
