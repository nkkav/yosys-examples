// http://noasic.com/blog/move-those-conditions-out-of-those-loops/

module countbits (clk, data, ones);
//  parameter DATA_WIDTH  = 4;
  parameter DATA_WIDTH  = 32;
  input        clk; 
  input  [DATA_WIDTH - 1:0] data; 
  output [2:0] ones; 
  reg    [2:0] ones;
  reg    [2:0] v_count; 
  integer      i;

  always @(posedge clk)
  begin : COUNT_BITS
    v_count = 0; 
    for (i = 0; i <= DATA_WIDTH - 1; i = i + 1)
    begin
      v_count = v_count + data[i]; 
    end
    ones <= v_count;  
  end 
endmodule
