module Program_Counter (
  
input wire        CLK,
input wire        rst,
input wire [31:0] PC_,

output reg [31:0] PC
);

always @ (posedge CLK or negedge rst)
  begin
  if(!rst)
    PC <= 32'b0;
  else
    PC <= PC_;    
  end

endmodule

