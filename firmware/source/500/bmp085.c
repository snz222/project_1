//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//адрес BMP085 без W/R
#define BMP085_TWI_BUS_ADDRESS (0xEE>>1)
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#include <twix.h>
// I/O Registers definitions
#include <io.h>
#include <delay.h>
#include <stdio.h>
//#include <alcd.h>
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!_VARIABLE_!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
signed short AC1;
signed short AC2; 
signed short AC3; 
unsigned short  AC4;
unsigned short  AC5;
unsigned short  AC6;
signed short B1; 
signed short B2;
signed short MB;
signed short MC;
signed short MD;
long UT = 0;
char oss=3;
long UP = 0;

signed long X1,X2,B5,Temp,B6,X3,B3,p;
unsigned long B4,B7; 
float Tempf;
float p1;
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!_VARIABLE_!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//структура данных датчика
//адреса регистров
      struct 
        {
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC1;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC2;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC3;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC4;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC5;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC6;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } B1;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } B2;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } MB;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } MC;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } MD;
        } twi_bmp085_reg;
        
        
   
  //значения калибр регистров
struct 
        {
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC1;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC2;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC3;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC4;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC5;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } AC6;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } B1;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } B2;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } MB;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } MC;
        struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } MD;
        } twi_bmp085_data; 
 
//запрос температуры
 struct
            { 
            unsigned char reg;
            unsigned char data;
            } read_temp_please;
 
 //чтение температуры 
 //адреса
  struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } read_temp_adr;
  //данные                             
  struct
            { 
            unsigned char msb;
            unsigned char lsb;
            } read_temp_data;  
  
  
  //чтение давления 
  //запрос давления
 struct
            { 
            unsigned char reg;
            unsigned char data;
            } read_pres_please;
 //адреса
  struct
            { 
            unsigned char msb;
            unsigned char lsb;
            unsigned char xlsb;
            } read_pres_adr;
  //данные                             
  struct
            { 
            unsigned char msb;
            unsigned char lsb;
            unsigned char xlsb;
            } read_pres_data;


//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//установка адресов регистров калибровки, запроса температуры и давления
void set_reg (void) 
{

//адреса регистров температуры
read_temp_adr.msb=0xF6;
read_temp_adr.lsb=0xF7;
//запрос температуры
read_temp_please.reg=0xF4;
read_temp_please.data=0x2E;

//адреса регистров давления
read_pres_adr.msb=0xF6;
read_pres_adr.lsb=0xF7;
read_pres_adr.xlsb=0xF8;
//запрос давления
read_pres_please.reg=0xF4;
read_pres_please.data=0x34+(oss<<6);

//адреса калибровочных регистров
//AC1 adres
twi_bmp085_reg.AC1.msb=0xAA;
twi_bmp085_reg.AC1.lsb=0xAB;
//AC2 adres
twi_bmp085_reg.AC2.msb=0xAC;
twi_bmp085_reg.AC2.lsb=0xAD;
//AC3 adres
twi_bmp085_reg.AC3.msb=0xAE;
twi_bmp085_reg.AC3.lsb=0xAF;
//AC4 adres
twi_bmp085_reg.AC4.msb=0xB0;
twi_bmp085_reg.AC4.lsb=0xB1;
//AC5 adres
twi_bmp085_reg.AC5.msb=0xB2;
twi_bmp085_reg.AC5.lsb=0xB3;
//AC6 adres
twi_bmp085_reg.AC6.msb=0xB4;
twi_bmp085_reg.AC6.lsb=0xB5;
//B1 adres
twi_bmp085_reg.B1.msb=0xB6;
twi_bmp085_reg.B1.lsb=0xB7;
//B2 adres
twi_bmp085_reg.B2.msb=0xB8;
twi_bmp085_reg.B2.lsb=0xB9;
//MB adres
twi_bmp085_reg.MB.msb=0xBA;
twi_bmp085_reg.MB.lsb=0xBB;
//MC adres
twi_bmp085_reg.MC.msb=0xBC;
twi_bmp085_reg.MC.lsb=0xBD;
//MD adres
twi_bmp085_reg.MD.msb=0xBE;
twi_bmp085_reg.MD.lsb=0xBF;
}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//функция для сокращения объема основной проги
void bmp_reg_init (void)
{
/////////////////////////////>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//адреса калибровки 
set_reg();
//чтение калибровочных данных 
//AC1
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.AC1, 
    2,
    (unsigned char *)&twi_bmp085_data.AC1,
    2                     ); 
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//AC2
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.AC2, 
    2,
    (unsigned char *)&twi_bmp085_data.AC2,
    2                     ); 

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//AC3
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.AC3, 
    2,
    (unsigned char *)&twi_bmp085_data.AC3,
    2                     ); 

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//AC4
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.AC4, 
    2,
    (unsigned char *)&twi_bmp085_data.AC4,
    2                     ); 

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//AC5
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.AC5, 
    2,
    (unsigned char *)&twi_bmp085_data.AC5,
    2                     ); 

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//AC6
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.AC6, 
    2,
    (unsigned char *)&twi_bmp085_data.AC6,
    2                     ); 
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//B1
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.B1, 
    2,
    (unsigned char *)&twi_bmp085_data.B1,
    2                     ); 

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//B2
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.B2, 
    2,
    (unsigned char *)&twi_bmp085_data.B2,
    2                     ); 

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//MB
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.MB, 
    2,
    (unsigned char *)&twi_bmp085_data.MB,
    2                     ); 

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//MC
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.MC, 
    2,
    (unsigned char *)&twi_bmp085_data.MC,
    2                     ); 
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//MD
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&twi_bmp085_reg.MD, 
    2,
    (unsigned char *)&twi_bmp085_data.MD,
    2                     );  
