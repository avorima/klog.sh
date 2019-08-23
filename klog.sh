#!/usr/bin/env bash

# Check if date supports %N
if date --help 2>&1 | grep -q '%N'; then
    DATESTR="%T.%6N"
else
    DATESTR="%H:%M:%S"
fi

__join() { local IFS=$1; echo "$*"; }

__writeHeader() {
    local c=($(caller 1))
    printf "%s%s %s %7d %s:%d] " \
        "$1" "$(date +%m%d)" "$(date +$DATESTR)" $$ \
        "$(basename "${c[2]}")" "${c[0]}" 1>&2
}

klog::Info() {
    __writeHeader "I"
    echo -e "$(__join "" "$@")"
}

klog::Infoln() {
    __writeHeader "I"
    echo -e "$@" 1>&2
}

klog::Infof() {
    __writeHeader "I"
    local a=("$@")
    echo -e "$(printf "$1" ${a[@]:1})" 1>&2
}

klog::Warning() {
    __writeHeader "W"
    echo -e "$@" 1>&2
}

klog::Warningf() {
    __writeHeader "W"
    local a=("$@")
    echo -e "$(printf "$1" ${a[@]:1})" 1>&2
}

klog::Warningln() {
    __writeHeader "W"
    echo -e "$@" 1>&2
}

klog::Error() {
    __writeHeader "E"
    echo -e "$(__join "" "$@")" 1>&2
}

klog::Errorf() {
    __writeHeader "E"
    local a=("$@")
    echo -e "$(printf "$1" ${a[@]:1})" 1>&2
}

klog::Errorln() {
    __writeHeader "E"
    echo -e "$@" 1>&2
}
