#!/bin/sh

test_description="Test sans-option syntax of grpfilter"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../grpfilter --file ../test.group"
CMD_P="cat ../test.group | ${SHARNESS_TEST_DIRECTORY}/../grpfilter"

test_expect_success "sans-option - single ID" "
    $CMD_P 1000 > gs01.gen &&
    test_cmp ../gs01.out gs01.gen
"

test_expect_success "sans-option - multiple IDs" "
    $CMD_P 34 2 2000 > gs02.gen &&
    test_cmp ../gs02.out gs02.gen
"

test_expect_success "Sans options must be first" "
    test_must_fail $CMD_F 1000 39
"

test_done
