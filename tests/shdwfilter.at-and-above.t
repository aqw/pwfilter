#!/bin/sh

test_description="Test shdwfilter --at-and-above"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../shdwfilter --file ../test.passwd ../test.shadow"

test_expect_success "--at-and-above simple" "
    $CMD_F --at-and-above 20 > sa01.gen &&
    test_cmp ../sa01.out sa01.gen
"

test_expect_success "-a everything" "
    $CMD_F -a 0 > sa02.gen &&
    test_cmp ../test.shadow sa02.gen
"

test_expect_success "Only one argument allowed" "
    test_must_fail $CMD_F -a 22 39
"

test_expect_success "Argument must be an integer" "
    test_must_fail $CMD_F -a alex
"

test_done
