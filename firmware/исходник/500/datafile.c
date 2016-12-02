//файл для протокола общения с ПК
/*Байт  //  
1    Маркер (А5)
2    Ток ФЭУ
2    Расход помпы. 
2    Напряжение ФЭУ.
2    Сигнал  усилителя
2    Доп АЦП 3 
2    Температура воздуха в аналитической кювете.
2    Температура контрольной кюветы
2     Давление воздуха в аналитической кювете.
1    Доп АЦП 1 младший байт 
1    Доп АЦП 1 старший байт 
1    Доп АЦП 2 младший байт 
1    Доп АЦП 2 старший байт 
1	Статус
1	Контрольная сумма
*/
//#include "usart_init.c"

// USARTC0 Receiver buffer
//char RX_BUFFER_SIZE_USARTC0=30;
//char rx_counter_usartc0=0;
//char rx_wr_index_usartc0=0,rx_rd_index_usartc0=0,rx_counter_usartc0=0;
//char rx_buffer_usartc0[RX_BUFFER_SIZE_USARTC0];

/* NAME file */
char fNAME[15];
bit flag_sd=0;
char tSDACARD[45];
bool izm=0;
char potok1[36];
unsigned int T_analog,Tempf_K;
bool CLBR=0;
unsigned int KALC_PULS;

char RX_BUFFER_SIZE_USARTC0=1;
char rx_buffer_usartc0[30];
unsigned char rx_wr_index_usartc0=0,rx_rd_index_usartc0=0,rx_counter_usartc0=0;


#define VREF 2050.0 // ADC reference voltage [mV]
#define CHANNELS 4
unsigned char nn,xx;

// Store ADC result
unsigned int adcb_store[4];//0,1,2,3
unsigned int adca_store[4];//4,5,6,7

unsigned int adcb_SD[4];//0,1,2,3
unsigned int adca_SD[4];//4,5,6,7

unsigned char B5upr;

////////////////////////////////////////////
char A0[6];//данные пакета A0
char AF[18];//данные пакета AF
char AA[4];//данные пакета AA
char A1[27];//данные пакета A1
///////////////////////////////////////////
char AD[6];//данные пакета AD
char A7[3];//данные пакета A7
char p77[4];//данные пакета 77
char p76[4];//данные пакета 76
char ch,l;//переменная перебора для контольного байта
char AB[12];//данные пакета AB
char A2[4];//данные пакета A2
char AE[10];//данные пакета AE
char p6A[6];//данные пакета 6a
////////////////////////////////////////////////////
char A4[6];//данные пакета A4
char p58[6];//данные пакета 58
char A6[6];//данные пакета A6
//////////////////////////////////////////////////
unsigned char check_sum=0;
char info[30];
//перебор s1
//usart функции в этом файле!!
unsigned char status;
char data;
//////////usart функции в этом файле!!

//bit mb=0;//0-малый 1-большой пакет 
//отправка
char S0[23];
//прием
char S1[30];

char send=0;
char indexs1=0;
char s1suml;
char Mx=0xFF,markerok=0,dl=0;

char B5buf[4];

void topk(void)
{

unsigned char x,SUM;
PORTR.OUT=PORTR.OUT&0b11111110;

for (x=0,SUM=0;x<22;x++)
{
if (x!=0) SUM=SUM+S0[x];
putchar(S0[x]);
}
S0[22]=SUM;
putchar(S0[22]);
PORTR.OUT=PORTR.OUT|0b00000001;
}

