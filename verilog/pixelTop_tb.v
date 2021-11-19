`timescale 1ns / 1ps

module pixelTop_tb;

   logic clk =0;
   logic reset =0;
   parameter integer clk_period = 500;
   parameter integer sim_end = clk_period*2400;
   always #clk_period clk=~clk;
   
   parameter real    dv_pixel = 0.5;  //Set the expected photodiode current (0-1)

   //Analog signals
   logic              anaBias1;
   logic              anaRamp;
   logic              anaReset;

   //Tie off the unused lines
   assign anaReset = 1;

   //Digital
   logic              erase;
   logic              expose;
   logic              read1;
   logic	      read2;
   logic [15:0]        data_out;
   logic convert;
   
   //Instanciate the pixel
   pixelTop pt (clk,anaBias1,anaRamp,anaReset,reset,erase,expose,convert,read1,read2,
   data_out);
   
initial
     begin
      $dumpfile("pixelTop_tb.vcd");
        $dumpvars(0,pixelTop_tb);
        reset = 1;

        #clk_period  reset=0;
        
           #sim_end
          $stop;

end

endmodule // test            

	
