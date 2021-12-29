# Start TMUX when window opens
# if status is-interactive
# and not set -q TMUX
#     exec tmux
# end

alias vim=nvim
alias python=python3
if status is-interactive
    # vim keybindings
    fish_vi_key_bindings
end
