// Copyright (c) 2012-2013 Ludvig Strigeus
// Copyright (c) 2017 David Shah
// This program is GPL Licensed. See COPYING for the full license.

`timescale 1ns / 1ps

module NES_okice40_pro (  
    input   clk_12,
    output  led_r, led_b,
    output  VGA_HS,         // VGA H_SYNC
    output  VGA_VS,         // VGA V_SYNC
    output  [1:0] VGA_R,    // VGA Red[1:0]
    output  [1:0] VGA_G,    // VGA Green[1:0]
    output  [1:0] VGA_B,    // VGA Blue[1:0]
    output  speaker,
    output  flash_sck,
    output  flash_csn,
    output  flash_mosi,
    input   flash_miso,
    input   btnA, btnB, btnL, btnR, btnU, btnD, btnM
);
	
    wire clock;
    wire scandoubler_disable;
    reg clock_locked;
    wire locked_pre;
    always @(posedge clock)
        clock_locked <= locked_pre;
  
    wire [8:0] cycle;
    wire [8:0] scanline;
    wire [15:0] sample;
    wire [5:0] color;
  
    wire load_done;
    wire [21:0] memory_addr;
    wire memory_read_cpu, memory_read_ppu;
    wire memory_write;
    wire [7:0] memory_din_cpu, memory_din_ppu;
    wire [7:0] memory_dout;
    wire [31:0] mapper_flags;
  
    pll pll_i (
  	    .clock_in(clk_12),
  	    .clock_out(clock),
  	    .locked(locked_pre)
    );  
  
    assign led_r = 1'b1; //!memory_addr[0];
    assign led_b = 1'b1; //load_done;

    wire sys_reset = !clock_locked;
    reg reload = 1'b0;
    reg [2:0] last_pressed = 3'b000;

    main_mem mem (
        .clock(clock),
        .reset(sys_reset),
        .reload(reload),
        .index({1'b0, last_pressed}),
        .load_done(load_done),
        .flags_out(mapper_flags),
        //NES interface
        .mem_addr(memory_addr),
        .mem_rd_cpu(memory_read_cpu),
        .mem_rd_ppu(memory_read_ppu),
        .mem_wr(memory_write),
        .mem_q_cpu(memory_din_cpu),
        .mem_q_ppu(memory_din_ppu),
        .mem_d(memory_dout),
        //Flash load interface
        .flash_csn(flash_csn),
        .flash_sck(flash_sck),
        .flash_mosi(flash_mosi),
        .flash_miso(flash_miso)
    );
  
    wire reset_nes = !load_done || sys_reset;
    reg [1:0] nes_ce;
    wire run_nes = (nes_ce == 3);	// keep running even when reset, so that the reset can actually do its job!
  
    wire run_nes_g;
    SB_GB ce_buf (
        .USER_SIGNAL_TO_GLOBAL_BUFFER(run_nes),
        .GLOBAL_BUFFER_OUTPUT(run_nes_g)
    );
  
    // NES is clocked at every 4th cycle.
    always @(posedge clock)
        nes_ce <= nes_ce + 1;
  
    wire [31:0] dbgadr;
    wire [1:0] dbgctr;

    // NES Joypad controller for OK:iCE40 Pro
    wire joy_strobe;
    wire joy_clock;
    wire joy_data = joy_key[0];
    reg  [7:0] joy_key;
    reg  last_joy_clock;
    wire kSel = btnM ? 1'b1 : btnB;
    wire kStart = btnM ? 1'b1 : btnA;
    wire kA = btnM ? btnA : 1'b1;
    wire kB = btnM ? btnB : 1'b1;
    always @(posedge clock) begin
        if (joy_strobe) joy_key <= {btnR,btnL,btnD,btnU,kStart,kSel,kB,kA};
        else if (!joy_clock && last_joy_clock) joy_key <= {1'b1, joy_key[7:1]};
        last_joy_clock <= joy_clock;
    end
  
    NES nes(clock, reset_nes, run_nes_g,
        mapper_flags,
        sample, color,
        joy_strobe, joy_clock, {3'b0,!joy_data},         
        5'b11111,  // enable all channels
        memory_addr,
        memory_read_cpu, memory_din_cpu,
        memory_read_ppu, memory_din_ppu,
        memory_write, memory_dout,
        cycle, scanline,
        dbgadr,
        dbgctr
    );

    video video (
	    .clk(clock),
	    .color(color),
	    .count_v(scanline),
	    .count_h(cycle),
	    .mode(1'b0),
	    .smoothing(1'b1),
	    .scanlines(1'b1),
	    .overscan(1'b1),
	    .palette(1'b0),
	    .VGA_HS(VGA_HS),
	    .VGA_VS(VGA_VS),
	    .VGA_R(VGA_R),
	    .VGA_G(VGA_G),
	    .VGA_B(VGA_B)
    );

    wire audio;
    assign speaker = audio;

    sigma_delta_dac sigma_delta_dac (
	    .DACout(audio),
	    .DACin(sample[15:8]),
	    .CLK(clock),
	    .RESET(reset_nes),
        .CEN(run_nes)
    );

endmodule
