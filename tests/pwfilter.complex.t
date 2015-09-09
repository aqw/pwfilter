#!/bin/sh

test_description="Test more complex/contrived pwfilter interactions"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../pwfilter --file ../test.passwd"
CMD_P="cat ../test.passwd | ${SHARNESS_TEST_DIRECTORY}/../pwfilter"

test_expect_success "Fully cascade" "
    $CMD_P --range 0 2000 --exclude-range 10 40 --include 33 --exclude 1000 > pc01.gen &&
    test_cmp ../pc0102.out pc01.gen
"

test_expect_success "Fully cascade in reverse" "
    $CMD_P -e 1000 -i 33 -E 10 40 -I 0 2000  > pc02.gen &&
    test_cmp ../pc0102.out pc02.gen
"

test_done