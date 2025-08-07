#!/bin/sh

# locate source directory
DIR_SRC="$( cd "$( dirname "${0}" )/../" && pwd )"

. "$DIR_SRC/tap.sh"

log_header "ok.sh"

test_count=0
test_output() {
	test_count=$((test_count + 1))
	out=$(tap_ok "$@")
	if [ "$out" != "$3" ]; then 
		log_failure "not ok $test_count${2:+ $2} ($3 == $out)\n"
		return 1
	fi
	log_success "ok $test_count${2:+ $2} ($3 == $out)\n"
}

test_output 0 "" "$(log_success "ok 1")"
test_output 1 "" "$(log_failure "not ok 1")"
log_text "1..2\n"
