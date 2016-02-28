/**
	project MU0
	module vreg16, 16 bit register
	G. Borg
	Feb 2009
**/
`timescale 1 ns/1 ps
module vreg16 (clk, q, d, en, rs);
`include "defs.h"
  output [MAXWIDTH-1:0] q;
  input  [MAXWIDTH-1:0] d;
  input  clk;
  input  en;
  input  rs;
  reg    [MAXWIDTH-1:0] q;

  always @(posedge clk) 
  begin
    if (en && ~rs) 
      q <= d;
    if (en && rs) 
      q <= 16'h0;
  end

endmodule // v_reg16
