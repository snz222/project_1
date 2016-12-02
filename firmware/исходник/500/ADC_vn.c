// Function used to read the calibration byte from the
// signature row, specified by 'index'
#pragma optsize-
unsigned char read_calibration_byte(unsigned char index)
{
unsigned char r;
NVM.CMD=NVM_CMD_READ_CALIB_ROW_gc;
r=*((flash unsigned char*) index);
// Clean up NVM command register
NVM.CMD=NVM_CMD_NO_OPERATION_gc;
return r;
}
#pragma optsize_default

// ADCA initialization
void adca_init(void)
{
// ADCA is enabled
// Resolution: 12 Bits
// Load the calibration value for 12 Bit resolution
// from the signature row
ADCA.CALL=read_calibration_byte(PROD_SIGNATURES_START+ADCACAL0_offset);
ADCA.CALH=read_calibration_byte(PROD_SIGNATURES_START+ADCACAL1_offset);

// Free Running mode: Off
// Conversion mode: Unsigned
ADCA.CTRLB=(0<<ADC_CONMODE_bp) | ADC_RESOLUTION_12BIT_gc;

// Clock frequency: 1000,000 kHz
ADCA.PRESCALER=ADC_PRESCALER_DIV32_gc;

// Reference: Internal Vcc/1.6
// Temperature reference: On
ADCA.REFCTRL=ADC_REFSEL_VCC_gc | (1<<ADC_TEMPREF_bp) | (0<<ADC_BANDGAP_bp);

// Initialize the ADC Compare register
ADCA.CMPL=0x00;
ADCA.CMPH=0x00;

// ADC channel 0 gain: 1
// ADC channel 0 input mode: Single-ended positive input signal
ADCA.CH0.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;

// ADC channel 0 positive input: ADC4 pin
// ADC channel 0 negative input: GND
ADCA.CH0.MUXCTRL=ADC_CH_MUXPOS_PIN4_gc;

// ADC channel 1 gain: 1
// ADC channel 1 input mode: Single-ended positive input signal
ADCA.CH1.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;

// ADC channel 1 positive input: ADC5 pin
// ADC channel 1 negative input: GND
ADCA.CH1.MUXCTRL=ADC_CH_MUXPOS_PIN5_gc;

// ADC channel 2 gain: 1
// ADC channel 2 input mode: Single-ended positive input signal
ADCA.CH2.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;

// ADC channel 2 positive input: ADC6 pin
// ADC channel 2 negative input: GND
ADCA.CH2.MUXCTRL=ADC_CH_MUXPOS_PIN6_gc;

// ADC channel 3 gain: 1
// ADC channel 3 input mode: Single-ended positive input signal
ADCA.CH3.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;

// ADC channel 3 positive input: ADC7 pin
// ADC channel 3 negative input: GND
ADCA.CH3.MUXCTRL=ADC_CH_MUXPOS_PIN7_gc;

// AD conversion is started by software
ADCA.EVCTRL=ADC_EVACT_NONE_gc;

// Channel 0 interrupt: Disabled
ADCA.CH0.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
// Channel 1 interrupt: Disabled
ADCA.CH1.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
// Channel 2 interrupt: Disabled
ADCA.CH2.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
// Channel 3 interrupt: Disabled
ADCA.CH3.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;

// Enable the ADC
ADCA.CTRLA|=ADC_ENABLE_bm;
// Insert a delay to allow the ADC common mode voltage to stabilize
delay_us(2);
}

// ADCA channel data read function using polled mode
unsigned int adca_read(unsigned char channel)
{
ADC_CH_t *pch=&ADCA.CH0+channel;
unsigned int data;

// Start the AD conversion
pch->CTRL|= 1<<ADC_CH_START_bp;
// Wait for the AD conversion to complete
while ((pch->INTFLAGS & ADC_CH_CHIF_bm)==0);
// Clear the interrupt flag
pch->INTFLAGS=ADC_CH_CHIF_bm;
// Read the AD conversion result
((unsigned char *) &data)[0]=pch->RESL;
((unsigned char *) &data)[1]=pch->RESH;
return data;
}

// ADCA sweeped channel(s) data read function
// for software triggered mode
void adca_sweep_read(unsigned char nch, unsigned int *pdata)
{
ADC_CH_t *pch=&ADCA.CH0;
unsigned char i,j,m;

// Sweep starts with channel 0
j=ADC_CH0START_bm;
// Prepare the AD conversion start mask for the sweeped channel(s)
m=0;
i=0;
do
  {
  m|=j;
  j<<=1;
  }
while (++i<nch);
// Ensure the interrupt flags are cleared
ADCA.INTFLAGS=ADCA.INTFLAGS;
// Start the AD conversion for the sweeped channel(s)
ADCA.CTRLA=(ADCA.CTRLA & (ADC_DMASEL_gm | ADC_FLUSH_bm | ADC_ENABLE_bm)) | m;
// Read and store the AD conversion results for all the sweeped channels
for (i=0; i<nch; i++)
    {
    // Wait for the AD conversion to complete
    while ((pch->INTFLAGS & ADC_CH_CHIF_bm)==0);
    // Clear the interrupt flag
    pch->INTFLAGS=ADC_CH_CHIF_bm;
    // Read the AD conversion result
    ((unsigned char *) pdata)[0]=pch->RESL;
    ((unsigned char *) pdata)[1]=pch->RESH;
    pdata++;
    pch++;
    }
}

