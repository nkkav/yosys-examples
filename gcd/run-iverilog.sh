#!/bin/sh

echo "Testing: gcd.v"
${IVERILOG_PATH}/iverilog -g1995 -o gcd_tb gcd.v gcd_tb.v
${IVERILOG_PATH}/vvp gcd_tb

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."

echo "Ran all tests."
