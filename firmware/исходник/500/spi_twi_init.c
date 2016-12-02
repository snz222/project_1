// SPIC initialization
void spic_init(void)
{
// SPIC is enabled
// SPI mode: 0
// Operating as: Master
// Data order: MSB First
// SCK clock prescaler: 128 250
// SCK clock prescaler: 64  1000
// SCK clock prescaler: 16  2000 
// SCK clock doubled: Off
// SCK clock frequency: 250,000 - 2000!!!
SPIC.CTRL=SPI_ENABLE_bm | SPI_MODE_0_gc | SPI_MASTER_bm |
    SPI_PRESCALER_DIV64_gc;
// SPIC interrupt: Disabled
SPIC.INTCTRL=(SPIC.INTCTRL & (~SPI_INTLVL_gm)) | SPI_INTLVL_OFF_gc;
// Note: the MOSI (PORTC Bit 5), SCK (PORTC Bit 7) and
// /SS (PORTC Bit 4) signals are configured as outputs in the ports_init function
}

// Macro used to drive the SPIC /SS signal low in order to select the slave
//#define SET_SPIC_SS_LOW {PORTC.OUTCLR=SPI_SS_bm;}
// Macro used to drive the SPIC /SS signal high in order to deselect the slave
//#define SET_SPIC_SS_HIGH {PORTC.OUTSET=SPI_SS_bm;}

// SPIC transmit/receive function in Master mode
// c - data to be transmitted
// Returns the received data
unsigned char spic_master_tx_rx(unsigned char c)
{
// Transmit data in Master mode
SPIC.DATA=c;
// Wait for the data to be transmitted/received
while ((SPIC.STATUS & SPI_IF_bm)==0);
// Return the received data
return SPIC.DATA;
}



// TWIE initialization
// structure that holds information used by the TWIE Master
// for performing a TWI bus transaction
TWI_MASTER_INFO_t twie_master;

void twie_init(void)
{
// General TWIE initialization
// External Driver Interface: Off
// SDA Hold: Off
twi_init(&TWIE,false,false);

// TWIE Master initialization
// Master interrupt: Low Level
// System Clock frequency: 32000000 Hz
// SCL Rate: 100000 bps
// Real SCL Rate: 100000 bps, Error: 0,0 %
twi_master_init(&twie_master,&TWIE,TWI_MASTER_INTLVL_LO_gc,
    TWI_BAUD_REG(32000000,100000));



// TWIE Slave is disabled
TWIE.SLAVE.CTRLA=0;
}

// TWIE Master interrupt service routine
#pragma optsize- // optimize for speed
interrupt [TWIE_TWIM_vect] void twie_master_isr(void)
{
twi_master_int_handler(&twie_master);
}
#pragma optsize_default