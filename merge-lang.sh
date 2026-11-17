#!/bin/bash

SOURCE_DIR="$1"
lang="resources/staging/assets/minecraft/lang"

for ns in $(ls "$SOURCE_DIR/assets"); do
    src="$SOURCE_DIR/assets/$ns/lang"

    if [ ! -e "$src" ]; then exit; fi

    mkdir -p "$lang"

    tmp=$(mktemp -d)

    for file in $(ls "$src"); do
	echo " -> $file"

	if [ -f "$lang/$file" ]; then
	    mv "$lang/$file" "$tmp/$file"
	    jq --slurpfile b "$src/$file" ". + \$b[0]" "$tmp/$file" > "$lang/$file"
	else
	    cp "$src/$file" "$lang/$file"
	fi
    done
done
