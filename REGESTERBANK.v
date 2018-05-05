`timescale 1ns / 1ns

module REGESTERBANK(clock, reset, c_select, b_select_encoded, bus_c_data, a_data, b_data);
//inputs
input clock;
input reset;
input [8:0] c_select;
input [3:0] b_select_encoded;
input [31:0] bus_c_data;
//outputs
output reg [31:0] a_data, b_data;
//decoding variable
reg [8:0] b_select_decoded;
//regesters
reg [31:0] mar;
reg [31:0] mdr;
reg [31:0] pc;
reg [31:0] mbr;
reg [31:0] sp;
reg [31:0] lv;
reg [31:0] cpp;
reg [31:0] tos;
reg [31:0] opc;
reg [31:0] h;

//decoding 4 bit b bus select to onehot encoding

always @(*)
  begin
  case(b_select_encoded)
  4'b0000 : begin b_select_decoded = 9'b000000001; end
  4'b0001 : begin b_select_decoded = 9'b000000010; end
  4'b0010 : begin b_select_decoded = 9'b000000100; end
  4'b0011 : begin b_select_decoded = 9'b000001000; end
  4'b0100 : begin b_select_decoded = 9'b000010000; end
  4'b0101 : begin b_select_decoded = 9'b000100000; end
  4'b0110 : begin b_select_decoded = 9'b001000000; end
  4'b0111 : begin b_select_decoded = 9'b010000000; end
  4'b1000 : begin b_select_decoded = 9'b100000000; end
  default : begin b_select_decoded = 9'b000000000; end
  endcase
  end
//determining A and B bus outputs
always @(*)
  begin
  a_data = h;
  case(b_select_decoded)
  9'b000000001 : begin b = mdr; end
  9'b000000010 : begin b = pc; end
  9'b000000100 : begin b = mbr; end
  9'b000001000 : begin b = mbr; end
  9'b000010000 : begin b = sp; end
  9'b000100000 : begin b = lv; end
  9'b001000000 : begin b = cpp; end
  9'b010000000 : begin b = tos; end
  9'b100000000 : begin b = opc; end
  endcase
  end
//Dealing with data inside c bus

always @(posedge clock)
  begin
  if(reset == 1)
    begin
    mar <= 32'd0;
    mdr <= 32'd0;
    pc <= 32'd0;
    mbr <= 32'd0;
    sp <= 32'd0;
    lv <= 32'd0;
    cpp <= 32'd0;
    tos <= 32'd0;
    opc <= 32'd0;
    h <= 32'd0;
    end
  else
    begin
    if(c_select[0])
      begin mar = bus_c_data; end
    if(c_select[1])
      begin mdr = bus_c_data; end
    if(c_select[2])
      begin pc = bus_c_data; end
    if(c_select[3])
      begin sp = bus_c_data; end
    if(c_select[4])
      begin lv = bus_c_data; end
    if(c_select[5])
      begin cpp = bus_c_data; end
    if(c_select[6])
      begin tos = bus_c_data; end
    if(c_select[7])
      begin opc = bus_c_data; end
    if(c_select[8])
      begin h = bus_c_data; end
    end
  end


endmodule
