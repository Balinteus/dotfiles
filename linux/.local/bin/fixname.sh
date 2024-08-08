#!/bin/sh

# Create a dict with the accented characters
declare -A accented_chars
accented_chars+=( [á]=a [é]=e [í]=i [ó]=o [ö]=o [ő]=o [ú]=u [ü]=u [ű]=u )

# Replaces the spaces with underscores
function remove_spaces() {
	space=" "
	separator="_"
	echo $1 | sed "s/$space/$separator/g"
}

# Replaces the accented characters
function replace_accented() {
	kek="$1"

	for key in "${!accented_chars[@]}"; do
		#echo "$1 $key ${accented_chars[$key]}"
		if [[ $1 == *"$key"* ]]; then
			kek=$(echo "$kek" | sed "s/$key/${accented_chars[$key]}/g")
		fi
	done

	echo $kek
}

# Main script logic
if [[ $# -eq 0 ]]; then
	# FIX ALL the filenames in the current working directory
	echo "replace all"
else
	# FIX ONLY THE SELECTED filenames
	echo "replace only the selected ones"

	for arg in $@; do
		remove_spaces $arg
		echo "$(replace_accented $arg)"
	done
fi

