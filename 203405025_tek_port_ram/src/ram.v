/*Tek yollu hem okunup hem yazilabilecek. 
Yukselen kenarda yazacak, dusen kenarda ise 
okuyacak. 16 bit veri obegi bulunacak ve 16
satir olacak.*/

module tek_yollu_bellek
 # (parameter ADDR_WIDTH = 4, // Adres genisligi
    parameter DATA_WIDTH = 16, // Veri obegi
    parameter DEPTH = 16 // Satir sayisi
   )

   (input                  clk, // Clock sinyali
    input [ADDR_WIDTH-1:0] addr, // Adres girisimiz satir sayisını gösterir.  
                                 // Satir sayimizdan buluruz 2^4=16
    inout [DATA_WIDTH-1:0] data, // Inout: Port hem giris hem cikis icin kullaniliyorsa
    input                  cs, // Chip enable
    input                  we, // Bellege yaz
    input                  oe, // Bellekten oku
   );

reg [DATA_WIDTH-1:0] tmp_data; // Okuma yaparken gecici veriye aktarip okumayi tercih ettik
reg [DATA_WIDTH-1:0] mem [DEPTH]; // Bellegimizi tanimladik
                                  // [DATA_WIDTH-1:0] Bellegin veri obegi
                                  // [DEPTH] Belelgin satir sayisi

always @(posedge clk) begin // Yukselen kenarda adrese yazma yaptik
    if(cs & we)
        mem[addr] <= data;
end

always @(negedge clk) begin // Dusen kenarda adresteki veriyi gecici olarak aldik
    if(cs & !we)
        tmp_data <= mem[addr];
end

assign data = cs & oe & !wr ? tmp_data : 'hz; 
// Eger chip aktifse, bellekten okuma aktifse, bellekten yazma aktif degilse
// gecici veriyi dataya aktar (veriyi oku) yoksa birsey yapma

endmodule

//------------------------------------------------------------------//

/*Cift yollu hem okunup hem yazilabilecek. 
Yukselen kenarda yazacak, dusen kenarda ise 
okuyacak. 16 bit veri obegi bulunacak ve 16
satir olacak.*/

module cift_yollu_bellek
 # (parameter ADDR_WIDTH = 4,
    parameter DATA_WIDTH = 16,
    parameter DEPTH = 16
   )

   (input                  clk,
    input [ADDR_WIDTH-1:0] addr,
    inout [DATA_WIDTH-1:0] data,
    input                  cs,
    input                  we,
    input                  oe,
   );

reg [DATA_WIDTH-1:0] tmp_data;
reg [DATA_WIDTH-1:0] mem [DEPTH];

always @(posedge clk) begin
    if(cs & we)
        mem[addr] <= data;
end

always @(negedge clk) begin
    if(cs & !we)
        tmp_data <= mem[addr];
end

assign data = cs & oe & !wr ? tmp_data : 'hz; 

endmodule

//********************************************************************

reg [15:0] data_RAM [0:4096];

always @(posedge clk)
    if(en)
        if(wr) begin
            data_RAM[a] <= d_in; d_out <= d_in;
        end
        else
            d_out <= data_RAM[a];


//--------------



module scaled_square(output reg signed [7:-12] y,
                     input      signed [7:-12] c_in, x,
                     input       [11:0] i,
                     input       start,
                     input      clk, reset);

wire c_ram_wr;
reg c_ram_en, x_ce, mult_sel, y_ce;
reg signed [7:-12] c_out, x_out;
reg signed [7:-12] c_RAM [0:4095];
reg signed [7:-12] operand1, operand2;

parameter [1:0] step1 = 2'b00, step2 = 2'b01, step3 = 2'b10;
reg [1:0] current_state, next_state;

assign c_ram_wr = 1'b0;

always @(posedge clk) // y register
    if(y_ce) begin
        if(!mult_sel) begin
            operand1 = c_out;
            operand2 = x_out;
        end
        else begin
            operand1 = x_out;
            operand2 = y;
        end
        y <= operand1 * operand2;
    end

always @(posedge clk) // State register
//...

always @* // Next-state logic
//...


