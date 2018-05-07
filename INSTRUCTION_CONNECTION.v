`timescale 1ns / 1ns

module INSTRUCTION_CONNECTION(clock, reset, c_out);
//inputs
input clock;
input reset;
//for connecting regbank and alu inputs to output
wire [5:0] alu_opcode;
wire [1:0] shifter_opcode;
wire [8:0] c_select;
wire [3:0] b_select;
output wire [31:0] c_out;
wire [31:0] a_data, b_data;
wire [8:0] instruction_address;
//unused for purpose
wire [0:0] n, z;
wire [2:0] jam, m;
//modules

ALU f1 (.alu_opcode(alu_opcode), .shifter_opcode(shifter_opcode), .in_a(a_data),
        .in_b(b_data), .alu_out(c_out), .n(n), .z(z));

/*always @(*)
  $display("Cout: %d", c_out);*/

always @(*)
  $display("alu opcode: %b", alu_opcode);

REGESTERBANK f2 (.clock(clock), .reset(reset), .c_select(c_select), .b_select_encoded(b_select),
                 .bus_c_data(c_out), .a_data(a_data), .b_data(b_data));

CODE_CONTROL f3 (.clock(clock), .current_instruction(instruction_address), .c_out(c_out),
                 .next_instruction(instruction_address), .alu_opcode(alu_opcode),
                 .shifter_opcode(shifter_opcode), .c_select(c_select), .b_select(b_select), .jam(jam), .m(m));

endmodule
