/**
	project MU0
	module mu0_ctrl, MU0 Controller
	G. Borg
	Feb 2009
**/
`timescale 1 ns/1 ps
module mu0_controller(clk, reset, opcode, acc, Asel, ACCen,
  PCen, IRen, M, Xsel, Ysel, Ren, Wen);
`include "defs.h"
  input clk;
  input reset;
  input [3:0] opcode;
  input [MAXWIDTH-1:0] acc;
  output Asel, ACCen, PCen, IRen, Xsel, Ysel, Ren, Wen;
  output [1:0] M;
  reg    Asel, ACCen, PCen, IRen, Xsel, Ysel, Ren, Wen;
  reg    [1:0] M;
  reg    [1:0] state, next_state;
  parameter INIT  = 2'b00;
  parameter FETCH = 2'b01;
  parameter EXEC  = 2'b10;
  // In the following S = last 12 bits of the IR, which is an address in memory
  reg [3:0] LDA = 4'b0000;  //Load the contents of S into ACC
  reg [3:0] STO = 4'b0001;  //Store the contents of ACC in S
  reg [3:0] ADD = 4'b0010;  //ADD the contents of the ACC to contents of S
  reg [3:0] SUB = 4'b0011;  //SUB the contents of the ACC to contents of S
  reg [3:0] JMP = 4'b0100;  //Set PC := S
  reg [3:0] JGE = 4'b0101;  //If ACC >= 0, PC := S
  reg [3:0] JNE = 4'b0110;  //If ACC ~= 0, PC := S
  reg [3:0] STP = 4'b0111;  //Stop

  always @(posedge clk)
  begin
    if (reset == 1)
      state <= INIT;
    else
      state <= next_state;
  end

  always @(state or opcode)
  begin
    case (state)
      INIT:
        next_state = FETCH;
      FETCH:
        next_state = EXEC;
      EXEC:
        if (opcode == STP)
          next_state = EXEC;
        else
          next_state = FETCH;
      default: next_state = INIT;
    endcase
  end

  always @(state or opcode or reset) begin
    case (state)
      INIT: begin
        PCen  = 1;
        IRen  = 1;
        ACCen = 1;
        Wen = 0;
        Ren = 0;
      end
      FETCH: begin
        //Store contents of mem[PC] in IR
        //Increment the contents of the PC register
        IRen = 1;  //Enable the IR for a new entry
        PCen = 1;  //Enable the PC for a new entry
        ACCen = 0; //Disable the accumulator
        M = 2'b10; //Set ALU to increment on Xbus input (pc)
        Xsel = 0;  //place contents of PC on Xbus destined for ALU
        //Ysel Dont care
        Asel = 0;  //place contents of PC on Abus destined for mem
        Ren = 1;   //Enable memory for a read on next neg edge
        Wen = 0;
      end
      EXEC: begin
        if (opcode == LDA) begin
          IRen = 0; PCen = 0; ACCen = 1;
          M = 2'b00;
          Xsel = 0; Ysel = 1; Asel = 1;
          Ren = 1; Wen = 0;
        end
        else if (opcode == STO) begin
          IRen = 0; PCen = 0; ACCen = 0;
          Xsel = 1;           Asel = 1;
          Ren = 0; Wen = 1;
        end
        else if (opcode == ADD) begin
          IRen = 0; PCen = 0; ACCen = 1;
          M = 2'b01;
          Xsel = 1; Ysel = 1; Asel = 1;
          Ren = 1; Wen = 0;
        end
        else if (opcode == SUB) begin
          IRen = 0; PCen = 0; ACCen = 1;
          M = 2'b11;
          Xsel = 1; Ysel = 1; Asel = 1;
          Ren = 1; Wen = 0;
        end
        else if (opcode == JMP) begin
          IRen = 0; PCen = 1; ACCen = 0;
          M = 2'b00;
          Xsel = 0; Ysel = 0; 
          Ren = 0; Wen = 0;
        end
        else if (opcode == JGE) begin
          IRen = 0;
          PCen = ~acc[MAXWIDTH-1];
          //If ACC>=0 then acc[MAXWIDTH-1]=0
          //Otherwise do nothing by disabling the PC
          ACCen = 0;
          M = 2'b00;
          Xsel = 0; Ysel = 0;
          Ren = 0; Wen = 0;
        end
        else if (opcode == JNE) begin
          IRen = 0;
          //If the acc is non-zero, then at least one bit=1
          //Otherwise do nothing by disabling the PC
          PCen = |acc;
          ACCen = 0;
          M = 2'b00;
          Xsel = 0; Ysel = 0; 
          Ren = 0; Wen = 0;
        end
        else begin
          IRen = 0; PCen = 0; ACCen = 0;
          Xsel = 0;
          Ren = 0; Wen = 0;
        end
      end
      default: begin
      end
    endcase
  end

endmodule //mu0_controller
