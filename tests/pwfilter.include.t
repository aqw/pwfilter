#!/bin/sh

test_description="Test pwfilter --include/-i"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../pwfilter --file ../test.passwd"
CMD_P="cat ../test.passwd | ${SHARNESS_TEST_DIRECTORY}/../pwfilter"

test_expect_success "--include single" "
    $CMD_P --include 1000 > pi01.gen &&
    test_cmp ../pi01.out pi01.gen
"

test_expect_success "-i multiple" "
    $CMD_P -i 34 2 2000 > pi02.gen &&
    test_cmp ../pi02.out pi02.gen
"

test_done