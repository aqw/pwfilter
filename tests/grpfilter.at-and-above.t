#!/bin/sh

test_description="Test grpfilter --at-and-above"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../grpfilter --file ../test.group"
CMD_P="cat ../test.group | ${SHARNESS_TEST_DIRECTORY}/../grpfilter"

test_expect_success "--at-and-above simple" "
    $CMD_F --at-and-above 20 > ga01.gen &&
    test_cmp ../ga01.out ga01.gen
"

test_expect_success "-a everything" "
    $CMD_F -a 0 > ga02.gen &&
    test_cmp ../test.group ga02.gen
"

test_done
