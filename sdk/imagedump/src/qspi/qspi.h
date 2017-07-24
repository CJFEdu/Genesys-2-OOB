/******************************************************************************
 * @file qspi.h
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

#ifndef QSPI_H_
#define QSPI_H_

#include "xparameters.h"
#include "xintc.h"
#include "xspi_l.h"
#include "xspi.h"
#include "xil_exception.h"

#define PAGE_SIZE 					256 //Also maximum data byte count
//#define READ_WRITE_EXTRA_BYTES	9 /* Read/Write extra bytes = command + 4 byte address + 0 dummy (LC=11, <=50MHz) + 4 whodafrakknows */
#define READ_EXTRA_BYTES		8 //4
#define WRITE_EXTRA_BYTES		4 //4
#define OTPR_EXTRA_BYTES		5 //cmd + 24-bit address + 1 dummy
#define MAC_OTP_ADDR			0x20 //Base address of MAC address (6 bytes)
#define MAC_OUI_DIGILENT 		0x00183E

#define QSPI_DEVICE_ID	XPAR_QSPI_FLASH_DEVICE_ID
#define QSPI_SS_MASK	0x1	//Slave select 0 is tied to the SS of the flash

#define QSPI_MAN_ID		0X01
#define QSPI_ID_HIGH	0x02
#define QSPI_ID_LOW		0x19
#define QSPI_ID_LENGTH	0x4D

#define PAGE_SIZE 	256 //Also maximum data byte count
/*
 * Definitions of the commands shown in this example.
 */
#define COMMAND_RDSR1			0x05 /* Status read command */
#define COMMAND_RDCR			0x35 /* Status read command */
#define COMMAND_QOR				0x6B /* Read Quad Out (3-byte Address) */
#define COMMAND_4QOR			0x6C /* Read Quad Out (4-byte Address) */
#define COMMAND_QCFR			0x0B /* Read FAST*/
#define COMMAND_QIFP			0x32 /* Quad Input Fast Program */
#define COMMAND_WRR				0x01 /*Write Registers Command*/

#define COMMAND_WRITE_ENABLE	0x06 /* Write Enable Command */

#define COMMAND_BULK_ERASE		0x60 /* Bulk Erase Command */
#define COMMAND_SECTOR_ERASE	0xD8 /* Sector Erase command */
#define COMMAND_4K_SECTOR_ERASE 0x20 /* 4K Parameter Sector Erase */

#define COMMAND_RDID			0x9F /* Read Manufacturer ID */

#define COMMAND_OTPR			0x4B /* OTP Read */
#define COMMAND_OTPP			0x42 /* OTP Program */


/**
 * This definitions number of bytes in each of the command
 * transactions. This count includes Command byte, address bytes and any
 * don't care bytes needed.
 */
#define RDSR1_BYTES				2 /* Status read bytes count */
#define RDCR_BYTES				2 /* Status read bytes count */


//This definitions specify the EXTRA bytes in each of the command
//transactions. This count includes Command byte, address bytes and any
//don't care bytes needed.
//#define READ_WRITE_EXTRA_BYTES	4 /* Read/Write extra bytes */
#define	WRITE_ENABLE_BYTES		1 /* Write Enable bytes */
#define SECTOR_ERASE_BYTES		4 /* Sector erase extra bytes */
#define STATUS_READ_BYTES		2 /* Status read bytes count */
#define CONFIG_READ_BYTES		2 /* Configuration register read bytes count */
#define	WRITE_REGISTER_BYTES	3 /* Write Register bytes */
#define BULK_ERASE_BYTES		1 /* Bulk erase extra bytes */


/*
 * Flash not busy mask in the status register of the flash device.
 */
#define FLASH_SR_IS_READY_MASK		0x01 /* Ready mask */

/*
 * Buffers used during read and write transactions.
 */
u8 rgbReadBuffer[PAGE_SIZE + READ_EXTRA_BYTES];
u8 rgbWriteBuffer[PAGE_SIZE + WRITE_EXTRA_BYTES];

XStatus fnQspiDevInit(XSpi *SpiPtr);
XStatus fnQSpiTest(XSpi *SpiPtr, char const * arg0);
XStatus SpiWriteOTP(XSpi *SpiPtr, u32 Addr, u8 * pMac);
XStatus SpiFlashWaitForFlashReady(XSpi *psQSpi);
XStatus SpiFlashGetStatus(XSpi *psQSpi);
XStatus SpiFlashGetControl(XSpi *psQSpi);
XStatus SpiFlashRead(XSpi *psQSpi, u32 Addr, u32 ByteCount, u8 WriteCmd);
int SpiFlashReadId(XSpi * SpiPtr);
int SpiFlashSectorErase(XSpi *SpiPtr, u32 Addr);
XStatus SpiFlashGetStatus(XSpi *SpiPtr);
XStatus SpiFlashGetControl(XSpi *SpiPtr);
XStatus SpiFlashWaitForFlashReady(XSpi *SpiPtr);
int SpiFlashBulkErase(XSpi *SpiPtr);
int SpiFlashWriteEnable(XSpi *SpiPtr);
int SpiFlashQuadEnable(XSpi *SpiPtr);
int SpiFlashWrite(XSpi *SpiPtr, u32 Addr, u32 ByteCount, u8 WriteCmd, u8 Data[ByteCount]);
void SpiHandler(void *CallBackRef, u32 StatusEvent, unsigned int ByteCount);
XStatus SpiFlashConvertMAC(char const * arg0, u8 *);



#endif /* QSPI_H_ */
