#!/bin/sh

test_description="Test grpfilter --exclude-range/-E (with help of include)"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../grpfilter --file ../test.group"
CMD_P="cat ../test.group | ${SHARNESS_TEST_DIRECTORY}/../grpfilter"

test_expect_success "Exclude simple" "
    $CMD_F --exclude-range 10 20 -I 0 40 > ger01.gen &&
    test_cmp ../ger01.out ger01.gen
"

test_expect_success "Exclude wins over include - everything" "
    $CMD_F --range 0 4294967294 -E 0 4294967294 > ger02.gen &&
    test_cmp ../empty ger02.gen
"

test_expect_success "Exclude overlapping outside" "
    $CMD_F -I 10 35 -E 5 10 -E 20 50 > ger03.gen &&
    test_cmp ../ger03.out ger03.gen
"

test_expect_success "Exclude overlapping each other" "
    $CMD_F -a 0 --exclude-range 7 39 -E 1 1000 > ger04.gen &&
    test_cmp ../ger04.out ger04.gen
"

test_done
