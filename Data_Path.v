module Data_Path (
  
input wire          CLK,
input wire          rst,
input wire  [31:0]  ReadData,
input wire  [31:0]  Instr,
input wire  [2:0]   ALUControl,
input wire          ALUSrc,
input wire          RegDst,
input wire          MemtoReg,
input wire          RegWrite,
input wire          Jump,
input wire          PcSrc,



output wire         Zero,
output wire [31:0]  PC,
output wire [31:0]  ALUResult, // address coming out of alu
output wire [31:0]  WriteData
);

wire [31:0] PCPlus4, PCBranch, M1_op, PCNext, SignImm, SignImmsh, Result, SrcA, SrcB;
wire [4:0]  WriteReg;
// next PC Logic
Adder A1(
.A(PC),
.B(32'd4),
.C(PCPlus4)
);

Adder A2(
.A(SignImmsh),
.B(PCPlus4),
.C(PCBranch)
);

Shift_Left_Twice #(.WIDTH(32)) SLT1 (
.in(SignImm),
.out(SignImmsh)
);
  
MUX2_1 #(.WIDTH(32)) M1 (
.IN0(PCPlus4),
.IN1(PCBranch),
.sel(PcSrc),

.OUT(M1_op)
);

MUX2_1 #(.WIDTH(32)) M2 (
.IN0(M1_op),
.IN1({PCPlus4[31:28], Instr[25:0], 2'b00}),
.sel(Jump),

.OUT(PCNext)
);

Program_Counter PC1 (
  
.CLK(CLK),
.rst(rst),
.PC_(PCNext),

.PC(PC)
);

// register file logic

Reg_File RF (
.CLK(CLK),
.rst(rst),
.WE3(RegWrite),
.A1(Instr[25:21]),
.A2(Instr[20:16]),
.A3(WriteReg),
.WD3(Result),

.RD1(SrcA),
.RD2(WriteData)
);

MUX2_1 #(.WIDTH(5)) M3 (
.IN0(Instr[20:16]),
.IN1(Instr[15:11]),
.sel(RegDst),

.OUT(WriteReg)
);

MUX2_1 #(.WIDTH(32)) M4 (
.IN0(ALUResult),
.IN1(ReadData),
.sel(MemtoReg),

.OUT(Result)
);

Sign_Extend EX1(
.Instr(Instr[15:0]),
.SignImm(SignImm)
);

// ALU Logic

ALU ALU1 (
.SrcA(SrcA),
.SrcB(SrcB),
.ALUControl(ALUControl),

.Zero(Zero),
.ALUResult(ALUResult)
);

MUX2_1 #(.WIDTH(32)) M5 (
.IN0(WriteData),
.IN1(SignImm),
.sel(ALUSrc),

.OUT(SrcB)
);

endmodule