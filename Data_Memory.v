module Data_Memory (
  
input wire          CLK,
input wire          WE,
input wire          rst,
input wire [31:0]   A,
input wire [31:0]   WD,

output wire [31:0]  RD,
output wire [15:0]  test_value

);

reg [31:0] register_file [31:0];
integer I;

assign RD = register_file[A];
// assign first 16 bit to test_value
assign test_value = register_file[0][15:0];

always @ (posedge CLK or negedge rst)
begin
  if(!rst)
  begin
      for(I = 0; I < 100; I = I+1)
        register_file[I] <= 32'b0;
  end
  else if(WE)
    register_file[A] <= WD;
    
end
endmodule