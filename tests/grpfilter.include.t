#!/bin/sh

test_description="Test grpfilter --include/-i"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../grpfilter --file ../test.group"
CMD_P="cat ../test.group | ${SHARNESS_TEST_DIRECTORY}/../grpfilter"

test_expect_success "--include single" "
    $CMD_P --include 1000 > gi01.gen &&
    test_cmp ../gi01.out gi01.gen
"

test_expect_success "-i multiple" "
    $CMD_P -i 34 2 2000 > gi02.gen &&
    test_cmp ../gi02.out gi02.gen
"

test_done
