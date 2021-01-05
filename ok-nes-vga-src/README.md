# Port of the MIST NES core to OK:iCE40 Pro

This port of the NES MIST core is currently designed for OK:iCE40Pro 
FPGA Dev Console, with a VGA-PMOD and a built-in gamepad controller.

---

Verilog source of OK:iCE40Pro NES gampad controller: 

>
>  wire joy_strobe;
>  wire joy_clock;
>  wire joy_data = joy_key[0];
>  reg  [7:0] joy_key;
>  reg  last_joy_clock;
>  wire kSel = btnM ? 1'b1 : btnB;   // menu+b = select
>  wire kStart = btnM ? 1'b1 : btnA; // menu+a = start
>  wire kA = btnM ? btnA : 1'b1;
>  wire kB = btnM ? btnB : 1'b1;
>  always @(posedge clock) begin
>        if (joy_strobe) joy_key <= {btnR,btnL,btnD,btnU,kStart,kSel,kB,kA};
>        else if (!joy_clock && last_joy_clock) joy_key <= {1'b1, joy_key[7:1]};
>        last_joy_clock <= joy_clock;
>  end
>

-----

Build nes bin:
$ make
$ iceprog nes_okice40_pro.bin

Convert game ROMs
$ rom/nes2bin.py demo.nes demo.bin

Upload game ROMs
$ iceprog -o 1024k demo.bin

-----
Credit to the original developer of the NES core, Ludvig Strigeus for 
making such an awesome project! Like the original core this is licensed 
under the GNU GPL.
