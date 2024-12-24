`timescale 1ns / 1ps

module vga_sync( h_count, v_count, h_sync, v_sync, video_enable, x_pos, y_pos);
    input[9:0] h_count; // from h_counter module
    input[9:0] v_count; // from v_counter module
    output h_sync; // when to move to next row
    output v_sync; // when to move back to top of screen
    output video_enable; // active area
    output[9:0] x_pos; // current x location of the pixel
    output[9:0] y_pos; // current y location of the pixel
    
    // Horizontal
    parameter HD = 640; // Horizontal Display Area
    parameter HF = 16; // Horizontal  Right Border
    parameter HB = 48; // Horizontal  Left Border
    parameter HR = 96; // Horizontal Retrace
    
    // Vertical
    parameter VD = 480; // Vertical Display Area
    parameter VF = 33; // Vertical Bottom Border 
    parameter VB =  10; // Vertical Top Border
    parameter VR =  2; // Vertical Retrace
    
    assign video_enable = h_count < HD && v_count < VD; // if in the displayable region then 1 else 0
    assign x_pos = h_count; // x location same as h_count
    assign y_pos = v_count; // y location same as v_count
    assign h_sync = h_count < HD + HF | h_count >= HD + HF + HR; // 1 for left to right then 0 reset back to left
    assign v_sync = v_count < VD + VF | v_count >= VD + VF + VR; // 1 for up to down then 0 reset back to up
endmodule