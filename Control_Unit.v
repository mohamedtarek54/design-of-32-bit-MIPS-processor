module Control_Unit (

input wire  [5:0] Opcode,
input wire  [5:0] Funct,
input wire        Zero,

output wire       Jump,
output wire       MemtoReg,
output wire       MemWrite,
output wire       PcSrc,
output wire       ALUSrc,
output wire       RegDst,
output wire       RegWrite,
output wire [2:0] ALUControl
);
  
wire [1:0] ALUOp;
wire       Branch;
assign PcSrc = Branch & Zero;

Main_Decoder MD(
.Opcode(Opcode),

.Jump(Jump),
.ALUOp(ALUOp),
.MemtoReg(MemtoReg),
.MemWrite(MemWrite),
.Branch(Branch),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite)
);

ALU_Decoder AD(
.ALUOp(ALUOp),
.Funct(Funct),

.ALUControl(ALUControl)
);
endmodule
