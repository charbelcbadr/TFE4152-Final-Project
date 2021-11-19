`timescale 1ns / 1ps

module pixelState_tb;

   logic clk =0;
   logic reset =0;
   logic erase,expose,convert,read1,read2;
   parameter integer clk_period = 500;
   parameter integer sim_end = clk_period*2400;
   always #clk_period clk=~clk;
   
   pixelState statemachine(clk,reset,erase,expose,convert,read1,read2);
   
initial
     begin
      $dumpfile("pixelState_tb.vcd");
      $dumpvars(0,pixelState_tb);
        reset = 1;

        #clk_period  reset=0;

       

        #sim_end
        $stop;

end 

endmodule // test
