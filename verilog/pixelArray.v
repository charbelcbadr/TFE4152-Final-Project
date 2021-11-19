`timescale 1ns / 1 ps

module PixelArray (
   input logic      CLK,
   inout logic      VBN1,
   inout logic      RAMP,
   input logic      VRESET,
   input logic      RESET,
   input logic      ERASE,
   input logic      EXPOSE,
   input logic      CONVERT,
   input logic      READ1,
   input logic      READ2,
   output logic [15:0]    DATA_OUT
   
);
 tri[7:0]         pixData1; //  We need this to be a wire, because we're tristating it
 tri[7:0]         pixData2; //  We need this to be a wire, because we're tristating it
 tri[7:0]         pixData3; //  We need this to be a wire, because we're tristating it
 tri[7:0]         pixData4; //  We need this to be a wire, because we're tristating it

PIXEL_SENSOR ps1 (VBN1,RAMP,RESET,ERASE,EXPOSE,READ1,pixData1);
PIXEL_SENSOR ps2 (VBN1,RAMP,RESET,ERASE,EXPOSE,READ2,pixData2);
PIXEL_SENSOR ps3 (VBN1,RAMP,RESET,ERASE,EXPOSE,READ1,pixData3);
PIXEL_SENSOR ps4 (VBN1,RAMP,RESET,ERASE,EXPOSE,READ2,pixData4);

  
   
   integer          counter;            //Delay counter in state machine
   logic[7:0]       data;


   // If we are to convert, then provide a clock via anaRamp
   // This does not model the real world behavior, as anaRamp would be a voltage from the ADC
   // however, we cheat
   assign RAMP = CONVERT ? CLK : 0;

   // During expoure, provide a clock via anaBias1.
   // Again, no resemblence to real world, but we cheat.
   assign VBN1 = EXPOSE ? CLK : 0;

   // If we're not reading the pixData, then we should drive the bus
   assign pixData1 = READ1 ? 8'bZ: out;
   assign pixData2 = READ2 ? 8'bZ: out;
   assign pixData3 = READ1 ? 8'bZ: out;
   assign pixData4 = READ2 ? 8'bZ: out;
   
   logic [7:0] out;
   // When convert, then run a analog ramp (via anaRamp clock) and digtal ramp via
   // data bus. Assert convert_stop to return control to main state machine.
   always_ff @(posedge CLK or posedge RESET) begin
      if(RESET) begin
         data =0;
      end
      if(CONVERT) begin
         data = data + 1;
      end
      else begin
         data = 0;
      end
      out = { data[7],data[7:1]^data[6:0]};
   end // always @ (posedge clk or reset)

   //------------------------------------------------------------
   // Readout from databus
   //------------------------------------------------------------

   always_ff @(posedge CLK or posedge RESET) begin
      if(RESET) begin
         DATA_OUT = 0;
      end
      else begin
         if(READ1)
         begin
           DATA_OUT[15:8] <= pixData1;
           DATA_OUT[7:0] <= pixData3;
          end
         else if(READ2)
         begin
           DATA_OUT[15:8] <= pixData2;
           DATA_OUT[7:0] <= pixData4;
         end
      end
   end
   

endmodule
