#!/bin/bash
########################################################################33
#Author: br0k3ngl255
#date:
#Purpose: just for laughs
########################################################################33
while IFS= read -r line; do
    length="${#line}"
    bol=1
    for (( offset = 0 ; offset < length ; offset++ )); do
        char="${line:offset:1}"
        printf '%s' "$char"
        if (( bol )) && [[ "$char" == " " ]]; then
            continue
        fi
        bol=0
        sleep 0.05
    done

    if (( length == 0 )); then
        sleep 0.$(( RANDOM % 3 + 2 ))
    else
        sleep 0.$(( RANDOM % 7 + 3 ))
    fi

    printf '\n'
done
