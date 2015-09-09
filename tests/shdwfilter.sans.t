#!/bin/sh

test_description="Test sans-option syntax of shdwfilter"

. ./sharness.sh
CMD="${SHARNESS_TEST_DIRECTORY}/../shdwfilter"

test_expect_success "sans-option - single ID" "
    $CMD 1000 --file ../test.passwd ../test.shadow > ss01.gen &&
    test_cmp ../ss01.out ss01.gen
"

test_expect_success "sans-option - multiple IDs" "
    $CMD 34 2 2000 --file ../test.passwd ../test.shadow > ss02.gen &&
    test_cmp ../ss02.out ss02.gen
"

test_done
