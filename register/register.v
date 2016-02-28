module register8 (clk, reset, ld, din, dout);
  input       clk, reset, ld;
  input[7:0]  din;
  output[7:0] dout;
  reg[7:0]    dout;
  
  // Use of asynchronous reset
  always @(posedge clk or posedge reset)
    if (reset == 1'b1) 
      dout <= 0;
    // Change register state on rising edge and assertion of load line
    else if (ld == 1'b1) 
      dout <= din;

endmodule
