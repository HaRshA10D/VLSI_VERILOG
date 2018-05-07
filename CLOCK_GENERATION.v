`timescale 1ns / 1ns

module CLOCK_GENERATION_;
//variable to control
reg clock;
reg reset;

wire [31:0] c_out;

integer k = 0;

INSTRUCTION_CONNECTION u1 (.clock(clock), .reset(reset), .c_out(c_out));

always
  begin
  #25 clock = ~clock;
  end


initial
  begin
    /*for (k = 0; k < 10; k++)
      #50 $display("Next number is series: %d", c_out);*/
    clock = 1;
    reset = 1;
    #20 reset = 0;
    #2500 $finish;
  end

endmodule
