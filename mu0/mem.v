/**
	project MU0
	module mem, simple non-synthesisable memory
	G. Borg
	Feb 2009
**/
`timescale 1 ns/1 ps
module mem (Clk, Wen, Ren, address, write_data, read_data);
`include "defs.h"
  input  Clk;
  input  Wen;
  input  Ren;
  input  [MAXDEPTH-1:0] address;
  input  [MAXWIDTH-1:0] write_data;
  output [MAXWIDTH-1:0] read_data;
  reg    [MAXWIDTH-1:0] read_data;
  reg    [MAXWIDTH-1:0] mem [12'h0:12'hFFF];

  initial 
    $readmemh("prog.lst", mem);

  always @(negedge Clk)
  begin
    if (Wen) 
      mem[address] <= write_data;
    if (Ren)
      read_data    <= mem[address];
  end

endmodule //mem.v
