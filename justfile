# Default recipe to compile all samples.
default: compile-all

# Compile all .typ files in samples/ directory (skipping soft-linked infomap.type)
compile-all:
	#!/usr/bin/env bash
	for file in samples/*.typ; do
		if [ -f "$file" ] && [ ! -L "$file" ]; then
			output="${file%.typ}.pdf"
			echo "Compiling $file -> $output"
			typst compile "$file" "$output"
		fi
	done

# Compile specific file
compile FILE:
	typst compile samples/{{FILE}}.typ samples/{{FILE}}.pdf

# Clean all PDFs
clean:
	rm -f samples/*.pdf
