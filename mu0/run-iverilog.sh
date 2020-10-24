#!/bin/sh

echo "Testing: mu0 (structural)"
${IVERILOG_PATH}/iverilog -g1995 -o mu0_tb mux12.v mux16.v vreg16.v \
  alu16.v mem.v mu0_controller.v mu0_datapath.v mu0.v mu0_tb.v
${IVERILOG_PATH}/vvp mu0_tb
cp -f mu0.vcd mu0_structural.vcd
rm -rf mu0.vcd

echo "Testing: mu0 (behavioral)"
${IVERILOG_PATH}/iverilog -g1995 -o mu0_tb mu0_behav.v mu0_tb.v
${IVERILOG_PATH}/vvp mu0_tb
cp -f mu0.vcd mu0_behavioral.vcd
rm -rf mu0.vcd

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."

echo "Ran all tests."
