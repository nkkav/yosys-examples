#!/bin/sh

echo "Testing: car_speed_cntl.v"
${IVERILOG_PATH}/iverilog -g1995 -o car_speed_cntl_tb car_speed_cntl.v car_speed_cntl_tb.v
${IVERILOG_PATH}/vvp car_speed_cntl_tb

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."

echo "Ran all tests."
