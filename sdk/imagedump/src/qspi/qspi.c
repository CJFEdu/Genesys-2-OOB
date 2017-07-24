/******************************************************************************
 * @file qspi.c
 * Bootloader implementation on a Spansion serial flash medium.
 *
 * @authors Elod Gyorgy
 *
 * @date 2015-Dec-23
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
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who          Date        Changes
 * ----- ------------ ----------- --------------------------------------------
 * 1.00  Elod Gyorgy  2015-Dec-23 First release
 *
 *
 * </pre>
 *
 *****************************************************************************/

#include "qspi.h"
//#include "..\cmd.h"
#include "xparameters.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <xstatus.h>

/*
 * Byte Positions.
 */
#define BYTE1				0 /* Byte 1 position */
#define BYTE2				1 /* Byte 2 position */
#define BYTE3				2 /* Byte 3 position */
#define BYTE4				3 /* Byte 4 position */
#define BYTE5				4 /* Byte 5 position */
#define BYTE6				5 /* Byte 6 position */
#define BYTE7				6 /* Byte 7 position */
#define BYTE8				7 /* Byte 8 position */


static volatile int TransferInProgress;
static volatile int ErrorCount;


/*****************************************************************************/
/**
*
* This function initializes the QSPI and sets the interrupt handler
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/

XStatus fnQspiDevInit(XSpi *SpiPtr)
{
	int Status;
	XSpi_Config *pConfigPtr;	/* Pointer to Configuration data */

    /* Init Quad SPI too
     * Since the Quad SPI Flash is not memory-mapped, memory access instructions
     * need to be replaced by function calls to the AXI Quad SPI core to fetch data */

	/*
	 * Initialize the SPI driver so that it is  ready to use.
	 */
	pConfigPtr = XSpi_LookupConfig(QSPI_DEVICE_ID);
	if (pConfigPtr == NULL) {
		return XST_DEVICE_NOT_FOUND;
	}

	Status = XSpi_CfgInitialize(SpiPtr, pConfigPtr,
			pConfigPtr->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Perform a self-test to ensure that the hardware was built correctly
	 */
	Status = XSpi_SelfTest(SpiPtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	Status = XSpi_SetOptions(SpiPtr, XSP_MASTER_OPTION | XSP_MANUAL_SSELECT_OPTION);
	if(Status != XST_SUCCESS) {
		//ERR_SET_LAST("flash:SPI Set up error");
		return XST_FAILURE;
	}

	Status = XSpi_SetSlaveSelect(SpiPtr, 0x01);
	if(Status != XST_SUCCESS) {
		//ERR_SET_LAST("flash:Set Slave Select error");
		return XST_FAILURE;
	}

	XSpi_SetStatusHandler(SpiPtr, NULL,  (XSpi_StatusHandler)SpiHandler);
	XSpi_Start(SpiPtr);

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This Tests the Flash memory by writing the first byte of sector 0
* and reads it back. It also writes the MAC addres used by the ETH
* in the OTP region of the Flash memory on the address 0x20
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	arg0 is a pointer to a string which represents the MAC address.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
XStatus fnQSpiTest(XSpi *SpiPtr, char const *arg0)
{

	int i;
	u32 Addr;
	const u32 BaseAddr = 0x00800000;

	u8 pMacAddress[6];
	u8 u8WriteByte;


	// Read Flash ID
    if (XST_SUCCESS != SpiFlashReadId(SpiPtr))
    {
    	xil_printf("\r\nQSPI Status Read failed.\r\n");
     	return XST_FAILURE;
    }

    xil_printf("Reading ID...\r\n");

    //Compare the read ID with the ID provided by the manufacturer
    if (
    		(rgbReadBuffer[1] != QSPI_MAN_ID)  ||
    		(rgbReadBuffer[2] != QSPI_ID_HIGH) ||
    		(rgbReadBuffer[3] != QSPI_ID_LOW)  ||
    		(rgbReadBuffer[4] != QSPI_ID_LENGTH)
        )
    {
    	xil_printf("flash:QSPI ID Mismatch\r\n");
     	return XST_FAILURE;
    }

 	xil_printf("QSPI ID Read Passed\r\n");

 	//Get Control register
    if (XST_SUCCESS != SpiFlashGetControl(SpiPtr))
    {
    	xil_printf("flash:QSPI Control Register Read failed.\r\n");
    	return XST_FAILURE;
    }

    xil_printf("Control Register Value = 0x%X\r\n", rgbReadBuffer[1]);

    //Allow Write Enable
    if (XST_SUCCESS != SpiFlashWriteEnable(SpiPtr))
    {
    	xil_printf("flash:QSPI Set Write Enable failed\r\n");
    	return XST_FAILURE;
    }

    //Enabling Quad bit for FLASH
    if (XST_SUCCESS != SpiFlashQuadEnable(SpiPtr))
    {

    	xil_printf("flash:QSPI Quad Bit Enable Failed\r\n");
    	return XST_FAILURE;
    }

    //Allow Write Enable
    if (XST_SUCCESS != SpiFlashWriteEnable(SpiPtr))
    {
    	xil_printf("flash:QSPI Set Write Enable failed\r\n");
    	return XST_FAILURE;
    }

    //Erase the first Sector
    Addr = BaseAddr;
    if (XST_SUCCESS != SpiFlashSectorErase(SpiPtr, Addr))
    {
    	xil_printf("flash:QSPI Sector Erase Failed\r\n");
        return XST_FAILURE;
    }

	// Wait while the Flash is busy.
	if(SpiFlashWaitForFlashReady(SpiPtr) != XST_SUCCESS)
	{
		xil_printf("flash:QSPI Flash Ready Fail\r\n");
		return XST_FAILURE;
	}
	xil_printf("Sector Erase completed\r\n");

	xil_printf("Programming Data...\r\n");
    //Set address to write to
    Addr = BaseAddr;

    //Allow Write Enable first
    if (XST_SUCCESS != SpiFlashWriteEnable(SpiPtr))
    {
    	xil_printf("flash:QSPI Set Write Enable failed\r\n");
	    return XST_FAILURE;
    }

    //Value to be written
    u8WriteByte = 0xA5;

    if (XST_SUCCESS != SpiFlashWrite(SpiPtr, Addr, 6, 0x32, &u8WriteByte))
    {
    	xil_printf("flash:QSPI Write Failed\r\n");
    	return XST_FAILURE;
    }

	// Wait while the Flash is busy.
	if(SpiFlashWaitForFlashReady(SpiPtr) != XST_SUCCESS)
	{
		xil_printf("flash:QSPI Flash Ready Fail\r\n");
		return XST_FAILURE;
	}
	xil_printf("Programming FLASH Completed\r\n");

	xil_printf("Reading back after programmming...\r\n");
    //Erase buffers
    for (i = 0; i<32; i++)
    {
    	rgbReadBuffer[i] = 0;
    	rgbWriteBuffer[i] = 0;

    }

    //Read back  written value n
	 if (XST_SUCCESS != SpiFlashRead(SpiPtr,  Addr, 1, COMMAND_QOR))
	 {
		 xil_printf("flash:QSPI Read Failed\r\n");
   		 return XST_FAILURE;
	 }
	 xil_printf("Reading from Address 0X%08X, Data 0X%X\r\n", Addr, rgbReadBuffer[READ_EXTRA_BYTES]);

	 //Compare expected value
 	 if (rgbReadBuffer[READ_EXTRA_BYTES] != u8WriteByte)
 	 {
 		 xil_printf("flash:Data Error, Expected 0xA5, Got 0x%X\r\n", rgbReadBuffer[READ_EXTRA_BYTES]);
		 xil_printf("flash:QSPI Compare Failed\r\n");
		 return XST_FAILURE;
 	 }

 	 //Convert MAC from ASCII to HEX
  	if (XST_SUCCESS != SpiFlashConvertMAC(arg0, pMacAddress))
 	{
// 	 	extern char szLastError[LAST_ERROR_MAXSIZE];
//		szLastError[0] = '\0';
//		strcat(szLastError,"flash:QSPI MAC wrong char:");
//		AppendHexDump(arg0, strlen(arg0), szLastError,sizeof(szLastError));
  		xil_printf("flash:QSPI MAC wrong char\r\n");
   	 	return XST_FAILURE;
 	}

  	//Write and Lock the MAC address to the OPT region
 	if (XST_SUCCESS != SpiWriteOTP(SpiPtr,  0x20, pMacAddress))
 	{
 	 	xil_printf("flash:QSPI OPT Fail\r\n");
   	 	return XST_FAILURE;
 	}
    xil_printf("flash:write_otp_done\r\n");

    return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* Writes the given MAC to a specific address in the OTP region, it is presumed
* that the selected address is in the first region. After writing the
* MAC address it will lock the first region and check if the MAC was
* written correctly
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	Addr is the address the MAC will be written to
* @param	pMac a pointer to the MAC value
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
XStatus SpiWriteOTP(XSpi *SpiPtr, u32 Addr, u8 * pMac)
{
	u8 fProgramMAC, i;
	u8 u8LockByte;

	//CMD_VERBOSE("QSPI write OTP Start");
	//Read OTPR register
	if (XST_SUCCESS != SpiFlashRead(SpiPtr,  Addr, 6, COMMAND_OTPR)) //Read Quad Out Command
	{
	 	//ERR_SET_LAST("flash:QSPI OTP initial read fail");
  	 	return XST_FAILURE;
	}

	//Check MAC was already programmed
	//activate MAC programming flag if not programmed
	for (i=0; i<6; i++)
	{
		if (rgbReadBuffer[5+i] != 0xFF)
		{
			if (rgbReadBuffer[5+i] != pMac[i])
			{
//				extern char szLastError[LAST_ERROR_MAXSIZE];
//				szLastError[0] = '\0';
//				strcat(szLastError,"flash:QSPI OTP read MAC different from current MAC:");
//				AppendHexDump((rgbReadBuffer+5), 6, szLastError, sizeof(szLastError));
//				strcat(szLastError,":");
//				AppendHexDump(pMac, 6, szLastError, sizeof(szLastError));
				return XST_FAILURE;
			}
			else
				fProgramMAC = 0;//clear prog flag
		}
		else
			fProgramMAC = 1; //set prog flag
	}

	if (fProgramMAC)
	{
	    //Allow Write Enable first
	    if (XST_SUCCESS != SpiFlashWriteEnable(SpiPtr))
	    {
//	    	//ERR_SET_LAST("flash:QSPI OTP Set Write Enable failed");
		    return XST_FAILURE;
	    }

	    //Write MAC in to OTP
	    if (XST_SUCCESS != SpiFlashWrite(SpiPtr, Addr, 6, COMMAND_OTPP, pMac))
	    {
//	    	//ERR_SET_LAST("flash:QSPI OTP Write Failed");
	    	return XST_FAILURE;
	    }

		// Wait while the Flash is busy.
		if(SpiFlashWaitForFlashReady(SpiPtr) != XST_SUCCESS)
		{
			//ERR_SET_LAST("flash:QSPI OTP Flash Ready Fail");
			return XST_FAILURE;
		}

	    //Allow Write Enable first
	    if (XST_SUCCESS != SpiFlashWriteEnable(SpiPtr))
	    {
	    	//ERR_SET_LAST("flash:QSPI OTP Set Write Enable failed");
		    return XST_FAILURE;
	    }

	    //Lock first region
	    u8LockByte = 0xFD;
	    if (XST_SUCCESS != SpiFlashWrite(SpiPtr, 0x10, 1, COMMAND_OTPP, &u8LockByte))
	    {
	    	//ERR_SET_LAST("flash:QSPI OTP Lock Failed");
	    	return XST_FAILURE;
	    }

		// Wait while the Flash is busy.
		if(SpiFlashWaitForFlashReady(SpiPtr) != XST_SUCCESS)
		{
			//ERR_SET_LAST("flash:QSPI OTP Flash Ready Fail");
			return XST_FAILURE;
		}

		//Read the OTP region
		if (XST_SUCCESS != SpiFlashRead(SpiPtr,  Addr, 6, COMMAND_OTPR))
		{
		 	//ERR_SET_LAST("flash:QSPI OTP Read-back MAC Failed");
	  	 	return XST_FAILURE;
		}

		//Check if MAC was written correctly
		for(i=0; i<6; i++)
		{
			if (rgbReadBuffer[5+i] != pMac[i])
			{
				//ERR_SET_LAST("flash:QSPI OTP MAC not written correctly");
				return XST_FAILURE;
			}

		}
	}
	//CMD_VERBOSE("QSPI write OTP Done and Checked");

	return XST_SUCCESS;

}


/*****************************************************************************/
/**
*
* This function reads the data from the Winbond Serial Flash Memory
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	Addr is the starting address in the Flash Memory from which the
*		data is to be read.
* @param	ByteCount is the number of bytes to be read.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
XStatus SpiFlashRead(XSpi *SpiPtr, u32 Addr, u32 ByteCount, u8 WriteCmd)
{
	int Status;

	if (ByteCount > PAGE_SIZE)
	{
		//CMD_VERBOSE("ByteCount > Page Size");
		return XST_FAILURE;
	}

	/*
	 * Wait while the Flash is busy.
	 */
	Status = SpiFlashWaitForFlashReady(SpiPtr);
	if(Status != XST_SUCCESS) {
		//CMD_VERBOSE("Wait for FLASH Ready Error");
		return XST_FAILURE;
	}

	/*
	 * Prepare the rgbWriteBuffer.
	 */
	rgbWriteBuffer[BYTE1] = WriteCmd; //COMMAND_4QOR;
//	rgbWriteBuffer[BYTE2] = (u8) (Addr >> 24);
	rgbWriteBuffer[BYTE2] = (u8) (Addr >> 16);
	rgbWriteBuffer[BYTE3] = (u8) (Addr >> 8);
	rgbWriteBuffer[BYTE4] = (u8) (Addr);

	/*
	 * Initiate the Transfer.
	 */

	TransferInProgress = TRUE;
	Status = XSpi_Transfer(SpiPtr, rgbWriteBuffer, rgbReadBuffer,
				(ByteCount + READ_EXTRA_BYTES));

	if(Status != XST_SUCCESS) {

		return XST_FAILURE;
	}

	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}


	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function waits until the flash is ready to accept the next
* command.
*
* @param	None
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		This function reads the status register of the Buffer and waits
*.		till the WIP bit of the status register becomes 0.
*
******************************************************************************/
XStatus SpiFlashWaitForFlashReady(XSpi *SpiPtr)
{
	int Status;
	u8 StatusReg;

	while(1) {

		/*
		 * Get the Status Register.
		 */
		Status = SpiFlashGetStatus(SpiPtr);
		if(Status != XST_SUCCESS) {
			return XST_FAILURE;
		}

		/*
		 * Check if the flash is ready to accept the next command.
		 * If so break.
		 */
		StatusReg = rgbReadBuffer[1];
		if((StatusReg & FLASH_SR_IS_READY_MASK) == 0) {
			break;
		}
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function reads the Status register SR1
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		The status register content is stored at the second byte pointed
*		by the rgbReadBuffer.
*
******************************************************************************/
XStatus SpiFlashGetStatus(XSpi *SpiPtr)
{
	int Status;

	/*
	 * Prepare the Write Buffer.
	 */
	rgbWriteBuffer[BYTE1] = COMMAND_RDSR1;

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	Status = XSpi_Transfer(SpiPtr, rgbWriteBuffer, rgbReadBuffer,
			STATUS_READ_BYTES);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction..
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function reads the Control register CR1
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		The status register content is stored at the second byte pointed
*		by the rgbReadBuffer.
*
******************************************************************************/
XStatus SpiFlashGetControl(XSpi *SpiPtr)
{
	int Status;

	/*
	 * Prepare the Write Buffer.
	 */
	rgbReadBuffer[BYTE1] = COMMAND_RDCR;

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	Status = XSpi_Transfer(SpiPtr, &rgbReadBuffer[0], &rgbReadBuffer[0],
			RDCR_BYTES);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction..
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function enables writes to the Winbond Serial Flash memory.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
int SpiFlashWriteEnable(XSpi *SpiPtr)
{
	int Status;

	/*
	 * Wait while the Flash is busy.
	 */
	Status = SpiFlashWaitForFlashReady(SpiPtr);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Prepare the WriteBuffer.
	 */
	rgbWriteBuffer[BYTE1] = COMMAND_WRITE_ENABLE;

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	Status = XSpi_Transfer(SpiPtr, rgbWriteBuffer, NULL,
				WRITE_ENABLE_BYTES);
	if(Status != XST_SUCCESS) {
		xil_printf ("\r\nSPI Transfer Failed");
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction..
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {

		xil_printf ("\r\nErrorCount = 0x%X", ErrorCount);
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function writes the data to the specified locations in the Winbond Serial
* Flash memory.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	Addr is the address in the Buffer, where to write the data.
* @param	ByteCount is the number of bytes to be written.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None
*
******************************************************************************/
int SpiFlashWrite(XSpi *SpiPtr, u32 Addr, u32 ByteCount, u8 WriteCmd, u8 * pData)
{
	u32 Index;
	int Status;

	/*
	 * Wait while the Flash is busy.
	 */
	Status = SpiFlashWaitForFlashReady(SpiPtr);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Prepare the WriteBuffer.
	 */

	rgbWriteBuffer[BYTE1] = WriteCmd;
	rgbWriteBuffer[BYTE2] = (u8) (Addr >> 16);
	rgbWriteBuffer[BYTE3] = (u8) (Addr >> 8);
	rgbWriteBuffer[BYTE4] = (u8) (Addr);

	/*
	 * Fill in the data that is to be written into the Serial
	 * Flash device.
	 */
	for(Index = 4; Index < ByteCount + WRITE_EXTRA_BYTES; Index++) {
		rgbWriteBuffer[Index] = pData[Index-4];
	}


//	for(Index = 0; Index < ByteCount + WRITE_EXTRA_BYTES; Index++) {
//		xil_printf("\r\nData to send in rgbWriteBuffer[%d] = 0x%02.2X", Index,rgbWriteBuffer[Index] );
//	}


	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	Status = XSpi_Transfer(SpiPtr, rgbWriteBuffer, NULL,
				(ByteCount + WRITE_EXTRA_BYTES));
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction.
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function erases the entire contents of the Winbond Serial Flash device.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		The erased bytes will read as 0xFF.
*
******************************************************************************/
//int SpiFlashBulkErase(XSpi *SpiPtr)
//{
//	int Status;
//
//	/*
//	 * Wait while the Flash is busy.
//	 */
//	Status = SpiFlashWaitForFlashReady(SpiPtr);
//	if(Status != XST_SUCCESS) {
//		return XST_FAILURE;
//	}
//
//	/*
//	 * Prepare the WriteBuffer.
//	 */
//	rgbWriteBuffer[BYTE1] = COMMAND_BULK_ERASE;
//
//	/*
//	 * Initiate the Transfer.
//	 */
//	TransferInProgress = TRUE;
//	Status = XSpi_Transfer(SpiPtr, rgbWriteBuffer, NULL,
//						BULK_ERASE_BYTES);
//	if(Status != XST_SUCCESS) {
//		return XST_FAILURE;
//	}
//	/*
//	 * Wait till the Transfer is complete and check if there are any errors
//	 * in the transaction..
//	 */
//	while(TransferInProgress);
//	if(ErrorCount != 0) {
//		ErrorCount = 0;
//		return XST_FAILURE;
//	}
//
//	return XST_SUCCESS;
//}

/*****************************************************************************/
/**
*
* This function erases the contents of the specified Sector in the Winbond
* Serial Flash device.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	Addr is the address within a sector of the Buffer, which is to
*		be erased.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		The erased bytes will be read back as 0xFF.
*
******************************************************************************/
int SpiFlashSectorErase(XSpi *SpiPtr, u32 Addr)
{
	int Status;

	/*
	 * Wait while the Flash is busy.
	 */
	Status = SpiFlashWaitForFlashReady(SpiPtr);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Prepare the WriteBuffer.
	 */
	rgbWriteBuffer[BYTE1] = COMMAND_SECTOR_ERASE;
	rgbWriteBuffer[BYTE2] = (u8) (Addr >> 16);
	rgbWriteBuffer[BYTE3] = (u8) (Addr >> 8);
	rgbWriteBuffer[BYTE4] = (u8) (Addr);

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	Status = XSpi_Transfer(SpiPtr, rgbWriteBuffer, NULL,
					SECTOR_ERASE_BYTES);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction..
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}


/*****************************************************************************/
/**
*
* This function erases the contents of a specified 4K Sector in the Spansion Flash Memory
* Serial Flash device.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
* @param	Addr is the address within a sector of the Buffer, which is to
*		be erased.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		The erased bytes will be read back as 0xFF.
*
******************************************************************************/
//int SpiFlash4KSectorErase(XSpi *SpiPtr, u32 Addr)
//{
//	int Status;
//
//	/*
//	 * Wait while the Flash is busy.
//	 */
//	Status = SpiFlashWaitForFlashReady(SpiPtr);
//	if(Status != XST_SUCCESS) {
//		return XST_FAILURE;
//	}
//
//	/*
//	 * Prepare the WriteBuffer.
//	 */
//	rgbWriteBuffer[BYTE1] = COMMAND_4K_SECTOR_ERASE;
//	rgbWriteBuffer[BYTE2] = (u8) (Addr >> 16);
//	rgbWriteBuffer[BYTE3] = (u8) (Addr >> 8);
//	rgbWriteBuffer[BYTE4] = (u8) (Addr);
//
//	/*
//	 * Initiate the Transfer.
//	 */
//	TransferInProgress = TRUE;
//	Status = XSpi_Transfer(SpiPtr, rgbWriteBuffer, NULL,
//					SECTOR_ERASE_BYTES);
//	if(Status != XST_SUCCESS) {
//		xil_printf ("\r\nXspi Transfer Failed");
//		return XST_FAILURE;
//	}
//
//	/*
//	 * Wait till the Transfer is complete and check if there are any errors
//	 * in the transaction..
//	 */
//	while(TransferInProgress);
//	if(ErrorCount != 0) {
//
//		xil_printf ("\r\nError Count = %d", ErrorCount);
//		ErrorCount = 0;
//		return XST_FAILURE;
//	}
//
//	return XST_SUCCESS;
//}




/*****************************************************************************/
/**
*
* This function sets the QuadEnable bit in Winbond flash.
*
* @param	None
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None.
*
******************************************************************************/
int SpiFlashQuadEnable(XSpi *SpiPtr)
{
	int Status;

	/*
	 * Perform the Write Enable operation.
	 */
	Status = SpiFlashWriteEnable(SpiPtr);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait while the Flash is busy.
	 */
	Status = SpiFlashWaitForFlashReady(SpiPtr);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Prepare the WriteBuffer.
	 */
	rgbWriteBuffer[BYTE1] = 0x01;
	rgbWriteBuffer[BYTE2] = 0x00;
	rgbWriteBuffer[BYTE3] = 0x02; /* QE = 1 */

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	Status = XSpi_Transfer(SpiPtr, rgbWriteBuffer, NULL, 3);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction..
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	/*
	 * Wait while the Flash is busy.
	 */
	Status = SpiFlashWaitForFlashReady(SpiPtr);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Verify that QE bit is set by reading status register 2.
	 */

	/*
	 * Prepare the Write Buffer.
	 */
	rgbWriteBuffer[BYTE1] = 0x35;

	/*
	 * Initiate the Transfer.
	 */
	TransferInProgress = TRUE;
	Status = XSpi_Transfer(SpiPtr, rgbWriteBuffer, rgbReadBuffer,
						STATUS_READ_BYTES);
	if(Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait till the Transfer is complete and check if there are any errors
	 * in the transaction..
	 */
	while(TransferInProgress);
	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}


	if ((rgbReadBuffer[BYTE2] & 0x02) != 0x02)
	{
		//CMD_VERBOSE("\r\nQuad enable bit is not set");
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* This function is the handler which performs processing for the SPI driver.
* It is called from an interrupt context such that the amount of processing
* performed should be minimized. It is called when a transfer of SPI data
* completes or an error occurs.
*
* This handler provides an example of how to handle SPI interrupts and
* is application specific.
*
* @param	CallBackRef is the upper layer callback reference passed back
*		when the callback function is invoked.
* @param	StatusEvent is the event that just occurred.
* @param	ByteCount is the number of bytes transferred up until the event
*		occurred.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void SpiHandler(void *CallBackRef, u32 StatusEvent, unsigned int ByteCount)
{
	/*
	 * Indicate the transfer on the SPI bus is no longer in progress
	 * regardless of the status event.
	 */
	//xil_printf("\r\nHandler Started");
	TransferInProgress = FALSE;

	/*
	 * If the event was not transfer done, then track it as an error.
	 */

	//xil_printf("\r\nInterrupt Status Event = 0x%X", StatusEvent);

	if (StatusEvent != XST_SPI_TRANSFER_DONE) {
		ErrorCount++;
	}
}


/*****************************************************************************
* This function reads the Status register of the serial Flash.
*
* @param	SpiPtr is a pointer to the instance of the Spi device.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		The status register content is stored at the second byte pointed
*			by the ReadBuffer.
*
******************************************************************************/
int SpiFlashReadId(XSpi * SpiPtr) {

	int Status;

	//Prepare the Write Buffer.
	rgbWriteBuffer[0] = COMMAND_RDID;

	//Initiate the Transfer.
	TransferInProgress = TRUE;

	Status = XSpi_Transfer(SpiPtr, rgbWriteBuffer, rgbReadBuffer, 6); //6
	if(Status != XST_SUCCESS) {

		//CMD_VERBOSE("\r\nSpi Transfer Failed");
		return XST_FAILURE;
	}


	//Wait till the Transfer is complete and check if there are any errors
	//in the transaction.
	while(TransferInProgress);

	if(ErrorCount != 0) {
		ErrorCount = 0;
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* Converts the MAC address received as a string in to a HEX value
*
* @param	arg0 pointer to the MAC char array.
* @param	u8MAC value which will store the converted MAC value
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		If the string contains anything else then a valid HEX char
* 			it will return FAIL. This function will only take in to
* 			account the first 12 characters which are passed on
*
******************************************************************************/
XStatus SpiFlashConvertMAC(char const * arg0, u8* u8MAC)
{
	u8 u8Var, u8UpperNibble, u8LowerNibble,i;

	for (i = 0; i<12; i = i+2)
	{
		//Check and convert the Upper Nibble
		//from char to hex
		u8Var = *(arg0+i);
		if ((u8Var < 0x3A) && (u8Var > 0x2F))
		{
			u8UpperNibble = u8Var - 0x30;
		}
		else
			if ((u8Var < 0x47) && (u8Var > 0x3F))
			{
				u8UpperNibble = 0x0a;
				u8UpperNibble = u8UpperNibble + (u8Var - 0x41);
			}
			else
				if((u8Var < 0x67) && (u8Var > 0x60))
				{
					u8UpperNibble = 0x0a;
					u8UpperNibble = u8UpperNibble + (u8Var - 0x61);
				}
				else
					return XST_FAILURE;// If the char is not a valid HEX char

		//Check and convert the Lower Nibble
		//from char to hex
		u8Var = *(arg0+i+1);
		if ((u8Var < 0x3A) && (u8Var > 0x2F))
		{
			u8LowerNibble = u8Var - 0x30;
		}
		else
			if ((u8Var < 0x47) && (u8Var > 0x3F))
			{
				u8LowerNibble = 0x0a;
				u8LowerNibble = u8LowerNibble + (u8Var - 0x41);
			}
			else
				if((u8Var < 0x67) && (u8Var > 0x60))
				{
					u8LowerNibble = 0x0a;
					u8LowerNibble = u8LowerNibble + (u8Var - 0x61);
				}
				else
					return XST_FAILURE;// If the char is not a valid HEX char

		//Combine the two nibbles in to  Byte
		u8MAC[i/2] = (u8UpperNibble << 4) | u8LowerNibble;
	}
	return XST_SUCCESS;
}


