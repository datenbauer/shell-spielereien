#!/bin/sh
#
# ufpb.sh
#
# User friendly progress bar
# [###############----]
#

ufpb_size=30		# number of segments
ufpb_current=0		# number of processed units
ufpb_maximum=0		# total units to process
ufpb_graphic=0		# number of drawn units

ufpb_set() {
	ufpb_current=$1
	ufpb_temp=$(printf "scale=2;$ufpb_current/$ufpb_maximum*$ufpb_size\n" | bc)
	ufpb_graphic=$(printf "%.0f" "$ufpb_temp")
}

ufpb_draw() {
	printf "\r"
	printf "["
	for ufpb_i in $(seq 1 $ufpb_size); do
		if [ "$ufpb_i" -le "$ufpb_graphic" ]; then
			printf "#"
		else
			printf "-"
		fi
	done
	printf "]"
	# printf "\n"
}


######################
#       DEMO         #
######################

ufpb_maximum=100
test_reihe=$(shuf -i 0-100 | head -n 20 | sort -g)

for test_wert in $test_reihe; do
	ufpb_set $test_wert
	ufpb_draw
	sleep 0.5
done
ufpb_set 100
ufpb_draw
printf "\n"
