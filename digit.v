module digits(num, ones, tens, hundreds, thousands);
    input [9:0] num;
    output [3:0] ones;
    output [3:0] tens;
    output [3:0] hundreds;
    output [3:0] thousands;

    assign thousand = num/1000;
    assign hundreds = (num%1000)/100;
    assign tens = ((num%1000)%100)/10;
    assign ones = (((num%1000)%100)%10);
endmodule