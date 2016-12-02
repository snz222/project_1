void tc0_disable(TC0_t *ptc)
{
// Timer/Counter off
ptc->CTRLA=(ptc->CTRLA & (~TC0_CLKSEL_gm)) | TC_CLKSEL_OFF_gc;
// Issue a reset command
ptc->CTRLFSET=TC_CMD_RESET_gc;
}

void tc1_disable(TC1_t *ptc)
{
// Timer/Counter off
ptc->CTRLA=(ptc->CTRLA & (~TC1_CLKSEL_gm)) | TC_CLKSEL_OFF_gc;
// Issue a reset command
ptc->CTRLFSET=TC_CMD_RESET_gc;
}


// Timer/Counter TCC0 initialization
void tcc0_init(void)
{
unsigned char s;
unsigned char n;

// Note: the correct PORTC direction for the Compare Channels outputs
// is configured in the ports_init function

// Save interrupts enabled/disabled state
s=SREG;
// Disable interrupts
#asm("cli")

// Disable and reset the timer/counter just to be sure
//tc0_disable(&TCC0);
// Clock source: Peripheral Clock/64
TCC0.CTRLA=(TCC0.CTRLA & (~TC0_CLKSEL_gm)) | TC_CLKSEL_DIV64_gc;
// Mode: Normal Operation, Overflow Int./Event on TOP
// Compare/Capture on channel A: Off
// Compare/Capture on channel B: Off
// Compare/Capture on channel C: Off
// Compare/Capture on channel D: Off
TCC0.CTRLB=(TCC0.CTRLB & (~(TC0_CCAEN_bm | TC0_CCBEN_bm | TC0_CCCEN_bm | TC0_CCDEN_bm | TC0_WGMODE_gm))) |
    TC_WGMODE_NORMAL_gc;

// Capture event source: None
// Capture event action: None
TCC0.CTRLD=(TCC0.CTRLD & (~(TC0_EVACT_gm | TC0_EVSEL_gm))) |
    TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;

// Overflow interrupt: High Level
// Error interrupt: Disabled
TCC0.INTCTRLA=(TCC0.INTCTRLA & (~(TC0_ERRINTLVL_gm | TC0_OVFINTLVL_gm))) |
    TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_LO_gc;   //////////////////////////////////////////hi

// Compare/Capture channel A interrupt: Disabled
// Compare/Capture channel B interrupt: Disabled
// Compare/Capture channel C interrupt: Disabled
// Compare/Capture channel D interrupt: Disabled
TCC0.INTCTRLB=(TCC0.INTCTRLB & (~(TC0_CCDINTLVL_gm | TC0_CCCINTLVL_gm | TC0_CCBINTLVL_gm | TC0_CCAINTLVL_gm))) |
    TC_CCDINTLVL_OFF_gc | TC_CCCINTLVL_OFF_gc | TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;

// High resolution extension: Off
//HIRESC.CTRL&= ~HIRES_HREN0_bm;

// Advanced Waveform Extension initialization
// Optimize for speed
#pragma optsize- 
// Disable locking the AWEX configuration registers just to be sure
n=MCU.AWEXLOCK & (~MCU_AWEXCLOCK_bm);
CCP=CCP_IOREG_gc;
MCU.AWEXLOCK=n;
// Restore optimization for size if needed
#pragma optsize_default

// Pattern generation: Off
// Dead time insertion: Off
AWEXC.CTRL&= ~(AWEX_PGM_bm | AWEX_CWCM_bm | AWEX_DTICCDEN_bm | AWEX_DTICCCEN_bm | AWEX_DTICCBEN_bm | AWEX_DTICCAEN_bm);

// Fault protection initialization
// Fault detection on OCD Break detection: On
// Fault detection restart mode: Latched Mode
// Fault detection action: None (Fault protection disabled)
AWEXC.FDCTRL=(AWEXC.FDCTRL & (~(AWEX_FDDBD_bm | AWEX_FDMODE_bm | AWEX_FDACT_gm))) |
    AWEX_FDACT_NONE_gc;
// Fault detect events: 
// Event channel 0: Off
// Event channel 1: Off
// Event channel 2: Off
// Event channel 3: Off
// Event channel 4: Off
// Event channel 5: Off
// Event channel 6: Off
// Event channel 7: Off
AWEXC.FDEVMASK=0b00000000;
// Make sure the fault detect flag is cleared
AWEXC.STATUS|=AWEXC.STATUS & AWEX_FDF_bm;

// Clear the interrupt flags
TCC0.INTFLAGS=TCC0.INTFLAGS;
// Set counter register
TCC0.CNT=0x0000;
// Set period register
TCC0.PER=0x7A11;
// Set channel A Compare/Capture register
TCC0.CCA=0x0000;
// Set channel B Compare/Capture register
TCC0.CCB=0x0000;
// Set channel C Compare/Capture register
TCC0.CCC=0x0000;
// Set channel D Compare/Capture register
TCC0.CCD=0x0000;

// Restore interrupts enabled/disabled state
SREG=s;
}




