/*****************************************************
Chip type               : ATxmega256A3B
Program type            : Application
AVR Core Clock frequency: 32,000000 MHz
Memory model            : Small
Data Stack size         : 4096
*****************************************************/
// I/O Registers definitions
#include <io.h>
#include <delay.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <twix.h>
#include "ADC_vn.c"
#include "datafile.c"
#include "port_init.c"
#include "data_time.c"
#include "usart_init.c"
#include "for_SD.c" 
#include "timers_init.c"
#include "spi_twi_init.c"
#include "bmp085.c"
#include "PCA9557D.c"
#include "ad7705.c"
#include "ISR.c"

// System Clocks initialization
void system_clocks_init(void)
{
unsigned char n,s;

// Optimize for speed
#pragma optsize- 
// Save interrupts enabled/disabled state
s=SREG;
// Disable interrupts
#asm("cli")

// Internal 32 MHz RC oscillator initialization
// Enable the internal 32 MHz RC oscillator
OSC.CTRL|=OSC_RC32MEN_bm;

// System Clock prescaler A division factor: 1
// System Clock prescalers B & C division factors: B:1, C:1
// ClkPer4: 32000,000 kHz
// ClkPer2: 32000,000 kHz
// ClkPer:  32000,000 kHz
// ClkCPU:  32000,000 kHz
n=(CLK.PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm))) |
	CLK_PSADIV_1_gc | CLK_PSBCDIV_1_1_gc;
CCP=CCP_IOREG_gc;
CLK.PSCTRL=n;

// Disable the autocalibration of the internal 32 MHz RC oscillator
DFLLRC32M.CTRL&= ~DFLL_ENABLE_bm;

// Wait for the internal 32 MHz RC oscillator to stabilize
while ((OSC.STATUS & OSC_RC32MRDY_bm)==0);

// Select the system clock source: 32 MHz Internal RC Osc.
n=(CLK.CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc;
CCP=CCP_IOREG_gc;
CLK.CTRL=n;

// Disable the unused oscillators: 2 MHz, internal 32 kHz, external clock/crystal oscillator, PLL
OSC.CTRL&= ~(OSC_RC2MEN_bm | OSC_RC32KEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm);

// Peripheral Clock output: Disabled
PORTCFG.CLKEVOUT=(PORTCFG.CLKEVOUT & (~PORTCFG_CLKOUT_gm)) | PORTCFG_CLKOUT_OFF_gc;

// Restore interrupts enabled/disabled state
SREG=s;
// Restore optimization for size if needed
#pragma optsize_default
}
         



