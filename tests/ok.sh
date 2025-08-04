#!/bin/sh

# locate source directory
DIR_SRC="$( cd "$( dirname "${0}" )/../" && pwd )"

. "$DIR_SRC/tap.sh"

test_count=0
test_output() {
	test_count=$((test_count + 1))
	out=$(tap_ok "$@")
	[ "$out" != "$3" ] && printf "not "
	echo "ok $test_count${2:+ $2} ($3 == $out)"
}

test_output 0 "" "ok 1"
test_output 1 "" "not ok 1"
echo '1..2'
