if test -f ~/.config/fish/env.fish
  . ~/.config/fish/env.fish
end

bind -k backspace backward-kill-word
bind \cF --mode insert accept-autosuggestion
bind \n down-line
bind \v up-line
