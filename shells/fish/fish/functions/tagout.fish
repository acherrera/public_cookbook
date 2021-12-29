function tagout
    # Creates tags for vim manually
    # Add more exlcusion if needed
    ctags --recurse=yes --exclude=.git  --exclude=venv
end
