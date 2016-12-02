// RTC32 initialization

#define RTC32_XOSC_FAILED 0
#define RTC32_BATT_FAILED 1
#define RTC32_COUNT_OK 2
#define RTC32_DISABLED 3
long unsigned int X;
long unsigned int date1;
bool newdate=0;
bool newtime=0;
long unsigned int time1;
eeprom long unsigned int Xsave;
unsigned char bufdt[5];


void get_CNTRTC(long unsigned int * X)
{
RTC32.SYNCCTRL = RTC32_SYNCCNT_bm;
while (RTC32.SYNCCTRL & RTC32_SYNCCNT_bm);
*X=RTC32.CNT;
}

 
unsigned char rtc32_battery_backup_init(void)
{
unsigned char status,s,n,result=RTC32_COUNT_OK;

// Save the Battery Backup System status
status=VBAT.STATUS;
// Reset the Battery Backup Power-On Flag if it's not valid
if (status & VBAT_BBPWR_bm) status&= ~VBAT_BBPORF_bm;

// Optimize for speed
#pragma optsize- 
// Save interrupts enabled/disabled state
s=SREG;
// Disable interrupts
#asm("cli")

// Check if the Battery Backup System had a failure or is not enabled
if (status & (VBAT_BBBORF_bm | VBAT_BBPORF_bm))
   {
   // Signal that the backup battery had a failure
   if (status & VBAT_BBBORF_bm) result=RTC32_BATT_FAILED;
   set_rtc32:
   // Enable the Battery Backup System access and apply a RESET
   n=(VBAT.CTRL & (~(VBAT_XOSCSEL_bm | VBAT_XOSCEN_bm | VBAT_XOSCFDEN_bm))) |
     VBAT_ACCEN_bm | VBAT_RESET_bm;
   CCP=CCP_IOREG_gc;
   VBAT.CTRL=n;
   // External 32.768 kHz crystal oscillator low power mode: On
   OSC.XOSCCTRL|=OSC_X32KLPM_bm;
   // Enable the 32.768 kHz external oscillator
   // RTC32 clock frequency: 1024 Hz
   n=(n & (~VBAT_RESET_bm)) | VBAT_XOSCSEL_bm | VBAT_XOSCEN_bm;
   CCP=CCP_IOREG_gc;
   VBAT.CTRL=n;

   // Wait for the external 32.768 kHz crystal oscillator to stabilize
   while ((VBAT.STATUS & VBAT_XOSCRDY_bm)==0);

   // Enable the 32.768 kHz external oscillator failure detector
   n|=VBAT_XOSCFDEN_bm;
   CCP=CCP_IOREG_gc;
   VBAT.CTRL=n;

   // Make sure that the RTC32 is disabled before initializing it
   RTC32.CTRL=(0<<RTC32_ENABLE_bp);

   // Wait until the RTC32 is not busy or synchronizing
   while (RTC32.SYNCCTRL & (RTC32_SYNCBUSY_bm | RTC32_SYNCCNT_bm));

   // Set the RTC32 period register
   RTC32.PER=0x1400;
   // Set the RTC32 count register
   RTC32.CNT=0x0000;
   // Start the synchronization of the CNT register from
   // the RTC32 clock to the System Clock domain
   RTC32.SYNCCTRL|=RTC32_SYNCCNT_bm;
   // Set the RTC32 compare register
   RTC32.COMP=0x0400;

   // Enable the RTC32
   RTC32.CTRL=(1<<RTC32_ENABLE_bp);

   // RTC32 overflow interrupt: Disabled
   // RTC32 compare interrupt: Low Level
   RTC32.INTCTRL=RTC32_OVFINTLVL_OFF_gc | RTC32_COMPINTLVL_LO_gc;
   }
else
   {
   // The Battery Backup System has not had any power loss
   n=VBAT.CTRL | VBAT_ACCEN_bm;

   // Ensure that the external 32.768 kHz crystal oscillator
   // and its failure detection are enabled
   if ((n & (VBAT_XOSCEN_bm | VBAT_XOSCFDEN_bm)) != (VBAT_XOSCEN_bm | VBAT_XOSCFDEN_bm))
      goto set_rtc32;

   // Enable Battery Backup System access
   CCP=CCP_IOREG_gc;
   VBAT.CTRL=n;

   // Check for external 32.768 kHz crystal oscillator failure
   if (status & VBAT_XOSCFAIL_bm)
      {
      // Yes, the external 32.768 kHz crystal oscillator has had a failure,
      // the RTC counter value is invalid, so it must be initialized again

      // Wait until the RTC32 is not busy or synchronizing
      while (RTC32.SYNCCTRL & (RTC32_SYNCBUSY_bm | RTC32_SYNCCNT_bm));

      // Set the RTC32 count register
      RTC32.CNT=0x0000;
      // Start the synchronization of the CNT register from
      // the RTC32 clock to the System Clock domain
      RTC32.SYNCCTRL|=RTC32_SYNCCNT_bm;

      // Signal that the RTC32 was re-initialized because the
      // 32.768 kHz external oscillator has had a failure
      result=RTC32_XOSC_FAILED;
      }
   }

// Clear the status bits
VBAT.STATUS=VBAT.STATUS;

// Disable further Battery Backup System access
n=VBAT.CTRL & (~VBAT_ACCEN_bm);
CCP=CCP_IOREG_gc;
VBAT.CTRL=n;

// Restore interrupts enabled/disabled state
SREG=s;
// Restore optimization for size if needed
#pragma optsize_default

return result;
}



