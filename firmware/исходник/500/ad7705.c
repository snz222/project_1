#include <io.h>
#include <delay.h>
#include <stdio.h>

#define Uop 1.6 //������� ���������� 

unsigned char chan=1;   //default ����� 1

#define can1cl 0x20     //�������� ������ �����, ���� �������� ��������� ������� (byte1)
#define mclk4 0x0C      //0x0C ��� ������ 4,9� , 0x04 ��� (2,4M)             byte2
#define mclk2 0x04      //   byte2
#define can1set 0x10    //�������� ������ �����, ���� �������� ��������� ���  byte3
#define set1 0x40       // gain = 1, bipolar mode,    byte4
//buffer off, clear FSYNC and perform a Self Calibration
#define set2 0x04       // gain = 1, unipolar mode,    byte4
//buffer off, normal mode

#define can2cl 0x21  // �������� ������ �����, ���� �������� ��������� ������� (byte1)
#define can2set 0x11 //   �������� ������� �����, ���� �������� ��������� ���  byte3



//ad7705_init(can1cl,mclk4,can1set,set1); �������� 

int RESULT;
int RESULT_buf;
long int RESULT_sr;
//���������
char RESULT_count;




void ad7705_init (unsigned char by1,unsigned char by2,unsigned char by3, unsigned char by4)
{

//���������� ������ CS � 0
PORTC.OUTCLR = 0b00010000;
//���������� �� SPI ������ ����� ���������
spic_master_tx_rx(by1);
spic_master_tx_rx(by2); 
spic_master_tx_rx(by3);
spic_master_tx_rx(by4);
// ���� ���� DRDY �� ������ 0.
// ��� ������ DRDY = 0, ��� ��������.
// � ����� ������� DRDY ����� �������� �� � 1 �� � 0.


while((PORTC.IN|0b11111101)==0b11111111);
// ��������� CS � 1. 
PORTC.OUTSET = 0b00010000;
}


int ad7705 (unsigned char chanel)
{
unsigned int ti;


short data_h,data_l;

//�������� ��������� ������
if ((chanel!=chan)&&(chanel==1||chanel==2)) 
{
//��������� ������� �� ���������� �����
    if (chanel==1)  ad7705_init(can1cl,mclk4,can1set,set1);
    if (chanel==2)  ad7705_init(can2cl,mclk4,can2set,set1); 
    
}

//����������
chan=chanel;

//for (ti=0;ti<50000;ti++)
//if((PORTC.IN|0b11111101)==0b11111111) delay_us(1);
//else ti=60000;

//if(ti==60000)
//{
KALC_PULS=0;
while(((PORTC.IN|0b11111101)==0b11111111)&&(KALC_PULS<20000)) {KALC_PULS++;delay_us(1);}
//���������� ������ CS � 0
if(KALC_PULS==20000) 
{
//PORTC.OUTCLR = 0b00010000;
//delay_us(10);
//������
//spic_master_tx_rx(0x38);
//�����
//data_h=spic_master_tx_rx(0xFF);
//data_l=spic_master_tx_rx(0xFF);
//���������� ������ CS � 1
//PORTC.OUTSET = 0b00010000;
//����� ������� 16 ���
//if (chanel==1)  ad7705_init(can1cl,mclk4,can1set,set1);
//if (chanel==2)  ad7705_init(can2cl,mclk4,can2set,set1); 
//while((PORTC.IN|0b11111101)==0b11111111);
return(0x03FF);
}

else
{
PORTC.OUTCLR = 0b00010000;

delay_us(10);
//������
spic_master_tx_rx(0x38);
//�����
data_h=spic_master_tx_rx(0xFF);
data_l=spic_master_tx_rx(0xFF);
//���������� ������ CS � 1
PORTC.OUTSET = 0b00010000;
//����� ������� 16 ���

return(data_h<<8|data_l);
//return((data_h*256+data_l)*Uop/32768.0);
//}
//else return(0xFF<<8|0xFF);
}

} 
