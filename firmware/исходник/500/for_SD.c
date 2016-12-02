
//#include "for_SD.c"


#include <io.h>
#include <delay.h>
#include <stdio.h>
#include <stdlib.h>
#include <ff.h>
#include <string.h>


// Declare your global variables here

/* FAT function result */
FRESULT res;
/* number of bytes written/read to the file */
unsigned int nbytes;
/* will hold the information for logical drive 0: */
FATFS fat;
/* will hold the file information */
FIL file;
/* file path */
char path[]="0:/test.txt";
char SD_IN=1;
/* file read buffer */
char buffer[36];

char SD[15];
char SD1[15];




/* error message list */
flash char * flash error_msg[]=
{
"", /* not used */
"FR_DISK_ERR",
"FR_INT_ERR",
"FR_INT_ERR",
"FR_NOT_READY",
"FR_NO_FILE",
"FR_NO_PATH",
"FR_INVALID_NAME",
"FR_DENIED",
"FR_EXIST",
"FR_INVALID_OBJECT",
"FR_WRITE_PROTECTED",
"FR_INVALID_DRIVE",
"FR_NOT_ENABLED",
"FR_NO_FILESYSTEM",
"FR_MKFS_ABORTED",
"FR_TIMEOUT"
};

/* display error message and stop */
void error(FRESULT res)
{
if ((res>=FR_DISK_ERR) && (res<=FR_TIMEOUT))
   {
   sprintf(info,"ERROR: %p\r\n",error_msg[res]);
   monitor();
   // Дерегистрация и отмена рабочих областей, освобождение порта
   f_mount(0, NULL);
   SD_IN=0;
   PORTC.DIR=0x00;
   PORTC.OUT=0x00;
   PORTC.OUT=0x18;
   PORTC.DIR=0xB9;
   }
/* stop here */
//while(1);
}

