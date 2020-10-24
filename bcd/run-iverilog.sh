#!/bin/sh

echo "Testing: bcd.v"
${IVERILOG_PATH}/iverilog -g1995 -o bcd_tb bcd.v bcd_tb.v
${IVERILOG_PATH}/vvp bcd_tb

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."

echo "Ran all tests."
