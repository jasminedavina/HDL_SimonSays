`timescale 1ns / 1ps

module top(clk, rst, start, PS2_DATA, PS2_CLK, LED0, LED1, LED2, LED3, h_sync, v_sync, red, green, blue, seg, an, pmod_1, pmod_2, pmod_4); 
    input clk, rst, start;
    //keyboard
    inout wire PS2_DATA, PS2_CLK;
    output wire LED0, LED1, LED2, LED3;
    output h_sync; //row
    output v_sync; //column
    //pixel RGB
    output [3:0] red;
    output [3:0] green;
    output [3:0] blue;
    //7-segment
    output [0:6] seg;
    output [3:0] an; 
    //speaker
    output pmod_1, pmod_2, pmod_4;
    
    wire [2:0]state;
    wire new_clk; // new clock with freq changed to 25mHz
    wire[9:0] h_count;
    wire[9:0] v_count;
    wire v_en; // enable for v_counter
    wire video_enable; // active area
    wire[9:0] x_pos; // current x
    wire[9:0] y_pos; // cuurent y
    wire [9:0] score;
    wire [3:0] ones;
    wire [3:0] tens;
    wire [3:0] hundreds;
    wire [3:0] thousands;
    
    //keyboard
    wire [511:0]key_down;
    wire [8:0]last_change;
    wire key_valid; 
    
    wire rst_btn, rst_op, start_btn, start_op;
    
    clock_divider(clk, new_clk);
    
    debounce deb1(rst, new_clk, rst_btn);
    onepulse on1(rst_btn, new_clk, rst_op);
    debounce deb2(start, new_clk, start_btn);
    onepulse on2(start_btn, new_clk, start_op);
    
    simon_algo simon1 (
          .clk   (new_clk),   
          .rst   (rst_op),
          .clk_counter (25000),
          .btn_start(start_op),
          .PS2_DATA(PS2_DATA),
          .PS2_CLK(PS2_CLK),
          .LED   ({LED3, LED2, LED1, LED0}),
          .pmod1 (pmod_1),
          .pmod2 (pmod_2),
          .pmod4 (pmod_4),
          .state(state),
          .score(score)
      );
    
    h_counter h1(new_clk, h_count, v_en); // h_counter called
    v_counter v1(new_clk, v_en, v_count); // v_counter called
    vga_sync vga1(h_count, v_count, h_sync, v_sync, video_enable, x_pos, y_pos); // syncing for VGA output
    pixel_gen pixelmod(new_clk, x_pos, y_pos, LED0, LED1, LED2, LED3, state, red, green, blue); //pixel color generator
    digits digitmod(score, one, tens, hundreds, thousands);
    seg7 segmod(new_clk, rst, ones, tens, hundreds, thousands, seg, an);
    
endmodule

module debounce (pb, clk, pb_debounce);
    input clk, pb;
    output pb_debounce;
    reg [3:0] DFF;
    
    always @(posedge clk) begin
        DFF[3:1] <= DFF[2:0];
        DFF[0] <= pb;
    end
    assign pb_debounce = (DFF == 4'b1111) ? 1'b1:1'b0;
endmodule

module onepulse(pb_debounce, clk, pb_onepulse);
    input pb_debounce, clk;
    output pb_onepulse;
    reg pb_debounce_delay, pb_onepulse;
    
    always @(posedge clk) begin
        pb_onepulse <= pb_debounce && (!pb_debounce_delay);
        pb_debounce_delay <= pb_debounce;
    end
endmodule