/**
	project MU0
	module TB_mu0_ctrl, test bench for mu0_ctrl
	G. Borg
	Feb 2009
**/
`timescale 1 ns/1 ps

module mu0_tb;
`include "defs.h"
  reg clk, reset;
  wire [MAXWIDTH-1:0] pc;
  wire [MAXWIDTH-1:0] ir;
  wire [MAXWIDTH-1:0] acc;

  mu0 processor (
    .clk(clk), .reset(reset),
    .pc(pc), .ir(ir), .acc(acc)
  );

  // Test clock generation.
  //
  // Clock pulse starts from 0.
  initial
  begin
    clk = 1'b0;
    reset = 1'b1;
    #10 reset = 1'b0;
  end
  // Free-running clock
  always
    #5 clk = ~clk;

  // Write simulation data to a VCD waveform file.
  initial
  begin
    // Open a VCD file for writing
    $dumpfile("mu0.vcd");
    // Dump the values of all nets and wires in module "gcd_main", seen
    // from hierarchy level 0
    $dumpvars(0, mu0_tb);
  end

  initial 
  begin
    #1000; 
    $finish;
  end

endmodule
