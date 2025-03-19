if test -f ~/.config/fish/env.fish
  . ~/.config/fish/env.fish
end

bind \n down-line
bind \v up-line

set -x EDITOR nvim

# pnpm
set -gx PNPM_HOME "/home/matias/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