//при первом включении прописать данные
void initzavod (void)
{
//заводская инициализация A0
A0[0]=0xA0;
A0[1]=0x30;
A0[2]=0x33;
A0[3]=0x35;
A0[4]=0x00;
l=sizeof(A0);
//checksum2(A0);
for(ch=1,A0[l-1]=0;ch<l-1;ch++)
{
A0[l-1]=A0[l-1]+A0[ch];
}
l=0;

AF[0]=0xAF;
AF[1]=0x01;
AF[2]=0x63;
AF[3]=0x60;
AF[4]=0x64;
AF[5]=0x00;
AF[6]=0x00;
AF[7]=0x00;
AF[8]=0x00;
AF[9]=0x00;
AF[10]=0x00;
AF[11]=0x00;
AF[12]=0x98;
AF[13]=0x3A;
AF[14]=0xDC;
AF[15]=0x05;
AF[16]=0x05;
l=sizeof(AF);
for(ch=1,AF[l-1]=0;ch<l-1;ch++)
AF[l-1]=AF[l-1]+AF[ch];
l=0;



AA[0]=0xAA;
AA[1]=0x60;
AA[2]=0xEA;
l=sizeof(AA);
for(ch=1,AA[l-1]=0;ch<l-1;ch++)
AA[l-1]=AA[l-1]+AA[ch];
l=0;



A2[0]=0xA2;
A2[1]=0x01;
A2[2]=0x00;
l=sizeof(A2);
for(ch=1,A2[l-1]=0;ch<l-1;ch++)
A2[l-1]=A2[l-1]+A2[ch];
l=0;


AD[0]=0xAD;
AD[1]=0x5A;
AD[2]=0x00;
AD[3]=0x5A;
AD[4]=0x00;
l=sizeof(AD);
for(ch=1,AD[l-1]=0;ch<l-1;ch++)
AD[l-1]=AD[l-1]+AD[ch];
l=0;




A6[0]=0xA6;
A6[1]=0x00;
A6[2]=0x00;
A6[3]=0x01;
A6[4]=0x00;
l=sizeof(A6);
for(ch=1,A6[l-1]=0;ch<l-1;ch++)
A6[l-1]=A6[l-1]+A6[ch];
l=0;

A1[0]=0xA1;
A1[1]=0x53;
A1[2]=0x75;
A1[3]=0x6E;
A1[4]=0x20;
///////////////
A1[5]=0x53;
A1[6]=0x65;
A1[7]=0x70;
A1[8]=0x20;
A1[9]=0x32;
///////////////
A1[10]=0x31;
A1[11]=0x20;
A1[12]=0x32;
A1[13]=0x33;
A1[14]=0x3A;
/////////////
A1[15]=0x33;
A1[16]=0x36;
A1[17]=0x3A;
A1[18]=0x32;
A1[19]=0x34;
////////////
A1[20]=0x20;
A1[21]=0x32;
A1[22]=0x30;
A1[23]=0x31;
A1[24]=0x34;
A1[25]=0x00;
//B0
//////////////
l=sizeof(A1);
for(ch=1,A1[l-1]=0;ch<l-1;ch++)
A1[l-1]=A1[l-1]+A1[ch];
l=0;
A7[0]=0xA7;
A7[1]=0x42;
l=sizeof(A7);
for(ch=1,A7[l-1]=0;ch<l-1;ch++)
A7[l-1]=A7[l-1]+A7[ch];
l=0;



p77[0]=0x77;
p77[1]=0x00;
p77[2]=0xFC;
//p77[3]=0xFC;
l=sizeof(p77);
for(ch=1,p77[l-1]=0;ch<l-1;ch++)
p77[l-1]=p77[l-1]+p77[ch];
l=0;


AB[0]=0xAB;
AB[1]=0x75;
AB[2]=0x6E;
AB[3]=0x37;
AB[4]=0x30;
AB[5]=0x32;
AB[6]=0x62;
AB[7]=0x0E;
AB[8]=0x04;
AB[9]=0x14;
AB[10]=0x0E;
//
l=sizeof(AB);
for(ch=1,AB[l-1]=0;ch<l-1;ch++)
AB[l-1]=AB[l-1]+AB[ch];
l=0;



AE[0]=0xAE;
AE[1]=0xFF;
AE[2]=0xFF;
AE[3]=0xFF;
AE[4]=0xFF;
AE[5]=0xFF;
AE[6]=0xFF;
AE[7]=0xFF;
AE[8]=0xFF;
//AE[9]=0x14;
l=sizeof(AE);
for(ch=1,AE[l-1]=0;ch<l-1;ch++)
AE[l-1]=AE[l-1]+AE[ch];
l=0;






A4[0]=0xA4;
A4[1]=0x00;
A4[2]=0xFC;
A4[3]=0x68;
A4[4]=0xF7;
//
l=sizeof(A4);
for(ch=1,A4[l-1]=0;ch<l-1;ch++)
A4[l-1]=A4[l-1]+A4[ch];
l=0;



p58[0]=0x58;
p58[1]=0x00;
p58[2]=0x00;
p58[3]=0x01;
p58[4]=0x00;
//
l=sizeof(p58);
for(ch=1,p58[l-1]=0;ch<l-1;ch++)
p58[l-1]=p58[l-1]+p58[ch];
l=0;



p76[0]=0x76;
p76[1]=0xFF;
p76[2]=0xFF;
//p77[3]=0xFE;
l=sizeof(p76);
for(ch=1,p76[l-1]=0;ch<l-1;ch++)
p76[l-1]=p76[l-1]+p76[ch];
l=0;



p6A[0]=0x6A;
p6A[1]=0x00;
p6A[2]=0x00;
p6A[3]=0x00;
p6A[4]=0x00;
//p77[3]=0xFE;
l=sizeof(p6A);
for(ch=1,p6A[l-1]=0;ch<l-1;ch++)
p6A[l-1]=p6A[l-1]+p6A[ch];
l=0;

}


