#!/bin/sh

test_description="Test more complex/contrived grpfilter interactions"

. ./sharness.sh
CMD_F="${SHARNESS_TEST_DIRECTORY}/../grpfilter --file ../test.group"
CMD_P="cat ../test.group | ${SHARNESS_TEST_DIRECTORY}/../grpfilter"

test_expect_success "Fully cascade" "
    $CMD_P --range 0 2000 --exclude-range 10 40 --include 33 --exclude 1000 > gc01.gen &&
    test_cmp ../gc0102.out gc01.gen
"

test_expect_success "Fully cascade in reverse" "
    $CMD_P -e 1000 -i 33 -E 10 40 -I 0 2000  > gc02.gen &&
    test_cmp ../gc0102.out gc02.gen
"

test_done
