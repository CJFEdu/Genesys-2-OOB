/******************************************************************************
 * @file demo.c
 * This is the 'Out of Box' demo application for the Digilent Genesys 2 board.
 * It runs as a standalone app on an embedded Microblaze system.
 *
 * @authors Elod Gyorgy, Mihaita Nagy
 *
 * @date 2015-Jul-20
 *
 * @copyright
 * (c) 2015 Copyright Digilent Incorporated
 * All Rights Reserved
 *
 * This program is free software; distributed under the terms of BSD 3-clause
 * license ("Revised BSD License", "New BSD License", or "Modified BSD License")
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. Neither the name(s) of the above-listed copyright holder(s) nor the names
 *    of its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 * @desciption
 *
 * User I/O Demo:	This demo shows a scanning light bar on the LEDs. Any of
 * 					the slide switches in the UP position overrides the scanning
 * 					bar and forces the LED above ON.
 *
 * Audio Demo:		The audio demo records a 5 second sample from microphone
 * 					(J12) or line in (J13) and plays it back on headphone out
 * 					(J10) or line out (J11). Record and playback is started by
 * 					pushbuttons:
 * 					BTNU: record from microphone
 * 					BTNR: record from line in
 * 					BTND: playback on headphone
 * 					BTNL: playback on line out
 * 					For example, with the push of BTNU this demo records 5
 * 					seconds of audio data from the MIC (J6) input. Consequently
 * 					by pressing BTND the demo plays on the HPH OUT (J4) the
 * 					recorded samples.
 *
 * Ethernet Demo:	The demo uses the lwIP stack to implement an pingable echo
 * 					server. The on-board EEPROM is read to find out the MAC
 * 					address of the board. The network interface initializes as
 * 					soon as a cable is plugged in and link is detected. The DHCP
 * 					client will	try to get an IP, which will be shown on both the
 * 					on-board OLED (DISP1) and the terminal.
 * 					Once the IP address is displayed, the server replies to ping
 * 					requests on port 7.
 *
 * Video Demo: 		A static image is loaded from the Flash and displayed on
 * 					all the video outputs (VGA, DVI, DisplayPort) using the DDR3
 * 					as frame buffer.
 *
 * Power Demo:		Power monitor circuits are being read and current readings
 * 					displayed on the OLED.
 *
 * XADC Demo:		The XADC is set up to monitor the internal FPGA temperature,
 * 					VCCINT voltage and VCCAUX voltage. The XADC is periodically
 * 					read and the readings are displayed on the OLED and the
 * 					terminal. The user temperature alert feature is used to turn
 * 					the fan ON and OFF when upper and lower limits are reached.
 *
 * OLED Demo:		The on-board OLED shows the Digilent logo on power-up. After
 * 					initialization is completed it switches to display various
 * 					other information on several pages. Advance between pages
 * 					by pressing BTNC.
 * 					Page 1: FPGA internal temperature, VCCINT, VCCAUX voltages
 * 					Page 2: Current readings for VCC1V0, VCC1V5, VCC1V8
 * 					Page 3: Current readings for VCC3V3, VCC5V0
 * 					Page 4: MAC address and IP address
 * 					The OLED driver uses the GPIO and SPI IPs to talk to the
 * 					display.
 *
 * UART Demo:		Status messages and XADC readings are shown on the terminal.
 *
 * @note
 *
 * UART setup:		In order to successfully communicate with this demo you
 * 					must set your terminal to 115200 Baud, 8 data bits, 1 stop
 * 					bit, no parity.
 *
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who          Date        Changes
 * ----- ------------ ----------- --------------------------------------------
 * 2.00  Elod Gyorgy  2015-Jul-20 Updates/changes for Genesys 2
 * 1.01  Elod Gyorgy  2015-Jan-21 Warm-reset fix.
 * 1.00  Mihaita Nagy 2015-Jan-15 First release
 *  	 Elod Gyorgy
 *
 * </pre>
 *
 *****************************************************************************/

