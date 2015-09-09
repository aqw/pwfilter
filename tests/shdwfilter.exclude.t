#!/bin/sh

test_description="Test shdwfilter --exclude/-e (with help of include)"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../shdwfilter --file ../test.passwd ../test.shadow"

test_expect_success "Exclude wins over include" "
    $CMD_F --include 10 --exclude 10 > se01.gen &&
    test_cmp ../empty se01.gen
"

test_expect_success "Exclude single ID" "
    $CMD_F --exclude 10 -I 8 10 > se02.gen &&
    test_cmp ../se02.out se02.gen
"

test_expect_success "Exclude both inside and outside included range" "
    $CMD_F -a 10 -e 7 39 > se03.gen &&
    test_cmp ../se03.out se03.gen
"

test_done
