function mkvenv --description "Make a python venv and activate it"
  uv venv
  source .venv/bin/activate.fish
  if test requirements.txt
    uv pip install -r requirements.txt
  end
end
