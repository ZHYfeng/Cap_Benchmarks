#!/bin/sh
klee pnscan  127.0.0.1 http 2>result.txt 1>&2
# klee pnscan 127.0.0.1 http
# klee pnscan -n2 127.0.0.1 1:65525
# klee pnscan 192.168.0.1:192.168.0.254 ssh