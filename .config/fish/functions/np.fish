function nvim-open --argument-names base_path
  set -f specific $(ls $base_path | fzf --info=right --layout=reverse)
  if test $pipestatus[2] -ne 0
    return 1
  end
  cd "$base_path/$specific"
  nvim .
end

function np --description "open a project in nvim"
  if ! set -q PROJECTS_PATH
    echo "PROJECTS_PATH env var not set" 
    return 1
  end
  nvim-open $PROJECTS_PATH 
end
