module Shift_Left_Twice #(parameter WIDTH = 32) (
input wire  [WIDTH-1:0] in,
output wire [WIDTH-1:0] out
);
  
  assign out = in<<2;
  
endmodule
