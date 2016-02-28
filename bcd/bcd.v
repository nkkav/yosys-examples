module bcd (clk, reset, count);
  input clk, reset;
  output [3:0] count;
  reg [3:0] count;
  reg [3:0] current_state;
  reg [3:0] next_state;
  parameter ZERO = 4'b0000, ONE = 4'b0001, TWO = 4'b0010, THREE = 4'b0011,
            FOUR = 4'b0100, FIVE = 4'b0101, SIX = 4'b0110, SEVEN = 4'b0111,
            EIGHT = 4'b1000, NINE = 4'b1001;

  always @(posedge clk or posedge reset)
  begin
    if (reset) 
      current_state <= ZERO;
    else 
      current_state <= next_state;
  end

  always @(current_state)
  begin
    case (current_state)
      ZERO: begin
        count = ZERO;  
        next_state = ONE;
      end
      ONE: begin
        count = ONE;   
        next_state = TWO;
      end
      TWO: begin
        count = TWO;   
        next_state = THREE;
      end
      THREE: begin
        count = THREE;   
        next_state = FOUR;
      end
      FOUR: begin
        count = FOUR;  
        next_state = FIVE;
      end
      FIVE: begin
        count = FIVE;  
        next_state = SIX;
      end
      SIX: begin
        count = SIX;   
        next_state = SEVEN;
      end
      SEVEN: begin
        count = SEVEN; 
        next_state = EIGHT;
      end
      EIGHT: begin
        count = EIGHT; 
        next_state = NINE;
      end
      NINE: begin
        count = NINE;  
        next_state = ZERO;
      end
      default: begin 
        count = 4'b1111; 
        next_state = ZERO;
      end
    endcase
  end
endmodule
