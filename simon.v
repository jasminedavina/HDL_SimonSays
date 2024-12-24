`timescale 1ns / 1ps

module simon_algo (clk, rst, clk_counter, btn_start, PS2_DATA, PS2_CLK, LED, pmod1, pmod2, pmod4, state, score); 
  input wire clk, rst, btn_start;
  input wire [15:0] clk_counter;
  //keyboard
  inout wire PS2_DATA, PS2_CLK; 
  output reg [3:0] LED;
  //speaker
  output wire pmod1, pmod2, pmod4;
  output reg [2:0] state;
  output reg [9:0] score = 0;

  assign pmod2 = 1'd1;	//no gain(6dB)
  assign pmod4 = 1'd1;	//turn-on

  //keyboard
  wire [511:0]key_down; 
  wire [8:0]last_change;  
  wire key_valid; 
  
  parameter MAX_GAME_LEN = 32;
  
  parameter [8:0] KEY_CODES_BLUE = 9'b0_0110_1011; // 4  
  parameter [8:0] KEY_CODES_GREEN = 9'b0_0111_0011; // 5 
  parameter [8:0] KEY_CODES_YELLOW = 9'b0_0110_1001; // 1
  parameter [8:0] KEY_CODES_RED = 9'b0_0111_0010; // 2  
  
  wire [9:0] input_sound [3:0];
  assign input_sound[0] = 196;  // G3
  assign input_sound[1] = 262;  // C4
  assign input_sound[2] = 330;  // E4
  assign input_sound[3] = 784;  // G5

  wire [9:0] pass_sound[6:0];
  assign pass_sound[0] = 330;  // E4
  assign pass_sound[1] = 392;  // G4
  assign pass_sound[2] = 659;  // E5
  assign pass_sound[3] = 523;  // C5
  assign pass_sound[4] = 587;  // D5
  assign pass_sound[5] = 784;  // G5
  assign pass_sound[6] = 0;  // no sound

  wire [9:0] fail_sound[3:0];
  assign fail_sound[0] = 622;  // D#5 
  assign fail_sound[1] = 587;  // D5
  assign fail_sound[2] = 554;  // C#5
  assign fail_sound[3] = 523;  // C5

  parameter PowerOn = 4'd0;
  parameter Init = 4'd1;
  parameter Play = 4'd2;
  parameter PlayWait = 4'd3;
  parameter UserWait = 4'd4;
  parameter UserComp = 4'd5;
  parameter NextLevel = 4'd6;
  parameter GameOver = 4'd7;

  reg [4:0] sequence_counter;
  reg [4:0] sequence_length;
  reg [1:0] sequence[MAX_GAME_LEN-1:0];
  
  reg [15:0] clk_cyc;
  reg [9:0] ms_counter;
  reg [2:0] tone_sequence;
  reg [9:0] sound_frequency;

  reg [1:0] next_random;
  reg [1:0] user_input;
  
  reg flag = 0;
  
  KeyboardDecoder kb_dec(
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(key_valid),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    );

  play_sound play1 (
      .clk(clk),
      .rst(rst),
      .clk_counter(clk_counter),
      .frequency(sound_frequency),
      .sound(pmod1)
  );

  always @(posedge clk) begin
    if (rst) begin
      sequence_length <= 0;
      sequence_counter <= 0;
      clk_cyc <= 0;
      ms_counter <= 0;
      sound_frequency <= 0;
      next_random <= 0;
      state <= PowerOn;
      sequence[0] <= 0;
      score <= 0;
      flag = 0;
      LED <= 4'b0000;
      
    end else begin
      clk_cyc <= clk_cyc + 1;
      next_random  <= next_random + 1;

      if (clk_cyc == clk_counter) begin
        clk_cyc   <= 0;
        ms_counter <= ms_counter + 1;
      end

      case (state)
        PowerOn: begin
          LED <= 4'b1111;
          LED[ms_counter[9:8]] <= 1'b0;
          //after start button pressed, start the game
          if (btn_start != 0) begin
            state <= Init;
            LED <= 4'b0000;
            ms_counter <= 0;
          end
        end
        Init: begin
          sequence[0] <= next_random;
          sequence_length <= 1;
          sequence_counter <= 0;
          tone_sequence <= 0;
          if (ms_counter == 500) begin
            state <= Play;
          end
        end
        Play: begin
          LED <= 0;
          LED[sequence[sequence_counter]] <= 1'b1;
          sound_frequency <= input_sound[sequence[sequence_counter]];
          ms_counter <= 0;
          state <= PlayWait;
        end
        PlayWait: begin
          if (ms_counter == 300) begin
            LED <= 0;
            sound_frequency <= 0;
          end
          if (ms_counter == 400) begin
            if (sequence_counter + 1 == sequence_length) begin
              state <= UserWait;
              ms_counter <= 0;
              sequence_counter <= 0;
            end else begin
              sequence_counter <= sequence_counter + 1;
              state <= Play;
            end
          end
        end
        UserWait: begin
        flag <= 0;
          LED <= 0;
          ms_counter <= 0;
          if (key_valid && key_down[last_change] == 1'b1) begin
            state <= UserComp;
            case (last_change)
              KEY_CODES_BLUE: user_input <= 0;
              KEY_CODES_GREEN: user_input <= 1;
              KEY_CODES_YELLOW: user_input <= 2;
              KEY_CODES_RED: user_input <= 3;
              default: state <= UserWait;
            endcase
          end
        end
        UserComp: begin
          LED <= 0;
          LED[user_input] <= 1'b1;
          sound_frequency <= input_sound[user_input];
          if (ms_counter == 300) begin
            sound_frequency <= 0;
            if (user_input == sequence[sequence_counter]) begin
              if (sequence_counter + 1 == sequence_length) begin
                ms_counter <= 0;
                sequence[sequence_length] <= next_random;
                sequence_length <= sequence_length + 1;
                state <= NextLevel;
              end else begin
                sequence_counter <= sequence_counter + 1;
                state <= UserWait;
              end
            end else begin
              ms_counter <= 0;
              state <= GameOver;
            end
          end
        end
        NextLevel: begin
          if (flag == 0) 
          begin
          score <= score + 1;
          flag = 1;
          end
          LED <= 0;
          if (ms_counter == 150) begin
            if (tone_sequence < 7) begin
              sound_frequency <= pass_sound[tone_sequence];
            end else begin
              sound_frequency <= 0;
              tone_sequence <= 0;
              sequence_counter <= 0;
              state <= Play;
            end
            tone_sequence <= tone_sequence + 1;
            ms_counter <= 0;
          end
        end
        GameOver: begin
          score <= 0;
          LED <= ms_counter[7] ? 4'b1111 : 4'b0000;

          if (tone_sequence == 4) begin
            sound_frequency <= fail_sound[3] - 16 + ms_counter[4:0];
            if (ms_counter == 1000) begin
              tone_sequence <= 7;
              sound_frequency <= 0;
            end
          end else if (ms_counter == 300) begin
            if (tone_sequence < 4) begin
              sound_frequency <= fail_sound[tone_sequence[1:0]];
              tone_sequence <= tone_sequence + 1;
            end
            ms_counter <= 0;
          end
          //press start button to replay 
          if (btn_start != 0) begin
            LED <= 4'b0000;
            sound_frequency <= 0;
            ms_counter <= 0;
            state <= Init;
          end
        end
      endcase
    end
  end

endmodule