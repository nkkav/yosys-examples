module car_speed_cntl (clock, keys, brake, accelerate, speed);
  input clock, keys, brake, accelerate;
  output [1:0] speed;
  reg[1:0] speed, newspeed;
  parameter STOP = 2'b00, SLOW = 2'b01, 
            MEDIUM = 2'b10, FAST = 2'b11;
  
  always @(posedge clock or negedge keys)
  begin
    if (!keys)
      speed <= STOP;
    else
      speed <= newspeed;
  end
  
  always @(speed or keys or brake or accelerate)
  begin
    case (speed)
      STOP: begin
        if (accelerate)
          newspeed = SLOW;
        else
          newspeed = STOP;
      end
      SLOW: begin
        if (brake) 
          newspeed = STOP;
        else if (accelerate)
          newspeed = MEDIUM;
        else
          newspeed = SLOW;
      end
      MEDIUM: begin
        if (brake) 
          newspeed = SLOW;
        else if (accelerate)
          newspeed = FAST;
        else
          newspeed = MEDIUM;
      end
      FAST: begin
        if (brake) 
          newspeed = MEDIUM;
        else
          newspeed = FAST;
      end
      default: 
        newspeed = STOP;
    endcase
  end
  
endmodule
