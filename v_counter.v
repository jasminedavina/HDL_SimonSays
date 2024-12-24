`timescale 1ns / 1ps

module v_counter(clk, v_en, v_count);
    input clk;
    input v_en;
    output v_count;
    reg[9:0] v_count = 0;
  
    always @ (posedge v_en) begin
        // v_count less than 524 --> increment
        if (v_count < 524 && v_en == 1) begin
                v_count <= v_count + 1;
        end
        else begin
           v_count <= 0;
        end
    end
endmodule