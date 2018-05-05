module ALU (alu_opcode, shifter_opcode, in_a, in_b, alu_out, n, z);
//inputs
input [5:0] alu_opcode;
input [1:0] shifter_opcode;
input [31:0] in_a, in_b;
//output
output reg [31:0] alu_out;
output reg [0:0] n, z;
//temp variable after alu
reg [31:0] temp_out;

always @(*)
  begin
  //alu operation
  case(alu_opcode)
  6'b011000 : begin
              temp_out = in_a;
              end
  6'b010100 : begin
              temp_out = in_b;
              end
  6'b011010 : begin
              temp_out = ~in_a;
              end
  6'b101100 : begin
              temp_out = ~in_b;
              end
  6'b111100 : begin
              temp_out = in_a + in_b;
              end
  6'b111101 : begin
              temp_out = in_a + in_b + 1;
              end
  6'b111001 : begin
              temp_out = in_a + 1;
              end
  6'b110101 : begin
              temp_out = in_b + 1;
              end
  6'b111111 : begin
              temp_out = in_b - in_a;
              end
  6'b110110 : begin
              temp_out = in_b - 1;
              end
  6'b111011 : begin
              temp_out = -in_a;
              end
  6'b001100 : begin
              temp_out = in_a & in_b;
              end
  6'b011100 : begin
              temp_out = in_a | in_b;
              end
  6'b010000 : begin
              temp_out = 0;
              end
  6'b110001 : begin
              temp_out = 1;
              end
  6'b110010 : begin
              temp_out = -1;
              end
  default : begin
            temp_out = 0;
            end
  endcase

  //determining n and z
  if(temp_out == 32'b0) z = 1'b1;
  else z = 1'b0;

  if(temp_out[31] == 1'b1) n = 1'b1;
  else n = 1'b0;


  //alu to shifter
  case(shifter_opcode)
  2'b10 : begin
          alu_out = temp_out >> 1;
          end
  2'b01 : begin
          alu_out = temp_out << 8;
          end
  default : begin
            alu_out = temp_out;
            end
  endcase


  end

endmodule
