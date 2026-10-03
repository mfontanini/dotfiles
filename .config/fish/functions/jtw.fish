function jtw --wraps='cargo test && cargo clippy' --description 'Run cargo test and clippy, optionally for a crate'
  set -l package_args
  if set -q argv[1]
    set package_args -p "$argv[1]"
  end

  cargo test $package_args && cargo clippy $package_args $argv[2..-1]
end
