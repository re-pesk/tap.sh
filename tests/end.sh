#!/bin/sh
# Testsuite for tap_end
#
# ###########################
# Warning:
# using tap_* test functions after tap_end violates the TAP spec
# but we depend on an implementation detail here
#
# dont't do that in your code
# ###########################

# locate source directory
DIR_SRC="$( cd "$( dirname "${0}" )/../" && pwd )"

. "$DIR_SRC/tap.sh"

log_header "end.sh"

# we need more than one passed test to make sure, that the values in
# the plan line have the correct order and tap_end returns success
tap_ok 0 "this prints 'ok'\n"
tap_pass "this prints 'ok'\n"

# verify plan line: "1..2" and resultcode: 0 (every test before the tap_end succeded)
end_out=$(tap_end)
end_rc=$?
out="$(echo "$end_out" | grep -v "^#" | head -1)"
tap_cmp "$out" "$(log_text "1..2")" "we used two tests before this tap_end\n"
tap_cmp 0 $end_rc "since every test succeeded: resultcode of tap_end must be 0\n"

# verify, that we can force a test counter for the plan line during tst_end
# and that tap_end returns a failure, when the internal test counter does not match
end_out=$(tap_end "42")
end_rc=$?
out="$(echo "$end_out" | grep -v "^#" | head -1)"
tap_cmp "$out" "$(log_text "1..42")" "we forced 42 as test counter in this tap_end\n"
tap_cmp 1 $end_rc "we forced a different test counter: resultcode of tap_end must be 1\n"

# we need a failed test to make sure, that tap_end returns failure
out="$(tap_end | grep -v "^#" | head -1)"
log_success "ok 7 - overwrite result: (" && tap_fail "expecting a 'not ok' here" && log_text ")\n"

# verify plan line: "1..7" and resultcode: 1 (we forced a failing test)
end_out=$(tap_end)
echo "end_out: $end_out" >&2
end_rc=$?
out="$(tap_end | grep -v "^#" | head -1)"
tap_cmp "$out" "1..7" "we used 7 tests before this tap_end\n"
tap_cmp 1 $end_rc "we forced a failing test: resultcode of tap_end must be 1" "\n"

# can't use tap_end here: the tap_fail above would fail this testsuite
log_text "1..9\n"
