/**
	project MU0
	module mu0_ctrl, MU0 Controller
	G. Borg
	Feb 2009
**/
`timescale 1 ns/1 ps
module mu0_datapath(clk, reset, 
  Abus, Xbus, Dbus, acc, ir, pc, 
  M, PCen, IRen, ACCen, Xsel, Ysel, Asel);
`include "defs.h"
  input  clk, reset;
  input  Xsel, Ysel, Asel, ACCen, PCen, IRen;
  input  [1:0] M;
  output [MAXWIDTH-1:0] acc;
  output [MAXWIDTH-1:0] ir;
  output [MAXWIDTH-1:0] pc;
  output [MAXDEPTH-1:0] Abus; // Address bus
  output [MAXWIDTH-1:0] Xbus;
  output [MAXWIDTH-1:0] Dbus; // Data input to MU0
  wire   [MAXWIDTH-1:0] Ybus;
  wire   [MAXWIDTH-1:0] Zbus; // ALU output

  /**********Module instantiations***********************/
  alu16 alu (
    .M(M), .X(Xbus), .Y(Ybus), .Z(Zbus)
  );

  mux16 x_mux (
    .z(Xbus), .s(Xsel), .a(pc), .b(acc)
  );
  mux16 y_mux (
    .z(Ybus), .s(Ysel), .a(ir), .b(Dbus)
  );
  mux12 a_mux (
    .z(Abus), .s(Asel), 
    .a(pc[MAXDEPTH-1:0]), .b(ir[MAXDEPTH-1:0])
  );

  vreg16 ProgramCounter (
    .clk(clk), .q(pc),  .d(Zbus), .en(PCen), .rs(reset)
  );
  vreg16 InstructionRegister (
    .clk(clk), .q(ir),  .d(Dbus), .en(IRen), .rs(reset)
  );
  vreg16 Accumulator (
    .clk(clk), .q(acc), .d(Zbus), .en(ACCen), .rs(reset)
  );

endmodule //mu0_datapath




