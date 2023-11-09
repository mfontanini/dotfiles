if [ "$color_prompt" == "yes" ]
then
  # Set prompt.
  # `root` has a red prompt, others a yellow one.
  # If we are connected remotely, `@<hostname>` shows first.
  build_ps1() {
      local prompt_color='\[\e[1;32m\]'
      local host=''
      [[ $UID -eq 0 ]] && prompt_color='\[\e[1;31m\]'
      [[ $SSH_TTY ]] && host="@$HOSTNAME "
      echo "${prompt_color}${host}\w\[\e[0m\] \$ "
  }
  PS1=$(build_ps1)
  PS2='\\ '
  PS4='+ $LINENO: '
fi

alias less="less -R"
