function tm -a 'session_name' --description "create/open a tmux session"
  if ! set -q session_name[1]
    set -f sessions $(tmux ls 2>/dev/null | cut -d: -f1)
    if ! set -q sessions[1]
      echo "no active sessions"
      return 1
    end

    set -f session_name $(string join \n $sessions | fzf --info=right --layout=reverse)
    if test $pipestatus[2] -ne 0
      return 0
    end
  end

  if ! tmux has-session -t $session_name 2>/dev/null
    tmux new-session -ds $session_name
  end

  if set -q TMUX
    tmux switch-client -t $session_name
  else
    tmux attach -t $session_name
  end
end

