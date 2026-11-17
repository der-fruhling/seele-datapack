#!/bin/bash

SOURCE_DIR="$1"
dst="resources/staging/assets"
src="$SOURCE_DIR/assets"

if [ ! -e "$src" ]; then exit; fi

process_dir() {
    local src="$1"
    local dst="$2"

    mkdir -p "$dst"

    for file in $(ls "$src"); do
    	echo " -> $src/$file"

    	if [ -f "$src/$file" ]; then
    	    mv "$src/$file" "$dst/$file"
    	elif [ -d "$src/$file" ]; then
    	    if [ "$file" != "lang" ]; then
                process_dir "$src/$file" "$dst/$file"
            fi
    	fi
    done
}

process_dir "$src" "$dst"
