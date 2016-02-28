module mux2to1(f, a, b, sel);
  output f;
  input a, b, sel;
// Needed when assigned in a sequential logic block (like always)
// A reg behaves like memory: holds its value until
// imperatively assigned otherwise
  reg f;
  
// Modules may contain one or more always blocks
// Sensitivity list contains signals whose change makes the block execute
  always @(a or b or sel)
// Body of an always block contains traditional imperative code
  begin
    if (sel)
      f = b;
    else
      f = a;
  end
  
endmodule
