#!/bin/sh

test_description="Test pwfilter --exclude-range/-E (with help of include)"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../pwfilter --file ../test.passwd"
CMD_P="cat ../test.passwd | ${SHARNESS_TEST_DIRECTORY}/../pwfilter"

test_expect_success "Exclude simple" "
    $CMD_F --exclude-range 10 20 -I 0 40 > per01.gen &&
    test_cmp ../per01.out per01.gen
"

test_expect_success "Exclude wins over include - everything" "
    $CMD_F --range 0 4294967294 -E 0 4294967294 > per02.gen &&
    test_cmp ../empty per02.gen
"

test_expect_success "Exclude overlapping outside" "
    $CMD_F -I 10 35 -E 5 10 -E 20 50 > per03.gen &&
    test_cmp ../per03.out per03.gen
"

test_expect_success "Exclude overlapping each other" "
    $CMD_F -a 0 --exclude-range 7 39 -E 1 1000 > per04.gen &&
    test_cmp ../per04.out per04.gen
"

test_done
