  Show BMP image Example (on 32bit RISC-V core, picosoc)
  Jan-2-21 tklua@wifiboy.org
 
  Before running this example, please upload a bmp image to 0x20000 first!
 
  Prepare a 160x128 RGB565-16bit No-RLE-Compression BMP(size:41032bytes)
  Then flash this bmp to OK:iCE40 Pro console:
 
  $ iceprog -o 0x20000 image.bmp
