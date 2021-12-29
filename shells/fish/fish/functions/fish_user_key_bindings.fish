function fish_user_key_bindings
    # Make ctrl+f work for auto complete in vi mode... somehow
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end

    # make "jk" work for "esc"
    bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

end
