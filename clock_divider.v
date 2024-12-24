`timescale 1ns / 1ps

module clock_divider(clk, new_clk);
    input clk;
    output new_clk;
    
    parameter div_value = 1;
    //div_value = (100 / 2*5) - 1 = 9
    
    reg new_clk = 0;
    reg count = 0;
    
    // increment the counter
    always @(posedge clk) begin
        if (count == div_value) begin
            count <= 0;
            new_clk <= ~new_clk;
        end
        else begin
            count <= count + 1;
        end
    end
endmodule