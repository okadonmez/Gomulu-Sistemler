module led
 # (parameter ON_SANIYE = 48'd240_000_000, 
    parameter BES_SANIYE = 48'd120_000_000, 
    parameter IKI_SANIYE = 48'd48_000_000, 
    parameter SIFIRLA = 48'd0
   )
   
   (input sys_clk, // Clock sinyali
    input sys_rst_n, // Reset butonu
    output reg[2:0] led // 110 Red, 101 Blue, 011 Green 
   );

reg [48:0] counter;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        counter <= SIFIRLA;
    else if(counter < ON_SANIYE + IKI_SANIYE + BES_SANIYE)
        counter <= counter + 1;
    else
        counter <= SIFIRLA;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 3'b000;
    else if(counter < ON_SANIYE)
        led[2:0] <= 3'b110;
    else if(counter == ON_SANIYE)
        led[2:0] <= {led[1:0], led[2]};
    else if(counter == ON_SANIYE + IKI_SANIYE)
        led[2:0] <= {led[1:0], led[2]};
    else if(counter == ON_SANIYE + IKI_SANIYE + BES_SANIYE)
        led <= 3'b110;
end

endmodule