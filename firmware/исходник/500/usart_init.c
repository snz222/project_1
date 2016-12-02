
void usartc0_init(void)
{
PORTC.OUTSET=0x08;

// Communication mode: Asynchronous USART
// Data bits: 8
// Stop bits: 1
// Parity: Disabled
USARTC0.CTRLC=USART_CMODE_ASYNCHRONOUS_gc | USART_PMODE_DISABLED_gc | USART_CHSIZE_8BIT_gc;

// Receive complete interrupt: High Level
// Transmit complete interrupt: Disabled
// Data register empty interrupt: Disabled
USARTC0.CTRLA=(USARTC0.CTRLA & (~(USART_RXCINTLVL_gm | USART_TXCINTLVL_gm | USART_DREINTLVL_gm))) |
    USART_RXCINTLVL_HI_gc | USART_TXCINTLVL_OFF_gc | USART_DREINTLVL_OFF_gc;

// Required Baud rate: 9600
// Real Baud Rate: 9601,0 (x1 Mode), Error: 0,0 %
USARTC0.BAUDCTRLA=0xF5;
USARTC0.BAUDCTRLB=((0x0C << USART_BSCALE_bp) & USART_BSCALE_gm) | 0x0C;

// Receiver: On
// Transmitter: On
// Double transmission speed mode: Off
// Multi-processor communication mode: Off
USARTC0.CTRLB=(USARTC0.CTRLB & (~(USART_RXEN_bm | USART_TXEN_bm | USART_CLK2X_bm | USART_MPCM_bm | USART_TXB8_bm))) |
    USART_RXEN_bm | USART_TXEN_bm;
}




