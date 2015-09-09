#!/bin/sh

test_description="Test pwfilter --at-and-above"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../pwfilter --file ../test.passwd"
CMD_P="cat ../test.passwd | ${SHARNESS_TEST_DIRECTORY}/../pwfilter"

test_expect_success "--at-and-above simple" "
    $CMD_F --at-and-above 20 > pa01.gen &&
    test_cmp ../pa01.out pa01.gen
"

test_expect_success "-a everything" "
    $CMD_F -a 0 > pa02.gen &&
    test_cmp ../test.passwd pa02.gen
"

test_done