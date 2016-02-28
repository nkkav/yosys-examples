/**
	project MU0
	module mux12, 12 bit mux
	G. Borg
	Feb 2009
**/
`timescale 1 ns/1 ps
module mux12 (z, s, a, b);
`include "defs.h"
  output [MAXDEPTH-1:0] z;
  input  [MAXDEPTH-1:0] a, b;
  input  s;

  assign  z =  s ? b : a ;    // s=1, z<-b; s=0, z<-a

endmodule //mux12.v

