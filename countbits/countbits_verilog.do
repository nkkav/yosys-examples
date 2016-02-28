###
vlib work
vlog countbits.v
vlog countbits_tb.v
vsim countbits_tb
vcd dumpports -file countbits.vcd /countbits_tb/uut/* -unique
onbreak {quit -f}
run -all
exit -f
