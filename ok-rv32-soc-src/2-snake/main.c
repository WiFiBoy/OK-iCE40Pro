/*
 * Snake Game Example (picorv32, picosoc)
 * 12-16-20 tklua@wifiboy.org
 */
#include "acia.h"
#include "clkcnt.h"
#include "lcd.h"

// 51-note frequency table
uint32_t freq[]={436364, 411872, 388756, 366937, 346342, 326903, 308556, 291238, 
274892, 259463, 244901, 231156, 218182, 205936, 194378, 183468, 173171, 163452, 
154278, 145619, 137446, 129732, 122450, 115578, 109091, 102968, 97189, 91734, 
86586, 81726, 77139, 72809, 68723, 64866, 61225, 57789, 54545, 51484, 48594, 45867, 
43293, 40863, 38569, 36405, 34361, 32433, 30613, 28894, 27273, 25742, 24297};

#define MAXLEN 64
uint8_t snake_x[MAXLEN] = {8, 8, 9, 9, 9}; // first 5 sects
uint8_t snake_y[MAXLEN] = {10,11,11,12,13}; // first 5 sects
uint8_t snake_len = 5, apple_x, apple_y, rel, md, key, gc;
int gd, score;
uint32_t _rnd;
char buf[16];

void itoa(char *buf, uint32_t val, uint8_t n) // n digits itoa()
{
    buf[n]=0;
    for(int8_t i=n-1; i>=0; i--) {
        buf[i] = (char)(val % 10)+48;
        val /= 10;
    }
}

void show(void)
{
    lcd_drawChar(snake_x[0]*8, snake_y[0]*8, 176, COLOR_GREEN, 0);
    lcd_fillRect(snake_x[snake_len]*8, snake_y[snake_len]*8, 8, 8, COLOR_BLACK);
    lcd_drawChar(apple_x*8, apple_y*8, 162, COLOR_RED, 0);
    itoa(buf, score, 5);
    lcd_drawStr(120,0, buf, COLOR_RED, COLOR_BLACK);
    itoa(buf, snake_len, 3);
    lcd_drawStr(43,0, buf, COLOR_RED, COLOR_BLACK);
}

void body_shift(void)
{
    for(uint8_t i=snake_len; i>0; i--) {
        snake_x[i]=snake_x[i-1];
        snake_y[i]=snake_y[i-1];
    }
}

void body_shift_back(void)
{
    for(uint8_t i=0; i<snake_len; i++) {
        snake_x[i]=snake_x[i+1];
        snake_y[i]=snake_y[i+1];
    }
}

uint8_t check_body(uint8_t x, uint8_t y, uint8_t s)
{
    for(uint8_t i=s; i<snake_len; i++) {
        if ((snake_x[i]==x) && (snake_y[i]==y)) return 1;
    }
    return 0;
}

uint32_t rand()
{
    _rnd = (_rnd*733+997)&0x0fffffff;
    return _rnd;
}

void new_apple()
{
    apple_x = (uint8_t)(rand()%20);
    apple_y = (uint8_t)(rand()%15+1);
}

uint8_t move(uint8_t dir)
{
    body_shift();
    if ((dir==0)&&(snake_y[0]>1)) snake_y[0]=snake_y[0]-1;
    else if ((dir==1)&&(snake_x[0]<19)) snake_x[0]=snake_x[0]+1;
    else if ((dir==2)&&(snake_y[0]<15)) snake_y[0]=snake_y[0]+1;
    else if ((dir==3)&&(snake_x[0]>0)) snake_x[0]=snake_x[0]-1;
    else {
        spkr = freq[50];
        body_shift_back();
        return 1;
    }
    if (check_body(snake_x[0], snake_y[0], 1)==1) {
        return 2; // game over
    }
    
    if ((snake_x[0]==apple_x)&&(snake_y[0]==apple_y)) {
        new_apple();
        score += 100;
        show();
        snake_len++;
        spkr = freq[30];
    } else {
        show();
        if (snake_len>10) spkr = 500;
        else if (snake_len>50) spkr = 800;
    }
    return 0;
}

uint8_t get_key(void)
{
    return(uint8_t)((127-(gp_in & 0x7F)));
}

void system_init()
{
	lcd_init();     // initialize LCD
	
	lcd_fillScreen(COLOR_BLACK); // clear screen
	lcd_emptyRect(0,0, 160, 128, COLOR_RED);
	lcd_drawStr(20,30,"Snake Game Demo", COLOR_GREEN, COLOR_BLACK);
	lcd_drawStr(16,56,"for OK:iCE40 Pro", COLOR_CYAN, COLOR_BLACK);
	lcd_drawStr(20,110,"Any Key to Play", COLOR_YELLOW, COLOR_BLACK);
	lcd_on(); // Turn on LCD backlight 
	
	clkcnt_reg = 0;         //
	while(get_key()==0);    // make a human-made random seed
	_rnd = clkcnt_reg;      //
	
	lcd_fillScreen(COLOR_BLACK);
    lcd_drawStr(0,0,"Snake", COLOR_YELLOW, COLOR_BLACK);
	lcd_drawStr(72,0,"Score:", COLOR_CYAN, COLOR_BLACK);
	rel=1; md=0; score = 0; gc=0;
	new_apple();
}

void game_over()
{
    show();
    spkr = 300000;
    lcd_fillRect(34,44, 92, 20, COLOR_BLUE); 
    lcd_drawStr(44,50,"Game Over", COLOR_YELLOW, COLOR_BLUE);
    lcd_fillRect(snake_x[0]*8, snake_y[0]*8, 8, 8, COLOR_RED);
    clkcnt_delayms(2000); // delay 2 seconds
    while(get_key()>0);
    while(get_key()==0);
    lcd_fillRect(0,8,160,120, COLOR_BLACK); 
    for(uint8_t i=0; i<5; i++) snake_x[i]=snake_y[i]=10;
    rel=1; md=0; score=0; gc=0; snake_len=5;
    new_apple();
}

void main()
{
	system_init(); // game setup()
	
	while(1) { // game loop()
	    key = get_key();                    // get key status
	    if ((key==0) && (rel==0)) rel=1;    // rel: key released indicator
	    if ((key>0) && (rel==1)) {          // make sure key released to check new key status
	        if (key==2)  md=(md+3)%4;       // counterclockwise turn
	        else if (key==1) md=(md+1)%4;   // clockwise turn
	        else if (key==4) md=1;          // right turn
	        else if (key==8) md=3;          // left turn
	        else if (key==16) md=2;         // down turn
	        else if (key==32) md=0;         // up turn
	        rel=0;                          // key pressed: clear rel status
	    }
	    if (gc--==0) { // count to delay snake moving speed
	        switch(move(md)) {
	            case 1: 
	                md=(md+1)%4;        // automatically clockwise turn
	                score-=100;
	                if (score<0) game_over();
	                break;
	            case 2:
	                game_over();
	                break;
	            default:
	                if (snake_len>10) score-=1;
	                if (score<0) game_over();
	                break;
	        }   
	        gd = 120-score/100;              // game delay counter is based on score
	        if (gd<40) gd=40;               // minimum delay is 40 units
	        gc = gd;                        // reset game counter to game delay counter
	    }
	    clkcnt_delayus(300);                // delay 300us for reasonable game speed
	}
}
