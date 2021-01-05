// okrv32.v - picorv32 soc for okice40pro
// 01-01-21 created. tklua@wifiboy.org

`default_nettype none

module okrv32 (
	input   clk12,                                  // 12MHz clock osc
	inout   rx, tx,                                 // UART (ACIA)
	inout	spi0_mosi,spi0_miso,spi0_sclk,spi0_cs0, // SPI0 port hooked to cfg flash
	inout	spi1_mosi,spi1_miso,spi1_sclk,spi1_cs0, // SPI1 port hooked to SPI-LCD
	output  lcd_nrst, lcd_dc,                       // GP Out for LCD
	output  lcd_bl, led_r, led_b, spkr,             // LEDs and Speaker
	input   key_a, key_b, key_u, key_d, key_l, key_r, key_m // BUTTONs
);
	// Fin=12Mhz, Fout=24Mhz (12*64/32)
	wire clk24, pll_lock;
	SB_PLL40_PAD #(
		.DIVR(4'b0000),
		.DIVF(7'b0111111), // (63+1=64)
		.DIVQ(3'b101),     // 2^5=32
		.FILTER_RANGE(3'b001),
		.FEEDBACK_PATH("SIMPLE"),
		.PLLOUT_SELECT("GENCLK"),
		.ENABLE_ICEGATE(1'b0)
	) pll_inst (
		.PACKAGEPIN(clk12),
		.PLLOUTCORE(clk24),
		//.PLLOUTGLOBAL(),
		.DYNAMICDELAY(8'h00),
		.RESETB(1'b1),
		.BYPASS(1'b0),
		.LOCK(pll_lock)
	);
	// reset generator waits > 256 ticks (10.6us@24mhz) afer PLL lock
	reg [7:0] reset_cnt;
	reg reset;    
	always @(posedge clk24) begin
		if(!pll_lock) begin
			reset_cnt <= 8'h00;
			reset <= 1'b1;
		end else begin
			if(reset_cnt != 8'hff) begin
				reset_cnt <= reset_cnt + 8'h01;
				reset <= 1'b1;
			end else reset <= 1'b0;
		end
	end
	// system core
	wire [31:0] gpio_o;
	wire [6:0] gpio_i = {key_m,key_u,key_d,key_l,key_r,key_b,key_a};

	system uut(
		.clk(clk24),
		.reset(reset),
		.tx(tx),
		.rx(rx),
		.spi0_mosi(spi0_mosi),
		.spi0_miso(spi0_miso),
		.spi0_sclk(spi0_sclk),
		.spi0_cs0(spi0_cs0),
		.spi1_mosi(spi1_mosi),
		.spi1_miso(spi1_miso),
		.spi1_sclk(spi1_sclk),
		.spi1_cs0(spi1_cs0),
		.gp_out(gpio_o),
		.gp_in(gpio_i),
		.spkr(spkr)
	);

	// RGB LED Driver IP core
	/*
	SB_RGBA_DRV #(
		.CURRENT_MODE("0b1"),
		.RGB0_CURRENT("0b000111"),
		.RGB1_CURRENT("0b000000"),
		.RGB2_CURRENT("0b000000")
	) RGBA_DRIVER (
		.CURREN(1'b1),
		.RGBLEDEN(1'b1),
		.RGB0PWM(gpio_o[0]),
		.RGB1PWM(1'b0),
		.RGB2PWM(1'b0),
		.RGB0(lcd_bl),
		.RGB1(),
		.RGB2()
	);*/
	
	assign led_r = gpio_o[2];
	assign led_b = gpio_o[1];
	assign lcd_bl = gpio_o[0];
	assign lcd_nrst = gpio_o[31];
	assign lcd_dc = gpio_o[30];
endmodule
