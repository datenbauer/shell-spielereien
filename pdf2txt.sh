#!/bin/sh
# requires pdftoppm, tesseract to be installed
#
# Usage:
# 	./pdf2txt.sh file
#

input="$1"		# TODO: must be pdf file
TMP_DIR=".tmp/"		# location for temporary files
OUT_NAME="converted"	# name of converted images
BATCH_SIZE=10

if [ $# -eq 0 ]; then
	printf "Error: no input file specified.\n"
	exit 1
elif [ -d "$TMP_DIR" ]; then
	printf "Error: directory '$TMP_DIR' already exists.\n"
	exit 1
fi

mkdir "$TMP_DIR"			# create dir for temporary files

total_pages=$(pdfinfo pensesdedescar00descuoft.pdf | grep "Pages.*" | egrep -o "[0-9]+")
interval_begin=0
interval_end=$BATCH_SIZE

while [ $interval_end -lt "$total_pages" ]; do
	if [ $((interval_end + BATCH_SIZE)) -gt $total_pages ]; then
		interval_end=$total_pages			# limit conversion to last page
	fi
	
	pdftoppm -f $interval_begin -l $interval_end "$input" "${TMP_DIR}${OUT_NAME}"
	
	for file in $(ls "$TMP_DIR"*.ppm); do
		tesseract -l fra --oem 1 "$file" "$file"	# convert images to txt
	done
	
	rm ${TMP_DIR}*.ppm					# delete images
	
	interval_begin=$((interval_begin + BATCH_SIZE + 1))	# prepare indices for next portion of the pdf
	interval_end=$((interval_end + $BATCH_SIZE + 1))
done

cat ${TMP_DIR}*.txt > "${input%pdf}"txt	# save with same name as input file, but with txt extension

