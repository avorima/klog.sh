#!/usr/bin/env bash

source ./klog.sh

assert_that_has_message() {
    if ! grep -qw "$2" <<< "$1"; then
        caller
        echo "Did not find message: $2 in $1"
        exit 1
    fi
}

assert_that_has_message "$(klog::Info "foo" "bar" 2>&1)" "foobar"
assert_that_has_message "$(klog::Info "foo " "bar" 2>&1)" "foo bar"
assert_that_has_message "$(klog::Infof "foobar" 2>&1)" "foobar"
assert_that_has_message "$(klog::Infof "foo%s" "bar" 2>&1)" "foobar"
assert_that_has_message "$(klog::Infoln "foo" "bar" 2>&1)" "foo bar"
