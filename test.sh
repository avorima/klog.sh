#!/usr/bin/env bash

source ./klog.sh

assert_that_has_message() {
    if ! grep -qw "$2" <<< "$1"; then
        caller
        echo "Did not find message: $2 in $1"
        exit 1
    fi
}

assert_that_failed_ok() {
    local exit_code=$?
    if (( exit_code != 255 )); then
        caller
        echo "Wrong exit code"
        exit 1
    fi
}

assert_that_has_message "$(klog::Info "foo" "bar" 2>&1)" "foobar"
assert_that_has_message "$(klog::Info "foo " "bar" 2>&1)" "foo bar"
assert_that_has_message "$(klog::Info "foo\n" "bar" 2>&1)" "foo"
assert_that_has_message "$(klog::Infof "foobar" 2>&1)" "foobar"
assert_that_has_message "$(klog::Infof "foo%s" "bar" 2>&1)" "foobar"
assert_that_has_message "$(klog::Infoln "foo" "bar" 2>&1)" "foo bar"

(
    klog::Fatal "panic"
)
assert_that_failed_ok

func1() {
    func2
}

func2() {
    klog::Fatal "panic"
}

# Verify that stacktrace contains the correct elements
stacktrace=()
while read -r line; do
    [[ $line == "Stacktrace:" ]] && continue
    stacktrace+=("$line")
done < <(
    func1 2>&1
)

if [[ ${#stacktrace[@]} -eq 0 ]]; then
    echo "Expected stack trace to be printed"
    exit 1
fi

assert_that_has_message "${stacktrace[0]}" "panic"
assert_that_has_message "${stacktrace[1]}" "func2"
assert_that_has_message "${stacktrace[2]}" "func1"
assert_that_has_message "${stacktrace[3]}" "main"
