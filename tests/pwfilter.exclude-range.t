#!/bin/sh

test_description="Test pwfilter --exclude-range/-E (with help of include)"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../pwfilter --file ../test.passwd"
CMD_P="cat ../test.passwd | ${SHARNESS_TEST_DIRECTORY}/../pwfilter"

test_expect_success "Exclude simple" "
    $CMD_F --exclude-range 10 20 -I 0 40 > pE01.gen &&
    test_cmp ../pE01.out pE01.gen
"

test_expect_success "Exclude wins over include - everything" "
    $CMD_F --range 0 4294967294 -E 0 4294967294 > pE02.gen &&
    test_cmp ../empty pE02.gen
"

test_expect_success "Exclude overlapping outside" "
    $CMD_F -I 10 35 -E 5 10 -E 20 50 > pE03.gen &&
    test_cmp ../pE03.out pE03.gen
"

test_expect_success "Exclude overlapping each other" "
    $CMD_F -a 0 --exclude-range 7 39 -E 1 1000 > pE04.gen &&
    test_cmp ../pE04.out pE04.gen
"

test_done