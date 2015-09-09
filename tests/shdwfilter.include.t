#!/bin/sh

test_description="Test shdwfilter --include/-i"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../shdwfilter --file ../test.passwd ../test.shadow"

test_expect_success "--include single" "
    $CMD_F --include 1000 > si01.gen &&
    test_cmp ../si01.out si01.gen
"

test_expect_success "-i multiple" "
    $CMD_F -i 34 2 2000 > si02.gen &&
    test_cmp ../si02.out si02.gen
"

test_done
