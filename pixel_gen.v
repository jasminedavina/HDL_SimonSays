`timescale 1ns / 1ps

module pixel_gen( clk, pixel_x, pixel_y, LED0, LED1, LED2, LED3, state, red, green, blue);
    input clk; // pixel clock, ranging from 100mHz to 25mHz
    input [9:0] pixel_x; // current x location for generating pixel color
    input [9:0] pixel_y; // current y location for generating pixel color
    input LED0, LED1, LED2, LED3;
    input [2:0] state;
    output reg [3:0] red = 0; // amount of red in the pixel
    output reg [3:0] green = 0;// amount of green in the pixel
    output reg [3:0] blue = 0; // amount of blue in the pixel

always @(posedge clk) begin
    case (state)
        // game start screen
        3'b000: begin
            if ((pixel_x > 640)|| (pixel_x < 0) || (pixel_y > 480) || (pixel_y <0))
                begin
                    red <= 4'h0;    
                    green <= 4'h0;    
                    blue <= 4'h0;    
                end
           else if (
                // G
               ( pixel_x>=119 && pixel_x<=210 && pixel_y>=130 && pixel_y<=150 )||
               ( pixel_x>=119 && pixel_x<=139 && pixel_y>=130 && pixel_y<=230 )||
               ( pixel_x>=119 && pixel_x<=210 && pixel_y>=210 && pixel_y<=230 )||
               ( pixel_x>=190 && pixel_x<=210 && pixel_y>=160 && pixel_y<=230 )||
               ( pixel_x>=169 && pixel_x<=210 && pixel_y>=160 && pixel_y<=180 ))
                begin
                    red <= 4'hF;
                    blue <= 4'h0;
                    green <= 4'h0;
                end
           else if (
               // A
               ( pixel_x>=219 && pixel_x<=310 && pixel_y>=130 && pixel_y<=150 )||
               ( pixel_x>=219 && pixel_x<=239 && pixel_y>=130 && pixel_y<=230 )||
               ( pixel_x>=290 && pixel_x<=310 && pixel_y>=130 && pixel_y<=230 )||
               ( pixel_x>=219 && pixel_x<=310 && pixel_y>=170 && pixel_y<=190 ))
               begin
                   red <= 4'h0;    
                   green <= 4'hF;    
                   blue <= 4'h0;
               end
          else if (
               // M
               ( pixel_x>=319 && pixel_x<=410 && pixel_y>=130 && pixel_y<=150 )||
               ( pixel_x>=319 && pixel_x<=339 && pixel_y>=130 && pixel_y<=230 )||
               ( pixel_x>=354 && pixel_x<=374 && pixel_y>=130 && pixel_y<=230 )||
               ( pixel_x>=390 && pixel_x<=410 && pixel_y>=130 && pixel_y<=230 ))
               begin
                   red <= 4'h0;    
                   green <= 4'hF;    
                   blue <= 4'hF;
               end
         else if (
               // E
               ( pixel_x>=419 && pixel_x<=510 && pixel_y>=130 && pixel_y<=150 )||
               ( pixel_x>=419 && pixel_x<=439 && pixel_y>=130 && pixel_y<=230 )||
               ( pixel_x>=419 && pixel_x<=469 && pixel_y>=170 && pixel_y<=190 )||
               ( pixel_x>=419 && pixel_x<=510 && pixel_y>=210 && pixel_y<=230 ))
               begin
                   red <= 4'h0;    
                   green <= 4'h0;    
                   blue <= 4'hF;
               end
         else if (
               // S
               ( pixel_x>=50 && pixel_x<=150 && pixel_y>=250 && pixel_y<=270 )||
               ( pixel_x>=50 && pixel_x<=70 && pixel_y>=250 && pixel_y<=300 )||
               ( pixel_x>=50 && pixel_x<=150 && pixel_y>=290 && pixel_y<=310 )||
               ( pixel_x>=130 && pixel_x<=150 && pixel_y>=310 && pixel_y<=350 )||
               ( pixel_x>=50 && pixel_x<=150 && pixel_y>=330 && pixel_y<=350 ))
               begin
                   red <= 4'hF;    
                   green <= 4'h0;    
                   blue <= 4'hF;
               end
         else if (
               // T
               ( pixel_x>=160 && pixel_x<=260 && pixel_y>=250 && pixel_y<=270 )||
               ( pixel_x>=200 && pixel_x<=220 && pixel_y>=250 && pixel_y<=350 ))
               begin
                   red <= 4'hF;    
                   green <= 4'hF;    
                   blue <= 4'h0;
               end
         else if (
               // A
               ( pixel_x>=270 && pixel_x<=290 && pixel_y>=250 && pixel_y<=350 )||
               ( pixel_x>=270 && pixel_x<=370 && pixel_y>=250 && pixel_y<=270 )||
               ( pixel_x>=350 && pixel_x<=370 && pixel_y>=250 && pixel_y<=350 )||
               ( pixel_x>=270 && pixel_x<=370 && pixel_y>=290 && pixel_y<=310 ))
               begin
                   red <= 4'hF;    
                   green <= 4'h0;    
                   blue <= 4'h6;
               end
        else if (
               // R 
               ( pixel_x>=380 && pixel_x<=480 && pixel_y>=250 && pixel_y<=270 )||
               ( pixel_x>=380 && pixel_x<=400 && pixel_y>=250 && pixel_y<=350 )||
               ( pixel_x>=460 && pixel_x<=480 && pixel_y>=250 && pixel_y<=300 )||
               ( pixel_x>=380 && pixel_x<=480 && pixel_y>=290 && pixel_y<=310 )||
               ( pixel_x>=420 && pixel_x<=440 && pixel_y>=310 && pixel_y<=323 )||
               ( pixel_x>=440 && pixel_x<=460 && pixel_y>=323 && pixel_y<=336 )||
               ( pixel_x>=460 && pixel_x<=480 && pixel_y>=336 && pixel_y<=350 ))
               begin
                   red <= 4'h6;    
                   green <= 4'hF;    
                   blue <= 4'h0;
               end
        else if (
               // T
               ( pixel_x>=490 && pixel_x<=590 && pixel_y>=250 && pixel_y<=270 )||
               ( pixel_x>=530 && pixel_x<=550 && pixel_y>=250 && pixel_y<=350 ))
               begin
                    red <= 4'hF;    
                    green <= 4'h0;    
                    blue <= 4'h3;
               end
           else
                begin            
                    red <= 4'hF;
                    blue <= 4'hF;
                    green <= 4'hF;
                end  
         end
         
        // game over screen
        3'b111: begin
            if ((pixel_x > 640)|| (pixel_x < 0) || (pixel_y > 480) || (pixel_y <0))
                begin
                    red <= 4'h0;    
                    green <= 4'h0;    
                    blue <= 4'h0;    
                end
           else if (
                // G
               ( pixel_x>=85 && pixel_x<=135 && pixel_y>=100+60 && pixel_y<=110+60 )||
               ( pixel_x>=85 && pixel_x<=95 && pixel_y>=100+60 && pixel_y<=135+60 )||
               ( pixel_x>=85 && pixel_x<=95 && pixel_y>=140+60 && pixel_y<=160+60 )||
               ( pixel_x>=90 && pixel_x<=95 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=110 && pixel_x<=135 && pixel_y>=125+60 && pixel_y<=135+60 )||
               ( pixel_x>=85 && pixel_x<=90 && pixel_y>=125+160 && pixel_y<=135+160 )||
               ( pixel_x>=125 && pixel_x<=130 && pixel_y>=135+60 && pixel_y<=160+60 )||
               ( pixel_x>=130 && pixel_x<=135 && pixel_y>=135+60 && pixel_y<=140+60 )||
               ( pixel_x>=130 && pixel_x<=135 && pixel_y>=145+60 && pixel_y<=160+60 )||
               ( pixel_x>=85 && pixel_x<=135 && pixel_y>=150+60 && pixel_y<=155+60 )||
               ( pixel_x>=85 && pixel_x<=125 && pixel_y>=155+60 && pixel_y<=160+60 )||
               ( pixel_x>=130 && pixel_x<=135 && pixel_y>=155+60 && pixel_y<=160+60 )||
               ( pixel_x>=130 && pixel_x<=135 && pixel_y>=155+90 && pixel_y<=90 )||
                
                // A
               ( pixel_x>=145 && pixel_x<=195 && pixel_y>=100+60 && pixel_y<=110+60 )||
               ( pixel_x>=150 && pixel_x<=155 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=145 && pixel_x<=150 && pixel_y>=100+60 && pixel_y<=155+60 )||
               ( pixel_x>=145 && pixel_x<=150 && pixel_y>=100+110 && pixel_y<=155+110 )||
               ( pixel_x>=145 && pixel_x<=195 && pixel_y>=120+60 && pixel_y<=125+60 )||
               ( pixel_x>=145 && pixel_x<=165 && pixel_y>=125+60 && pixel_y<=130+60 )||
               ( pixel_x>=170 && pixel_x<=195 && pixel_y>=125+60 && pixel_y<=130+60 )||
               ( pixel_x>=165 && pixel_x<=170 && pixel_y>=125+160 && pixel_y<=130+160 )||
               ( pixel_x>=185 && pixel_x<=190 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=190 && pixel_x<=195 && pixel_y>=100+60 && pixel_y<=150+60 )||
               ( pixel_x>=190 && pixel_x<=195 && pixel_y>=155+60 && pixel_y<=160+60 )||
               ( pixel_x>=190 && pixel_x<=195 && pixel_y>=155+80 && pixel_y<=160+80 )||
               
               // M
               ( pixel_x>=205 && pixel_x<=255 && pixel_y>=100+60 && pixel_y<=110+60 )||
               ( pixel_x>=205 && pixel_x<=210 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=210 && pixel_x<=215 && pixel_y>=100+60 && pixel_y<=130+60 )||
               ( pixel_x>=210 && pixel_x<=215 && pixel_y>=135+60 && pixel_y<=160+60 )||
               ( pixel_x>=225 && pixel_x<=235 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=245 && pixel_x<=250 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=250 && pixel_x<=255 && pixel_y>=100+60 && pixel_y<=155+60 )||
               ( pixel_x>=250 && pixel_x<=255 && pixel_y>=100+120 && pixel_y<=160+120 )||
               
               // E
               ( pixel_x>=265 && pixel_x<=315 && pixel_y>=100+60 && pixel_y<=105+60 )||
               ( pixel_x>=265 && pixel_x<=305 && pixel_y>=105+60 && pixel_y<=110+60 )||
               ( pixel_x>=310 && pixel_x<=315 && pixel_y>=105+60 && pixel_y<=110+60 )||
               ( pixel_x>=305 && pixel_x<=310 && pixel_y>=105+60+60 && pixel_y<=110+60+60 )||
               ( pixel_x>=265 && pixel_x<=275 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=265 && pixel_x<=290 && pixel_y>=120+60 && pixel_y<=130+60 )||
               (pixel_x>=265 && pixel_x<=315 && pixel_y>=150+60 && pixel_y<=155+60  )||
               (pixel_x>=265 && pixel_x<=300 && pixel_y>=155+60 && pixel_y<=160+60  )||
               (pixel_x>=305 && pixel_x<=315 && pixel_y>=155+60 && pixel_y<=160+60  )||
               (pixel_x>=300 && pixel_x<=305 && pixel_y>=155+90 && pixel_y<=160+90  )||
               
               // O
               ( pixel_x>=325 && pixel_x<=375 && pixel_y>=100+60 && pixel_y<=105+60 )||
               ( pixel_x>=325 && pixel_x<=350 && pixel_y>=105+60 && pixel_y<=110+60 )||
               ( pixel_x>=355 && pixel_x<=375 && pixel_y>=105+60 && pixel_y<=110+60 )||
               ( pixel_x>=350 && pixel_x<=355 && pixel_y>=150+200 && pixel_y<=110+200 )||
               ( pixel_x>=325 && pixel_x<=335 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=365 && pixel_x<=375 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=325 && pixel_x<=375 && pixel_y>=150+60 && pixel_y<=160+60 )||

               // V
               ( pixel_x>=385 && pixel_x<=395 && pixel_y>=105+60 && pixel_y<=140+60 )||
               ( pixel_x>=385 && pixel_x<=395 && pixel_y>=100+60 && pixel_y<=140+60 )||
               ( pixel_x>=425 && pixel_x<=435 && pixel_y>=100+60 && pixel_y<=140+60 )||
               ( pixel_x>=395 && pixel_x<=410 && pixel_y>=140+60 && pixel_y<=150+60 )||
               ( pixel_x>=405 && pixel_x<=425 && pixel_y>=150+60 && pixel_y<=160+60 )||
               ( pixel_x>=420 && pixel_x<=435 && pixel_y>=140+60 && pixel_y<=150+60 )||
               ( pixel_x>=420 && pixel_x<=425 && pixel_y>=140+130 && pixel_y<=150+130 )||

               // E
               ( pixel_x>=445 && pixel_x<=490 && pixel_y>=100+60 && pixel_y<=105+60 )||
               ( pixel_x>=490 && pixel_x<=495 && pixel_y>=100+160 && pixel_y<=105+160 )||
               ( pixel_x>=445 && pixel_x<=495 && pixel_y>=105+60 && pixel_y<=110+60 )||
               ( pixel_x>=445 && pixel_x<=455 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=445 && pixel_x<=470 && pixel_y>=120+60 && pixel_y<=125+60 ) ||
               ( pixel_x>=445 && pixel_x<=460 && pixel_y>=125+60 && pixel_y<=130+60 ) ||
               ( pixel_x>=465 && pixel_x<=470 && pixel_y>=125+60 && pixel_y<=130+60 ) ||
               ( pixel_x>=460 && pixel_x<=465 && pixel_y>=125+110 && pixel_y<=135+110 ) ||
               ( pixel_x>=445 && pixel_x<=495 && pixel_y>=150+60 && pixel_y<=155+60 ) ||
               ( pixel_x>=445 && pixel_x<=450 && pixel_y>=155+60 && pixel_y<=160+60 ) ||
               ( pixel_x>=455 && pixel_x<=490 && pixel_y>=155+60 && pixel_y<=160+60 ) ||
               ( pixel_x>=450 && pixel_x<=455 && pixel_y>=155+130 && pixel_y<=160+130 ) ||
       
               //R
               ( pixel_x>=505 && pixel_x<=555 && pixel_y>=100+60 && pixel_y<=105+60 )||
               ( pixel_x>=505 && pixel_x<=530 && pixel_y>=105+60 && pixel_y<=110+60 )||
               ( pixel_x>=535 && pixel_x<=555 && pixel_y>=105+60 && pixel_y<=110+60 )||
               ( pixel_x>=530 && pixel_x<=535 && pixel_y>=105+160 && pixel_y<=110+160 )||
               ( pixel_x>=505 && pixel_x<=515 && pixel_y>=100+60 && pixel_y<=160+60 )||
               ( pixel_x>=545 && pixel_x<=555 && pixel_y>=100+60 && pixel_y<=130+60 ) ||
               ( pixel_x>=505 && pixel_x<=555 && pixel_y>=120+60 && pixel_y<=130+60 ) ||
               ( pixel_x>=520 && pixel_x<=535 && pixel_y>=130+60 && pixel_y<=140+60 ) ||
               ( pixel_x>=530 && pixel_x<=545 && pixel_y>=140+60 && pixel_y<=150+60 ) ||
               ( pixel_x>=540 && pixel_x<=555 && pixel_y>=150+60 && pixel_y<=160+60 ) 
           )
           begin
                red <= 4'hF;    
                green <= 4'h0;    
                blue <= 4'h0;
           end
           else
                begin            
                    red <= 4'hF;
                    blue <= 4'hF;
                    green <= 4'hF;
                end
        end
       
        // game working screens
        default: begin
            if ((pixel_x > 640)|| (pixel_x < 0) || (pixel_y > 480) || (pixel_y <0))
                begin
                red <= 4'h0;    
                green <= 4'h0;    
                blue <= 4'h0;    
                end
           else if (
            // S
           ( pixel_x>=55 && pixel_x<=105 && pixel_y>=100 && pixel_y<=110 )||
           ( pixel_x>=55 && pixel_x<=65 && pixel_y>=100 && pixel_y<=130 )||
           ( pixel_x>=55 && pixel_x<=105 && pixel_y>=120 && pixel_y<=130 )||
           ( pixel_x>=95 && pixel_x<=105 && pixel_y>=130 && pixel_y<=160 )||
           ( pixel_x>=55 && pixel_x<=105 && pixel_y>=150 && pixel_y<=160 ))
           begin
                red <= 4'hF;
                blue <= 4'h0;
                green <= 4'h0;
           end
           // I
           else if
           (( pixel_x>=135 && pixel_x<=145 && pixel_y>=100 && pixel_y<=160 )||
           ( pixel_x>=115 && pixel_x<=165 && pixel_y>=100 && pixel_y<=110 )||
           ( pixel_x>=115 && pixel_x<=165 && pixel_y>=150 && pixel_y<=160 ))
           begin
                red <= 4'h6;
                blue <= 4'hF;
                green <= 4'h0;
           end
            // M
           else if (( pixel_x>=175 && pixel_x<=185 && pixel_y>=100 && pixel_y<=160 )||
           ( pixel_x>=175 && pixel_x<=225 && pixel_y>=100 && pixel_y<=110 )||
           ( pixel_x>=195 && pixel_x<=205 && pixel_y>=100 && pixel_y<=160 )||
           ( pixel_x>=215 && pixel_x<=225 && pixel_y>=100 && pixel_y<=160 ))
           begin
                red <= 4'hf;
                blue <= 4'hF;
                green <= 4'h0;
           end
           // O
           else if (( pixel_x>=235 && pixel_x<=245 && pixel_y>=100 && pixel_y<=160 )||
           ( pixel_x>=235 && pixel_x<=285 && pixel_y>=100 && pixel_y<=110 )||
           ( pixel_x>=235 && pixel_x<=285 && pixel_y>=150 && pixel_y<=160 )||
           ( pixel_x>=275 && pixel_x<=285 && pixel_y>=100 && pixel_y<=160 ))
           begin
                red <= 4'hF;
                blue <= 4'h0;
                green <= 4'h0;
           end
           // N
           else if (( pixel_x>=295 && pixel_x<=305 && pixel_y>=100 && pixel_y<=160 )||
           ( pixel_x>=295 && pixel_x<=345 && pixel_y>=100 && pixel_y<=110 )||
           ( pixel_x>=335 && pixel_x<=345 && pixel_y>=100 && pixel_y<=160 ))
           begin
                red <= 4'h6;
                blue <= 4'hF;
                green <= 4'h0;
           end
            // S
           else if (( pixel_x>=55+300 && pixel_x<=105+300 && pixel_y>=100 && pixel_y<=110 )||
           ( pixel_x>=55+300 && pixel_x<=65+300 && pixel_y>=100 && pixel_y<=130 )||
           ( pixel_x>=55+300 && pixel_x<=105+300 && pixel_y>=120 && pixel_y<=130 )||
           ( pixel_x>=95+300 && pixel_x<=105+300 && pixel_y>=130 && pixel_y<=160 )||
           ( pixel_x>=55+300 && pixel_x<=105+300 && pixel_y>=150 && pixel_y<=160 ))
           begin
                red <= 4'hF;
                blue <= 4'hF;
                green <= 4'h0;
           end
            // A
           else if (( pixel_x>=365+50 && pixel_x<=375+50 && pixel_y>=100 && pixel_y<=160 )||
           ( pixel_x>=365+50 && pixel_x<=415+50 && pixel_y>=100 && pixel_y<=110 )||
           ( pixel_x>=365+50 && pixel_x<=415+50 && pixel_y>=130 && pixel_y<=140 )||
           ( pixel_x>=405+50 && pixel_x<=415+50 && pixel_y>=100 && pixel_y<=160 ))
           begin
                red <= 4'hF;
                blue <= 4'h0;
                green <= 4'h0;
           end
            // Y
           else if (( pixel_x>=425+50 && pixel_x<=435+50 && pixel_y>=100 && pixel_y<=130 )||
           ( pixel_x>=465+50 && pixel_x<=475+50 && pixel_y>=100 && pixel_y<=160 )||
           ( pixel_x>=425+50 && pixel_x<=475+50 && pixel_y>=125 && pixel_y<=135)||
           ( pixel_x>=425+50 && pixel_x<=475+50 && pixel_y>=150 && pixel_y<=160 ))
           begin
                red <= 4'h6;
                blue <= 4'hF;
                green <= 4'h0;
           end
           // S
           else if (( pixel_x>=55+480 && pixel_x<=105+480 && pixel_y>=100 && pixel_y<=110 )||
           ( pixel_x>=55+480 && pixel_x<=65+480 && pixel_y>=100 && pixel_y<=130 )||
           ( pixel_x>=55+480 && pixel_x<=105+480 && pixel_y>=120 && pixel_y<=130 )||
           ( pixel_x>=95+480 && pixel_x<=105+480 && pixel_y>=130 && pixel_y<=160 )||
           ( pixel_x>=55+480 && pixel_x<=105+480 && pixel_y>=150 && pixel_y<=160 ))
            begin
                red <= 4'hF;
                blue <= 4'hF;
                green <= 4'h0;
           end else if ((pixel_x >= 235 && pixel_x <= 315) && (pixel_y >= 210 && pixel_y <= 290)) begin
                // Blue rectangle
                case (LED0)
                    1'b0: begin
                        red <= 4'h0;
                        green <= 4'h0;
                        blue <= 4'h6;
                    end
                    1'b1: begin
                        red <= 4'h0;
                        green <= 4'h0;
                        blue <= 4'hF;
                    end
                    endcase
            end else if ((pixel_x >= 325 && pixel_x <= 405) && (pixel_y >= 210 && pixel_y <= 290)) begin
                // Green rectangle
                case (LED1)
                    1'b0: begin
                        red <= 4'h0;
                        green <= 4'h6;
                        blue <= 4'h0;
                    end
                    1'b1: begin
                        red <= 4'h0;
                        green <= 4'hF;
                        blue <= 4'h0;
                    end
                endcase
            end else if ((pixel_x >= 235 && pixel_x <= 315) && (pixel_y >= 300 && pixel_y <= 380)) begin
                // Yellow rectangle
                case (LED2)
                    1'b0: begin
                        red <= 4'h6;
                        green <= 4'h6;
                        blue <= 4'h0;
                    end
                    1'b1: begin
                        red <= 4'hF;
                        green <= 4'hF;
                        blue <= 4'h0;
                    end
                endcase
            end else if ((pixel_x >= 325 && pixel_x <= 405) && (pixel_y >= 300 && pixel_y <= 380)) begin
                // Red rectangle
                case (LED3)
                    1'b0: begin
                        red <= 4'h6;
                        green <= 4'h0;
                        blue <= 4'h0;
                    end
                    1'b1: begin
                        red <= 4'hF;
                        green <= 4'h0;
                        blue <= 4'h0;

                    end
                endcase
            end
            else begin
                // Default: White outside rectangles
                red <= 4'hF;
                green <= 4'hF;
                blue <= 4'hF;
            end
        end
    endcase    
end
endmodule