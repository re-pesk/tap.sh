#!/bin/sh

# locate source directory
DIR_SRC="$( cd "$( dirname "${0}" )/../" && pwd )"

. "$DIR_SRC/tap.sh"

log_header "fail.sh"

test_count=0
test_output() {
	test_count=$((test_count + 1))
	out=$(tap_fail "$1")
	if [ "$out" != "$2" ]; then 
		log_failure "not ok $test_count${1:+ $1} ($2 == $out)\n"
		return 1
	fi
	log_success "ok $test_count${1:+ $1} ($2 == $out)\n"
}

test_output "" "$(log_failure "not ok 1")"
test_output "with expression" "$(log_failure "not ok 1 with expression")"
log_text "1..2\n"
