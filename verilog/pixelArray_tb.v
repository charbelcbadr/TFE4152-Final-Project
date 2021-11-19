`timescale 1 ns / 1 ps

module pixelArray_tb;

   //------------------------------------------------------------
   // Testbench clock
   //------------------------------------------------------------
   logic clk =0;
   logic reset =0;
   parameter integer clk_period = 500;
   parameter integer sim_end = clk_period*2400;
   always #clk_period clk=~clk;

   //------------------------------------------------------------
   // Pixel
   //------------------------------------------------------------
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
   logic              convert;
   logic [7:0]        data_out;
   //Instanciate the pixel
   PixelArray pa (clk,anaBias1,anaRamp,anaReset,reset,erase,expose,convert,read1,read2,
   data_out);


   
  //------------------------------------------------------------
   // Testbench stuff
   //------------------------------------------------------------
   initial
     begin
      $dumpfile("pixelArray_tb.vcd");
        $dumpvars(0,pixelArray_tb);
        reset = 1;

        #clk_period  reset=0;
        
        #500
        erase=1;
        expose=0;
        convert=0;
        read1=0;
        read2=0;
        #6000
        
        erase=0;
        expose=0;
        convert=0;
        read1=0;
        read2=0;
	#1000
	
        erase=0;
        expose=1;
        convert=0;
        read1=0;
        read2=0;
        #256000
        
        erase=0;
        expose=0;
        convert=0;
        read1=0;
        read2=0;
	#1000
        
        
        erase=0;
        expose=0;
        convert=1;
        read1=0;
        read2=0;
        #256000
        
        erase=0;
        expose=0;
        convert=0;
        read1=0;
        read2=0;
	#1000
        
        erase=0;
        expose=0;
        convert=0;
        read1=1;
        read2=0;
        #6000
        
        erase=0;
        expose=0;
        convert=0;
        read1=0;
        read2=1;
        #6000
        
        erase=0;
        expose=0;
        convert=0;
        read1=0;
        read2=0;
        
       
        #sim_end
          $stop;



     end

endmodule // test            

