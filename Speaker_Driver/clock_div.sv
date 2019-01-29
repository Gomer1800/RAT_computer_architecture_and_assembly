`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Bridget Benson 
// 
// Create Date: 10/01/2018 10:22:13 AM
// Description: Generic Clock Divider.  Divides the input clock by MAXCOUNT*2
// 
//////////////////////////////////////////////////////////////////////////////////


module ClockDivider (
    input clk, 
    input [15:0] maxcount,
    output logic sclk = 0
    );     
   
    logic [15:0] count = 0;
    
    always_ff @ (posedge clk)
    begin
        if (maxcount == 0) // NO SOUND, I added this to account for maxcount 0 and default cases
            sclk = 0;
        else
            count = count + 1; 
            if (count == maxcount)
            begin
                count = 0;
                sclk = ~sclk;
            end 
    end
    
endmodule