void main(void)
{
unsigned char n;
#pragma optsize- 
#asm("cli")
n=(PMIC.CTRL & (~(PMIC_RREN_bm | PMIC_IVSEL_bm | PMIC_HILVLEN_bm | PMIC_MEDLVLEN_bm | PMIC_LOLVLEN_bm))) |
	PMIC_LOLVLEN_bm | PMIC_MEDLVLEN_bm | PMIC_HILVLEN_bm;
CCP=CCP_IOREG_gc;
PMIC.CTRL=n;
PMIC.INTPRI=0x00;
#pragma optsize_default
system_clocks_init();

ports_init();
usartc0_init();
usartd1_init();
rtc32_init_my();
delay_ms(50);
tcd0_init();
twie_init();
sprintf(info,"start i2c");
monitor();
delay_ms(50);
#asm("sei")
delay_ms(1);
PORTE.OUT=PORTE.OUT|0b00010000;
init_buferU1();
delay_ms(50);
PORTE.OUT=PORTE.OUT&0b11101111;
delay_ms(50);
PORTE.OUT=PORTE.OUT|0b00010000;
init_buferU2();
delay_ms(50);
PORTE.OUT=PORTE.OUT&0b11101111;
delay_ms(50);
PORTE.OUT=PORTE.OUT|0b00010000;
init_buferU3();
delay_ms(50);
PORTE.OUT=PORTE.OUT&0b11101111;
delay_ms(50);
sprintf(info,"buf i2c start ok");
monitor();
delay_ms(50);
PORTE.OUT=PORTE.OUT|0b00010000;
bmp_reg_init();
delay_ms(50);
sprintf(info,"bmp i2c start ok");
PORTE.OUT=PORTE.OUT&0b11101111;
delay_ms(50);
monitor();
delay_ms(100);
spic_init();
sprintf(info,"SPI START");
monitor();
#asm("sei")
delay_ms(200);

check_sd_card();


spic_init();
PORTA.DIRSET=0b00000001;
PORTA.OUTSET = 0b00000001;
delay_ms(10);
PORTA.OUTCLR = 0b00000001;
delay_ms(100);
PORTA.OUTSET = 0b00000001;
delay_ms(10);
ad7705_init(can1cl,mclk4,can1set,set1);
delay_ms(10);
PORTE.OUT=PORTE.OUT&0b11101111;
delay_ms(10);
PORTE.OUT=PORTE.OUT|0b00010000;
sprintf(info,"ad7705 start ok");
monitor();

RESULT=ad7705(1);
S0[7]=RESULT;// Сигнал  усилителя младший
S0[8]=(RESULT>>8); //Сигнал  усилителя старший

// ADCA initialization
adca_init();
// ADCB initialization
adcb_init();

// Timer/Counter 
tcc0_init();
tcc1_init();
tcf0_init();
delay_ms(10);

sprintf(info,"start device");
monitor();
delay_ms(50);

if(Xsave==0xFFFFFFFF)Xsave=0; 
sprintf(info,"START WHILE");
monitor();
delay_ms(50);

if(RTC32.CNT<1454622753) RTC32.CNT=1454622753;

PORTE.OUT=PORTE.OUT&0b11101111;
//прописываем заводской ответ
//!!!! важно смертельно
initzavod();
reginit();



while (1)
{
PORTR.OUTTGL=0b00000010;
//////////////////////////////////////*************************************
//поиск ошибки буфера
//buferU1_error();
//включаю подсветку
//if(error_buf!=0) PORTE.OUT=PORTE.OUT|0b00010000;
init_buferU1();
/////////////////////////////////////////////////////////////////////////////
read_bmp();
///////////////////////////////////////////////////////////////
if((0.0<Tempf&&Tempf<60.0)&&(300.0<p1&&p1<825.0))
{
Tempf_K=Tempf*10.0+2730.0;
S0[11]=Tempf_K;// температура бмп младший
S0[12]=(Tempf_K>>8); //температура бмп  старший
///////////////////////////////////////////////////////////////
S0[15]=p/10;//ДАВЛЕНИЕ бмп младший
S0[16]=(p/10>>8);//ДАВЛЕНИЕ бмп  старший
}

init_buferU2();

if(SD_IN) 
{
get_CNTRTC(&X);
calcDateTime(X, 0, &date1,&time1);
bufform(); 
GETFILNAME();
} 

init_buferU3();

buferU1_opros();
buferU2_opros();
buferU3_opros();
//обработочка
    //21.1 b2 io7  +
     if((U2in.input&0b10000000)==0b10000000) S0[21]=S0[21]|0b00000010;
else if((U2in.input&0b10000000)==0b00000000) S0[21]=S0[21]&0b11111101;
     //21.2 b1 io4 +
     if((U1in.input&0b00010000)==0b00010000) S0[21]=S0[21]|0b00000100;
else if((U1in.input&0b00010000)==0b00000000) S0[21]=S0[21]&0b11111011;  
     //21.3 b1 io5  +
     if((U1in.input&0b00100000)==0b00100000) S0[21]=S0[21]|0b00001000;
else if((U1in.input&0b00100000)==0b00000000) S0[21]=S0[21]&0b11110111;
     //21.4 b1 io1   ----
     if((U1in.input&0b00000010)==0b00000010) S0[21]=S0[21]|0b00010000;
else if((U1in.input&0b00000010)==0b00000000) S0[21]=S0[21]&0b11101111;
     //21.5 b2 io3
     if((U2in.input&0b00001000)==0b00001000) S0[21]=S0[21]|0b00100000;
else if((U2in.input&0b00001000)==0b00000000) S0[21]=S0[21]&0b11011111;
     //21.6 b2 io4
     if((U2in.input&0b00010000)==0b00010000) S0[21]=S0[21]|0b01000000;
else if((U2in.input&0b00010000)==0b00000000) S0[21]=S0[21]&0b10111111;
     //21.6 b3 io6
     if((U3in.input&0b01000000)==0b01000000) S0[21]=S0[21]|0b10000000;
else if((U3in.input&0b01000000)==0b00000000) S0[21]=S0[21]&0b01111111;

//пождиг    
if( (B5upr&0b00000010)==0b00000010 ) { U3out.output=U3out.output|0b00000010; }
else if( (B5upr&0b00000010)==0b00000000 ) {U3out.output=U3out.output&0b11111101;}
//клапан1    
if( (B5upr&0b00000100)==0b00000100 ) {U3out.output=U3out.output|0b00000100;}
else if( (B5upr&0b00000100)==0b00000000 ) {U3out.output=U3out.output&0b11111011;} 
//контрольная кювета    
if( (B5upr&0b00001000)==0b00001000)        {U1out.output=U1out.output&0b00111111;
                                            U1out.output=U1out.output|0b01000000;}

else if((B5upr&0b00001000)==0b00000000)     {U1out.output=U1out.output&0b00111111;
                                             U1out.output=U1out.output|0b10000000;}


//клапан 2    
if( (B5upr&0b00010000)==0b00010000 ) {U3out.output=U3out.output|0b00001000;}
else if( (B5upr&0b00010000)==0b00000000 ) {U3out.output=U3out.output&0b11110111;}
//клапан 3    
if( (B5upr&0b00100000)==0b00100000 ) {U3out.output=U3out.output|0b00010000;}
else if( (B5upr&0b00100000)==0b00000000 ) {U3out.output=U3out.output&0b11101111;}
//реле 1    инверсно
if( (B5upr&0b01000000)==0b01000000 )       {U1out.output=U1out.output&0b11111110;}
else if( (B5upr&0b01000000)==0b00000000 ) {U1out.output=U1out.output|0b00000001;}
//реле 2  инверсно  
if( (B5upr&0b10000000)==0b10000000 )      {U2out.output=U2out.output&0b11111110;}
else if( (B5upr&0b10000000)==0b00000000 ) {U2out.output=U2out.output|0b00000001;}

buferU1_set();
buferU2_set();
buferU3_set(); 
  
//////////////////////////////////////*************************************
//установка даты времени
if ((newtime==1)||(newdate==1)) 
                      {
                                    
                      calcSeconds(date1,time1,0,&X);
                      Xsave=X;//последняя установка
                      set_CNTRTC();
                      newdate=0;
                      newtime=0;
                                      
                      }
                      
                  

                                                  

}



}

