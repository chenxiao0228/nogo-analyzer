#!/bin/bash

find . -name go.mod -print0 |
	while IFS= read -r -d '' f; do
		d=$(dirname "$f")
		(
			cd "$d" || exit
			echo "Running 'go mod tidy' in $d"
			bazel run @rules_go//go -- mod tidy
		)
	done

bazel run @rules_go//go -- work sync
