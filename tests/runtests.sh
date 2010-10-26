#!/bin/sh
# Note: this should be run from within the tests directory
# Make sure you've set the 'test' flag using Cabal:
# cabal install -ftest
# Otherwise the test program 'texmath' won't be built.
# Exit status is number of failed tests.
TESTPROG=../dist/build/texmath/texmath
failures=0
if [ -f $TESTPROG ]; then
    for t in *.tex; do
        $TESTPROG <$t >tmp
        diff ${t%.tex}.xhtml tmp >tmpdiff
        if [ "$?" -ne "0" ]; then
            echo "Test ${t%.tex} FAILED (< expected, > actual):"
            cat tmpdiff
            let "failures=$failures+1"
        else
            echo "Test ${t%.tex} PASSED"
        fi
    done
else
    echo "Test executable not built. NOT running tests."
fi
exit $failures
