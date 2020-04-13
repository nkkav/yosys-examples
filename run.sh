#!/bin/bash

# Icarus Verilog
for test in "adder" "alu" "and2" "bcd" "car_speed_cntl" \
  "countbits" \
  "gcd" "ior2" "mu0" "mux2to1" "ram" "register" "rom16x8" \
  "xor2"
do
  cd ${test}
  echo "Simulate ${test} with Icarus Verilog"
  ./run-iverilog.sh
  cd ..
done

# YOSYS
for test in "adder" "alu" "and2" "bcd" "car_speed_cntl" \
  "countbits" \
  "gcd" "ior2" "mu0" "mux2to1" "ram" "register" "rom16x8" \
  "xor2"
do
  cd ${test}
  echo "Synthesize ${test} using YOSYS"
  ./run-yosys.sh show_rtl
  cd ..
done

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."
