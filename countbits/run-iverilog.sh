#!/bin/sh

echo "Testing: countbits.v"
${IVERILOG_PATH}/iverilog -o countbits_tb countbits.v countbits_tb.v
${IVERILOG_PATH}/vvp countbits_tb
echo " "
echo "Testing: countbits_opt.v"
${IVERILOG_PATH}/iverilog -o countbits_opt_tb countbits_opt.v countbits_tb.v
${IVERILOG_PATH}/vvp countbits_opt_tb
echo " "
