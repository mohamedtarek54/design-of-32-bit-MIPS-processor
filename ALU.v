module ALU (

input wire  [31:0]  SrcA,
input wire  [31:0]  SrcB,
input wire  [2:0]   ALUControl,

output wire         Zero,
output reg  [31:0] ALUResult
);

always @ (*)
  begin
    case(ALUControl)
     3'b000: ALUResult = SrcA & SrcB;
     3'b001: ALUResult = SrcA | SrcB;
     3'b010: ALUResult = SrcA + SrcB;
     3'b100: ALUResult = SrcA - SrcB;
     3'b101: ALUResult = SrcA * SrcB;
     3'b110: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0;
    default: ALUResult = 16'b0;
   endcase
  end
  
  assign Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;

endmodule