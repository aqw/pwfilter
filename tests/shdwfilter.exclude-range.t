#!/bin/sh

test_description="Test shdwfilter --exclude-range/-E (with help of include)"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../shdwfilter --file ../test.passwd ../test.shadow"

test_expect_success "Exclude simple" "
    $CMD_F --exclude-range 10 20 -I 0 40 > ser01.gen &&
    test_cmp ../ser01.out ser01.gen
"

test_expect_success "Exclude wins over include - everything" "
    $CMD_F --range 0 4294967294 -E 0 4294967294 > ser02.gen &&
    test_cmp ../empty ser02.gen
"

test_expect_success "Exclude overlapping outside" "
    $CMD_F -I 10 35 -E 5 10 -E 20 50 > ser03.gen &&
    test_cmp ../ser03.out ser03.gen
"

test_expect_success "Exclude overlapping each other" "
    $CMD_F -a 0 --exclude-range 7 39 -E 1 1000 > ser04.gen &&
    test_cmp ../ser04.out ser04.gen
"

test_done
