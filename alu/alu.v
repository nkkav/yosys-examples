module alu(a, b, cin, sel, y);
  input [7:0] a, b;
  input cin;
  input [3:0] sel;
  output [7:0] y;
  reg [7:0] y;
  reg [7:0] arithval;
  reg [7:0] logicval;

  // Arithmetic unit
  always @(a or b or cin or sel) begin
    case (sel[2:0])
      3'b000  : arithval = a;
      3'b001  : arithval = a + 1;
      3'b010  : arithval = a - 1;
      3'b011  : arithval = b;
      3'b100  : arithval = b + 1;
      3'b101  : arithval = b - 1;
      3'b110  : arithval = a + b;
      default : arithval = a + b + cin;
    endcase
  end

  // Logic unit
  always @(a or b or sel) begin
    case (sel[2:0])
      3'b000  : logicval =  ~a;
      3'b001  : logicval =  ~b;
      3'b010  : logicval = a & b;
      3'b011  : logicval = a | b;
      3'b100  : logicval =  ~((a & b));
      3'b101  : logicval =  ~((a | b));
      3'b110  : logicval = a ^ b;
      default : logicval =  ~(a ^ b);
    endcase
  end

  // Multiplexer
  always @(arithval or logicval or sel) begin
    case (sel[3])
      1'b0    : y = arithval;
      default : y = logicval;
    endcase
  end

endmodule