// Timer/Counter TCC1 initialization
void tcc1_init(void)

{
unsigned char s;

// Note: the correct PORTC direction for the Compare Channels outputs
// is configured in the ports_init function

// Save interrupts enabled/disabled state
s=SREG;
// Disable interrupts
#asm("cli")

// Disable and reset the timer/counter just to be sure
tc1_disable(&TCC1);
// Clock source: ClkPer/64
//40ms!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
TCC1.CTRLA=TC_CLKSEL_DIV64_gc;
// Mode: Normal Operation, Overflow Int./Event on TOP
// Compare/Capture on channel A: Off
// Compare/Capture on channel B: Off
TCC1.CTRLB=(0<<TC1_CCBEN_bp) | (0<<TC1_CCAEN_bp) |
	TC_WGMODE_NORMAL_gc;
// Capture event source: None
// Capture event action: None
TCC1.CTRLD=TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;

// Set Timer/Counter in Normal mode
TCC1.CTRLE=(0<<TC1_BYTEM_bp);

// Overflow interrupt: Disabled
// Error interrupt: Disabled
//TCC1.INTCTRLA=TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_OFF_gc;
TCC1.INTCTRLA=(TCC1.INTCTRLA & (~(TC1_ERRINTLVL_gm | TC1_OVFINTLVL_gm))) |
    TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_LO_gc; 

// Compare/Capture channel A interrupt: Disabled
// Compare/Capture channel B interrupt: Disabled
TCC1.INTCTRLB=TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;

// High resolution extension: Off
HIRESC.CTRLA&= ~HIRES_HREN1_bm;

// Clear the interrupt flags
TCC1.INTFLAGS=TCC1.INTFLAGS;
// Set Counter register
TCC1.CNT=0x0000;
// Set Period register

//40ms!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
TCC1.PER=0x4E1F;// n
// Set channel A Compare/Capture register
TCC1.CCA=0x0000;
// Set channel B Compare/Capture register
TCC1.CCB=0x0000;

// Restore interrupts enabled/disabled state
SREG=s;
}
// Timer/Counter TCD0 initialization
// Timer/Counter TCD0 initialization
void tcd0_init(void)
{
unsigned char s;

// Note: The correct PORTD direction for the Compare Channels
// outputs is configured in the ports_init function.

// Save interrupts enabled/disabled state
s=SREG;
// Disable interrupts
#asm("cli")

// Disable and reset the timer/counter just to be sure
tc0_disable(&TCD0);
// Clock source: ClkPer/8
TCD0.CTRLA=TC_CLKSEL_DIV8_gc;
// Mode: Normal Operation, Overflow Int./Event on TOP
// Compare/Capture on channel A: Off
// Compare/Capture on channel B: Off
// Compare/Capture on channel C: Off
// Compare/Capture on channel D: Off
TCD0.CTRLB=(0<<TC0_CCDEN_bp) | (0<<TC0_CCCEN_bp) | (0<<TC0_CCBEN_bp) | (0<<TC0_CCAEN_bp) |
	TC_WGMODE_NORMAL_gc;
// Capture event source: None
// Capture event action: None
TCD0.CTRLD=TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;

// Set Timer/Counter in Normal mode
TCD0.CTRLE=(0<<TC0_BYTEM_bp);

// Overflow interrupt: High Level
// Error interrupt: Disabled
TCD0.INTCTRLA=TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_HI_gc;

// Compare/Capture channel A interrupt: Disabled
// Compare/Capture channel B interrupt: Disabled
// Compare/Capture channel C interrupt: Disabled
// Compare/Capture channel D interrupt: Disabled
TCD0.INTCTRLB=TC_CCDINTLVL_OFF_gc | TC_CCCINTLVL_OFF_gc | TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;

// High resolution extension: Off
HIRESD.CTRLA&= ~HIRES_HREN0_bm;

// Clear the interrupt flags
TCD0.INTFLAGS=TCD0.INTFLAGS;
// Set Counter register
TCD0.CNT=0x0000;
// Set Period register
TCD0.PER=0x9C3F;
// Set channel A Compare/Capture register
TCD0.CCA=0x0000;
// Set channel B Compare/Capture register
TCD0.CCB=0x0000;
// Set channel C Compare/Capture register
TCD0.CCC=0x0000;
// Set channel D Compare/Capture register
TCD0.CCD=0x0000;

// Restore interrupts enabled/disabled state
SREG=s;
}