interrupt [USARTC0_RXC_vect] void usartc0_rx_isr(void)
{

status=USARTC0.STATUS;
data=USARTC0.DATA;

if ((status & (USART_FERR_bm | USART_PERR_bm | USART_BUFOVF_bm)) == 0)
   {
rx_buffer_usartc0[rx_wr_index_usartc0]=data;
rx_wr_index_usartc0++;
   }

   
switch(Mx)
{
case 0xFF:   
{
    //поиск маркера
    //////////////////////////////////////////////
    switch (rx_buffer_usartc0[0])
    {
    ///////////////////////////////////////
    case 0xFF: 
    {
    Mx=0xFF;
    RX_BUFFER_SIZE_USARTC0=1;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    ///////////////////////////////////////
    case 0xCA: 
    {
    Mx=0xCA;
    RX_BUFFER_SIZE_USARTC0=2;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    ///////////////////////////////////////
    case 0xF5: 
    {
    Mx=0xF5;
    RX_BUFFER_SIZE_USARTC0=2;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    ///////////////////////////////////////
    
    case 0xB5: 
    {
    Mx=0xB5;
    RX_BUFFER_SIZE_USARTC0=4;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    ///////////////////////////////////////
    
    ///////////////////////////////////////   ///////////////////////////////////////
    
    case 0xEA: 
    {
    Mx=0xEA;
    RX_BUFFER_SIZE_USARTC0=2;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    ///////////////////////////////////////   ///////////////////////////////////////
    
    ///////////////////////////////////////   ///////////////////////////////////////
    
    case 0xE5: 
    {
    Mx=0xE5;
    RX_BUFFER_SIZE_USARTC0=7;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    ///////////////////////////////////////   ///////////////////////////////////////  
    
    ///////////////////////////////////////   ///////////////////////////////////////
    
    case 0xE7: 
    {
    Mx=0xE7;
    RX_BUFFER_SIZE_USARTC0=7;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;  
    
    
    case 0x60: 
    {
    Mx=0x60;
    RX_BUFFER_SIZE_USARTC0=2;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    ///////////////////////////////////////   ///////////////////////////////////////
    
    ///////////////////////////////////////   ///////////////////////////////////////
    
    case 0xE8: 
    {
    Mx=0xE8;
    RX_BUFFER_SIZE_USARTC0=3;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    ///////////////////////////////////////   ///////////////////////////////////////
    
    ///////////////////////////////////////   ///////////////////////////////////////
    
    case 0xE9: 
    {
    Mx=0xE9;
    RX_BUFFER_SIZE_USARTC0=3;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    ///////////////////////////////////////   /////////////////////////////////////// 
    ///////////////////////////////////////////////////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    /////////////////////дата ///////////////////////////////////////
    case 0xD1: 
    {
    Mx=0xD1;
    RX_BUFFER_SIZE_USARTC0=5;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    //////////////////////время///////////////////////////////////////
    case 0xD3: 
    {
    Mx=0xD3;
    RX_BUFFER_SIZE_USARTC0=4;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    }
    break;
    //////////////////////////////////////////////////////////////////////////////
     /////////////////////дата ///////////////////////////////////////
    case 0xD5: 
    {
    Mx=0xD5;
    rx_buffer_usartc0[0]=0xFF;
    RX_BUFFER_SIZE_USARTC0=1;
    rx_wr_index_usartc0=0; 
    
    
    }
    break;  
    
    case 0xD7: 
    {
    Mx=0xD7;
    rx_buffer_usartc0[0]=0xFF;
    RX_BUFFER_SIZE_USARTC0=1;
    rx_wr_index_usartc0=0; 
    
    }
    break;
    
    //////////////////////время///////////////////////////////////////
    /*
    case 0xA0: 
    {
    //Mx=0xA0;
    //RX_BUFFER_SIZE_USARTC0=1;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(A0);
    for(ch=1,A0[l-1]=0;ch<l-1;ch++) A0[l-1]=A0[l-1]+A0[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(A0[ch]);
    l=0;
    Mx=0xFF;
    rx_wr_index_usartc0=0;
    }
    break; 
    */
    
    
    
    
    
    
    
    
    
    
    
    ///////////////////////////////////////////////////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //////////////////////////////запросы данных//////////////////////////////запросы данных
    case 0xA0: 
    {
    //Mx=0xA0;
    //RX_BUFFER_SIZE_USARTC0=1;
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(A0);
    for(ch=1,A0[l-1]=0;ch<l-1;ch++) A0[l-1]=A0[l-1]+A0[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(A0[ch]);
    l=0;
    Mx=0xFF;
    rx_wr_index_usartc0=0;
    }
    break; 
    
    case 0xA1: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(A1);
    for(ch=1,A1[l-1]=0;ch<l-1;ch++) A1[l-1]=A1[l-1]+A1[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(A1[ch]);
    l=0;
    Mx=0xFF;
    }
    break; 
   
    case 0xA2: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(A2);
    for(ch=1,A2[l-1]=0;ch<l-1;ch++) A2[l-1]=A2[l-1]+A2[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(A2[ch]);
    l=0;
    Mx=0xFF;
    }
    break;
    
    case 0xA4: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(A4);
    for(ch=1,A4[l-1]=0;ch<l-1;ch++) A4[l-1]=A4[l-1]+A4[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(A4[ch]);
    l=0;
    Mx=0xFF;
    
    }
    break;
    
    case 0xA6: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(A6);
    for(ch=1,A6[l-1]=0;ch<l-1;ch++) A6[l-1]=A6[l-1]+A6[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(A6[ch]);
    l=0;
    Mx=0xFF;
    }
    break; 
     
    case 0xA7: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(A7);
    for(ch=1,A7[l-1]=0;ch<l-1;ch++) A7[l-1]=A7[l-1]+A7[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(A7[ch]);
    l=0;
    Mx=0xFF;
    }
    break; 
    
    case 0xAA: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(AA);
    for(ch=1,AA[l-1]=0;ch<l-1;ch++) AA[l-1]=AA[l-1]+AA[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(AA[ch]);
    l=0;
    Mx=0xFF;
    }
    break;
    
     
    case 0xAB: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(AB);
    for(ch=1,AB[l-1]=0;ch<l-1;ch++) AB[l-1]=AB[l-1]+AB[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(AB[ch]);
    l=0;
    Mx=0xFF;
    }
    break; 
    
    case 0xAD: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(AD);
    for(ch=1,AD[l-1]=0;ch<l-1;ch++) AD[l-1]=AD[l-1]+AD[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(AD[ch]);
    l=0;
    Mx=0xFF;
    }
    break;
    
    
    case 0xAE: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(AE);
    for(ch=1,AE[l-1]=0;ch<l-1;ch++) AE[l-1]=AE[l-1]+AE[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(AE[ch]);
    l=0;
    Mx=0xFF;
    }
    break;
    
    case 0xAF: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(AF);
    for(ch=1,AF[l-1]=0;ch<l-1;ch++) AF[l-1]=AF[l-1]+AF[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(AF[ch]);
    l=0;
    Mx=0xFF;
    }
    break;
      
    
    case 0x58: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(p58);
    for(ch=1,p58[l-1]=0;ch<l-1;ch++) p58[l-1]=p58[l-1]+p58[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(p58[ch]);
    l=0;
    Mx=0xFF;
    }
    break;
      
    case 0x6A: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(p6A);
    for(ch=1,p6A[l-1]=0;ch<l-1;ch++) p6A[l-1]=p6A[l-1]+p6A[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(p6A[ch]);
    l=0;
    Mx=0xFF;
    }
    break;
    
    
    case 0x76: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(p76);
    for(ch=1,p76[l-1]=0;ch<l-1;ch++) p76[l-1]=p76[l-1]+p76[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(p76[ch]);
    l=0;
    Mx=0xFF;
    }
    break;
        
    case 0x77: 
    {
    rx_buffer_usartc0[0]=0xFF;
    rx_wr_index_usartc0=0;
    //тут же ответ
    l=sizeof(p77);
    for(ch=1,p77[l-1]=0;ch<l-1;ch++) p77[l-1]=p77[l-1]+p77[ch];
    //высылаем пачку
    for (ch=0;ch<l;ch++) putchar(p77[ch]);
    l=0;
    Mx=0xFF;
    }
    break;
    
    //////////////////////////////запросы данных//////////////////////////////запросы данных
    
    default : 
    {
    rx_buffer_usartc0[0]=0xFF;
    Mx=0xFF;
    RX_BUFFER_SIZE_USARTC0=1;
    rx_wr_index_usartc0=0;
    }
    
    
    
}//switch buf
//////////////////////////////////////////////////////////////////////////////



}//end case ff
//break; //mx=ff


///////////////////////////////////////////////////CACACACCAACACACACACACACACACACACACACACACACAC
case 0xCA:
 {
 //проверка по длинне
 if(rx_wr_index_usartc0==2)
 //проверка по содержанию пакета
 {
 if(rx_buffer_usartc0[0]==0x01&&rx_buffer_usartc0[1]==0x01) {putchar(0xCA);putchar(0xCA);Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;} 
 else if(rx_buffer_usartc0[0]==0x0F&&rx_buffer_usartc0[1]==0x0F) {putchar(0xCA);putchar(0xCA);Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;
                                                                    send=1;
                                                                    rx_wr_index_usartc0=0;} 
 else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;} 
 }
 
 
 }
break;
/////////////////////////////////////////////////////////////////////////сброс
case 0xF5:
{
     
//проверка по длинне
 if(rx_wr_index_usartc0==2)
 //содержание
                if(rx_buffer_usartc0[0]==0x5F&&rx_buffer_usartc0[1]==0x5F) 
                {
                putchar(0xF5);
                putchar(0xF5);
                putchar(0xF5);
                Mx=0xFF;
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                delay_ms(5);
                CCP = CCP_IOREG_gc;
                RST.CTRL=RST_SWRST_bm;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
                            
}
break;
///////////////////////////////////////////////////////////ответ данные%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 0xB5:
{
     
//проверка по длинне
 if(rx_wr_index_usartc0==4) 
 {
 //содержание   
                
                for(ch=0,check_sum=0;ch<3;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];B5buf[ch]=rx_buffer_usartc0[ch];}
                
                B5buf[3]=rx_buffer_usartc0[3];
                
                if(rx_buffer_usartc0[3]==check_sum)
                
                
                             
                {
                
                                /*
                //эмуляция вывода кюветы
                if( (rx_buffer_usartc0[0]&0b00001000)==0b00000000)
                {
                //S0[21]=S0[21]|0b00001000; 
                //S0[21]=S0[21]&0b11111011;
                //увеличение значения усилителя
                //S0[7]=0x00;// Сигнал  усилителя
                //S0[8]=0xFF; //Сигнал  усилителя
                }
                else 
                if( (rx_buffer_usartc0[0]&0b00001000)==0b00001000)
                {
                //S0[21]=S0[21]|0b00000100;
                //S0[21]=S0[21]&0b11110111;
                //сигнал усилителя 
                //S0[7]=0xC0;
                //S0[8]=0x0A;
                
                }
                //клапан
                if( (rx_buffer_usartc0[0]&0b00000100)==0b00000100)
                {
                //S0[21]=S0[21]|0b00001000;
                //давление
                //S0[15]=0x04;// давление
                //S0[16]=0x0C;// 
                
                //S0[15]=0xAC;// давление
                //S0[16]=0x26;//
                }  
                
                
                if( (rx_buffer_usartc0[0]&0b00000100)==0b00000000)
                {
                //S0[21]=S0[21]|0b00001000;
                //давление
                ///S0[15]=0xC0;// 
                //S0[16]=0x0C;//
                
                //S0[15]=0x10;// давление
                //S0[16]=0x27;//
                }
                */
                B5upr=rx_buffer_usartc0[0];
                putchar(0xB5);
                putchar(0xB5);
                Mx=0xFF; 
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                check_sum=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;



case 0xEA:
{
     
//проверка по длинне
 if(rx_wr_index_usartc0==2) 
 {
 //содержание   
                
                for(ch=0,check_sum=0;ch<1;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
                
                if(rx_buffer_usartc0[1]==check_sum)
                             
                {
                putchar(0xEA);
                putchar(0xEA);
                Mx=0xFF; 
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                check_sum=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;

case 0x60:
{
     
//проверка по длинне
 if(rx_wr_index_usartc0==2) 
 {
 //содержание   
                
                for(ch=0,check_sum=0;ch<1;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
                
                if(rx_buffer_usartc0[1]==check_sum)
                             
                {
                putchar(0x60);
                putchar(0x00);
                putchar(0x00);
                Mx=0xFF; 
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                check_sum=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;


case 0xE5:
{
     
//проверка по длинне
 if(rx_wr_index_usartc0==7) 
 {
 //содержание   
                
                for(ch=0,check_sum=0;ch<6;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
                
                if(rx_buffer_usartc0[6]==check_sum)
                             
                {
                putchar(0xE5);
                putchar(0xE5);
                Mx=0xFF; 
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                check_sum=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;


case 0xE7:
{
     
//проверка по длинне
 if(rx_wr_index_usartc0==7) 
 {
 //содержание   
                
                for(ch=0,check_sum=0;ch<6;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
                
                if(rx_buffer_usartc0[6]==check_sum)
                             
                {
                putchar(0xE7);
                putchar(0xE7);
                Mx=0xFF; 
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                check_sum=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;




case 0xE8:
{
     
//проверка по длинне
 if(rx_wr_index_usartc0==3) 
 {
 //содержание   
                
                for(ch=0,check_sum=0;ch<2;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
                
                if(rx_buffer_usartc0[2]==check_sum)
                             
                {
                putchar(0xE8);
                putchar(0xE8);
                Mx=0xFF; 
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                check_sum=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;


case 0xE9:
{
     
//проверка по длинне
 if(rx_wr_index_usartc0==3) 
 {
 //содержание   
                
                for(ch=0,check_sum=0;ch<2;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
                
                if(rx_buffer_usartc0[2]==check_sum)
                             
                {
                putchar(0xE9);
                putchar(0xE9);
                Mx=0xFF; 
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                check_sum=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;


case 0xD1:
{
     
//проверка по длинне
 if(rx_wr_index_usartc0==5) 
 {
 //содержание   
                
                for(ch=0,check_sum=0;ch<4;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
                
                if(rx_buffer_usartc0[4]==check_sum)
                             
                {
                //копировать дату
                rx_buffer_usartc0[4]=NULL;
                date1=0;
                date1=rx_buffer_usartc0[0]*100+rx_buffer_usartc0[1];
                date1=date1*100+rx_buffer_usartc0[2];
                date1=date1*100+rx_buffer_usartc0[3];
                newdate=1;
                putchar(0xD1);
                putchar(0xD1);
                Mx=0xFF; 
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                check_sum=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;

case 0xD3:
{
//проверка по длинне
 if(rx_wr_index_usartc0==4) 
 {
 //содержание   
                
                for(ch=0,check_sum=0;ch<3;ch++){check_sum=check_sum+rx_buffer_usartc0[ch];}
                
                if(rx_buffer_usartc0[3]==check_sum)
                             
                {
                //установить время
                //запись даты в переменные
                rx_buffer_usartc0[3]=NULL;
                time1=0;
                time1=rx_buffer_usartc0[0]*100+rx_buffer_usartc0[1];
                time1=time1*100+rx_buffer_usartc0[2];  
                newtime=1;
                putchar(0xD3);
                putchar(0xD3);
                Mx=0xFF; 
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                check_sum=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;

case 0xD5:
{
//проверка по длинне
 if(rx_wr_index_usartc0==1) 
 {
                if(rx_buffer_usartc0[0]==0xD5)
                             
                {
                //установить время
                //запись даты в переменные
                get_CNTRTC(&X);
                calcDateTime(X, 0, &date1,&time1);
                //date1=rx_buffer_usartc0[0]*100+rx_buffer_usartc0[1];
                //date1=date1*100+rx_buffer_usartc0[2];
                //date1=date1*100+rx_buffer_usartc0[3];
                //CSdt
                //bufdt 
               // bufdt[0]=time1/10000;
               // bufdt[1]=(time1-bufdt[0]*10000)/100; 
               // bufdt[2]=(time1-bufdt[0]*10000-bufdt[1]*100);
                
                
                bufdt[0]=date1/1000000;
                bufdt[1]=date1%1000000/10000;
                bufdt[2]=date1%10000/100;
                bufdt[3]=date1%100;
                
                
                //тут же ответ
                
                for(ch=0,bufdt[4]=0;ch<4;ch++) bufdt[4]=bufdt[4]+bufdt[ch];
                //высылаем пачку
                putchar(0xD5);
                for (ch=0;ch<5;ch++) putchar(bufdt[ch]);
                Mx=0xFF;
                rx_buffer_usartc0[0]=0xFF;
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;

case 0xD7:
{
//проверка по длинне
 if(rx_wr_index_usartc0==1) 
 {
                if(rx_buffer_usartc0[0]==0xD7)
                             
                {
                //установить время
                //запись даты в переменные
                get_CNTRTC(&X);
                calcDateTime(X, 0, &date1,&time1);
                //date1=rx_buffer_usartc0[0]*100+rx_buffer_usartc0[1];
                //date1=date1*100+rx_buffer_usartc0[2];
                //date1=date1*100+rx_buffer_usartc0[3];
                //CSdt
                //bufdt 
                //
                             
                
                bufdt[0]=time1/10000;
                bufdt[1]=time1%10000/100; 
                bufdt[2]=time1%100;
                //тут же ответ
                for(ch=0,bufdt[3]=0;ch<3;ch++) bufdt[3]=bufdt[3]+bufdt[ch];
                //высылаем пачку
                putchar(0xD7);
                for (ch=0;ch<4;ch++) putchar(bufdt[ch]);
                Mx=0xFF;
                rx_buffer_usartc0[0]=0xFF;
                RX_BUFFER_SIZE_USARTC0=1;
                rx_wr_index_usartc0=0;
                }
                else {Mx=0xFF;RX_BUFFER_SIZE_USARTC0=1;rx_wr_index_usartc0=0;}
   }                         
}
break;



default : 
{
rx_buffer_usartc0[0]=0xFF;
Mx=0xFF;
RX_BUFFER_SIZE_USARTC0=1;
rx_wr_index_usartc0=0;
}
//delay_ms(1);
}


}














//////////////////////////////////////////////////////////////////////////////////////////////////////
// Receive a character from USARTC0
// USARTC0 is used as the default input device by the 'getchar' function
#define _ALTERNATE_GETCHAR_

#pragma used+
char getchar(void)
{
char data;

while (rx_counter_usartc0==0);
data=rx_buffer_usartc0[rx_rd_index_usartc0++];
//#if RX_BUFFER_SIZE_USARTC0 != 256
if (rx_rd_index_usartc0 == RX_BUFFER_SIZE_USARTC0) rx_rd_index_usartc0=0;
//#endif
#asm("cli")
--rx_counter_usartc0;
#asm("sei")
return data;
}
#pragma used-

// Write a character to the USARTC0 Transmitter
// USARTC0 is used as the default output device by the 'putchar' function
#define _ALTERNATE_PUTCHAR_

#pragma used+
void putchar(char c)
{
while ((USARTC0.STATUS & USART_DREIF_bm) == 0);
USARTC0.DATA=c;
}
#pragma used-

// USARTD1 initialization
void usartd1_init(void)
{
// Note: the correct PORTD direction for the RxD, TxD and XCK signals
// is configured in the ports_init function

// Transmitter is enabled
// Set TxD=1
PORTD.OUTSET=0x80;

// Communication mode: Asynchronous USART
// Data bits: 8
// Stop bits: 1
// Parity: Disabled
USARTD1.CTRLC=USART_CMODE_ASYNCHRONOUS_gc | USART_PMODE_DISABLED_gc | USART_CHSIZE_8BIT_gc;

// Receive complete interrupt: Disabled
// Transmit complete interrupt: Disabled
// Data register empty interrupt: Disabled
USARTD1.CTRLA=(USARTD1.CTRLA & (~(USART_RXCINTLVL_gm | USART_TXCINTLVL_gm | USART_DREINTLVL_gm))) |
    USART_RXCINTLVL_OFF_gc | USART_TXCINTLVL_OFF_gc | USART_DREINTLVL_OFF_gc;

// Required Baud rate: 57600
// Real Baud Rate: 57605,8 (x1 Mode), Error: 0,0 %
USARTD1.BAUDCTRLA=0x6E;
USARTD1.BAUDCTRLB=((0x0A << USART_BSCALE_bp) & USART_BSCALE_gm) | 0x08;

// Receiver: Off
// Transmitter: On
// Double transmission speed mode: Off
// Multi-processor communication mode: Off
USARTD1.CTRLB=(USARTD1.CTRLB & (~(USART_RXEN_bm | USART_TXEN_bm | USART_CLK2X_bm | USART_MPCM_bm | USART_TXB8_bm))) |
    USART_TXEN_bm;
}

// Write a character to the USARTD1 Transmitter
#pragma used+
void putchar_usartd1(char c)
{
while ((USARTD1.STATUS & USART_DREIF_bm) == 0);
USARTD1.DATA=c;
}
#pragma used-


//второй usart для меня
void monitor(void)
{
char x;
for(x=0;x<strlen(info);x++)
{
putchar_usartd1(info[x]);
}
memset(info,0,30);
putchar_usartd1(10);
putchar_usartd1(13);
}



