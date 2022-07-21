module Main_Decoder (

input wire  [5:0] Opcode,

output reg       Jump,
output reg [1:0] ALUOp,
output reg       MemtoReg,
output reg       MemWrite,
output reg       Branch,
output reg       ALUSrc,
output reg       RegDst,
output reg       RegWrite
);
  
  
always @ (*)
begin
  
  Jump = 1'b0;
  ALUOp = 2'b00;
  MemWrite = 1'b0;
  RegWrite = 1'b0;
  RegDst = 1'b0;
  ALUSrc = 1'b0;
  MemtoReg = 1'b0;
  Branch = 1'b0;
  
  case(Opcode)
     // load word instruction
     6'b10_0011: begin
          Jump = 1'b0;
          ALUOp = 2'b00;
          MemWrite = 1'b0;
          RegWrite = 1'b1;
          RegDst = 1'b0;
          ALUSrc = 1'b1;
          MemtoReg = 1'b1;
          Branch = 1'b0;
     end
     // store word instruction
     6'b10_1011: begin
          Jump = 1'b0;
          ALUOp = 2'b00;
          MemWrite = 1'b1;
          RegWrite = 1'b0;
          RegDst = 1'b0;
          ALUSrc = 1'b1;
          MemtoReg = 1'b1;
          Branch = 1'b0;
     end
     // R-type instruction
     6'b00_0000: begin
          Jump = 1'b0;
          ALUOp = 2'b10;
          MemWrite = 1'b0;
          RegWrite = 1'b1;
          RegDst = 1'b1;
          ALUSrc = 1'b0;
          MemtoReg = 1'b0;
          Branch = 1'b0;
     end
     // add immediate instruction
     6'b00_1000: begin
          Jump = 1'b0;
          ALUOp = 2'b00;
          MemWrite = 1'b0;
          RegWrite = 1'b1;
          RegDst = 1'b0;
          ALUSrc = 1'b1;
          MemtoReg = 1'b0;
          Branch = 1'b0;
     end
     // branch if equal instruction
     6'b00_0100: begin
          Jump = 1'b0;
          ALUOp = 2'b01;
          MemWrite = 1'b0;
          RegWrite = 1'b0;
          RegDst = 1'b0;
          ALUSrc = 1'b0;
          MemtoReg = 1'b0;
          Branch = 1'b1;
     end
     // jump instruction
     6'b00_0010: begin
          Jump = 1'b1;
          ALUOp = 2'b00;
          MemWrite = 1'b0;
          RegWrite = 1'b0;
          RegDst = 1'b0;
          ALUSrc = 1'b0;
          MemtoReg = 1'b0;
          Branch = 1'b0;
     end
  endcase
end
endmodule