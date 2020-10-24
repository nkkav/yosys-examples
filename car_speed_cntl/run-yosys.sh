#!/bin/bash

########################################################################
# $1 = show_cmos, show_coarse, or show_rtl
#
# Operation: select script to run with YOSYS synthesis.
# NOTE: Assumes that a YOSYS script uses the .ys suffix.
########################################################################

${YOSYS_PATH}/yosys -s $1.ys
