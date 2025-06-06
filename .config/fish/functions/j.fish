function j --description "quick jump entry point" -a action
  switch $action
    case wr
      jump_cargo_workspace
    case rr
      jump_repo_root
    case c
      jump_crate
    case p
      jump_project
    case b
      jump_git_branch
    case d
      jump_dir
    case '*'
      echo "invalid action: $action"
  end
end

function jump_cargo_workspace
  set -l workspace_root $(cargo locate-project --workspace 2>/dev/null | jq ".root" -r)
  if test $pipestatus[1] -ne 0
    echo "not in a workspace"
    return 1
  end
  cd $workspace_root
end

function jump_repo_root
  set -l repo_root $(git rev-parse --show-toplevel)
  if test $status -ne 0
    echo "not in a git repo"
    return 1
  end
  cd $repo_root
end

function jump_crate
  set -f line $(cargo workspaces list -l | fzf --info=right --layout=reverse)
  if test $pipestatus[2] -ne 0
    return 1
  end
  set -f workspace_root $(cargo locate-project --workspace 2>/dev/null | jq ".root" -r | sed 's/Cargo\.toml//')
  set -f crate $(echo $line | awk '{{ print $3 }}' | sed 's/Cargo\.toml//')
  cd "$workspace_root/$crate"
end

function jump_project
  if ! set -q PROJECTS_PATH
    echo "PROJECTS_PATH env var not set"
    return 1
  end

  set -f path $(find $PROJECTS_PATH -maxdepth 1 -type d -print | fzf --info=right --layout=reverse)
  if test $pipestatus[2] -ne 0
    return 1
  end
  cd $path
end

function jump_git_branch
  set -f branch $(git branch --format="%(refname:short)" | fzf --info=right --layout reverse)
  if test $pipestatus[2] -ne 0
    return 1
  end
  git checkout $branch 
end

function jump_dir
  set -f dir $(fd -t dir -H | fzf --info=right --layout reverse)
  if test $pipestatus[2] -ne 0
    return 1
  end
  cd $dir
end
