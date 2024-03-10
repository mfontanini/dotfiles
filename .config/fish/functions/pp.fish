function pp --description "jump to a project"
  if ! set -q PROJECTS_PATH
    echo "PROJECTS_PATH env var not set" 
    return 1
  end

  set -f specific $(ls $PROJECTS_PATH | fzf --info=right --layout=reverse)
  if test $pipestatus[2] -ne 0
    return 1
  end
  cd "$PROJECTS_PATH/$specific"
end
