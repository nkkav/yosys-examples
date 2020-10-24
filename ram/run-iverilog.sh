#!/bin/sh

for test in "ram"
do
  echo "Testing:" ${test}
  ${IVERILOG_PATH}/iverilog -o ${test}_tb ${test}.v ${test}_tb.v
  ${IVERILOG_PATH}/vvp ${test}_tb
  echo " "
done

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."
