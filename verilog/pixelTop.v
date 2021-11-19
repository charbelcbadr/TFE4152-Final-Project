`timescale 1ns / 1ps
module pixelTop(
   input logic      CLK,
   inout logic      VBN1,
   inout logic      RAMP,
   input logic      VRESET,
   input logic	    RESET,
   inout logic      ERASE,
   inout logic      EXPOSE,
   output logic     CONVERT,
   inout logic      READ1,
   inout logic      READ2,
   output logic [15:0] DATA_OUT);
   
PixelArray pa (CLK,VBN1,RAMP,VRESET,RESET,ERASE,EXPOSE,CONVERT,READ1,READ2,
  DATA_OUT);
   
pixelState statemachine(CLK,RESET,ERASE,EXPOSE,CONVERT,READ1,READ2);

endmodule
