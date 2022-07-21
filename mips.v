module mips(
  input wire        CLK,
  input wire        rst,
  input wire [31:0] Instr,
  input wire [31:0] ReadData,
  
  output wire        MemWrite,
  output wire [15:0] test_value,
  output wire [31:0] PC,
  output wire [31:0] ALUOut,
  output wire [31:0] WriteData
  );
  
  wire Zero, Jump, MemtoReg, PcSrc, ALUSrc, RegDst, RegWrite;
  wire [2:0] ALUControl;

Control_Unit CU(

.Opcode(Instr[31:26]),
.Funct(Instr[5:0]),
.Zero(Zero),

.Jump(Jump),
.MemtoReg(MemtoReg),
.MemWrite(MemWrite),
.PcSrc(PcSrc),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.ALUControl(ALUControl)
);
  
Data_Path  DP(
.CLK(CLK),
.rst(rst),
.ReadData(ReadData),
.Instr(Instr),
.ALUControl(ALUControl),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.MemtoReg(MemtoReg),
.RegWrite(RegWrite),
.Jump(Jump),
.PcSrc(PcSrc),

.Zero(Zero),
.PC(PC),
.ALUResult(ALUOut),
.WriteData(WriteData)
);

Instruction_Memory IM (
.PC(PC),
.Instr(Instr)
);

Data_Memory DM (
.CLK(CLK),
.WE(MemWrite),
.rst(rst),
.A(ALUOut),
.WD(WriteData),

.RD(ReadData),
.test_value(test_value)
);

endmodule
