#!/bin/sh

# locate source directory
DIR_SRC="$( cd "$( dirname "${0}" )/../" && pwd )"

. "$DIR_SRC/tap.sh"

log_header "cmp.sh"

test_count=0
test_output() {
	test_count=$((test_count + 1))
	out=$(tap_cmp "$1" "$2" "$3")
	if [ "$out" != "$4" ]; then 
		log_failure "not ok $test_count${2:+ $2} ($4 == $out)\n" 
		return 1
	fi
	log_success "ok $test_count${2:+ $2} ($4 == $out)\n"
}

test_output "foo" "foo" "match succeeds" "$(log_success "ok 1 match succeeds")"
test_output "foo" "bar" "mismatch fails" "$(log_failure "not ok 1 mismatch fails - expected 'bar' but got 'foo'")"
test_output "" "" "empty succeeds" "$(log_success "ok 1 empty succeeds")"
log_text "1..3\n"
