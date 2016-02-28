module ram (clk, we, rwaddr, di, do);
  input  clk;
  input  we;
  input  [5:0] rwaddr;
  input  [15:0] di;
  output [15:0] do;
  reg    [15:0] RAM [63:0];
  reg    [15:0] do;

  always @(posedge clk) begin
    if (we)
    begin
      RAM[rwaddr] <= di;
    end
    do <= RAM[rwaddr];    
  end

endmodule
