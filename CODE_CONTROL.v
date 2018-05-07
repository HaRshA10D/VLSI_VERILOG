 `timescale 1ns / 1ns

 module CODE_CONTROL (clock, current_instruction, c_out, next_instruction, alu_opcode, shifter_opcode, c_select, b_select, jam, m);
 //inputs
 input clock;
 input [8:0] current_instruction;
 input [31:0] c_out;
 //outputs
 output reg [8:0] next_instruction;
 output reg [5:0] alu_opcode;
 output reg [1:0] shifter_opcode;
 output reg [8:0] c_select;
 output reg [3:0] b_select;
 output reg [2:0] jam;
 output reg [2:0] m;

 always @(negedge clock)
  begin
  shifter_opcode = 2'b00;
  jam = 3'b000;
  m = 3'b000;
  case(current_instruction)
    9'b000000001: begin
                  $display("Step 2");
                  next_instruction = 9'b000000010;
                  alu_opcode = 6'b110001;
                  c_select = 9'b010000000;
                  end
    9'b000000010: begin
                  $display("Step 3");
                  next_instruction = 9'b000000100;
                  b_select = 4'b1000;
                  alu_opcode = 6'b111100;
                  c_select = 9'b001000000;
                  end
    9'b000000100: begin
                  next_instruction = 9'b000001001;
                  //$display("Next number is series: %d", c_out);
                  end
    9'b000001001: begin
                  $display("Step 4");
                  next_instruction = 9'b000001000;
                  $display("Next number is series: %d", c_out);
                  end
    9'b000001000: begin
                  $display("Step 5");
                  next_instruction = 9'b000010000;
                  b_select = 4'b1000;
                  alu_opcode = 6'b010100;
                  c_select = 9'b100000000;
                  end
    9'b000010000: begin
                  $display("Step 6");
                  next_instruction = 9'b000100000;
                  b_select = 4'b0111;
                  alu_opcode = 6'b010100;
                  c_select = 9'b010000000;
                  end
    9'b000100000: begin
                  $display("Step 7");
                  next_instruction = 9'b000000100;
                  b_select = 4'b1000;
                  alu_opcode = 6'b111100;
                  c_select = 9'b001000000;
                  end
    default : begin
              $display("Step 1");
              next_instruction = 9'b000000001;
              alu_opcode = 6'b010000;
              c_select = 9'b111000000;
              end

  endcase
  end

 endmodule
