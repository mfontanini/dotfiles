function git-yolo-amend-commit --wraps='git commit --amend --no-edit --no-verify' --description 'alias git-yolo-amend-commit=git commit --amend --no-edit --no-verify'
  git commit --amend --no-edit --no-verify $argv
        
end
