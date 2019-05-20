#!/bin/sh
#
# Usage:
#	files [dir1 ..]
#
# Extracts data from all given directories and writes a report to
# stdout.
# First, a summary of all file types with their total count
# and accumulated size.
# Second, a similar summary grouped by file extensions.
#
# Note: The summary by file extension puts all files without extension
# in one group ("-"). Dotfiles can be without extension (e.g. ".config")
# or with extension (e.g. ".hidden_file.txt").
#

for dir in $@; do
	if [ ! -d "$dir" ]; then
		printf "Error: $dir is no directory!" >&2
		exit 1
	fi
done

ls -lA "$@" | awk '
	/[a-z-]{10} / {								# process only lines with file information
		
		total_count += 1						# count of all files
		
		# Analysis of types
		
		type = substr($1, 1, 1)
		
		count_type[type] += 1					# count per file type
		
		if(type != "b" && type != "c") {
			accumulated_size_type[type] += $5	# total size per type (except c or b)
			total_size += $5					# total size of all files
		}
		
		# Analysis of extensions
		
		if(substr($NF, 1, 1) == ".") { 			# if file name starts with "." ...
			filename = substr($NF, 2)			# ... remove leading "."
		} else {
			filename = $NF
		}
		n = split(filename, res, ".")			# split file name and save number of resulting parts
		if(n == 1 || type == "d") {				# no extension (including directories)
			if(type != "b" && type != "c") {
				accumulated_size_ext["-"] += $5	# total size per extension
				count_ext["-"] += 1
			}
		} else {
			ext = res[n]
			accumulated_size_ext[ext] += $5
			count_ext[ext] += 1
		}
	}
	
	END {
		printf "tp\tno\t\tsz\n"
		for(type in count_type){
			printf "%s\t%4d\t%10d\n", type, count_type[type], accumulated_size_type[type]
		}
		printf "------------------------------\n"
		printf "sum\t%4d\t%10d\n", total_count, total_size
		
		
		printf "\n\n"
		
		
		printf "ext\tno\t\tsz\n"
		for(type in count_ext){
			printf "%s\t%4d\t%10d\n", type, count_ext[type], accumulated_size_ext[type]
		}
		printf "------------------------------\n"
		printf "sum\t%4d\t%10d\n", total_count, total_size
	}
'
