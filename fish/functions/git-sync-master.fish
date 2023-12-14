function git-sync-master --wraps='git checkout master && git pull origin master' --description 'alias git-sync-master=git checkout master && git pull origin master'
  git checkout master && git pull origin master $argv
        
end
