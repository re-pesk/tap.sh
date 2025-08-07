#!/bin/sh

DIR_TEST="$( cd "$( dirname "${0}" )" && pwd )"
DIR_ROOT="$( cd "$DIR_TEST/../" && pwd )"

. "$DIR_ROOT/tap.sh"

log_header "tests.sh"

"$DIR_TEST/pass.sh"
"$DIR_TEST/fail.sh"
"$DIR_TEST/ok.sh"
"$DIR_TEST/cmp.sh"
"$DIR_TEST/end.sh"
