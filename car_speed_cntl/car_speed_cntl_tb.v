`timescale 1 ns / 10 ps

module main;
  reg clock, keys, brake, accelerate;
  wire [1:0] speed;

  car_speed_cntl test ( 
    .clock(clock),
    .keys(keys),
    .brake(brake),
    .accelerate(accelerate),
    .speed(speed)
  );
  
  // Test clock generation.
  //
  // Clock pulse starts from 0.
  initial 
    clock = 1'b0;
  // Free-running clock  
  always
    #25 clock = ~clock;
    
  // Data stimulus
  initial 
  begin
    #10 keys = 1'b0; brake = 1'b0; accelerate = 1'b0;
    #50 keys = 1'b1;
    #50 accelerate = 1'b1;
    #50 accelerate = 1'b1;
    #50 brake = 1'b1; 
    #50 brake = 1'b1; accelerate = 1'b1;
    #50 brake = 1'b0; accelerate = 1'b1;
    #50 accelerate = 1'b0;
    #50 accelerate = 1'b1;
    #150 brake = 1'b1; accelerate = 1'b0;
    #250
//    $stop;    // for Modelsim
    $finish;  // for Icarus Verilog 
  end

  // Write simulation data to a Value Change Dump (VCD) file.
  // More on this in lecture 07, scheduled next week!
  initial 
  begin
    // Open a VCD file for writing
    $dumpfile("car_speed_cntl.vcd");
    // Dump the values of all nets and wires in module "main", since simulation 
    // time 0
    $dumpvars(0, main);
  end

endmodule