void rtc32_init_my(void)
{
   unsigned char n;
  // Enable Battery Backup System access
   CCP=CCP_IOREG_gc;
   VBAT.CTRL=VBAT.CTRL | VBAT_ACCEN_bm;;
    
   // External 32.768 kHz crystal oscillator low power mode: Off
   OSC.XOSCCTRL&= ~OSC_X32KLPM_bm;
   // Enable the 32.768 kHz external oscillator
   // RTC32 clock frequency: 1024 Hz
   //n=(n & (~VBAT_RESET_bm)) | VBAT_XOSCSEL_bm | VBAT_XOSCEN_bm;
   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   // RTC32 clock frequency: 1 Hz
   n=(n & (~VBAT_RESET_bm)) | VBAT_XOSCEN_bm;
  
   
   CCP=CCP_IOREG_gc;
   VBAT.CTRL=n;

   // Wait for the external 32.768 kHz crystal oscillator to stabilize
   while ((VBAT.STATUS & VBAT_XOSCRDY_bm)==0);

   // Enable the 32.768 kHz external oscillator failure detector
   n|=VBAT_XOSCFDEN_bm;
   CCP=CCP_IOREG_gc;
   VBAT.CTRL=n;

   // Make sure that the RTC32 is disabled before initializing it
   RTC32.CTRL=(0<<RTC32_ENABLE_bp);

   // Wait until the RTC32 is not busy or synchronizing
   while (RTC32.SYNCCTRL & (RTC32_SYNCBUSY_bm | RTC32_SYNCCNT_bm));

   // Set the RTC32 period register
   //!RTC32.PER=0x1400;
   RTC32.PER=0xFFFFFFFF;
   // Set the RTC32 count register
   //при включении время опять установиться, я закаментил строку
   //RTC32.CNT=1111111111;    //18 марта 2005 года, 01:58:31 
   // Start the synchronization of the CNT register from
   // the RTC32 clock to the System Clock domain
   RTC32.SYNCCTRL|=RTC32_SYNCCNT_bm;
   // Set the RTC32 compare register
   RTC32.COMP=0x0000;

   // Enable the RTC32
   RTC32.CTRL=(1<<RTC32_ENABLE_bp);

   // RTC32 overflow interrupt: Medium Level _OFF_gc
   // RTC32 compare interrupt: Disabled _MED_gc 
   RTC32.INTCTRL=RTC32_OVFINTLVL_OFF_gc | RTC32_COMPINTLVL_OFF_gc;
}


//RTC32.CNT=1111111111;    //18 марта 2005 года, 01:58:31 
void set_CNTRTC(void)
{
CCP=CCP_IOREG_gc;
//RTC32 is disabled t
RTC32.CTRL=(0<<RTC32_ENABLE_bp);
// Wait until the RTC32 is not busy or synchronizing
while (RTC32.SYNCCTRL & (RTC32_SYNCBUSY_bm | RTC32_SYNCCNT_bm));
RTC32.PER=0xFFFFFFFF;
RTC32.CNT=X;
// the RTC32 clock to the System Clock domain
RTC32.SYNCCTRL|=RTC32_SYNCCNT_bm;
// Enable the RTC32
RTC32.CTRL=(1<<RTC32_ENABLE_bp);
}










void calcDateTime(long seconds, long hours_to_gm, long unsigned int * date, long unsigned int * time)
{
   long daysmonth[] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
   long secs_per_year  = 365 * 24 * 3600;
   long secs_per_month = 31 * 24 * 3600;
   long year           = 1970;
   long month          = 1;
   long day            = 1;
   long hours          = 0;
   long minutes        = 0;
   long leap           = 0 ;

   // adjust seconds to localtime
   seconds -= hours_to_gm * 3600;
   // year
   for ( ; seconds > secs_per_year; ++year, seconds -= secs_per_year)
   {
       leap = ((year)%4 == 0 && ((year%100 != 0) || (year%400 == 0)))? 1 : 0;
       secs_per_year = (365 + leap) * 24 * 3600;
   }   
   // month 
   leap = ((year)%4 == 0 && ((year%100 != 0) || (year%400 == 0)))? 1 : 0;
   daysmonth[2] = (leap)? 29 : 28;
   for ( ; seconds >= secs_per_month; ++month, seconds -= secs_per_month)
   {
       secs_per_month = daysmonth[month]*24*3600;
   }    
   // day
   day = (seconds / (24 * 3600) ) + 1;
   seconds = seconds % (24 * 3600) ;

   hours   = seconds / 3600;
   seconds = seconds % 3600;

   minutes = seconds / 60;
   seconds = seconds % 60;

   *date   = year * 10000 + month * 100 + day;
   *time   = hours * 10000 + minutes * 100 + seconds;
                                                                        
}

void calcSeconds(long unsigned int date, long unsigned int time, long unsigned int hours_to_gm, long unsigned int * seconds)
{
   long daysmonth[] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
   long year           = date/10000;
   long month          = (date%10000)/100;
   long day            = date%100;
   long hours          = time/10000;
   long minutes        = (time%10000)/100;
   long leap           = ((year)%4 == 0 && ((year%100 != 0) || (year%400 == 0)))? 1 : 0;;

   *seconds            = time%100 + minutes * 60 + (hours + hours_to_gm) * 3600 + (day - 1) * 24 * 3600;

   // month 
   daysmonth[2] = (leap)? 29 : 28;
   for ( month = month-1; month > 0; --month)
   {
       *seconds += daysmonth[month] * 24 * 3600;
   }    

   // year
   for (year = year-1; year >= 1970; --year)
   {
       leap = ((year)%4 == 0 && ((year%100 != 0) || (year%400 == 0)))? 1 : 0;
       *seconds += (365 + leap) * 24 * 3600;
   }   
                                                                   
}


