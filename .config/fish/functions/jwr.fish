function jwr --description "jump to a project"
  set -l workspace_root $(cargo metadata 2>/dev/null | jq ".workspace_root" -r)
  if test $pipestatus[1] -ne 0
    echo "not in a workspace"
    return 1
  end
  cd $workspace_root
end

