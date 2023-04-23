module led(
    output reg [1:3] ledler,
    input buton1,
    input buton2
);

always @(buton1,buton2) begin
    if(!buton1 && !buton2)
        ledler=3'b011;
    if(buton1 && !buton2)
        ledler=3'b101;
    if(!buton1 && buton2)
        ledler=3'b110;
    if(buton1 && buton2)
        ledler=3'b000;
end

endmodule