/***************************** Include Files *********************************/
#include "demo.h"
#include <string.h>
#include "xil_cache.h"
#include "xuartns550_l.h"

#include "intc/intc.h"
#include "qspi/qspi.h"

//the image to be loaded can be changed by swapping out hello.h for another 1920x1080 C header generated by GIMP 2
#define IMAGE_FILE "Genesys2-DemoScreen-1-01.h"
#include "images/Genesys2-DemoScreen-1-01.h"

/************************** Variable Definitions *****************************/
static XIntc sIntc;
static XSpi sFlashSpi;

// This variable holds the demo related settings
volatile sDemo_t Demo = {TRUE, FALSE, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

/************************** Constant Definitions *****************************/
// UART baud rate
#define UART_BAUD 				115200

// Interrupt vector table
const ivt_t ivt[] = {
	//Flash QSPI Interrupt handler
	{XPAR_MICROBLAZE_0_AXI_INTC_QSPI_FLASH_IP2INTC_IRPT_INTR, (XInterruptHandler)XSpi_InterruptHandler, &sFlashSpi}
};

// Flash Video Image Area definitions
#define IMAGE_FLASH_BASE_ADDR 0x00800000
#define IMAGE_DEPTH           3
#define IMAGE_WIDTH           1920
#define IMAGE_HEIGHT          1080
// derivation: IMAGE_PAGES = (IMAGE_WIDTH * IMAGE_HEIGHT * IMAGE_DEPTH / PAGE_SIZE)
#define IMAGE_PAGES 		  24300
#define FLASH_ERASE_SECTOR_SIZE 	  (64*1024)

/************************** Function Prototypes ******************************/
void Asserted (const char *File, int Line);

void ImageLoop();
void PrintMenu();
int ProgImage();
int DumpImage(int start_page, int num_pages);
int ImagePageWrite(u32 page, u8 data[PAGE_SIZE]);

int HardwareInitialize();
void HardwareCleanup();

/************************* Function Definitions ******************************/

void PrintMenu() {
	xil_printf("Available Commands:\r\n");
	xil_printf("    'm': Print Menu\r\n");
	xil_printf("    'w': Program Image from Header\r\n");
	xil_printf("    'r': Print First Page of Video Image Flash Memory\r\n");
	xil_printf("    'q': Exit Application\r\n");
}

void ImageLoop() {
	u8 cmd = 'm';

	while (1) {
		xil_printf("Entered Command Loop: ");
		switch(cmd) {
			case 'w': ProgImage(); break;
			case 'r': DumpImage(0, 1); break;
			case 'm': PrintMenu(); break;
			case 'q': return;
		}
		cmd = XUartNs550_RecvByte(XPAR_AXI_UART16550_0_BASEADDR); // wait for host to send request.
		xil_printf("%c\r\n", cmd);
	}
}

/*
 *  Function: fnXADCInit
 *      Read and Print pages from the image segment of flash memory
 *		Intended for human-readability or scripting on the other side of the serial port.
 *
 *	Parameters:
 *		int start_page - the index of the first page to read
 *      int num_pages - the number of pages to print
 *
 *  Returns:
 *  	success or failure
*/
int DumpImage(int start_page, int num_pages) {
//	u32 columns = 1920, rows = 1080, depth = 3;
	u32 page, byte;
	u8 Status;
	const u8 ReadCmd = COMMAND_QOR;
	if (start_page + num_pages >= IMAGE_PAGES) {
		xil_printf("Error: cannot print pages beyond image boundary\r\n");
		return XST_FAILURE;
	}
	for (page=0; page<num_pages; page++)
	{
		Status = SpiFlashRead(&sFlashSpi, IMAGE_FLASH_BASE_ADDR+(page+start_page)*PAGE_SIZE, PAGE_SIZE, ReadCmd);
		if (Status != XST_SUCCESS)
		{
			xil_printf("Error: flash read failed on page %d\r\n", page);
			return Status;
		}
		for (byte=0; byte<PAGE_SIZE; byte++)
		{
			xil_printf("%02x", rgbReadBuffer[byte+READ_EXTRA_BYTES]);
		}
		xil_printf("\r\n");
	}
	xil_printf("\r\n");//finish loop with double-newline token (for script parse-ability)

	return XST_SUCCESS;
}


/*
 *  Function: ImagePageWrite
 *		Writes a single page of data to the specified page of the flash video image area
 *
 *	Parameters:
 *		page: index of page to be written
 *		data: buffer of RGB byte data
 *
 *  Returns:
 *  	success or failure
 *
*/
int ImagePageWrite(u32 page, u8 data[PAGE_SIZE]) {
	int Status;
	const u32 PageAddr = IMAGE_FLASH_BASE_ADDR + PAGE_SIZE*page;
	const u8 WriteCmd = COMMAND_QIFP;

	if (page > IMAGE_PAGES) {
		xil_printf("Error: page %d outside of image area\r\n", page);
		return XST_FAILURE;
	}

	Status = SpiFlashWriteEnable(&sFlashSpi);
	if (Status != XST_SUCCESS) {
		xil_printf("Error: image page write failed\r\n");
		return Status;
	}

	Status = SpiFlashQuadEnable(&sFlashSpi);
	if (Status != XST_SUCCESS) {
		xil_printf("Error: image page write failed\r\n");
		return Status;
	}
	if (PageAddr % FLASH_ERASE_SECTOR_SIZE == 0) {
		// then page is the start of an unvisited sector, assuming pages are being written in sequential order
		Status = SpiFlashWriteEnable(&sFlashSpi);
		if (Status != XST_SUCCESS) {
			xil_printf("Error: image page write failed\r\n");
			return Status;
		}

		Status = SpiFlashSectorErase(&sFlashSpi, PageAddr);
		if (Status != XST_SUCCESS) {
			xil_printf("Error: image page write failed\r\n");
			return Status;
		}
	}
	Status = SpiFlashWaitForFlashReady(&sFlashSpi);
	if (Status != XST_SUCCESS) {
		xil_printf("Error: image page write failed\r\n");
		return Status;
	}

	Status = SpiFlashWriteEnable(&sFlashSpi);
	if (Status != XST_SUCCESS) {
		xil_printf("Error: image page write failed\r\n");
		return Status;
	}

	Status = SpiFlashWrite(&sFlashSpi, PageAddr, PAGE_SIZE, WriteCmd, data);
	if (Status != XST_SUCCESS) {
		xil_printf("Error: image page write failed\r\n");
		return Status;
	}

	Status = SpiFlashWaitForFlashReady(&sFlashSpi);
	if (Status != XST_SUCCESS) {
		xil_printf("Error: image page write failed\r\n");
		return Status;
	}

	return XST_SUCCESS;
}

/*
 *  Function: ProgImage
 *		program the flash video image area with data taken from the specified IMAGE_FILE
 *
 *	Parameters:
 * 		num_pages: the number of pages to program
 *
 *  Returns:
 *  	success or failure
 *
*/
int ProgImage() {
//	u32 pwidth = width;
//	u32 pheight = height;

	u8 data[PAGE_SIZE+IMAGE_DEPTH-1]; // allocate space for a page of data with extra space for IMAGE_DEPTH byte reads to overflow into
	u8 *from_ptr = (u8*)header_data;
	u8 *to_ptr = data;
	u8 temp;
	u32 i, pages = 0;

	//traverse IMAGE_FILE header_data and program each 256 byte page.

	if (width * height * 3 / PAGE_SIZE != IMAGE_PAGES) {
		xil_printf("Error: image header file size does not match expected size\r\n");
		return XST_FAILURE;
	}

	xil_printf("programming imagedump/src/%s into flash memory at address %08x\r\n", IMAGE_FILE, IMAGE_FLASH_BASE_ADDR);
	xil_printf("writing ");
	xil_printf("\x1b[s"); // save cursor position
	xil_printf("0 / %d pages\r\n", pages, IMAGE_PAGES);
	while (pages < IMAGE_PAGES) {
		//pull pixels out of image header until data buffer is full or has overflowed
		while (to_ptr - (u8*)data < PAGE_SIZE) {
			//pulls a pixel out of the image header and increment the header pointer forward
			HEADER_PIXEL(from_ptr, to_ptr);

			//rotate colors
			temp = *to_ptr;
			for (i=0; i < IMAGE_DEPTH-1; i++)
				*(to_ptr+i) = *(to_ptr+i+1);
			*(to_ptr+i) = temp;

			//step pointer into buffer forward one pixel width
			to_ptr += IMAGE_DEPTH;
		}
//		if (pages == 0) xil_printf("%02x%02x%02x\r\n", data[0], data[1], data[2]);
		ImagePageWrite(pages, data);

		//preserve any overflow bytes from the last pixel read at the front of the data buffer.
		//reset to_ptr for next iteration, placed after the overflow bytes.
		for (i=0; i<to_ptr-data-PAGE_SIZE; i++)
			data[i] = data[i+PAGE_SIZE];
		to_ptr = (u8*)((u32)data + i);
		pages ++;

		// print progress
		xil_printf("\x1b[u");// restore cursor position
		xil_printf("%d / %d pages\r\n", pages, IMAGE_PAGES);
	}
	xil_printf("done\r\n");
	return XST_SUCCESS;
}


/*
 *  Function: HardwareInitialize
 *		Enables Caches, Starts the UART, Quad SPI, and Interrupt Controller devices.
 *
 *	Parameters:
 *		none
 *
 *  Returns:
 *  	success or failure
 *
*/
int HardwareInitialize() {
	XStatus Status;

	// Enabling caches
#ifdef XPAR_MICROBLAZE_USE_ICACHE
    Xil_ICacheEnable();
#endif
#ifdef XPAR_MICROBLAZE_USE_DCACHE
    Xil_DCacheDisable(); //AXI Quad SPI is not compatible with the data cache
#endif

	// Empty assert function. We can put a breakpoint there to look for asserts
	Xil_AssertSetCallback((Xil_AssertCallback)Asserted);

    // Initialize UART
    XUartNs550_SetBaud(XPAR_AXI_UART16550_0_BASEADDR,
    		XPAR_XUARTNS550_CLOCK_HZ, UART_BAUD);
    XUartNs550_SetLineControlReg(XPAR_AXI_UART16550_0_BASEADDR,
    		XUN_LCR_8_DATA_BITS);

    xil_printf("\033[H\033[J"); //Clear the terminal
    xil_printf("\r\nInitializing Hardware: ");

	// Initialize the interrupt controller
	Status = fnInitInterruptController(&sIntc);
	if(Status != XST_SUCCESS) {
		xil_printf("Error initializing interrupts");
		return XST_FAILURE;
	}

	//Initialize Flash quad spi controller
	Status = fnQspiDevInit(&sFlashSpi);
	if(Status != XST_SUCCESS) {
		xil_printf("Error initializing QSpi\n");
		return XST_FAILURE;
	}

	// Enable all interrupts in our interrupt vector table
	// Make sure all driver instances using interrupts are initialized first
	fnEnableInterrupts(&sIntc, &ivt[0], sizeof(ivt)/sizeof(ivt[0]));

	return XST_SUCCESS;
}

void HardwareCleanup() {
    // Disabling caches
#ifdef XPAR_MICROBLAZE_USE_ICACHE
    Xil_DCacheDisable();
#endif
#ifdef XPAR_MICROBLAZE_USE_DCACHE
    Xil_ICacheDisable();
#endif

}

int main() {
	XStatus Status;

	Status = HardwareInitialize();

	if (XST_SUCCESS == Status)
		ImageLoop();

	xil_printf("Shutting project down\r\n");
	HardwareCleanup();

    return Status;
}

//! The assert function is called when something goes wrong and execution cannot continue
void Asserted (const char *File, int Line) {
	xil_printf("Error: Assertion at line %d in %s.\n", Line, File);
	while (1) ; //Stay here
}
