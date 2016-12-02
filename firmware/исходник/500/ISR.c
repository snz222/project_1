//функция создания нового файла
//анализ даты для нового файла в суточках
void GETFILNAME (void)
{
char po;
char da=0;
char newfNAME[15];
sprintf(newfNAME,"0:/%ld.bin",date1);
for(po=0;po<11;po++)
if(newfNAME[po]!=fNAME[po]) {da=1;po=12;}

if (da) 
{
for(po=0;po<15;po++)
fNAME[po]=newfNAME[po];
if ((res=f_open(&file,fNAME,FA_READ|FA_WRITE))==FR_OK) res=f_close(&file);
else 
{
res = f_open(&file,fNAME,FA_CREATE_ALWAYS | FA_WRITE);
res=f_close(&file);
}
}
else ;

}

void bufform (void)
{
char i;
char tim[6];
char potok[36];
//время
sprintf(tim,"%6ld",time1);
//////начало маркер
potok[0]=0xF4;

for(i=1;i<7;i++)
potok[i]=tim[i-1];
////////////////разделитель
potok[7]=0xA5;

potok[8]=potok1[8];
potok[9]=potok1[9];
potok[10]=potok1[10];
potok[11]=potok1[11];
potok[12]=potok1[12];
potok[13]=potok1[13];
potok[14]=potok1[14];
potok[15]=potok1[15];
potok[16]=potok1[16];
potok[17]=potok1[17];
potok[18]=S0[11];
potok[19]=S0[12];
potok[20]=potok1[20];
potok[21]=potok1[21];
potok[22]=S0[15];
potok[23]=S0[16];
potok[24]=potok1[24];
potok[25]=potok1[25];
potok[26]=potok1[26];
potok[27]=potok1[27];
potok[28]=S0[21];
potok[29]=S0[22];
potok[30]=0xB5;

for(i=31;i<31+4;i++)
{
potok[i]=B5buf[i-31];
}


potok[35]=0xF8;
memset(B5buf,0,4);
for(i=0;i<36;i++)
{
buffer[i]=potok[i];
}

}

