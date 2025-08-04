#!/bin/sh

# import our test functions and our hello function

# locate source directory
DIR_CUR="$( cd "$( dirname "${0}" )" && pwd )"

DIR_SRC="$( cd "$DIR_CUR/../../" && pwd )"

. "$DIR_SRC/tap.sh"
. "$DIR_CUR/hello.sh"


test_1() {
	# test #1 does hello() print the expected output?
	hello_out=$(hello)
	tap_cmp "$hello_out" "Hello, World!" "hello"
}

test_2() {
	# test #2 does hello "you" print the expected output?
	hello_out=$(hello "you")
	tap_cmp "$hello_out" "Hello, you!" "hello 'you'"
}

tests() {
	test_1
	test_2
	echo
	# print the test plan
	tap_end 2
}

tests
