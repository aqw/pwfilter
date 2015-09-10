#!/bin/sh

test_description="Test pwfilter --range/-I"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../pwfilter --file ../test.passwd"
CMD_P="cat ../test.passwd | ${SHARNESS_TEST_DIRECTORY}/../pwfilter"

test_expect_success "--range single ID" "
    $CMD_P --range 9 9 > pr01.gen &&
    test_cmp ../pr01.out pr01.gen
"

test_expect_success "-I multiple" "
    $CMD_P -I 3 7 -I 1000 1500  > pr02.gen &&
    test_cmp ../pr02.out pr02.gen
"

test_expect_success "--range overlapping" "
    $CMD_P --range 2 15 -I 10 2000  > pr03.gen &&
    test_cmp ../pr03.out pr03.gen
"

test_expect_success "--range everything" "
    $CMD_P --range 0 4294967294 > pr04.gen &&
    test_cmp ../test.passwd pr04.gen
"

test_expect_success "Two arguments are required" "
    test_must_fail $CMD_F -I 0
"

test_done
