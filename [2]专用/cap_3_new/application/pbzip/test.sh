#!/bin/sh
klee pbzip2_revise2.bc -k -f -p1 ${PWD}/2 2>result.txt 1>&2
