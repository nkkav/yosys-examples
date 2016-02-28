/**
	project MU0
	module mu0_ctrl, MU0 Controller
	G. Borg
	Feb 2009
**/
`timescale 1 ns/1 ps
module mu0(clk, reset, pc, ir, acc);
`include "defs.h"
  input clk, reset;
  wire Asel, Xsel, Ysel, ACCen, PCen, IRen, Ren, Wen;
  wire [1:0] M;
  output [MAXWIDTH-1:0] pc, ir, acc, Zbus;
  wire [MAXDEPTH-1:0] Abus;
  wire [MAXWIDTH-1:0] Xbus, Dbus;

  // Instruction and data memory (non-synthesizable)
  mem memory (
    .Clk(clk), .Wen(Wen), .Ren(Ren),
    .address(Abus), .write_data(Xbus), .read_data(Dbus));

  // Control unit
  mu0_controller control_unit (
    .clk(clk), .reset(reset), .opcode(ir[MAXWIDTH-1:MAXWIDTH-4]),
    .acc(acc), .Asel(Asel), .ACCen(ACCen), .PCen(PCen), .IRen(IRen),
    .M(M), .Xsel(Xsel), .Ysel(Ysel), .Ren(Ren), .Wen(Wen));

  // Datapath
  mu0_datapath datapath (
    .clk(clk), .reset(reset),
    .Abus(Abus), .Xbus(Xbus), .Dbus(Dbus), .acc(acc), .ir(ir), .pc(pc),
    .M(M), .PCen(PCen), .IRen(IRen), .ACCen(ACCen),
    .Xsel(Xsel), .Ysel(Ysel), .Asel(Asel));

endmodule //mu0
