#!/usr/bin/env bash

source ./klog.sh

assert_that_has_message() {
    if ! grep -qw "$2" <<< "$1"; then
        echo "Did not find message: $2 in $1"
        exit 1
    fi
}

assert_that_has_message "$(klog::Info "foo" "bar")" "foobar"
assert_that_has_message "$(klog::Infof "foobar")" "foobar"
assert_that_has_message "$(klog::Infof "foo%s" "bar")" "foobar"
assert_that_has_message "$(klog::Infof "foo%s\n" "bar")" "foobar"

assert_that_has_message "$(klog::Error "foo" "bar" 2>&1)" "foobar"
assert_that_has_message "$(klog::Errorf "foobar" 2>&1)" "foobar"
assert_that_has_message "$(klog::Errorf "foo%s" "bar" 2>&1)" "foobar"
assert_that_has_message "$(klog::Errorf "foo%s\n" "bar" 2>&1)" "foobar"
