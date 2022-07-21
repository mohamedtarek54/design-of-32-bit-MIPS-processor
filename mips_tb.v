`timescale 1us/1us
module mips_tb();
  
reg        CLK_tb;
reg        rst_tb;
reg [31:0] Instr_tb;
reg [31:0] ReadData_tb;
  
wire        MemWrite_tb;
wire [15:0] test_value_tb;
wire [31:0] PC_tb;
wire [31:0] ALUOut_tb;
wire [31:0] WriteData_tb;
  
  // Clock Generator
parameter CLK_PERIOD = 10;
always #(CLK_PERIOD/2) CLK_tb = ~CLK_tb ;
  
initial
begin
  reset_mips();
  #(20*CLK_PERIOD)
  $finish;
end

task reset_mips;
  begin
    CLK_tb = 1'b0;
    rst_tb = 1'b1;
    Instr_tb = 32'b0;
    ReadData_tb = 32'b0;
    
    rst_tb = 1'b0;
    #CLK_PERIOD
    rst_tb = 1'b1;
  end
endtask


mips DUT(
.CLK(CLK_tb),
.rst(rst_tb),
.Instr(Instr_tb),
.ReadData(ReadData_tb),
  
.MemWrite(MemWrite_tb),
.test_value(test_value_tb),
.PC(PC_tb),
.ALUOut(ALUOut_tb),
.WriteData(WriteData_tb)
);
endmodule