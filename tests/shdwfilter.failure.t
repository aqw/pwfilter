#!/bin/sh

test_description="Test expected failures in shdwfilter"

. ./sharness.sh
CMD="${SHARNESS_TEST_DIRECTORY}/../shdwfilter"

test_expect_success "Two files are required" "
    test_must_fail $CMD --file ../test.passwd
"

test_expect_success "File must exist" "
    test_must_fail $CMD --file ../test.not.here ../test.not.here.either
"

test_expect_success "Only integers accepted" "
    test_must_fail $CMD happy to be me
"

test_done
