`timescale 1ns / 1ns

module INSTRUCTION_CONNECTION(clock, reset, alu_shifter_opcode, c_select, b_select, c_out, n, z);
//inputs
input clock;
input reset;
input [7:0] alu_shifter_opcode;
input [8:0] c_select;
input [3:0] b_select;
//outputs
output wire [31:0] c_out;
output wire [0:0] n, z;
//for connecting regbank and alu inputs to output
wire [31:0] a_data, b_data;

//modules

ALU f1 (.alu_opcode(alu_shifter_opcode[5:0]), .shifter_opcode(alu_shifter_opcode[7:6]), .in_a(a_data),
        .in_b(b_data), .alu_out(c_out), .n(n), .z(z));

REGESTERBANK f2 (.clock(clock), .reset(reset), .c_select(c_select), .b_select_encoded(b_select),
                 .bus_c_data(c_out), .a_data(a_data), .b_data(b_data));

endmodule
