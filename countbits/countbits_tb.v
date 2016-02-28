`timescale 1 ns / 1 ns

module countbits_tb;
  parameter DATA_WIDTH  = 4;
  parameter CLK_PERIOD  = 10/*ns*/;
  reg       clk; 
  reg  [DATA_WIDTH - 1:0]     data; 
  wire [$clog2(DATA_WIDTH):0] ones; 
  integer   i;

  countbits uut(
    .clk(clk), 
    .data(data),
    .ones(ones)
  );

  // Test clock generation.
  //
  // Clock pulse starts from 0.
  initial
  begin
    clk   = 1'b0;
  end
  // Free-running clock.
  always
    #(CLK_PERIOD/2) clk = ~clk;
    
  initial 
  begin
    for (i = 0;  i <= (1<<DATA_WIDTH)-1; i = i + 1) 
    begin
      data = i;
      // Apply a 10-time unit delay; think of it as the system machine cycle.
      #(CLK_PERIOD);
      // Display results after 10 time units $.
      $display("%t: data=%h, ones=%d", $time, data, ones);
    end 
    // Automatic end of the current simulation.
    #(CLK_PERIOD);
    $display("End simulation time reached.");
    $finish;
  end

  // Write simulation data to a VCD waveform file.
  initial
  begin
    $dumpfile("countbits.vcd");
    $dumpvars(0, countbits_tb);
  end
  
endmodule // main
