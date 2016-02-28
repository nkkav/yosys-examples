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
  reg [WIDTH-1:0] outp;
  reg done;
  reg[1:0] state;
  reg [WIDTH-1:0] x, y;
  
  always @(posedge clock or posedge reset)
  begin
    done = 1'b0;
    if (reset) begin
      state = s0;
      x = 0;
      y = 0;
      done = 1'b0;
      outp = 0;
    end
    else begin
      case (state)
        s0: begin
          if (start) begin
            x = a;
            y = b;
            state = s1;
          end
          else
            state = s0;
        end
        s1: begin
          if (x != 0 && y != 0)
            state = s2;
          else begin
            outp = 0;
            state = s3;
          end
        end
        s2: begin
          if (x > y) begin
            x = x - y;
            state = s2;
          end
          else if (x < y) begin
            y = y - x;
            state = s2;
          end
          else begin
            outp = x;
            state = s3;
          end
        end
        s3: begin
          done = 1'b1;
          state = s0;
        end
      endcase
    end
  end

endmodule
