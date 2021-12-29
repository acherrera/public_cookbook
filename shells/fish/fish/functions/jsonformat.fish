function jsonformat
    # Formats json files with python automatically
    set outfile /tmp/tmpjson.json
    python3 -mjson.tool $argv > $outfile
    less $outfile > $argv
end
