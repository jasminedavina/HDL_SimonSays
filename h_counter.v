`timescale 1ns / 1ps

module h_counter(clk, h_count, v_en);
    input clk;
    output h_count;
    output v_en;
    reg[9:0] h_count = 0;
    reg v_en = 0;
    
    always @ (posedge clk) begin
        // h_count less than 800 --> increment
        if (h_count < 799) begin
            h_count <= h_count + 1; // increment
            v_en <= 1'b0;
        end
        else begin
        // h_count more or equal to 800  --> enable
            v_en <= 1'b1;
            h_count <= 1'b0;
        end        
    end
endmodule