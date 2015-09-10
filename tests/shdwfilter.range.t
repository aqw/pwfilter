#!/bin/sh

test_description="Test shdwfilter --range/-I"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../shdwfilter --file ../test.passwd ../test.shadow"

test_expect_success "--range single ID" "
    $CMD_F --range 9 9 > sr01.gen &&
    test_cmp ../sr01.out sr01.gen
"

test_expect_success "-I multiple" "
    $CMD_F -I 3 7 -I 1000 1500 > sr02.gen &&
    test_cmp ../sr02.out sr02.gen
"

test_expect_success "--range overlapping" "
    $CMD_F --range 2 15 -I 10 2000 > sr03.gen &&
    test_cmp ../sr03.out sr03.gen
"

test_expect_success "--range everything" "
    $CMD_F --range 0 4294967294 > sr04.gen &&
    test_cmp ../test.shadow sr04.gen
"

test_expect_success "Two arguments are required" "
    test_must_fail $CMD_F -I 0
"

test_done
