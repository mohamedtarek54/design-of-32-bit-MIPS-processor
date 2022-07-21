module MUX2_1 #(parameter WIDTH = 32) (

input wire [WIDTH-1:0] IN0,
input wire [WIDTH-1:0] IN1,
input wire             sel,

output wire [WIDTH-1:0] OUT
);

assign OUT = (sel) ? IN1 : IN0;

endmodule