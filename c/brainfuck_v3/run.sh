#!/usr/bin/env bash
program=(./target/*)
args=("$@")
prog=${args[0]}
flag=${args[1]}
if (( ${#program[@]} != 1 )); then return 1; fi
$program "bf_programs/$prog" "$flag"
