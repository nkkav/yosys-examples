`timescale 1 ns / 10 ps

module main;
  reg clk, re;
  reg [3:0] addr;
  wire [7:0] data;
  integer idx;
  
  rom16x8 uut(.clk(clk), .re(re), .addr(addr), .data(data));
  
  // Test clock generation.
  //
  // Clock pulse starts from 1.
  initial 
    clk = 1'b1;
  // Free-running clock  
  always
    #25 clk = ~clk;
    
  // Data stimulus
  initial 
  begin
    #1 re = 1'b0; addr = 4'h2;
    //
    for (idx = 0; idx <= 15; idx = idx + 1) 
    begin
      #50 addr = idx; re = 1'b1;      
    end
    #50
//    $stop;    // for Modelsim
    $finish;  // for Icarus Verilog 
  end
  
  initial
    $monitor("%t: clk = %b, re=%b, addr=%h, data=%h", $time, clk, re, addr, data);

  // Write simulation data to a Value Change Dump (VCD) file.
  initial 
  begin
    // Open a VCD file for writing
    $dumpfile("rom16x8.vcd");
    // Dump the values of all nets and wires in module "main", since simulation 
    // time 0
    $dumpvars(0, main);
  end

endmodule
