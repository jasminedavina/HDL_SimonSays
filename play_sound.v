`timescale 1ns / 1ps

module play_sound (clk, rst, clk_counter, frequency, sound);
    input wire clk, rst;
    input wire [15:0] clk_counter;
    input wire [9:0] frequency;
    output reg sound;
    
    reg [31:0] clk_cyc;
    wire [31:0] clk_per_second = clk_counter * 1000;
    
    always @(posedge clk) begin
        if (rst) begin
            clk_cyc <= 0;
            sound <= 0;
        end else if (frequency == 0) begin
            sound <= 0;
        end 
        else begin
            clk_cyc <= clk_cyc + frequency;
            if (clk_cyc >= (clk_per_second >> 1)) begin
            sound <= !sound;
            clk_cyc <= clk_cyc + frequency - (clk_per_second >> 1);
            end
        end
    end
endmodule