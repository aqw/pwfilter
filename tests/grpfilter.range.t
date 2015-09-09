#!/bin/sh

test_description="Test grpfilter --range/-I"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../grpfilter --file ../test.group"
CMD_P="cat ../test.group | ${SHARNESS_TEST_DIRECTORY}/../grpfilter"

test_expect_success "--range single ID" "
    $CMD_P --range 9 9 > gr01.gen &&
    test_cmp ../gr01.out gr01.gen
"

test_expect_success "-I multiple" "
    $CMD_P -I 3 7 -I 1000 1500 > gr02.gen &&
    test_cmp ../gr02.out gr02.gen
"

test_expect_success "--range overlapping" "
    $CMD_P --range 2 15 -I 10 2000 > gr03.gen &&
    test_cmp ../gr03.out gr03.gen
"

test_expect_success "--range everything" "
    $CMD_P --range 0 4294967294 > gr04.gen &&
    test_cmp ../test.group gr04.gen
"

test_done
