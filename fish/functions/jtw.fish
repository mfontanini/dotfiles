function jtw --wraps='cargo test && cargo clippy' --description 'alias jtw=cargo test && cargo clippy'
  cargo test && cargo clippy $argv
        
end
