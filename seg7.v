module seg7(clk_100MHz, rst, ones, tens, hundreds, thousands, seg, an);
    input clk_100MHz;
    input rst;
    input [3:0] ones;
    input [3:0] tens;
    input [3:0] hundreds;
    input [3:0] thousands;
    output reg [0:6] seg; 
    output reg [3:0] an; //digit

    //segment pattern
    parameter zero  = 7'b000_0001;  // 0
    parameter one   = 7'b100_1111;  // 1
    parameter two   = 7'b001_0010;  // 2 
    parameter three = 7'b000_0110;  // 3
    parameter four  = 7'b100_1100;  // 4
    parameter five  = 7'b010_0100;  // 5
    parameter six   = 7'b010_0000;  // 6
    parameter seven = 7'b000_1111;  // 7
    parameter eight = 7'b000_0000;  // 8
    parameter nine  = 7'b000_0100;  // 9
    
    reg [1:0] an_select;     // 2 bit counter for selecting each of 4 digits
    reg [16:0] an_timer;     // counter for digit refresh
    
    always @(posedge clk_100MHz or posedge rst) begin
        if(rst) begin
            an_select <= 0;
            an_timer <= 0; 
        end
        else begin
        // 1ms x 4 displays = 4ms refresh period, the period of 100MHz clock is 10ns (1/100,000,000 seconds), /10ns x 100,000 = 1ms
            if(an_timer == 99_999) begin   
                 an_timer <= 0; 
                an_select <=  an_select + 1;
            end
            else begin
                an_timer <=  an_timer + 1;
            end
        end
    end
    
    // connecting an output based on digit select
    always @(an_select) begin
        case(an_select) 
            2'b00 : an = 4'b1110;   // ones digit
            2'b01 : an = 4'b1101;   // tens digit
            2'b10 : an = 4'b1011;   // hundreds digit
            2'b11 : an = 4'b0111;   // thousands digit
        endcase
    end
    
    // segments based on which digit is selected and the value of each digit
    always @*
        case(an_select)
            //ones
            2'b00 : begin
                case(ones)
                    4'b0000 : seg = zero;
                    4'b0001 : seg = one;
                    4'b0010 : seg = two;
                    4'b0011 : seg = three;
                    4'b0100 : seg = four;
                    4'b0101 : seg = five;
                    4'b0110 : seg = six;
                    4'b0111 : seg = seven;
                    4'b1000 : seg = eight;
                    4'b1001 : seg = nine;
                endcase
            end
            //tens 
            2'b01 : begin
                case(tens)
                    4'b0000 : seg = zero;
                    4'b0001 : seg = one;
                    4'b0010 : seg = two;
                    4'b0011 : seg = three;
                    4'b0100 : seg = four;
                    4'b0101 : seg = five;
                    4'b0110 : seg = six;
                    4'b0111 : seg = seven;
                    4'b1000 : seg = eight;
                    4'b1001 : seg = nine;
                endcase
            end
            //hundreds 
            2'b10 : begin
                case(hundreds)
                    4'b0000 : seg = zero;
                    4'b0001 : seg = one;
                    4'b0010 : seg = two;
                    4'b0011 : seg = three;
                    4'b0100 : seg = four;
                    4'b0101 : seg = five;
                    4'b0110 : seg = six;
                    4'b0111 : seg = seven;
                    4'b1000 : seg = eight;
                    4'b1001 : seg = nine;
                endcase
            end
            //thousands
            2'b11 : begin 
                case(thousands)
                    4'b0000 : seg = zero;
                    4'b0001 : seg = one;
                    4'b0010 : seg = two;
                    4'b0011 : seg = three;
                    4'b0100 : seg = four;
                    4'b0101 : seg = five;
                    4'b0110 : seg = six;
                    4'b0111 : seg = seven;
                    4'b1000 : seg = eight;
                    4'b1001 : seg = nine;
                endcase
            end
        endcase
endmodule