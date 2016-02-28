module gcd (
  clock, reset, start,
  a, b,
  outp, done);
  parameter WIDTH = 8;
  parameter s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11;
  input clock, reset, start;
  input [WIDTH-1:0] a, b;
  output [WIDTH-1:0] outp;
  output done;
  reg done;
  reg [WIDTH-1:0] outp;
  reg[1:0] state;
  reg [WIDTH-1:0] x_reg, x_next, y_reg, y_next;
  
  always @(posedge clock or posedge reset)
  begin
    done = 1'b0;
    if (reset) begin
      state = s0;
      x_reg = 0;
      y_reg = 0;
      done = 1'b0;
      outp = 0;
    end
    else begin
      x_reg = x_next;
      y_reg = y_next;
      case (state)
        s0: begin
          if (start) begin
            x_next = a;
            y_next = b;
            state = s1;
          end
          else
            state = s0;
        end
        s1: begin
          if (x_reg != 0 && y_reg != 0)
            state = s2;
          else begin
            outp = 0;
            state = s3;
          end
        end
        s2: begin
          if (x_reg > y_reg) begin
            x_next = x_reg - y_reg;
            state = s2;
          end
          else if (x_reg < y_reg) begin
            y_next = y_reg - x_reg;
            state = s2;
          end
          else
            state = s3;
        end
        s3: begin
          done = 1'b1;
          outp = x_reg;
          state = s0;
        end
      endcase
    end
  end

endmodule
