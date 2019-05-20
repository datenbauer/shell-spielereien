#!/bin/sh
# palindrome.sh
#
# Usage:
#	./palindrome.sh
#
# Options:
# 	- none -
#
# Reads user input line by line and checks if it is a palindrome.
# If this is the case, the input is printed again. Only letters and
# numbers are considered in the check; blanks, punctuation and other
# characters are being ignored.
#

to_uppercase() {	# takes a string, converts it to uppercase (also strips blanks and punctuation)
	string="$1"
	uppercase=''	# result string
	while test -n "$string"; do
		tail=${string#?}		# string without first character
		head=${string%"$tail"}		# first character of string
		case $head in
			a) head=A;;  h) head=H;;  o) head=O;;  u) head=U;;  
			b) head=B;;  i) head=I;;  p) head=P;;  v) head=V;;  
			c) head=C;;  j) head=J;;  q) head=Q;;  w) head=W;;  
			d) head=D;;  k) head=K;;  r) head=R;;  x) head=X;;  
			e) head=E;;  l) head=L;;  s) head=S;;  y) head=Y;;  
			f) head=F;;  m) head=M;;  t) head=T;;  z) head=Z;;  
			g) head=G;;  n) head=N;;  [A-Z0-9]) head=$head;;
			?) head='';;		# omit other characters than letters
		esac
		uppercase=${uppercase}${head}	# append capitalized head to result
		string="$tail"			# repeat with rest of string until empty
	done
	printf "$uppercase"			# return capitalized string
}

reverse() {		# takes a string and returns it in reversed order
	string="$1"
	reverse=''
	while test -n "$string"; do
		tail=${string#?}
		head=${string%"$tail"}
		reverse=${head}${reverse}
		string="$tail"
	done
	printf "$reverse"
}

palindrome() {		# takes a string and returns 0 if palindrome (else 1)
	uppercase=$(to_uppercase "$1")
	reverse=$(reverse $uppercase)
	if [ "$uppercase" = "$reverse" ]; then
		return 0
	else
		return 1
	fi
}

while IFS= read -r line; do
	if [ ! "$line" ]; then			# ignore empty lines
		:
	else
		if palindrome "$line"; then
			printf "$line\n"
		fi
	fi
done
