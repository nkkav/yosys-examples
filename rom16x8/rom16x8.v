module rom16x8 (clk, re, addr, data); 
  input  clk; 
  input  re; 
  input  [3:0] addr; 
  output [7:0] data; 
  reg [7:0] ROM [15:0]; 
  reg [7:0] data;

  initial 
  begin
    ROM[ 0] = 8'h01; ROM[ 1] = 8'h02; ROM[ 2] = 8'h04; ROM[ 3] = 8'h08;
    ROM[ 4] = 8'h10; ROM[ 5] = 8'h20; ROM[ 6] = 8'h40; ROM[ 7] = 8'h80;
    ROM[ 8] = 8'h01; ROM[ 9] = 8'h03; ROM[10] = 8'h07; ROM[11] = 8'h0F;
    ROM[12] = 8'h1F; ROM[13] = 8'h3F; ROM[14] = 8'h7F; ROM[15] = 8'hFF;
  end

  always @(posedge clk) 
  begin 
    if (re) 
      data <= ROM[addr];
  end
   
endmodule
