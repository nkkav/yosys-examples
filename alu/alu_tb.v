`timescale 1 ns / 1 ns

module main;
  reg[7:0] a, b;
  reg cin;
  reg[3:0] sel;
  wire[7:0] y;
  integer idx;

  alu test(.a(a), .b(b), .cin(cin), .sel(sel), .y(y));

  initial 
  begin
    // a, b are fixed through out the test
    a = 8'h93;
    b = 8'hA7;
    for (idx = 0;  idx <= 15;  idx = idx + 1) 
    begin
      // Generate sel
      sel = idx;
      // cin = 1 only for sel = 5
      if (idx == 5)
        cin = 1'b1;
      else
        cin = 1'b0;
      // Apply a 10-time unit delay; think of it as the system machine cycle
      #10
      // Display results after 10 time units $
      $display("%t: a=%h, b=%h, cin=%b, sel=%h, y=%h", $time, a, b, cin, sel, y);
    end 
  end
endmodule // main
