#!/bin/sh

test_description="Test more complex/contrived shdwfilter interactions"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../shdwfilter --file ../test.passwd ../test.shadow"

test_expect_success "Fully cascade" "
    $CMD_F --range 0 2000 --exclude-range 10 40 --include 33 --exclude 1000 > sc01.gen &&
    test_cmp ../sc0102.out sc01.gen
"

test_expect_success "Fully cascade in reverse" "
    $CMD_F -e 1000 -i 33 -E 10 40 -I 0 2000 > sc02.gen &&
    test_cmp ../sc0102.out sc02.gen
"

test_done
