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

`timescale 1ns/1ps

module displayport_v9_0_5_tx_lnk_fifo 
#(
  parameter C_DIN_WIDTH  = 48,
  parameter C_DOUT_WIDTH = 48,
  parameter C_FAMILY = "spartan6"
 )
    (
   input clk, 
   input rst,
   input [C_DIN_WIDTH-1:0] din,   	
   output [C_DOUT_WIDTH-1:0] dout,
   input wr_en, 
   input rd_en,
   output full,
   output overflow,
   output empty, 
   output almost_empty, 	
   output prog_full 	
	);

system_displayport_0_0_tx_lnk_fifo_inst fifo_gen_inst (
//displayport_v8_1_tx_lnk_fifo_inst fifo_gen_inst (
.srst         (rst              ),
.clk          (clk              ),
.din          (din              ),
.wr_en        (wr_en            ),
.rd_en        (rd_en            ),
.dout         (dout             ),
.full         (full             ),
.empty        (empty            ),
.almost_empty (almost_empty     ),
.overflow     (overflow         ),
.prog_full    (prog_full        )
);

endmodule
