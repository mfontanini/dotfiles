function venv --description "Make a python venv and activate it"
  if ! test -f .venv/bin/activate.fish
    uv venv -q
    source .venv/bin/activate.fish
    if test -f requirements.txt
      uv pip install -r requirements.txt
    else if test -f pyproject.toml
      uv pip install -r pyproject.toml
    end
  else
    source .venv/bin/activate.fish
  end
end
