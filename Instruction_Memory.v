module Instruction_Memory (
input wire [31:0] PC,
output wire [31:0] Instr
);


reg [31:0] ROM [31:0];

//==========program flashing==========
initial
  $readmemh("Program 1_MachineCode.txt", ROM);

/*always @ (*)
begin 
  Instr = ROM[PC>>2];
end*/
assign Instr = ROM[PC>>2];


//assign Instr = 32'h00008020;
endmodule
