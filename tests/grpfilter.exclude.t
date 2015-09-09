#!/bin/sh

test_description="Test grpfilter --exclude/-e (with help of include)"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../grpfilter --file ../test.group"
CMD_P="cat ../test.group | ${SHARNESS_TEST_DIRECTORY}/../grpfilter"

test_expect_success "Exclude wins over include" "
    $CMD_F --include 10 --exclude 10 > ge01.gen &&
    test_cmp ../empty ge01.gen
"

test_expect_success "Exclude single ID" "
    $CMD_F --exclude 10 -I 8 10 > ge02.gen &&
    test_cmp ../ge02.out ge02.gen
"

test_expect_success "Exclude both inside and outside included range" "
    $CMD_F -a 10 -e 7 39 > ge03.gen &&
    test_cmp ../ge03.out ge03.gen
"

test_done
