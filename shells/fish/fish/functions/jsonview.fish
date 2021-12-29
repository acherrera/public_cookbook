function jsonview
    # View the formatted file without saving to new
    set outfile /tmp/(date +%s)_reformat.json
    python3 -mjson.tool $argv >$outfile
    vim -O $argv $outfile
end
