#!/bin/sh

nl='
'

log_header() (
	printf "\n=== %s ===\n\n" "$@" # >&2
)

log_text() (
	printf "$@" # >&2
)

log_success() (
	printf "✔ $@" # >&2
)

log_failure() (
	printf "✖ $@" # >&2
)

TAP_TEST_COUNT=0
TAP_FAIL_COUNT=0

tap_pass() {
	TAP_TEST_COUNT=$((TAP_TEST_COUNT + 1))
	log_success "ok $TAP_TEST_COUNT${1:+ $1}${2:-}"
}

tap_fail() {
	TAP_TEST_COUNT=$((TAP_TEST_COUNT + 1))
	TAP_FAIL_COUNT=$((TAP_FAIL_COUNT + 1))
	log_failure "not ok $TAP_TEST_COUNT${1:+ $1}${2:-}"
}

tap_end() {
	num_tests="$1"
	[ -z "$num_tests" ] && num_tests="$TAP_TEST_COUNT"
	log_text "1..$num_tests"
	[ "$num_tests" = "$TAP_TEST_COUNT" ] || exit 1
	exit $((TAP_FAIL_COUNT > 0)) # C semantics
}

tap_ok() {
	if [ "$1" -eq 0 ]; then
		tap_pass "$2"
		return 0
	fi
	tap_fail "$2"
}

tap_cmp() {
	if [ "$1" = "$2" ]; then
		tap_pass "$3"
		return 0
	fi
	tap_fail "$3 - expected '$2' but got '$1'$4"
}
