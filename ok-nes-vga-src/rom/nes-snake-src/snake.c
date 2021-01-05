#include <stdlib.h>
#include <string.h>
#include <nes.h>
#include "neslib.h"
//#link "chr_generic.s"
#include "apu.h"
//#link "apu.c"
#include "music.h"

char snake_x[6]={15,16,16,16,16,0};
char snake_y[6]={16,16,16,16,16,0};	
char i, md=0, pad, fc=0, mc=0, oam_id, r, apple_x, apple_y;

char move()
{   
    oam_id=0;
    for (i=0; i<5; i++) oam_id = oam_spr(snake_x[i]*8, snake_y[i]*8, 11, 7, oam_id);
    oam_id = oam_spr(apple_x*8, apple_y*8, 0xb6, 4, oam_id);
  
    for(i=5; i>0; i--) { snake_x[i]=snake_x[i-1]; snake_y[i]=snake_y[i-1]; }
    if ((md==0) && (snake_y[0] > 2)) snake_y[0] = snake_y[0]-1; // head up
    else if ((md==1) && (snake_x[0] < 29)) snake_x[0] = snake_x[0]+1; // head right
    else if ((md==2) && (snake_y[0] < 26)) snake_y[0] = snake_y[0]+1; // head down
    else if ((md==3) && (snake_x[0] > 2)) snake_x[0] = snake_x[0]-1; // head left
    else {
        for(i=0; i<5; i++) { snake_x[i]=snake_x[i+1]; snake_y[i]=snake_y[i+1]; }
        return 0;
    }
    if ((snake_x[0]==apple_x) && (snake_y[0]==apple_y)) {
        APU_NOISE_DECAY(380, 5, 1);
        apple_x = rand() % 27+3;
        apple_y = rand() % 24+3;
    }
    return 1;
}

void main(void)
{
    char buf[32]=" 2021 WiFiBoy Computing Lab.";
    pal_col(2,0x20);
    pal_col(3,0x30);
    vram_adr(NTADR_A(10,8));
    vram_write("Snake Demo", 11);
    vram_adr(NTADR_A(2,24));
    buf[0]=16;
    vram_write(buf, 28);
    oam_clear();
    pal_all(PALETTE);
    ppu_on_all();
    apu_init();
    music_ptr = 0; 
    apple_x = rand() % 28+2;
    apple_y = rand() % 28+2;
    while (1) {
        if (!music_ptr) { 
            music_ptr = music1; 
            cur_duration = 0; 
        } 
        if (!mute && mc--==0) {
            play_music();
            mc=30;
        } 
        pad = pad_poll(0);
        if (r!=pad) {
            if (pad & PAD_A) md=(md+3)%4;
            else if (pad & PAD_B) md=(md+1)%4;
            else if (pad & PAD_UP) md=0;
            else if (pad & PAD_RIGHT) md=1;
            else if (pad & PAD_DOWN) md=2;
            else if (pad & PAD_LEFT) md=3;
            else if (pad & PAD_SELECT) mute=1-mute;
            r=pad;
        }
        if (fc--==0) {
            if (move()==0) md=(md+1)%4;
            fc=180;
        }
    }
}