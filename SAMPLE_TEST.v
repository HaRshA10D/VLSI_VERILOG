`timescale 1ns / 1ps

module SAMPLE_TEST_;
//variable to control
reg clock;
reg reset;
reg [5:0] alu_opcode;
reg [1:0] shifter_opcode;
reg [8:0] c_select;
reg [3:0] b_select;
//outputs
wire [31:0] c_out;
wire [0:0] n, z;

initial
  $monitor($time, " Monitor C output = %d", c_out);

INSTRUCTION_CONNECTION u1 (.clock(clock), .reset(reset), .alu_opcode(alu_opcode), .shifter_opcode(shifter_opcode),
                             .c_select(c_select), .b_select(b_select), .c_out(c_out), .n(n), .z(z));


initial
  begin
    clock = 1;
    reset = 1;
    forever
      begin
      #500 clock = ~clock;
      end
  end


initial
  begin
  @(posedge clock);
    reset = 1;
  @(negedge clock);
    reset = 0;
    alu_opcode = 6'b110001;
    shifter_opcode = 2'b00;
    c_select = 9'b100000000;
    $display("c data: %d", c_out);
  @(posedge clock);
  @(negedge clock);
    alu_opcode = 6'b111001;
    shifter_opcode = 2'b00;
  @(posedge clock);
  @(negedge clock);
    $display("c data: %d", c_out);
    alu_opcode = 6'b111001;
    shifter_opcode = 2'b00;
  @(posedge clock);
  @(negedge clock);
      $display("c data: %d", c_out);

  $stop;
  end


endmodule
