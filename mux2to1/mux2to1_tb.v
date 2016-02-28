`timescale 1 ns / 1 ns

module main;
  reg  a, b, sel;
  reg[2:0] inputs;
  wire f;
  integer idx;

  mux2to1 test(.f(f), .a(a), .b(b), .sel(sel));

  initial 
  begin
    for (idx = 0;  idx <= 7;  idx = idx + 1) 
    begin
      inputs = idx;
      sel  = inputs[2];
      a    = inputs[1];
      b    = inputs[0];
      // Apply a 10-time unit delay; think of it as the system machine cycle
      #10
      // Display results after 10 time units $
      $display("%t: sel=%b, a=%b, b=%b, f=%b", $time, sel, a, b, f);
    end 
  end
endmodule // main