//////////////////////////////////////CALC////////////////////////////////////////////////////


//вычисление переменных для расчета температуры// и давления
AC1=(twi_bmp085_data.AC1.msb<<8)+twi_bmp085_data.AC1.lsb;
AC2=(twi_bmp085_data.AC2.msb<<8)+twi_bmp085_data.AC2.lsb;
AC3=(twi_bmp085_data.AC3.msb<<8)+twi_bmp085_data.AC3.lsb;
AC4=(twi_bmp085_data.AC4.msb<<8)+twi_bmp085_data.AC4.lsb;
AC5=(twi_bmp085_data.AC5.msb<<8)+twi_bmp085_data.AC5.lsb; //
AC6=(twi_bmp085_data.AC6.msb<<8)+twi_bmp085_data.AC6.lsb;//
B1=(twi_bmp085_data.B1.msb<<8)+twi_bmp085_data.B1.lsb;
B2=(twi_bmp085_data.B2.msb<<8)+twi_bmp085_data.B2.lsb;
MB=(twi_bmp085_data.MB.msb<<8)+twi_bmp085_data.MB.lsb;
MC=(twi_bmp085_data.MC.msb<<8)+twi_bmp085_data.MC.lsb;//
MD=(twi_bmp085_data.MD.msb<<8)+twi_bmp085_data.MD.lsb;//

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>









}

//
void read_bmp(void)
{
/////////////////////////////MEASUREMENT//////////////////////////////////////////////////////
//запрос температуры
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&read_temp_please, 
    2,
    0,
    0                     );  
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//пауза
//ожидание сигнал по линии OEC
//while((PORTE.IN&0b00000100)==0b00000000) 
//{
//;   
//}
delay_ms(26);

//адреса и данные

twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&read_temp_adr, 
    2,
    (unsigned char *)&read_temp_data,
    2                     );                

//??????????????????????????????????????????????????????????????????????????????????????????????    

//запрос давления

twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&read_pres_please, 
    2,
    0,
    0                     );  
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//пауза
//ожидание по OEC
//
delay_ms(26);
//while((PORTE.IN&0b00000100)==0b00000000) 
//{
//;   
//}

twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&read_pres_adr.msb, 
    1,
    (unsigned char *)&read_pres_data.msb,
    1                     ); 
                              
twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&read_pres_adr.lsb, 
    1,
    (unsigned char *)&read_pres_data.lsb,
    1                     );

twi_master_trans ( 
    &twie_master, 
    BMP085_TWI_BUS_ADDRESS,
    (unsigned char *)&read_pres_adr.xlsb, 
    1,
    (unsigned char *)&read_pres_data.xlsb,
    1                     );   
    
/////////////////////////////MEASUREMENT//////////////////////////////////////////////////////

 
//////////////////////////////////////CALC////////////////////////////////////////////////////
//собираем регистр температуры
UT=(read_temp_data.msb<<8)+read_temp_data.lsb;
UP= read_pres_data.msb;
UP<<=8;
UP=UP+read_pres_data.lsb;
UP<<=8;
UP=UP+read_pres_data.xlsb;
UP>>=(8-oss);

///////////////_TTTTT_/////////////   
X1=((UT-AC6)*AC5)>>15;     
X2=((long)MC<<11)/(X1+MD);                 
B5=(X1+X2);
Temp=((B5+8)>>4); 
Tempf=Temp/10.0;   
///////////////_TTTTT_/////////////  

//////////////_PPPPPPP_////////////
B6=B5-4000; 
X1=(B2*(B6*B6)>>12)>>11;
X2=(AC2*B6)>>11; 
X3=X1+X2;  
B3=    ((( ((signed long)AC1)*4 + X3)<<oss) + 2)>>2;
X1=(AC3*B6)>>13;  
X2 = (B1 * ((B6 * B6)>>12))>>16;
X3 = ((X1 + X2) + 2)>>2; 
B4 = (AC4 * (unsigned long)(X3 + 32768))>>15;
B7 = ((unsigned long)(UP - B3) * (50000>>oss));
if (B7 < 0x80000000){p = (B7<<1)/B4;}
else {p = (B7/B4)<<1;}
X1=(p>>8)*(p>>8);
X1=(X1*3038)>>16;
X2=(-7357*p)>>16;
p+=(X1+X2+3791)>>4;
p1=p/133.322;
//////////////_PPPPPPP_////////////
}

