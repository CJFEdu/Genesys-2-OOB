-- (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: digilentinc.com:ip:rgb2dpvid:1.0
-- IP Revision: 4

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY system_rgb2dpvid_1_0 IS
  PORT (
    PixelClk : IN STD_LOGIC;
    pData : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    pHSync : IN STD_LOGIC;
    pVSync : IN STD_LOGIC;
    pVde : IN STD_LOGIC;
    pVidClk : OUT STD_LOGIC;
    pVidPixel0 : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
    pVidHSync : OUT STD_LOGIC;
    pVidVSync : OUT STD_LOGIC;
    pVidOddEven : OUT STD_LOGIC;
    pVidRst : OUT STD_LOGIC;
    pVidEnable : OUT STD_LOGIC
  );
END system_rgb2dpvid_1_0;

ARCHITECTURE system_rgb2dpvid_1_0_arch OF system_rgb2dpvid_1_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF system_rgb2dpvid_1_0_arch: ARCHITECTURE IS "yes";
  COMPONENT rgb2dpvid IS
    GENERIC (
      kDataWidth : INTEGER
    );
    PORT (
      PixelClk : IN STD_LOGIC;
      pData : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      pHSync : IN STD_LOGIC;
      pVSync : IN STD_LOGIC;
      pVde : IN STD_LOGIC;
      pVidClk : OUT STD_LOGIC;
      pVidPixel0 : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
      pVidHSync : OUT STD_LOGIC;
      pVidVSync : OUT STD_LOGIC;
      pVidOddEven : OUT STD_LOGIC;
      pVidRst : OUT STD_LOGIC;
      pVidEnable : OUT STD_LOGIC
    );
  END COMPONENT rgb2dpvid;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF system_rgb2dpvid_1_0_arch: ARCHITECTURE IS "rgb2dpvid,Vivado 2016.4";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF system_rgb2dpvid_1_0_arch : ARCHITECTURE IS "system_rgb2dpvid_1_0,rgb2dpvid,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF PixelClk: SIGNAL IS "xilinx.com:signal:clock:1.0 ClkIn CLK";
  ATTRIBUTE X_INTERFACE_INFO OF pData: SIGNAL IS "xilinx.com:interface:vid_io:1.0 InputData DATA";
  ATTRIBUTE X_INTERFACE_INFO OF pHSync: SIGNAL IS "xilinx.com:interface:vid_io:1.0 InputData HSYNC";
  ATTRIBUTE X_INTERFACE_INFO OF pVSync: SIGNAL IS "xilinx.com:interface:vid_io:1.0 InputData VSYNC";
  ATTRIBUTE X_INTERFACE_INFO OF pVde: SIGNAL IS "xilinx.com:interface:vid_io:1.0 InputData ACTIVE_VIDEO";
BEGIN
  U0 : rgb2dpvid
    GENERIC MAP (
      kDataWidth => 24
    )
    PORT MAP (
      PixelClk => PixelClk,
      pData => pData,
      pHSync => pHSync,
      pVSync => pVSync,
      pVde => pVde,
      pVidClk => pVidClk,
      pVidPixel0 => pVidPixel0,
      pVidHSync => pVidHSync,
      pVidVSync => pVidVSync,
      pVidOddEven => pVidOddEven,
      pVidRst => pVidRst,
      pVidEnable => pVidEnable
    );
END system_rgb2dpvid_1_0_arch;
