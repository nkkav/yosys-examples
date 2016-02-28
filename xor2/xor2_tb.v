`timescale 1 ns / 1 ns

module main;
  reg      a, b;
  reg[1:0] inputs;
  wire     f;
  integer  idx;

  xor2 test(.f(f), .a(a), .b(b));

  initial 
  begin
    for (idx = 0;  idx <= 3;  idx = idx + 1) 
    begin
      inputs = idx;
      a    = inputs[1];
      b    = inputs[0];
      // Apply a 10-time unit delay; think of it as the system machine cycle
      #10
      // Display results after 10 time units $
      $display("%t: a=%b, b=%b, f=%b", $time, a, b, f);
    end 
  end
endmodule // main
