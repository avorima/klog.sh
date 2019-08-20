#!/usr/bin/env bash

# Check if date supports %N
if date --help 2>&1 | grep -q '%N'; then
    DATESTR="%T.%6N"
else
    DATESTR="%H:%M:%S"
fi

klog::Info() {
    local c=($(caller))
    local a=("$@")
    local msg=$(IFS=; echo "${a[*]}")
    echo "I$(date +"%m%d") $(date +$DATESTR) $$ $(basename "${c[1]}"):${c[0]}] $msg"
}

klog::Infof() {
    local c=($(caller))
    local msg
    local a=("$@")
    msg=$(printf "$1" ${a[@]:1})
    echo "I$(date +"%m%d") $(date +$DATESTR) $$ $(basename "${c[1]}"):${c[0]}] $msg"
}

klog::Warning() {
    local c=($(caller))
    local a=("$@")
    local msg=$(IFS=; echo "${a[*]}")
    echo "W$(date +"%m%d") $(date +$DATESTR) $$ $(basename "${c[1]}"):${c[0]}] $msg" 1>&2
}

klog::Warningf() {
    local c=($(caller))
    local msg
    local a=("$@")
    msg=$(printf "$1" ${a[@]:1})
    echo "W$(date +"%m%d") $(date +$DATESTR) $$ $(basename "${c[1]}"):${c[0]}] $msg" 1>&2
}

klog::Error() {
    local c=($(caller))
    local a=("$@")
    local msg=$(IFS=; echo "${a[*]}")
    echo "E$(date +"%m%d") $(date +$DATESTR) $$ $(basename "${c[1]}"):${c[0]}] $msg" 1>&2
}

klog::Errorf() {
    local c=($(caller))
    local msg
    local a=("$@")
    msg=$(printf "$1" ${a[@]:1})
    echo "E$(date +"%m%d") $(date +$DATESTR) $$ $(basename "${c[1]}"):${c[0]}] $msg" 1>&2
}

klog::Fatal() {
    local c=($(caller))
    local a=("$@")
    local msg=$(IFS=; echo "${a[*]}")
    echo "F$(date +"%m%d") $(date +$DATESTR) $$ $(basename "${c[1]}"):${c[0]}] $msg" 1>&2
    exit 255
}

klog::Fatalf() {
    local c=($(caller))
    local msg
    local a=("$@")
    msg=$(printf "$1" ${a[@]:1})
    echo "F$(date +"%m%d") $(date +$DATESTR) $$ $(basename "${c[1]}"):${c[0]}] $msg" 1>&2
    exit 255
}
