set_prompt_vars() {
  reinit_prompt_vars
  set_git_vars
  set_tuple
  set_carette
}

reinit_prompt_vars() {
  git_branch_formatted=''
  git_branches_formatted=''
  git_dirty=''
  git_tag_formatted=''
}

set_git_vars() {
  if git_repo_exists=$(git rev-parse --git-dir 2> /dev/null); then 
    if [ $(git branch | wc -l) -gt 0 ]; then
      set_git_branch
      set_git_branches
      set_git_tags
    fi
    set_git_dirty
  fi
}

set_git_branch() {
  if git_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    [[ "$git_branch" == "HEAD" ]] && git_branch_formatted=" ${txtred}detached @ $(git rev-parse --short HEAD)" || git_branch_formatted=" @$git_branch"
  fi
}

set_git_branches() {
  if git_branches=$(git branch --points-at HEAD | grep -v "$git_branch" 2> /dev/null); then
    git_branches_formatted=$(echo "$git_branches" | paste -s -d" " - | sed -e 's/  */ /g')
  fi
}

set_git_dirty() {
  git_dirty=$(git status --porcelain 2> /dev/null) && [[ ! -z "$git_dirty" ]] && git_dirty='*'
}

set_git_tags() {
  git_tag=$(git tag --points-at HEAD 2> /dev/null)
  [[ ! -z $git_tag ]] && git_tag_formatted=" $(echo "$git_tag" |  paste -s -d" " - | sed -e 's/[^ ]* */#&/g')"
}

set_tuple() {
  tuple_dir=$(basename $(dirname $PWD))/$(basename $PWD)
}

set_carette() {
  carette='$ ' && [ -d .git ] && carette=" ${txtblu}\$${txtrst} " && [ ! -z "$git_dirty" ] && carette=" ${txtred}\$${txtrst} "
}

PROMPT_COMMAND="set_prompt_vars; $PROMPT_COMMAND"

export PS1="\[$txtwht\]\$tuple_dir\[$txtlgrn\]\$git_branch_formatted\[$txtred\]\$git_dirty\[$txtlylw\]\$git_tag_formatted\[$txtrst\]\[$txtgrn\]\$git_branches_formatted\[$txtrst\]\$carette"
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

# !!!!!!!!! 

alias cdg="cd ~/work/git-hands-on"

