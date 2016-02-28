/**
	project MU0
	module alu3_project, 16 bit ALU
	G. Borg
	Feb 2009
**/
`timescale 1 ns/1 ps
module alu16(M, X, Y, Z);
 `include "defs.h"
  parameter Acc = 2'b00; //Pass through to the Accumulator
  parameter Add = 2'b01; //Add X and Y
  parameter PCi = 2'b10; //Increment the Program counter
  parameter Sub = 2'b11; //Subtract Y from X
  input  [1:0] M;
  input  [MAXWIDTH-1:0] X;
  input  [MAXWIDTH-1:0] Y;
  output [MAXWIDTH-1:0] Z;
  reg    [MAXWIDTH-1:0] Z;

  always @(M, X, Y)
  begin
    case(M)
      Add: Z = X + Y;
      Sub: Z = X + ~Y + 1;
      PCi: Z = X + 1;
      Acc: Z = Y;
      default: Z = 0;
    endcase
  end

endmodule //alu16.v
