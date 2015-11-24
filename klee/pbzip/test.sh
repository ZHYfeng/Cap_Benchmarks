#!/bin/sh
klee pbzip2_revise2.o -k -f -p4 $PWDinput 2>result.txt 1>&2
