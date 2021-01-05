/*
 * system.v - top-level system for picorv32
 * 06-30-19 E. Brombaugh
 * 12-10-20 tklua@wifiboy.org
 */

`default_nettype none

module system(
	input	clk, reset,
	input	rx,
	output	tx,
	inout	spi0_mosi, spi0_miso, spi0_sclk, spi0_cs0, // SPI core 0
	inout	spi1_mosi, spi1_miso, spi1_sclk, spi1_cs0, // SPI core 1
	output  reg [31:0] gp_out,
	input   [6:0] gp_in,
	output	spkr
);
	// CPU
	wire        mem_valid;
	wire        mem_instr;
	wire        mem_ready;
	wire [31:0] mem_addr;
	reg  [31:0] mem_rdata;
	wire [31:0] mem_wdata;
	wire [ 3:0] mem_wstrb;
	picorv32 #(
		.PROGADDR_RESET(32'h 0000_0000),	// start or ROM
		.STACKADDR(32'h 1001_0000),		    // end of SPRAM
		.BARREL_SHIFTER(0),
		.COMPRESSED_ISA(0),
		.ENABLE_COUNTERS(0),
		.ENABLE_MUL(0),
		.ENABLE_DIV(0),
		.ENABLE_IRQ(0),
		.ENABLE_IRQ_QREGS(0),
		.CATCH_MISALIGN(0),
		.CATCH_ILLINSN(0)
	) cpu_I (
		.clk       (clk),
		.resetn    (~reset),
		.mem_valid (mem_valid),
		.mem_instr (mem_instr),
		.mem_ready (mem_ready),
		.mem_addr  (mem_addr),
		.mem_wdata (mem_wdata),
		.mem_wstrb (mem_wstrb),
		.mem_rdata (mem_rdata)
	);
	
	// Address decode
	wire rom_sel = (mem_addr[31:28]==4'h0)&mem_valid ? 1'b1 : 1'b0;
	wire ram_sel = (mem_addr[31:28]==4'h1)&mem_valid ? 1'b1 : 1'b0;
	wire gpo_sel = (mem_addr[31:28]==4'h2)&mem_valid ? 1'b1 : 1'b0;
	wire ser_sel = (mem_addr[31:28]==4'h3)&mem_valid ? 1'b1 : 1'b0; 
	wire wbb_sel = (mem_addr[31:28]==4'h4)&mem_valid ? 1'b1 : 1'b0;
	wire cnt_sel = (mem_addr[31:28]==4'h5)&mem_valid ? 1'b1 : 1'b0;
	//wire usb_sel = (mem_addr[31:28]==4'h6)&mem_valid ? 1'b1 : 1'b0;
	wire gpi_sel = (mem_addr[31:28]==4'h7)&mem_valid ? 1'b1 : 1'b0;
    wire spk_sel = (mem_addr[31:28]==4'h8)&mem_valid ? 1'b1 : 1'b0;
	wire boot_sel= (mem_addr[31:28]==4'h9)&mem_valid ? 1'b1 : 1'b0;

	always @(posedge clk)
		if (boot_sel & mem_wstrb[0]) 
		    wboot[2:0] <= mem_wdata[2:0];

	reg [2:0] wboot;
	SB_WARMBOOT warmboot(
        	.BOOT(wboot[2]),
        	.S1(wboot[1]),
        	.S0(wboot[0])
    	);

	// 2k x 32 ROM
	reg [31:0] rom[2047:0], rom_do;
	initial
        $readmemh("rom.hex",rom);		
	always @(posedge clk)
		rom_do <= rom[mem_addr[12:2]];
	
	// RAM, byte addressable
	wire [31:0] ram_do;
	spram_16kx32 uram(
		.clk(clk),
		.sel(ram_sel),
		.we(mem_wstrb),
		.addr(mem_addr[15:0]),
		.wdat(mem_wdata),
		.rdat(ram_do)
	);
	
	// GPIO
	always @(posedge clk)
		if(gpo_sel) begin
			if(mem_wstrb[0]) gp_out[7:0] <= mem_wdata[7:0];
			if(mem_wstrb[1]) gp_out[15:8] <= mem_wdata[15:8];
			if(mem_wstrb[2]) gp_out[23:16] <= mem_wdata[23:16];
			if(mem_wstrb[3]) gp_out[31:24] <= mem_wdata[31:24];
		end
		
	// Serial
	wire [7:0] ser_do;
	acia uacia(
		.clk(clk),			    // system clock (24mhz)
		.rst(reset),			// system reset
		.cs(ser_sel),			// chip select
		.we(mem_wstrb[0]),		// write enable
		.rs(mem_addr[2]),		// address
		.rx(rx),				// serial receive
		.din(mem_wdata[7:0]),	// data bus input
		.dout(ser_do),			// data bus output
		.tx(tx),				// serial transmit
		.irq()					// interrupt request
	);
	
	
	// 256B Wishbone bus master and SB IP cores @ F100-F1FF
	wire [7:0] wbb_do;
	wire wbb_rdy;
	wb_bus uwbb(
		.clk(clk),		    // system clock
		.rst(reset),		    // system reset
		.cs(wbb_sel),		    // chip select
		.we(mem_wstrb[0]),	    // write enable
		.addr(mem_addr[9:2]),	// address
		.din(mem_wdata[7:0]),	// data bus input
		.dout(wbb_do),		    // data bus output
		.rdy(wbb_rdy),		    // bus ready
		.spi0_mosi(spi0_mosi),	// spi core 0 mosi
		.spi0_miso(spi0_miso),	// spi core 0 miso
		.spi0_sclk(spi0_sclk),	// spi core 0 sclk
		.spi0_cs0(spi0_cs0),	// spi core 0 cs
		.spi1_mosi(spi1_mosi),	// spi core 1 mosi
		.spi1_miso(spi1_miso),	// spi core 1 miso
		.spi1_sclk(spi1_sclk),	// spi core 1 sclk
		.spi1_cs0(spi1_cs0)	    // spi core 1 cs
	);

	reg [31:0] tone_div=100000;
	always @(posedge clk)
	    if(spk_sel) begin
			if(mem_wstrb[0]) tone_div[7:0] <= mem_wdata[7:0];
			if(mem_wstrb[1]) tone_div[15:8] <= mem_wdata[15:8];
			if(mem_wstrb[2]) tone_div[23:16] <= mem_wdata[23:16];
			if(mem_wstrb[3]) tone_div[31:24] <= mem_wdata[31:24];
		end
	pwmtone pt(
		.clk(clk),
		.pwmcount(tone_div[30:0]),
		.rst(spk_sel),
		.pwmout(spkr)
	);
		
	// Resettable clock counter
	reg [31:0] cnt;
	always @(posedge clk)
		if(cnt_sel & |mem_wstrb) begin
			if(mem_wstrb[0]) cnt[7:0] <= mem_wdata[7:0];
			if(mem_wstrb[1]) cnt[15:8] <= mem_wdata[15:8];
			if(mem_wstrb[2]) cnt[23:16] <= mem_wdata[23:16];
			if(mem_wstrb[3]) cnt[31:24] <= mem_wdata[31:24];
		end else cnt <= cnt + 32'd1;
	
	always @(*)
		casex({gpi_sel,ser_sel,cnt_sel,wbb_sel,gpo_sel,ram_sel,rom_sel})
			7'b0000001: mem_rdata = rom_do;
			7'b000001x: mem_rdata = ram_do;
			7'b00001xx: mem_rdata = gp_out;
			7'b0001xxx: mem_rdata = {{24{1'b0}},wbb_do};
			7'b001xxxx: mem_rdata = cnt;
			7'b01xxxxx: mem_rdata = {{24{1'b0}},ser_do};
			7'b1xxxxxx: mem_rdata = {{25{1'b0}},gp_in};	
			default: mem_rdata = 32'd0;
		endcase
	
	reg mem_rdy;
	always @(posedge clk)
		if(reset) mem_rdy <= 1'b0;
		else mem_rdy <= (boot_sel|spk_sel|gpi_sel|cnt_sel|ser_sel|gpo_sel|ram_sel|rom_sel) & ~mem_rdy;
	assign mem_ready = wbb_rdy | mem_rdy;

endmodule

module pwmtone(
    input clk,
    input [30:0] pwmcount, // counter = 12M / freq
    input rst,
    output pwmout
    );
  reg [30:0] pwm_counter = pwmcount; 
  reg [30:0] counter = 0;
  reg wave;
  reg [30:0] comp = 0;
  reg [30:0] nn=100;
  assign pwmout = wave;
  always @(posedge clk) begin
    if (rst==1) comp <= 3800; //pwm_counter >> 4; //nn <= 5; //comp >> 4;
    if (counter > pwm_counter) begin
        counter <= 0;
        if (comp > nn) comp <= comp - nn; 
        else comp <= 0;
    end else counter <= counter + 1;
    if (counter > comp) wave <= 1;
    else wave <= 0;
  end
endmodule


