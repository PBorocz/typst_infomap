# Default recipe is to compile all samples.
default: compile-all

# Compile all .typ files in samples/ directory (skipping soft-linked infomap.type)
compile-all:
	#!/usr/bin/env bash
	for file in samples/*.typ; do
		if [ -f "$file" ] && [ ! -L "$file" ]; then
			output="${file%.typ}.pdf"
			echo "typst $file -> $output"
			typst compile "$file" "$output"
		fi
	done

# Compile specific file
compile FILE:
	typst compile samples/{{FILE}}.typ samples/{{FILE}}.pdf

# DEVELOPMENT ONLY: Run the test suite
test:
	uv run test_infomap.py

# Clean all sample PDFs
clean:
	rm -f samples/*.pdf
