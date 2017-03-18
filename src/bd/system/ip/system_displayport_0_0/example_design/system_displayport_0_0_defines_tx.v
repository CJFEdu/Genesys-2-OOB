// (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved. 
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.


//======================================================================
// HSW=146 HBP=174 HFP=38 VSW=6 VBP=13 VFP=3 CD=16 DW=1
// 512 x 76, 48 bpp video stream, 65.000000 MHz
//[DISPLAY PORT] Link Rate=270, No Of Lanes=4
//======================================================================
`define HSW              20'h0_0092  //20'h0_0092
`define HBP              20'h0_00AE  //20'h0_000E
`define HFP              20'h0_0026  //20'h0_0006
`define HRES             20'h0_0200  //20'h0_0100
`define VSW              20'h0_0006  //20'h0_0006
`define VBP              20'h0_000D  //20'h0_000D
`define VFP              20'h0_0003  //20'h0_0003
`define VRES             20'h0_004C  //20'h0_0002
`define CD               20'h0_0010  //20'h0_0010
`define DW               20'h0_0001  //20'h0_0001
`define VPOL             1'b1 
`define HPOL             1'b1
`define VPOL_HPOL        20'h0_0003 
`define HTOTAL           `HFP + `HBP + `HSW + `HRES
`define VTOTAL           `VFP + `VBP + `VSW + `VRES
`define VTOTAL_MINUS_VFP `VBP + `VSW + `VRES + 1
`define WORDS_PER_LINE   (`HRES * 20'h0_0003) - 20'h0_0001 //(HRES * BPP / 16) -1 
`ifndef LANE_COUNT
`define LANE_COUNT       20'h4
`endif
`ifndef LINK_RATE
`define LINK_RATE        20'h00014 
`endif

//Delay Element
`ifndef TCQ
`define TCQ  100 
`endif

