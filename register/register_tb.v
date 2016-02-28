`timescale 1 ns / 1 ns

module main;
  reg clk, reset, ld;
  reg [7:0] din;
  wire [7:0] dout;

  register8 test(.clk(clk), .reset(reset), .ld(ld), .din(din), .dout(dout));

  // Test clock generation.
  //
  // Clock pulse starts from 0.
  initial 
    clk = 1'b0;
  // Free-running clock  
  always
    #25 clk = ~clk;
    
  initial 
  begin
    #10 din = 8'h00; ld = 1'b0; reset = 1'b1;
    #50 din = 8'h00; ld = 1'b1; reset = 1'b0;
    #50 din = 8'h01;
    #50 din = 8'hFF;
    #50 din = 8'h55; ld = 1'b0;
    #50 din = 8'hAA; ld = 1'b1;
    #50 din = 8'hBA;
    #50 din = 8'h0B;
    #50 din = 8'hAB;
    #50
    $finish;
  end

  initial 
    $monitor("%t: reset=%b, ld=%b, din=%b, dout=%b", $time, reset, ld, din, dout);

endmodule // main