//инициализация массива для передачи %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
void reginit (void)
{
S0[0]=0xA5;// Маркер (А5)
//тест
S0[1]=0x40;// Ток ФЭУ
S0[2]=0x1F;// Ток ФЭУ

//S0[1]=0x98;// Ток ФЭУ
//S0[2]=0x3A;// Ток ФЭУ

//S0[3]=0x30;// Расход помпы
//S0[4]=0x75;// Расход помпы.

S0[3]=0x78;// Расход помпы.
S0[4]=0x00; // Расход помпы.

S0[5]=0xBB;// Напряжение ФЭУ
S0[6]=0x0B; // Напряжение ФЭУ

//S0[7]=0x00;// Сигнал  усилителя
//S0[8]=0xFF; //Сигнал  усилителя


S0[9]=0x00;// Доп АЦП 3 
S0[10]=0x08; //Доп АЦП 3 

S0[11]=0xAD;// Температура воздуха в аналитической кювете.
S0[12]=0x0D; //Температура воздуха в аналитической кювете.

S0[13]=0xAC;// Температура контрольной кюветы
S0[14]=0x0D; //Температура контрольной кюветы

//S0[15]=0x15; //!! // Давление воздуха в аналитической кювете. мл
//S0[16]=0x0C; //!!//Давление воздуха в аналитической кювете.     ст

S0[15]=0x10;  // Давление воздуха в аналитической кювете. мл
S0[16]=0x27;

S0[17]=0x00; // Доп АЦП 1 младший байт 
S0[18]=0x04; // Доп АЦП 1 старший байт 

S0[19]=0x00; // Доп АЦП 2 младший байт 
S0[20]=0x06; // Доп АЦП 2 старший байт 

//S0[21]=0b11111011; // Статус
S0[21]=0;
//S0[22]=checksum(); // Контрольная сумма
}

/*
запрос на сброс мк F5,5F,check
Ответ f5,f5, chek;
*/
////////////////////////////////////////////////////////////////////////
//Программный RESET 
//void (*funcptr)( void ) = 0x0000;
//unsigned char tmp=RST_SWRST_bm;
//CCP = CCP_IOREG_gc;
//RST.CTRL=RST_SWRST_bm;
//Программный RESET 
////////////////////////////////////////////////////////////////////////
//очистка строки
void clrs1(void)
{
memset(S1, 0, sizeof(S1));
}