// ADCB initialization
void adcb_init(void)
{
// ADCB is enabled
// Resolution: 12 Bits
// Load the calibration value for 12 Bit resolution
// from the signature row
ADCB.CALL=read_calibration_byte(PROD_SIGNATURES_START+ADCBCAL0_offset);
ADCB.CALH=read_calibration_byte(PROD_SIGNATURES_START+ADCBCAL1_offset);

// Free Running mode: Off
// Conversion mode: Unsigned
ADCB.CTRLB=(0<<ADC_CONMODE_bp) | ADC_RESOLUTION_12BIT_gc;

// Clock frequency: 1000,000 kHz
ADCB.PRESCALER=ADC_PRESCALER_DIV32_gc;

// Reference: Internal Vcc/1.6
// Temperature reference: Off
ADCB.REFCTRL=ADC_REFSEL_VCC_gc | (0<<ADC_TEMPREF_bp) | (0<<ADC_BANDGAP_bp);

// Initialize the ADC Compare register
ADCB.CMPL=0x00;
ADCB.CMPH=0x00;

// ADC channel 0 gain: 1
// ADC channel 0 input mode: Single-ended positive input signal
ADCB.CH0.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;

// ADC channel 0 positive input: ADC0 pin
// ADC channel 0 negative input: GND
ADCB.CH0.MUXCTRL=ADC_CH_MUXPOS_PIN0_gc;

// ADC channel 1 gain: 1
// ADC channel 1 input mode: Single-ended positive input signal
ADCB.CH1.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;

// ADC channel 1 positive input: ADC1 pin
// ADC channel 1 negative input: GND
ADCB.CH1.MUXCTRL=ADC_CH_MUXPOS_PIN1_gc;

// ADC channel 2 gain: 1
// ADC channel 2 input mode: Single-ended positive input signal
ADCB.CH2.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;

// ADC channel 2 positive input: ADC2 pin
// ADC channel 2 negative input: GND
ADCB.CH2.MUXCTRL=ADC_CH_MUXPOS_PIN2_gc;

// ADC channel 3 gain: 1
// ADC channel 3 input mode: Single-ended positive input signal
ADCB.CH3.CTRL=(0<<ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc;

// ADC channel 3 positive input: ADC3 pin
// ADC channel 3 negative input: GND
ADCB.CH3.MUXCTRL=ADC_CH_MUXPOS_PIN3_gc;

// AD conversion is started by software
ADCB.EVCTRL=ADC_EVACT_NONE_gc;

// Channel 0 interrupt: Disabled
ADCB.CH0.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
// Channel 1 interrupt: Disabled
ADCB.CH1.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
// Channel 2 interrupt: Disabled
ADCB.CH2.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;
// Channel 3 interrupt: Disabled
ADCB.CH3.INTCTRL=ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc;

// Enable the ADC
ADCB.CTRLA|=ADC_ENABLE_bm;
// Insert a delay to allow the ADC common mode voltage to stabilize
delay_us(2);
}

// ADCB channel data read function using polled mode
unsigned int adcb_read(unsigned char channel)
{
ADC_CH_t *pch=&ADCB.CH0+channel;
unsigned int data;

// Start the AD conversion
pch->CTRL|= 1<<ADC_CH_START_bp;
// Wait for the AD conversion to complete
while ((pch->INTFLAGS & ADC_CH_CHIF_bm)==0);
// Clear the interrupt flag
pch->INTFLAGS=ADC_CH_CHIF_bm;
// Read the AD conversion result
((unsigned char *) &data)[0]=pch->RESL;
((unsigned char *) &data)[1]=pch->RESH;
return data;
}

// ADCB sweeped channel(s) data read function
// for software triggered mode
void adcb_sweep_read(unsigned char nch, unsigned int *pdata)
{
ADC_CH_t *pch=&ADCB.CH0;
unsigned char i,j,m;

// Sweep starts with channel 0
j=ADC_CH0START_bm;
// Prepare the AD conversion start mask for the sweeped channel(s)
m=0;
i=0;
do
  {
  m|=j;
  j<<=1;
  }
while (++i<nch);
// Ensure the interrupt flags are cleared
ADCB.INTFLAGS=ADCB.INTFLAGS;
// Start the AD conversion for the sweeped channel(s)
ADCB.CTRLA=(ADCB.CTRLA & (ADC_DMASEL_gm | ADC_FLUSH_bm | ADC_ENABLE_bm)) | m;
// Read and store the AD conversion results for all the sweeped channels
for (i=0; i<nch; i++)
    {
    // Wait for the AD conversion to complete
    while ((pch->INTFLAGS & ADC_CH_CHIF_bm)==0);
    // Clear the interrupt flag
    pch->INTFLAGS=ADC_CH_CHIF_bm;
    // Read the AD conversion result
    ((unsigned char *) pdata)[0]=pch->RESL;
    ((unsigned char *) pdata)[1]=pch->RESH;
    pdata++;
    pch++;
    }
}
