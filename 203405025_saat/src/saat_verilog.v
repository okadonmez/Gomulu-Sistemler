module saat 
 # (
    parameter BIR_SANIYE = 26'd24_000_000,
    parameter SIFIRLA = 26'd0
   )

   (
    input sys_clk,
    input button_1,
    input button_2,

    output reg[2:0] led,
    output reg[7:0] segment,//Kablolar normal pinlerine baglanacak.
    output reg[3:0] digit   //Kablolar normal pinlerine baglanacak.
                            //GND ucuna baglanirsa topraklanir ve hep yanar.
   );

reg [26:0] counter_clk;
reg [14:0] counter_digit_yenileme;
reg [26:0] counter_zamani_guncelleme;

reg clk_digit_yenileme = 0;

reg [7:0] karakter [0:19];

reg [7:0] saniye = 0;
reg [7:0] dakika = 0;
reg [7:0] saat = 0;

always @* begin

    karakter[0] <= 8'b00111111; // 0
    karakter[1] <= 8'b00000110; // 1
    karakter[2] <= 8'b01011011; // 2
    karakter[3] <= 8'b01001111; // 3
    karakter[4] <= 8'b01100110; // 4
    karakter[5] <= 8'b01101101; // 5
    karakter[6] <= 8'b01111101; // 6
    karakter[7] <= 8'b00000111; // 7
    karakter[8] <= 8'b01111111; // 8
    karakter[9] <= 8'b01101111; // 9

    karakter[10] <= 8'b10111111; // 0 . 
    karakter[11] <= 8'b10000110; // 1 .
    karakter[12] <= 8'b11011011; // 2 .
    karakter[13] <= 8'b11001111; // 3 .
    karakter[14] <= 8'b11100110; // 4 .
    karakter[15] <= 8'b11101101; // 5 .
    karakter[16] <= 8'b11111101; // 6 .
    karakter[17] <= 8'b10000111; // 7 .
    karakter[18] <= 8'b11111111; // 8 .
    karakter[19] <= 8'b11101111; // 9 .
end

always @(posedge sys_clk) begin
    if(!button_1 && !button_2) begin
        counter_clk <= SIFIRLA;
        saniye <= 0;
        dakika <= 0;
        saat <= 0;
    end
    else if(counter_clk < BIR_SANIYE / 600) begin
        //counter_clk <= counter_clk + 1;
        counter_clk <= {counter_clk + 8'h1};
    end
    else begin
        counter_clk <= SIFIRLA;
        //saniye <= saniye + 1;
        saniye <= {saniye + 8'h1};
    end

    if(saniye > 59) begin
        saniye <= 0;
        //dakika <= dakika + 1;
        dakika <= {dakika + 8'h1};
    end
    
    if(dakika > 59) begin
        dakika <= 0;
        //saat <= saat + 1;
        saat <= {saat + 8'h1};
    end
    
    if(saat > 23) begin
        saat <= 0;
    end      

    if(!button_1) begin
        if(counter_zamani_guncelleme < BIR_SANIYE) begin
            //counter_zamani_guncelleme <= counter_zamani_guncelleme + 1;
            counter_zamani_guncelleme <= {counter_zamani_guncelleme + 8'h1};
        end
        else begin
            counter_zamani_guncelleme <= SIFIRLA;
            //saat <= saat + 1;
            saat <= {saat + 8'h1};
        end
    end
    
    if(!button_2) begin
        if(counter_zamani_guncelleme < BIR_SANIYE) begin
            //counter_zamani_guncelleme <= counter_zamani_guncelleme + 1;
            counter_zamani_guncelleme <= {counter_zamani_guncelleme + 8'h1};
        end
        else begin
            counter_zamani_guncelleme <= SIFIRLA;
            //dakika <= dakika + 1;
            dakika <= {dakika + 8'h1};
        end
    end
end

always @(posedge clk_digit_yenileme) begin
    if(digit == 4'b1110) begin  
        if(dakika % 10 == 0) 
            segment <= karakter[0];
        else if(dakika % 10 == 1) 
            segment <= karakter[1];
        else if(dakika % 10 == 2) 
            segment <= karakter[2];
        else if(dakika % 10 == 3) 
            segment <= karakter[3];
        else if(dakika % 10 == 4) 
            segment <= karakter[4];
        else if(dakika % 10 == 5) 
            segment <= karakter[5];
        else if(dakika % 10 == 6) 
            segment <= karakter[6];
        else if(dakika % 10 == 7) 
            segment <= karakter[7];
        else if(dakika % 10 == 8) 
            segment <= karakter[8];
        else if(dakika % 10 == 9) 
            segment <= karakter[9];
        
        digit <= 4'b1101;
    end
    else if(digit == 4'b1101) begin 
        if(0 <= dakika && dakika < 10) 
            segment <= karakter[0];
        else if(10 <= dakika &&  dakika < 20) 
            segment <= karakter[1];
        else if(20 <= dakika &&  dakika < 30) 
            segment <= karakter[2];
        else if(30 <= dakika &&  dakika < 40) 
            segment <= karakter[3];
        else if(40 <= dakika &&  dakika < 50) 
            segment <= karakter[4];
        else if(50 <= dakika &&  dakika < 60) 
            segment <= karakter[5];

        digit <= 4'b1011;
    end
    else if(digit == 4'b1011) begin 
        if(saat % 10 == 0) 
            segment <= karakter[10];
        else if(saat % 10 == 1) 
            segment <= karakter[11];
        else if(saat % 10 == 2) 
            segment <= karakter[12];
        else if(saat % 10 == 3) 
            segment <= karakter[13];
        else if(saat % 10 == 4) 
            segment <= karakter[14];
        else if(saat % 10 == 5) 
            segment <= karakter[15];
        else if(saat % 10 == 6) 
            segment <= karakter[16];
        else if(saat % 10 == 7) 
            segment <= karakter[17];
        else if(saat % 10 == 8) 
            segment <= karakter[18];
        else if(saat % 10 == 9) 
            segment <= karakter[19];

        digit <= 4'b0111;
    end
    else if(digit == 4'b0111) begin 
        if(0 <= saat && saat < 10) 
            segment <= karakter[0];
        else if(10 <= saat &&  saat < 20) 
            segment <= karakter[1];
        else if(20 <= saat &&  saat < 30) 
            segment <= karakter[2];

        digit <= 4'b1110;
    end
    else
        digit <= 4'b1110;
end

always @(posedge sys_clk) begin
    if(!button_1 || !button_2) begin
        led <= 3'b000;
    end
    else begin
        led <= 3'b111; 
    end
end

always @(posedge sys_clk) begin
    //counter_digit_yenileme <= counter_digit_yenileme + 1;
    counter_digit_yenileme <= {counter_digit_yenileme + 8'h1};
   
    if(counter_digit_yenileme == BIR_SANIYE / 1000) begin
        clk_digit_yenileme = ~clk_digit_yenileme;
        counter_digit_yenileme <= 0;
    end
end

endmodule