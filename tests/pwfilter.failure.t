#!/bin/sh

test_description="Test expected failures in pwfilter"

. ./sharness.sh
CMD="${SHARNESS_TEST_DIRECTORY}/../pwfilter"

test_expect_success "Only one file is accepted" "
    test_must_fail $CMD --file ../test.passwd ../test.shadow
"

test_expect_success "File must exist" "
    test_must_fail $CMD --file ../test.not.here
"

test_expect_success "Only integers accepted" "
    test_must_fail $CMD happy to be me
"

test_done
