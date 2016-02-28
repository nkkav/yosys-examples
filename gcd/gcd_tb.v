`timescale 1 ns / 10 ps

module gcd_main;
  parameter WIDTH = 8;
  reg clock, reset, start;
  reg [WIDTH-1:0] a, b, y, y_ref;
  reg [WIDTH-1:0] a_reg, b_reg;
  wire [WIDTH-1:0] outp;
  wire done;
  // 
  parameter GCD_tests = 8;
  integer N,M;
  reg Passed, FailTime;
  integer SimResults;
  // Declare memory array for test data
  reg [WIDTH-1:0] ab_y_ref_arr[1:GCD_tests*3];
  // Profiling counter
  integer ncycles;
  
  // Test the GCD implementation
  gcd test(
    .clock(clock), .reset(reset), .start(start),
    .a(a), .b(b),
    .outp(outp), .done(done)
  );  
  
  // Test clock generation.
  //
  // Clock pulse starts from 0.
  initial 
    clock = 1'b0;
  // Free-running clock  
  always
    #25 clock = ~clock;  
  
  // PROFILING
  always @(posedge clock or posedge reset)
  begin
    if (reset)
      ncycles = 0;
    else
      ncycles = ncycles + 1;
  end
  
  // Test GCD algorithm
  initial
  begin
    // Load contents of "gcd_test_data_hex.txt" into array.
    $readmemh("gcd_test_data_hex.txt", ab_y_ref_arr);
    // Open simulation results file.
    SimResults = $fopen("gcd_alg_test_results.txt");
    Passed = 1; // Set to 0 if fails
    for (N = 0; N < GCD_tests; N = N + 1)
    begin
      a = ab_y_ref_arr[(N*3)+1];
      b = ab_y_ref_arr[(N*3)+2];
      y_ref = ab_y_ref_arr[(N*3)+3];
      ///////////////////////////////////////////////////
      reset = 1;
      #50 reset = 0; start = 1;
      ///////////////////////////////////////////////////
      wait (done);
      #50;
      // Diagnostics for GCD algorithm
      if (outp != y_ref) begin
        Passed = 0;
        $fdisplay(SimResults, "GCD Error: A=%d, B=%d, Y=%d. Y should be %d",
        a, b, outp, y_ref);
      end
      else begin
        $fdisplay(SimResults, "GCD OK: Number of cycles = %d", ncycles);
      end
    end
    if (Passed == 1) begin
      $fdisplay(SimResults, "GCD algorithm test has passed");
      $fclose(SimResults);
      $finish;
    end
  end

  // Write simulation data to a VCD waveform file.
  initial 
  begin
    // Open a VCD file for writing
    $dumpfile("gcd.vcd");
    // Dump the values of all nets and wires in module "gcd_main", seen 
    // from hierarchy level 0
    $dumpvars(0, gcd_main);
  end

endmodule
