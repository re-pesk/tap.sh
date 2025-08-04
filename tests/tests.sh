#!/bin/sh

DIR_TEST="$( cd "$( dirname "${0}" )" && pwd )"
DIR_ROOT="$( cd "$DIR_TEST/../" && pwd )"

. "$DIR_ROOT/tap.sh"

"$DIR_TEST/pass.sh"
echo
"$DIR_TEST/fail.sh"
echo
"$DIR_TEST/end.sh"
echo
"$DIR_TEST/ok.sh"
echo
"$DIR_TEST/cmp.sh"

