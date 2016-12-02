//адреса наших микросхем
#define PCA9557D_U1 (0x30>>1)
#define PCA9557D_U2 (0x32>>1)
#define PCA9557D_U3 (0x34>>1)
//необходимые библиотеки
#include <io.h>
#include <stdio.h>

char error_buf=0;

        struct
            {
            unsigned char control;
            unsigned char input;
            } U1in;   
        
        struct
            {
            unsigned char control;
            unsigned char output;
            } U1out; 
        
         
        struct
            {
            unsigned char control;
            unsigned char io;
            } U1io; 
         
         struct
            {
            unsigned char control;
            unsigned char data;
            } U1ne_invert;
         ////////////////////////////////U1////////////////////////////////////              
         
         ////////////////////////////////U2////////////////////////////////////
        struct
            {
            unsigned char control;
            unsigned char input;
            } U2in;   
        
        struct
            {
            unsigned char control;
            unsigned char output;
            } U2out; 
        
         
        struct
            {
            unsigned char control;
            unsigned char io;
            } U2io; 
         
         struct
            {
            unsigned char control;
            unsigned char data;
            } U2ne_invert;
         ////////////////////////////////U2////////////////////////////////////   
         
          ////////////////////////////////U3////////////////////////////////////
        struct
            {
            unsigned char control;
            unsigned char input;
            } U3in;   
        
        struct
            {
            unsigned char control;
            unsigned char output;
            } U3out; 
        
         
        struct
            {
            unsigned char control;
            unsigned char io;
            } U3io; 
         
         struct
            {
            unsigned char control;
            unsigned char data;
            } U3ne_invert;
         ////////////////////////////////U3////////////////////////////////////     


///////////////////111111111111111111111111111111111111111111111111//////////////////////////////////


//из буфера U1 мы читаем биты 1,4,5
//пишим биты 0,2,3,6,7
//настройка конфигурации =0x32

//инициализация буфера U1
void init_buferU1 (void)
{
//запрещаем инверсию

U1ne_invert.control=0x02;
U1ne_invert.data=0x00;

twi_master_trans(
     &twie_master,
     PCA9557D_U1,
    (unsigned char *)&U1ne_invert,2,
    0, 0);

//настройка входов выходов            
U1io.control=0x03;
U1io.io=0x32;   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
twi_master_trans(
     &twie_master,
     PCA9557D_U1,
    (unsigned char *)&U1io,2,
    0, 0);             
}

//опрос буфера U1
void buferU1_opros(void)
{
U1in.control=0x00;
twi_master_trans(
     &twie_master,
     PCA9557D_U1,
    (unsigned char *)&U1in.control,1,
    (unsigned char *)&U1in.input, 1); 
//ответ храниться в U1in.input
}

//установка выходов буфера U1
//значение должно храниться в U1out.output
void buferU1_set(void)
{
U1out.control=0x01;
twi_master_trans(
     &twie_master,
     PCA9557D_U1,
    (unsigned char *)&U1out,2,
    0, 0);
}


//из буфера U2 мы читаем биты 7,3,4
//пишим биты 0,1,2,5,6
//настройка конфигурации =0x98

//инициализация буфера U2
void init_buferU2 (void)
{
//запрещаем инверсию
U2ne_invert.control=0x02;
U2ne_invert.data=0x00;

twi_master_trans(
     &twie_master,
     PCA9557D_U2,
    (unsigned char *)&U2ne_invert,2,
    0, 0);

//настройка входов выходов            
U2io.control=0x03;
U2io.io=0x98;
twi_master_trans(
     &twie_master,
     PCA9557D_U2,
    (unsigned char *)&U2io,2,
    0, 0);             
}

//опрос буфера U2
void buferU2_opros(void)
{
U2in.control=0x00;
twi_master_trans(
     &twie_master,
     PCA9557D_U2,
    (unsigned char *)&U2in.control,1,
    (unsigned char *)&U2in.input, 1); 
//ответ храниться в U2in.input
}



//установка выходов буфера U2
//значение должно храниться в U2out.output
void buferU2_set(void)
{
U2out.control=0x01;
twi_master_trans(
     &twie_master,
     PCA9557D_U2,
    (unsigned char *)&U2out,2,
    0, 0);
}

///////////////////2222222222222222222222222222222222222222222222222222//////////////////////////////





///////////////////333333333333333333333333333333333333333333333333333//////////////////////////////////


//из буфера U3 мы читаем биты 6
//пишим биты 0,1,2,3,4,5,7
//настройка конфигурации =0x40

//инициализация буфера U3
void init_buferU3 (void)
{
//запрещаем инверсию
U3ne_invert.control=0x02;
U3ne_invert.data=0x00;

twi_master_trans(
     &twie_master,
     PCA9557D_U3,
    (unsigned char *)&U3ne_invert,2,
    0, 0);

//настройка входов выходов            
U3io.control=0x03;
U3io.io=0x40;
twi_master_trans(
     &twie_master,
     PCA9557D_U3,
    (unsigned char *)&U3io,2,
    0, 0);             
}

//опрос буфера U3
void buferU3_opros(void)
{
U3in.control=0x00;
twi_master_trans(
     &twie_master,
     PCA9557D_U3,
    (unsigned char *)&U3in.control,1,
    (unsigned char *)&U3in.input, 1); 
//ответ храниться в U3in.input
}



//установка выходов буфера U3
//значение должно храниться в U2out.output
void buferU3_set(void)
{
U3out.control=0x01;
twi_master_trans(
     &twie_master,
     PCA9557D_U3,
    (unsigned char *)&U3out,2,
    0, 0);
}

///////////////////333333333333333333333333333333333333333333333333333333//////////////////////////////
