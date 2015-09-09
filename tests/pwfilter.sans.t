#!/bin/sh

test_description="Test sans-option syntax of pwfilter"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../pwfilter --file ../test.passwd"
CMD_P="cat ../test.passwd | ${SHARNESS_TEST_DIRECTORY}/../pwfilter"

test_expect_success "sans-option - single ID" "
    $CMD_P 1000 > ps01.gen &&
    test_cmp ../ps01.out ps01.gen
"

test_expect_success "sans-option - multiple IDs" "
    $CMD_P 34 2 2000 > ps02.gen &&
    test_cmp ../ps02.out ps02.gen
"

test_done