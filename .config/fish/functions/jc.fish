function jc --description "jump to a crate in the current cargo workspace"
  set -f line $(cargo workspaces list -l | fzf --info=right --layout=reverse)
  if test $pipestatus[2] -ne 0
    return 1
  end
  set -f workspace_root $(cargo metadata 2>/dev/null | jq ".workspace_root" -r)
  set -f crate $(dirname $(echo $line | awk '{{ print $3 }}'))
  cd "$workspace_root/$crate"
end
