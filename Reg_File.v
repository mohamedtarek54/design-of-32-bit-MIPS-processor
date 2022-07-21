module Reg_File (

input wire          CLK,
input wire          rst,
input wire          WE3,
input wire  [4:0]   A1,
input wire  [4:0]   A2,
input wire  [4:0]   A3,
input wire  [31:0]  WD3,

output wire [31:0]  RD1,
output wire [31:0]  RD2
);


reg [31:0] register_file [99:0];
integer I;

assign RD1 = register_file[A1];
assign RD2 = register_file[A2];

always @ (posedge CLK or negedge rst)
begin
  if(!rst)
    begin
      for(I = 0; I < 100; I = I+1)
        register_file[I] <= 32'b0;
    end
  else if(WE3)
    begin
      register_file[A3] <= WD3;   
    end
end

endmodule