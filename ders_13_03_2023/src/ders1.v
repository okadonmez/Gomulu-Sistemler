module ders(
    output red,
    output green,
    output blue,
    input a,
    input b
);

//assign c=1'b1;
//assign c=0;
//assign green=1'b0;
assign red=a;
assign green=b;
assign blue=a&b;
endmodule