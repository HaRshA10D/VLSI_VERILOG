`timescale 1ns / 1ps

module SAMPLE_TEST_;
//variable to control
reg clock;
reg reset;
reg [7:0] alu_shifter_opcode;
reg [8:0] c_select;
reg [3:0] b_select;
//outputs
wire [31:0] c_out;
wire [0:0] n, z;

initial


INSTRUCTION_CONNECTION u1 (.clock(clock), .reset(reset), .alu_shifter_opcode(alu_shifter_opcode),
                             .c_select(c_select), .b_select(b_select), .c_out(c_out), .n(n), .z(z));

initial begin
  clock = 1;
  reset = 1;
  forever begin
    #500 clock = ~clock;
  end
end

initial begin
  @(negedge clock)
  reset = 1;
  @(posedge clock)
  $display(" cout = %d", c_out);
  alu_shifter_opcode = 8'b00110001;
  $display(" cout = %d", c_out);
end

endmodule
