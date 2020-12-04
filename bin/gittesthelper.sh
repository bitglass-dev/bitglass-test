#!/bin/bash

usage() {
    cat <<EOF
    \$ ${prog}: COMMAND

    COMMANDS:
    create_branches            - create large amount of branch from master
    delete_branches            - delete all test_branch_*
EOF
}

NUM_TEST_BRANCHES=500

create_branches() {
    git fetch
    git checkout origin/master
    for i in `seq 1 ${NUM_TEST_BRANCHES}`
    do
        git branch test_branch_$i
    done
    for i in `seq 1 ${NUM_TEST_BRANCHES}`
    do
        git checkout test_branch_$i
        git push --set-upstream origin test_branch_$i
    done
}

delete_branches() {
    git fetch
    git checkout origin/master
    for i in `seq 1 ${NUM_TEST_BRANCHES}`
    do
        git checkout test_branch_$i
        git push -d origin test_branch_$i
        git branch -d test_branch_$i
    done
}

case $1 in
    create_branches) create_branches;;
    delete_branches) delete_branches;;
    *|"") usage ;;
esac