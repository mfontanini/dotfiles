function venv --description "Make a python venv and activate it" -a param
  if ! set -q param[1]
    run_venv .venv .
  else
    switch $param
      case v volatile
        set -l dir $(mktemp -d)
        run_venv $dir "volatile venv"
      case "*"
        echo "invalid parameter: $param"
    end
  end
end

function run_venv -a venv_path prompt
  set -l activate_path "$venv_path/bin/activate.fish"
  if ! test -f $activate_path
    uv venv -q --prompt $prompt $venv_path
    source $activate_path
    if test -f requirements.txt
      uv pip install -r requirements.txt
    else if test -f pyproject.toml
      uv pip install -r pyproject.toml
    end
  else
    source $activate_path
  end
end
