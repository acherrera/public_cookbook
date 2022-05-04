# Bash

Bash scripts and tricks


## Unzipping Files In Subdirectories
```
for D in *; do
    if [ -d "${D}" ]; then
        echo "${D}"   # your processing here
        unzip $D/images.zip -d $D
        rm -rf $D
    fi
done
```
