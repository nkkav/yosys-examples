`timescale 1 ns / 1 ns

module main;
  reg [7:0] a, b;
  reg ci;
  wire [7:0] sum;
  wire co;

  adder test(.a(a), .b(b), .ci(ci), .sum(sum), .co(co));

  initial 
  begin
    a = 8'hA1; b = 8'hBF; ci = 1'b1;
    #10
    $display("%t: a=%h, b=%h, ci=%b, sum=%h, co=%b", $time, a, b, ci, sum, co);
    a = 8'h00; b = 8'h00; ci = 1'b0;
    #10
    $display("%t: a=%h, b=%h, ci=%b, sum=%h, co=%b", $time, a, b, ci, sum, co);
    a = 8'h00; b = 8'h01; ci = 1'b1;
    #10
    $display("%t: a=%h, b=%h, ci=%b, sum=%h, co=%b", $time, a, b, ci, sum, co);
    a = 8'hFF; b = 8'h01; ci = 1'b0;
    #10
    $display("%t: a=%h, b=%h, ci=%b, sum=%h, co=%b", $time, a, b, ci, sum, co);
    a = 8'h12; b = 8'h23; ci = 1'b0;
    #10
    $display("%t: a=%h, b=%h, ci=%b, sum=%h, co=%b", $time, a, b, ci, sum, co);
    a = 8'hA1; b = 8'hBF; ci = 1'b0;
    #10
    $display("%t: a=%h, b=%h, ci=%b, sum=%h, co=%b", $time, a, b, ci, sum, co);
  end
endmodule // main
  