void check_sd_card (void)
{

if ((res=f_mount(0,&fat))==FR_OK)

{
sprintf(info,"Logical drive 0: mounted OK\r\n",);
monitor();
delay_ms(100);
}

else
  error(res);

if ((res=f_open(&file,path,FA_CREATE_ALWAYS | FA_WRITE))==FR_OK)
   {
   sprintf(info,"File %s created OK\r\n",path);
   monitor();
   SD_IN=1;
   }
else
   {
   error(res);
   SD_IN=0;
   TCF0.INTCTRLA=TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_OFF_gc;
   }


if (SD_IN==1)
{
sprintf(SD,"this is test",);
SD[13]=0x0D;
SD[14]=0x0A;

if ((res=f_write(&file,SD,sizeof(SD)-1,&nbytes))==FR_OK)
 {
   sprintf(info,"%u bytes written of %u\r\n",nbytes,sizeof(SD)-1);
   monitor();
   }
else
   //
   error(res);   
  
sprintf(SD1,"file sd card",);
SD1[13]=0x0D;
SD1[14]=0x0A;
 
if ((res=f_write(&file,SD1,sizeof(SD1)-1,&nbytes))==FR_OK)
   {
   sprintf(info,"%u bytes written of %u\r\n",nbytes,sizeof(SD1)-1);
   monitor();
   }
else

   error(res); 

 

if ((res=f_close(&file))==FR_OK)
   {
   sprintf(info,"File %s closed OK\r\n",path);
   monitor();
   }
else
   /* an error occured, display it and stop */
   error(res);


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

get_CNTRTC(&X);
calcDateTime(X, 0, &date1,&time1);
sprintf(fNAME,"0:/%ld.bin",date1);


bufform();

if ((res=f_open(&file,fNAME,FA_READ)==FR_OK))
{
sprintf(info,"File est yze");
monitor();
}
else
{ 
   if ((res=f_open(&file,fNAME,FA_CREATE_ALWAYS | FA_WRITE))==FR_OK)
   {
   sprintf(info,"File %s created OK\r\n",fNAME);
   monitor();
   }
else
      error(res); 

if ((res=f_write(&file,buffer,sizeof(buffer),&nbytes))==FR_OK)

 {
   sprintf(info,"%u bytes written of %u\r\n",nbytes,sizeof(buffer)-1);
   monitor();
   }
else
    error(res); 

}
  
/*зактрыть файл*/
if ((res=f_close(&file))==FR_OK)
   {
   sprintf(info,"File %s closed OK\r\n",fNAME);
   monitor();
   }
else
   
   error(res);

delay_ms(100);


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

PORTC.OUTSET=0b00010001;
}







// Timer/counter TCC0 Overflow/Underflow interrupt service routine
interrupt [TCC0_OVF_vect] void tcc0_overflow_isr(void)
{
// write your code here
char qw,qi;

if(send&&Mx==0xFF) {topk();delay_us(5);izm=0;}


}

// Timer/counter TCC1 Overflow/Underflow interrupt service routine
interrupt [TCC1_OVF_vect] void tcc1_overflow_isr(void)
{

if(!izm) 
{
izm=1;
RESULT_buf=ad7705(1);
if(RESULT_buf<0) RESULT_buf=32768+RESULT_buf;
else RESULT_buf=-32768+RESULT_buf;
RESULT_sr+=RESULT_buf;
S0[7]=RESULT_buf;// Сигнал  усилителя младший
S0[8]=(RESULT_buf>>8); //Сигнал  усилителя старший
//4*2 АЦП
for (nn=0; nn<CHANNELS; nn++)
{
adca_store[nn]=adca_read(nn);
adca_SD[nn]+=adca_store[nn];
adcb_store[nn]=adcb_read(nn);
adcb_SD[nn]+=adcb_store[nn];
}


S0[1]=adcb_store[0];//adc0 b0 мл ток ФЭУ
S0[2]=adcb_store[0]>>8;// ст

S0[5]=adcb_store[1];//adc1 b1 мл напряжение фэу
S0[6]=adcb_store[1]>>8;// ст  

S0[3]=adcb_store[2];//adc2 b2 мл расход помпы
S0[4]=adcb_store[2]>>8;// ст      

T_analog=(((adcb_store[3]-993)/19.85)+273)*10;

S0[13]=T_analog;//adc3 b3 мл температура контрольн кюветы
S0[14]=T_analog>>8;// ст 


S0[17]=adca_store[0];//adc4 a4 доп ацп
S0[18]=adca_store[0]>>8;// ст

S0[19]=adca_store[1];//adc5 a5 мл доп ацп
S0[20]=adca_store[1]>>8;// ст  

S0[9]=adca_store[2];//adc6 a6 мл доп ацп
S0[10]=adca_store[2]>>8;// ст      

if(SD_IN)
{
//подсчет для усреднения
RESULT_count++; 
////////////////////////////////////////////////////////////////////////////////////////////////////
if(RESULT_count==16)    {  
                        RESULT=RESULT_sr/16;
                        RESULT_count=0;
                        RESULT_sr=0;
                        potok1[14]=RESULT;// Сигнал  усилителя младший;
                        potok1[15]=(RESULT>>8); //Сигнал  усилителя старший
                        
                        
                        
                        
                        
for (nn=0; nn<CHANNELS; nn++)
{
adca_SD[nn]=adca_SD[nn]/16; 
adcb_SD[nn]=adcb_SD[nn]/16;
}



potok1[8]=adcb_SD[0];//adc0 b0 мл ток ФЭУ
potok1[9]=adcb_SD[0]>>8;// ст

potok1[12]=adcb_SD[1];//adc1 b1 мл напряжение фэу
potok1[13]=adcb_SD[1]>>8;// ст  

potok1[10]=adcb_SD[2];//adc2 b2 мл расход помпы
potok1[11]=adcb_SD[2]>>8;// ст

T_analog=(((adcb_SD[3]-993)/19.85)+273)*10; 

potok1[20]=T_analog;//adc3 b3 мл температура контрольн кюветы
potok1[21]=T_analog>>8;// ст
 
//potok1[20]=adcb_SD[3];//adc3 b3 мл температура контрольн кюветы
//potok1[21]=adcb_SD[3]>>8;// ст  

potok1[24]=adca_SD[0];//adc4 a4 доп ацп
potok1[25]=adca_SD[0]>>8;// ст

potok1[26]=adca_SD[1];//adc5 a5 мл доп ацп
potok1[27]=adca_SD[1]>>8;// ст  

potok1[16]=adca_SD[2];//adc6 a6 мл доп ацп
potok1[17]=adca_SD[2]>>8;// ст      


for (nn=0; nn<CHANNELS; nn++)
{
adca_SD[nn]=0;
adcb_SD[nn]=0;
} 

                    
} 
}

}


else 
{
;
}


}

// Timer/counter TCD0 Overflow/Underflow interrupt service routine
interrupt [TCD0_OVF_vect] void tcd0_overflow_isr(void)
{
if(SD_IN)
disk_timerproc();
}

//  прерывание по секунде от таймера
interrupt [TCF0_OVF_vect] void tcf0_overflow_isr(void)
{
if(SD_IN==1)
{
res = f_open(&file,fNAME,FA_READ|FA_WRITE);
res = f_lseek(&file, file.fsize);

res=f_write(&file,buffer,sizeof(buffer),&nbytes);
res=f_close(&file);    
}
error(res);


}   





