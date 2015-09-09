#!/bin/sh

test_description="Test pwfilter --exclude/-e (with help of include)"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../pwfilter --file ../test.passwd"
CMD_P="cat ../test.passwd | ${SHARNESS_TEST_DIRECTORY}/../pwfilter"

test_expect_success "Exclude wins over include" "
    $CMD_F --include 10 --exclude 10 > pe01.gen &&
    test_cmp ../empty pe01.gen
"

test_expect_success "Exclude single ID" "
    $CMD_F --exclude 10 -I 8 10  > pe02.gen &&
    test_cmp ../pe02.out pe02.gen
"

test_expect_success "Exclude both inside and outside included range" "
    $CMD_F -a 10 -e 7 39  > pe03.gen &&
    test_cmp ../pe03.out pe03.gen
"

test_done