// Timer/Counter TCF0 initialization
void tcf0_init(void)
{
unsigned char s;

// Note: The correct PORTF direction for the Compare Channels
// outputs is configured in the ports_init function.

// Save interrupts enabled/disabled state
s=SREG;
// Disable interrupts
#asm("cli")

// Disable and reset the timer/counter just to be sure
tc0_disable(&TCF0);
// Clock source: ClkPer/1024
TCF0.CTRLA=TC_CLKSEL_DIV1024_gc;
// Mode: Normal Operation, Overflow Int./Event on TOP
// Compare/Capture on channel A: Off
// Compare/Capture on channel B: Off
// Compare/Capture on channel C: Off
// Compare/Capture on channel D: Off
TCF0.CTRLB=(0<<TC0_CCDEN_bp) | (0<<TC0_CCCEN_bp) | (0<<TC0_CCBEN_bp) | (0<<TC0_CCAEN_bp) |
	TC_WGMODE_NORMAL_gc;
// Capture event source: None
// Capture event action: None
TCF0.CTRLD=TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;

// Set Timer/Counter in Normal mode
TCF0.CTRLE=(0<<TC0_BYTEM_bp);

// Overflow interrupt: hi Level
// Error interrupt: Disabled
TCF0.INTCTRLA=TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_HI_gc;

// Compare/Capture channel A interrupt: Disabled
// Compare/Capture channel B interrupt: Disabled
// Compare/Capture channel C interrupt: Disabled
// Compare/Capture channel D interrupt: Disabled
TCF0.INTCTRLB=TC_CCDINTLVL_OFF_gc | TC_CCCINTLVL_OFF_gc | TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;

// High resolution extension: Off
HIRESF.CTRLA&= ~HIRES_HREN0_bm;

// Clear the interrupt flags
TCF0.INTFLAGS=TCF0.INTFLAGS;
// Set Counter register
TCF0.CNT=0x0000;
// Set Period register
// 1 cek
TCF0.PER=0x7A11;
//999 ms
//TCF0.PER=0x79F2;
// Set channel A Compare/Capture register
TCF0.CCA=0x0000;
// Set channel B Compare/Capture register
TCF0.CCB=0x0000;
// Set channel C Compare/Capture register
TCF0.CCC=0x0000;
// Set channel D Compare/Capture register
TCF0.CCD=0x0000;

// Restore interrupts enabled/disabled state
SREG=s;
}

