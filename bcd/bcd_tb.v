`timescale 1 ns / 1 ns

module main;
  reg clk, reset;
  wire [3:0] count;

  bcd test(.clk(clk), .reset(reset), .count(count));

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
    reset = 1'b1;
    #50 reset = 1'b0;
    #600
    $finish;
  end

  // Write simulation data to a Value Change Dump (VCD) file.
  // More on this in lecture 07, scheduled next week!
  initial 
  begin
    // Open a VCD file for writing
    $dumpfile("bcd.vcd");
    // Dump the values of all nets and wires in module "main", since simulation 
    // time 0
    $dumpvars(0, main);
  end

endmodule
