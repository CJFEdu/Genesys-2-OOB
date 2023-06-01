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

//----------------------------------------------
// Directives
//----------------------------------------------
`timescale 1 ps / 1 ps

//----------------------------------------------
// Includes
//----------------------------------------------
`include "displayport_v9_0_5_tx_defs.v"

//----------------------------------------------
// module declaration
//----------------------------------------------
(* DowngradeIPIdentifiedWarnings = "yes" *)
module system_displayport_0_0_tx_phy
#(
    parameter   pDEVICE_FAMILY  = "kintex7",    // select the device family support
    parameter   pDEVICE         = "xc7k325t",   // select the device family support
    parameter   pLANE_COUNT     = 4,    // number of lanes implemented
    parameter   pTCQ            = 100,                  // delay for all register assignments
    parameter   pAC_CAP_DISABLE = "TRUE",               // disable the internal AC capacitor
    parameter   pDATA_WIDTH     = 2,
    parameter   pBUF_BYPASS     = 0
)
(
    // main link transceiver interface
    input  wire         lnk_clk_ibufds,                 // clock input from Input Buffer
    output wire         lnk_clk,                        // link clock for the FPGA fabric

    input  wire [7:0]   lnk_tx_lane0_override_disparity,// override automatic disparity
    input  wire [3:0]   lnk_tx_lane0_k_char,            // control character input
    input  wire [31:0]  lnk_tx_lane0_data,              // transmitter data, lane 0, 16-bits
    input  wire [7:0]   lnk_tx_lane1_override_disparity,// override automatic disparity
    input  wire [3:0]   lnk_tx_lane1_k_char,            // control character input
    input  wire [31:0]  lnk_tx_lane1_data,              // transmitter data, lane 1, 16-bits
    input  wire [7:0]   lnk_tx_lane2_override_disparity,// override automatic disparity
    input  wire [3:0]   lnk_tx_lane2_k_char,            // control character input
    input  wire [31:0]  lnk_tx_lane2_data,              // transmitter data, lane 2, 16-bits
    input  wire [7:0]   lnk_tx_lane3_override_disparity,// override automatic disparity
    input  wire [3:0]   lnk_tx_lane3_k_char,            // control character input
    input  wire [31:0]  lnk_tx_lane3_data,              // transmitter data, lane 3, 16-bits

    output wire [pLANE_COUNT-1:0]   lnk_tx_lane_p,      // lane serial data, p
    output wire [pLANE_COUNT-1:0]   lnk_tx_lane_n,      // lane serial data, n

    // configuration and status
    input  wire `tDPORT_TX_PHY_CONFIG cfg_tx_phy_config,// PHY configuration registers
    output wire `tDPORT_TX_PHY_STATUS cfg_tx_phy_status,// PHY status registers

    // host clock for the DRP control
    input  wire         apb_clk,                        // apb host clock
    input  wire         apb_reset,                      // apb host reset

    // AUX channel interface
    input  wire         aux_data_out,                   // manchester encoded serial data out, positive polarity only
    output wire         aux_data_in,                    // manchester encoded serial data in, positive polarity only
    input  wire         aux_data_enable_n,              // data enable of aux serial data

 
    output wire         aux_tx_out_channel_p,           // positive polarity of the AUX Manchester-II data
    output wire         aux_tx_out_channel_n,           // negative polarity of the AUX Manchester-II data
    input  wire         aux_tx_in_channel_p,            // positive polarity of the AUX Manchester-II data
    input  wire         aux_tx_in_channel_n,            // negative polarity of the AUX Manchester-II data

    // HPD interface
    input  wire         hpd,                            // hot plug detect signal
    output wire         hot_plug_detect,                // HPD signal to link controller

    output wire         link_bw_high_out,
    output wire         link_bw_hbr2_out,
    output wire         bw_changed_out,
    output wire         phy_pll_reset_out,


   // GT Common Ports (QPLL)
    input           gt0_qpllclk_in,
    input           gt0_qpllclk_lock,
    input           gt0_qpllrefclk_in

);

 //---------------------------------------------
 // internal signal definitions
 //--------------------------------------------
 wire [3:0]      i_lnk_tx_lane_p_w;
 wire [3:0]      i_lnk_tx_lane_n_w;
 wire            i_phy_reset;                            // combined reset
 wire            i_tx_phy_reset;                         // global reset for the PHY
 wire            i_tx_phy_reset_2;                       // secondary reset for the transmitter phy sections

 wire            i_buf_reset;                
 wire            i_pma_reset;                
 wire            i_pcs_reset;                
 wire [2:0]      i_loopback;                
 wire            i_prbs_force_err;          
 wire            i_txpolarity_lane0;              
 wire            i_txpolarity_lane1;              
 wire            i_txpolarity_lane2;              
 wire            i_txpolarity_lane3;              
 wire            i_pll_reset;                            // reset the clock generator PLL
 wire [3:0]      i_tx_voltage_swing_lane_0;
 wire [3:0]      i_tx_voltage_swing_lane_1;
 wire [3:0]      i_tx_voltage_swing_lane_2;
 wire [3:0]      i_tx_voltage_swing_lane_3;
 wire [2:0]      i_tx_enable_prbs7;
 wire [3:0]      i_tx_power_down;                        // power down the PHY
 wire [1:0]      i_tx_buffer_status_lane_0;
 wire [1:0]      i_tx_buffer_status_lane_1;
 wire [1:0]      i_tx_buffer_status_lane_2;
 wire [1:0]      i_tx_buffer_status_lane_3;
 // clocking source signals
 wire            i_lnk_clk_out;
 wire            i_lnk_clk_out_buf;
 wire            i_lnk_clk_out2_buf;
 wire            i_lnk_clk_out_bufgt;

 // GT status signals
 wire            i_pll_lock_detect_tile_0;
 wire            i_pll_lock_detect_tile_1;
 wire            i_pll_lock_detect_tile_00;
 wire            i_pll_lock_detect_tile_01;
 wire            i_pll_lock_detect_tile_10;
 wire            i_pll_lock_detect_tile_11;
 wire [1:0]      i_reset_done_tile_0;
 wire [1:0]      i_reset_done_tile_1;
 wire [3:0]      i_tx_pma_reset_done_out;
 // drp signals
  reg  [8:0]      i_drp_state;
  reg             i_detect_clock_update;
  reg             i_drp_enable;
  wire            i_drp_busy;
  reg             i_drp_write;
  reg             i_drp_locked=1'b0;
  wire [15:0]     i_drp_read_data;
  reg  [15:0]     i_drp_write_data;
  wire [1:0]      i_drp_ready;
  wire            i_drp_ready00, i_drp_ready01;
  wire            i_drp_ready10, i_drp_ready11;
  reg  [7:0]      i_drp_addr;
  reg  [7:0]      i_auto_reset;
  wire            bw_changed;
  wire            link_bw_high;
  wire            link_bw_hbr2;
  wire            link_bw_rbr;
  wire            i_pll_locked;
  reg [2:0]       i_clk_select0 ;
  reg [2:0]       i_clk_select1 ;
  wire            gtp_recclk_out;   // RXRECCLK0
  wire            gtp_refclk_out;   // TXREFCLK0
  wire [2:0]      i_tx_preemphasis_lane_0;
  wire [2:0]      i_tx_preemphasis_lane_1;
  wire [2:0]      i_tx_preemphasis_lane_2;
  wire [2:0]      i_tx_preemphasis_lane_3;
  wire            lnk_clk_135;
  wire            lnk_clk_81;
  wire            ref_clk_135;
  wire            ref_clk_81;
  wire            s6tile_01_clk01;
  wire            s6tile_01_clk23;
  wire            i_clkout0;
  wire            i_clkout0_buf;
  wire            i_clkout2;
  wire            i_clkout2_buf;
  wire            i_clkfbout;
  wire [4:0]      i_tx_precursor_lane_0;
  wire [4:0]      i_tx_precursor_lane_1;
  wire [4:0]      i_tx_precursor_lane_2;
  wire [4:0]      i_tx_precursor_lane_3;
  wire [4:0]      i_tx_postcursor_lane_0;
  wire [4:0]      i_tx_postcursor_lane_1;
  wire [4:0]      i_tx_postcursor_lane_2;
  wire [4:0]      i_tx_postcursor_lane_3;
  reg             i_gtx_test;
  reg  [9:0]      i_rst_count;
  reg             i_tx_user_ready;

 wire          lnk_clk_p_buf;
 wire          lnk_clk_n_buf;
 wire	       locked_o;

 //    --------------------------- TX Buffer Bypass Signals --------------------
    wire  [pLANE_COUNT-1 : 0]        U0_TXDLYEN;
    wire  [pLANE_COUNT-1 : 0]        U0_TXDLYSRESET;
    wire  [pLANE_COUNT-1 : 0]        U0_TXDLYSRESETDONE;
    wire  [pLANE_COUNT-1 : 0]        U0_TXPHINIT;
    wire  [pLANE_COUNT-1 : 0]        U0_TXPHINITDONE;
    wire  [pLANE_COUNT-1 : 0]        U0_TXPHALIGN;
    wire  [pLANE_COUNT-1 : 0]        U0_TXPHALIGNDONE ;
    wire   i_reset_done;
    wire   U0_run_tx_phalignment_i;
    wire   U0_rst_tx_phalignment_i;
    wire   gt0_txphaligndone_i;
    wire   gt0_txdlysreset_i;
    wire   gt0_txdlysresetdone_i;
    wire   gt0_txphdlyreset_i;
    wire   gt0_txphalignen_i;
    wire   gt0_txdlyen_i;
    wire   gt0_txphalign_i;
    wire   gt0_txphinit_i;
    wire   gt0_txphinitdone_i;
    wire   run_tx_phalignment_i;
    wire   rst_tx_phalignment_i;
    wire   gt0_tx_phalignment_done_i;

    wire   gt1_txphaligndone_i;
    wire   gt1_txdlysreset_i;
    wire   gt1_txdlysresetdone_i;
    wire   gt1_txphdlyreset_i;
    wire   gt1_txphalignen_i;
    wire   gt1_txdlyen_i;
    wire   gt1_txphalign_i;
    wire   gt1_txphinit_i;
    wire   gt1_txphinitdone_i;
    wire   gt1_run_tx_phalignment_i;
    wire   gt1_rst_tx_phalignment_i;
    wire   gt1_tx_phalignment_done_i;
    wire   gt2_txphaligndone_i;
    wire   gt2_txdlysreset_i;
    wire   gt2_txdlysresetdone_i;
    wire   gt2_txphdlyreset_i;
    wire   gt2_txphalignen_i;
    wire   gt2_txdlyen_i;
    wire   gt2_txphalign_i;
    wire   gt2_txphinit_i;
    wire   gt2_txphinitdone_i;
    wire   gt2_run_tx_phalignment_i;
    wire   gt2_rst_tx_phalignment_i;
    wire   gt2_tx_phalignment_done_i;
    wire   gt3_txphaligndone_i;
    wire   gt3_txdlysreset_i;
    wire   gt3_txdlysresetdone_i;
    wire   gt3_txphdlyreset_i;
    wire   gt3_txphalignen_i;
    wire   gt3_txdlyen_i;
    wire   gt3_txphalign_i;
    wire   gt3_txphinit_i;
    wire   gt3_txphinitdone_i;
    wire   gt3_run_tx_phalignment_i;
    wire   gt3_rst_tx_phalignment_i;
    wire   gt3_tx_phalignment_done_i;

    wire  tied_to_ground_i;
    wire  tied_to_vcc_i;
    wire [15:0] gt_pcsrsvdin_in;
    wire        gt_txinhibit;

    assign  tied_to_ground_i                     =  1'b0;
    assign  tied_to_vcc_i                        =  1'b1;
 //--------------------------------------------------------------------------------
 // LPM enable signals to be high when link rate is 5.4.
 //--------------------------------------------------------------------------------

  wire GT0_RXLPMEN_IN;
  wire GT1_RXLPMEN_IN;
  wire GT2_RXLPMEN_IN;
  wire GT3_RXLPMEN_IN;
  wire tx8b10ben;


 //--------------------------------------------------------------------------------
 // This PHY is targetted to S6 CVK.
 // For a custom board, Please see the available clocking and make connections to CLK10/11.
 // pUSE_GT_REF_CLKS controls the clk_sel logic for correct clock selection.
 //--------------------------------------------------------------------------------
 localparam      pUSE_GT_REF_CLKS   = 1'b0;   // Signal to indicate logic to use CLK00/01 & CLK10/11
 //----------------------------------------------
 // DRP state machine for 7-series
 //----------------------------------------------
 localparam      pDS_IDLE             = 9'h 001;
 localparam      pDS_WAIT_READ        = 9'h 002;
 localparam      pDS_WAIT_WRITE       = 9'h 004;
 localparam      pDS_WAIT_READ2       = 9'h 008;
 localparam      pDS_WAIT_WRITE2      = 9'h 010;
 localparam      pDS_HOST_ACCESS      = 9'h 020;
 localparam      pDS_WAIT_READ3       = 9'h 040;
 localparam      pDS_WAIT_WRITE3      = 9'h 080;
 localparam      pDS_HOST_ACCESS_WAIT = 9'h 100;
 //----------------------------------------------
 // DRP state machine for A7
 //----------------------------------------------
 localparam      pDS_WAIT_READ_COM    = 9'h 008;
 localparam      pDS_WAIT_WRITE_COM   = 9'h 010;

 //----------------------------------------------------------
 // handle verilog parameterized lane count by using internal
 //----------------------------------------------------------
 assign  lnk_tx_lane_p = i_lnk_tx_lane_p_w[pLANE_COUNT-1:0];
 assign  lnk_tx_lane_n = i_lnk_tx_lane_n_w[pLANE_COUNT-1:0];
 //--------------------------------------------------------------------------------
 //  Global - map internal signals
 //--------------------------------------------------------------------------------
 assign  i_buf_reset               = cfg_tx_phy_config[`kCFG_TX_PHY_BUF_RST];
 assign  i_pcs_reset               = cfg_tx_phy_config[`kCFG_TX_PHY_PCS_RST];
 assign  i_pma_reset               = cfg_tx_phy_config[`kCFG_TX_PHY_PMA_RST];
 assign  i_loopback                = cfg_tx_phy_config[`kCFG_TX_PHY_LOOPBACK];
 assign  i_prbs_force_err          = cfg_tx_phy_config[`kCFG_TX_PHY_PRBSFORCEERR];
 assign  i_txpolarity_lane0        = (cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY_LANE_CTRL] == 1'b1)?cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY_LANE0]:cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY];
 assign  i_txpolarity_lane1        = (cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY_LANE_CTRL] == 1'b1)?cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY_LANE1]:cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY]; 
 assign  i_txpolarity_lane2        = (cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY_LANE_CTRL] == 1'b1)?cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY_LANE2]:cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY]; 
 assign  i_txpolarity_lane3        = (cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY_LANE_CTRL] == 1'b1)?cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY_LANE3]:cfg_tx_phy_config[`kCFG_TX_PHY_TXPOLARITY]; 
 assign  i_tx_voltage_swing_lane_0 = cfg_tx_phy_config[`kCFG_TX_PHY_VOLTAGE_DIFF_LANE_0];
 assign  i_tx_voltage_swing_lane_1 = cfg_tx_phy_config[`kCFG_TX_PHY_VOLTAGE_DIFF_LANE_1];
 assign  i_tx_voltage_swing_lane_2 = cfg_tx_phy_config[`kCFG_TX_PHY_VOLTAGE_DIFF_LANE_2];
 assign  i_tx_voltage_swing_lane_3 = cfg_tx_phy_config[`kCFG_TX_PHY_VOLTAGE_DIFF_LANE_3];
 assign  i_tx_phy_reset            = cfg_tx_phy_config[`kCFG_TX_PHY_RESET];
 assign  i_tx_enable_prbs7         = (cfg_tx_phy_config[`kCFG_TX_PHY_TRANSMIT_PRBS7] == 1'b1) ? 3'b 001 : 3'b 000;
 assign  i_tx_power_down           = cfg_tx_phy_config[`kCFG_TX_PHY_POWER_DOWN];
 assign  i_phy_reset               = (i_tx_phy_reset | i_auto_reset[7]);
 assign  i_pll_reset               = ~i_pll_lock_detect_tile_0;
 assign  cfg_tx_phy_status[1:0]    = i_reset_done_tile_0;
 assign  cfg_tx_phy_status[3:2]    = i_reset_done_tile_1;
 assign  cfg_tx_phy_status[4]      = i_pll_lock_detect_tile_0;
 assign  cfg_tx_phy_status[5]      = i_pll_lock_detect_tile_1;
 assign  cfg_tx_phy_status[6]      = i_pll_locked;
 assign  cfg_tx_phy_status[10:7]   = 4'h0;
 assign  cfg_tx_phy_status[15:11]  = 8'h00;
 assign  cfg_tx_phy_status[17:16]  = i_tx_buffer_status_lane_0;
 assign  cfg_tx_phy_status[19:18]  = 2'b00;
 assign  cfg_tx_phy_status[21:20]  = i_tx_buffer_status_lane_1;
 assign  cfg_tx_phy_status[23:22]  = 2'b00;
 assign  cfg_tx_phy_status[25:24]  = i_tx_buffer_status_lane_2;
 assign  cfg_tx_phy_status[27:26]  = 2'b00;
 assign  cfg_tx_phy_status[29:28]  = i_tx_buffer_status_lane_3;
 assign  cfg_tx_phy_status[31:30]  = 2'b00;
 assign  cfg_tx_phy_status[`kCFG_TX_PHY_STATUS_DRP_LOCKED]  = i_drp_locked;
 assign  cfg_tx_phy_status[`kCFG_TX_PHY_STATUS_DRP_READY]   = (i_drp_ready==2'b11);
 assign  cfg_tx_phy_status[`kCFG_TX_PHY_STATUS_DRP_RDATA]   = i_drp_read_data;     
 //----------------------------------------------
 // DRP machine assigns
 //----------------------------------------------
 assign  bw_changed                = ( i_detect_clock_update != cfg_tx_phy_config[`kCFG_TX_PHY_PLL_FB_UPDATE] );
 assign  link_bw_high              = ( cfg_tx_phy_config[`kCFG_TX_PHY_PLL_FB_SETTING] == 8'h 3 ); // for 2.72
 assign  link_bw_hbr2              = ( cfg_tx_phy_config[`kCFG_TX_PHY_PLL_FB_SETTING] == 8'h 5 ); // hbr2
 assign  link_bw_rbr               = ( cfg_tx_phy_config[`kCFG_TX_PHY_PLL_FB_SETTING] == 8'h 1 ); // rbr

 assign bw_changed_out   = bw_changed;
 assign link_bw_hbr2_out = link_bw_hbr2;
 assign link_bw_high_out = link_bw_high;
 assign phy_pll_reset_out = i_phy_reset;
 assign tx8b10ben = cfg_tx_phy_config[`kCFG_TX_PHY_8B10BEN];
 assign gt_txinhibit = cfg_tx_phy_config[`kCFG_TXINHIBIT];

 //----------------------------------------------
 // store the value of the previous select to detect a change
 //----------------------------------------------
 always @ (posedge apb_clk)
 begin
    if (apb_reset == 1'b1)
    begin
       i_detect_clock_update <= #pTCQ 1'b0;
    end
    else
    begin
       i_detect_clock_update <= #pTCQ cfg_tx_phy_config[`kCFG_TX_PHY_PLL_FB_UPDATE];
    end
 end
 //

   
 //------------------------------------------------------------------------------------------------------------
 //                               7-Series  PHY components
 //------------------------------------------------------------------------------------------------------------
 generate if ( ( pDEVICE_FAMILY == "virtex7" ) | ( pDEVICE_FAMILY == "kintex7" ) | ( pDEVICE_FAMILY == "virtexu" ) | ( pDEVICE_FAMILY == "kintexu" ) |
               ( pDEVICE_FAMILY == "kintexuplus" ) | ( pDEVICE_FAMILY == "zynquplus" ))
 begin //{

        assign i_lnk_clk_out_bufgt = i_lnk_clk_out;  



      //----------------------------------------------
      // link_clk out from GT routed through BUFG
      //----------------------------------------------
      assign i_lnk_clk_out2_buf = i_lnk_clk_out_buf;
      BUFG ref_clk_out_bufg_gtx_gth
      (
          .O              (i_lnk_clk_out_buf),
          .I              (i_lnk_clk_out_bufgt)
      );

    assign i_tx_phy_reset_2         = cfg_tx_phy_config[`kCFG_TX_PHY_RESET_2] | ~i_pll_lock_detect_tile_0 | ~i_pll_lock_detect_tile_1;
    assign i_tx_precursor_lane_0    = cfg_tx_phy_config[`kCFG_TX_PHY_PRECURSOR_LANE_0];
    assign i_tx_precursor_lane_1    = cfg_tx_phy_config[`kCFG_TX_PHY_PRECURSOR_LANE_1];
    assign i_tx_precursor_lane_2    = cfg_tx_phy_config[`kCFG_TX_PHY_PRECURSOR_LANE_2];
    assign i_tx_precursor_lane_3    = cfg_tx_phy_config[`kCFG_TX_PHY_PRECURSOR_LANE_3];
    assign i_tx_postcursor_lane_0   = cfg_tx_phy_config[`kCFG_TX_PHY_POSTCURSOR_LANE_0];
    assign i_tx_postcursor_lane_1   = cfg_tx_phy_config[`kCFG_TX_PHY_POSTCURSOR_LANE_1];
    assign i_tx_postcursor_lane_2   = cfg_tx_phy_config[`kCFG_TX_PHY_POSTCURSOR_LANE_2];
    assign i_tx_postcursor_lane_3   = cfg_tx_phy_config[`kCFG_TX_PHY_POSTCURSOR_LANE_3];
    assign i_pll_lock_detect_tile_0 = i_pll_lock_detect_tile_00 & i_pll_lock_detect_tile_01;
    assign i_pll_lock_detect_tile_1 = i_pll_lock_detect_tile_10 & i_pll_lock_detect_tile_11;
    assign i_drp_ready[0]           = i_drp_ready00 & i_drp_ready01;
    assign i_drp_ready[1]           = i_drp_ready10 & i_drp_ready11;
    assign lnk_clk                  = i_lnk_clk_out2_buf;
    assign i_pll_locked             = 1'b 1;
    assign GT0_RXLPMEN_IN           = 1'b0;
    assign GT1_RXLPMEN_IN           = 1'b0;
    assign GT2_RXLPMEN_IN           = 1'b0;
    assign GT3_RXLPMEN_IN           = 1'b0;
    assign gt_pcsrsvdin_in          =  cfg_tx_phy_config[`kCFG_TX_PHY_PCSRSVDIN]; 




    //----------------------------------------------
    // 7 series DRP registers
    //----------------------------------------------
    //05E
    //15:14 R/W SATA_CPLL_CFG 0
    //13    NOT DEFINED
    //12:8  R/W CPLL_REFCLK_DIV 4:0 1->10
    //7     R/W CPLL_FBDIV_45 5->1
    //6:0   R/W CPLL_FBDIV 6:0 5->3, 3->1
    //------------------------------------------------------------
    //088 
    //6:4 R/W TXOUT_DIV 2:0  1->0 ,2->1 ,4->2 ,8->3 ,16->4
    //2:0 R/W RXOUT_DIV 2:0  1->0 ,2->1 ,4->2 ,8->3 ,16->4
    //------------------------------------------------------------
      wire [15:0] v7_drp_data_5e = ( link_bw_high | link_bw_hbr2 ) ? { i_drp_read_data[15:13], 13'h 1003 } :
                                                                   { i_drp_read_data[15:13], 13'h 1001 } ;
    wire [15:0] v7_drp_data_88 = ( link_bw_hbr2 ) ? { i_drp_read_data[15:7], 3'h 0, i_drp_read_data[3], 3'h 0 } :
                                                    { i_drp_read_data[15:7], 3'h 1, i_drp_read_data[3], 3'h 1 } ;
    //----------------------------------------------
    //  DRP state machine
    //----------------------------------------------
    always @ (posedge apb_clk)
    begin
       if (apb_reset == 1'b1)
       begin
          i_drp_state      <= #pTCQ pDS_IDLE;
          i_drp_enable     <= #pTCQ 1'b0;
          i_drp_write      <= #pTCQ 1'b0;
          i_drp_write_data <= #pTCQ 16'h0000;
          i_drp_addr       <= #pTCQ 8'h00;
          i_drp_locked     <= #pTCQ 1'b0;
       end
       else
       begin
          i_drp_enable     <= #pTCQ 1'b 0;
          i_drp_write      <= #pTCQ 1'b 0;
          case ( i_drp_state )
             pDS_IDLE:
             begin
                i_drp_locked     <= #pTCQ 1'b0;
                if ( bw_changed | cfg_tx_phy_config[`kCFG_TX_PHY_DRP_ACCESS] )
                begin
                   i_drp_addr       <= #pTCQ 8'h 5e;
                   i_drp_state      <= #pTCQ (cfg_tx_phy_config[`kCFG_TX_PHY_DRP_ACCESS])?pDS_HOST_ACCESS:pDS_WAIT_READ;
                   i_drp_enable     <= #pTCQ (cfg_tx_phy_config[`kCFG_TX_PHY_DRP_ACCESS])?1'b 0:1'b 1;
                end
                else
                begin
                   i_drp_state      <= #pTCQ pDS_IDLE;
                end
             end

             pDS_HOST_ACCESS:
             begin
                   i_drp_locked     <= #pTCQ 1'b0;
                   i_drp_enable     <= #pTCQ 1'b1;
                   i_drp_addr       <= #pTCQ cfg_tx_phy_config[`kCFG_TX_PHY_DRP_ADDR];
                   i_drp_write_data <= #pTCQ cfg_tx_phy_config[`kCFG_TX_PHY_DRP_WDATA];
                   i_drp_write      <= #pTCQ cfg_tx_phy_config[`kCFG_TX_PHY_DRP_WRITE];
                   if ( i_drp_ready == 2'b11 )
                     i_drp_state      <= #pTCQ pDS_IDLE;
                   else
                     i_drp_state      <= #pTCQ pDS_HOST_ACCESS_WAIT;
             end
            
             pDS_HOST_ACCESS_WAIT:
             begin
                   i_drp_locked     <= #pTCQ 1'b0;
                   i_drp_enable     <= #pTCQ 1'b0;
                   i_drp_addr       <= #pTCQ cfg_tx_phy_config[`kCFG_TX_PHY_DRP_ADDR];
                   i_drp_write_data <= #pTCQ cfg_tx_phy_config[`kCFG_TX_PHY_DRP_WDATA];
                   i_drp_write      <= #pTCQ 1'b0;
                   if ( i_drp_ready == 2'b11 )
                     i_drp_state      <= #pTCQ pDS_IDLE;
                   else
                     i_drp_state      <= #pTCQ pDS_HOST_ACCESS_WAIT;
             end

             pDS_WAIT_READ:
             begin
                i_drp_locked     <= #pTCQ 1'b1;
                if ( i_drp_ready == 2'b11 )
                begin
                   i_drp_addr       <= #pTCQ 8'h 5e;
                   i_drp_write_data <= #pTCQ v7_drp_data_5e;
                   i_drp_state      <= #pTCQ pDS_WAIT_WRITE;
                   i_drp_enable     <= #pTCQ 1'b 1;
                   i_drp_write      <= #pTCQ 1'b 1;
                end
                else
                begin
                   i_drp_state      <= #pTCQ pDS_WAIT_READ;
                end
             end
             pDS_WAIT_WRITE:
             begin
                if ( i_drp_ready == 2'b11 )
                begin
                   i_drp_addr       <= #pTCQ 8'h 88;
                   i_drp_state      <= #pTCQ pDS_WAIT_READ2;
                   i_drp_enable     <= #pTCQ 1'b 1;
                end
                else
                begin
                   i_drp_state      <= #pTCQ pDS_WAIT_WRITE;
                end
             end
             pDS_WAIT_READ2:
             begin
                if ( i_drp_ready == 2'b11 )
                begin
                   i_drp_addr       <= #pTCQ 8'h 88;
                   i_drp_write_data <= #pTCQ v7_drp_data_88;
                   i_drp_state      <= #pTCQ pDS_WAIT_WRITE2;
                   i_drp_enable     <= #pTCQ 1'b 1;
                   i_drp_write      <= #pTCQ 1'b 1;
                end
                else
                begin
                   i_drp_state      <= #pTCQ pDS_WAIT_READ2;
                end
             end
             pDS_WAIT_WRITE2:
             begin
                if ( i_drp_ready == 2'b11 )
                begin
                   i_drp_state      <= #pTCQ pDS_IDLE;
                end
                else
                begin
                   i_drp_state      <= #pTCQ pDS_WAIT_WRITE2;
                end
             end
          endcase
       end
    end
    //----------------------------------------------
    //  Automatic reset after a link rate change
    //----------------------------------------------
    always @ (posedge apb_clk)
    begin
       if (apb_reset == 1'b1)
       begin
          i_auto_reset <= 8'h00;
       end
       else
       begin
          // At the end of a link change reset
          if (i_drp_state == pDS_WAIT_WRITE2 && i_drp_ready == 2'b11)
          begin
             i_auto_reset <= #pTCQ 8'hff;
          end
          else
          begin
             i_auto_reset <= #pTCQ {i_auto_reset[6:0], 1'b0};
          end
       end
    end
    //----------------------------------------------
    // User ready signaling for 7 series (async reset)
    //----------------------------------------------
    always @ ( posedge lnk_clk or posedge i_phy_reset )
    begin
       if ( i_phy_reset )
       begin
          i_tx_user_ready <= 1'b 0;
       end
       else
       begin
          i_tx_user_ready <= i_pll_lock_detect_tile_00 & i_pll_lock_detect_tile_01 &
                             i_pll_lock_detect_tile_10 & i_pll_lock_detect_tile_11;
       end
    end

    //----------------------------------------------
    // Hot Plug Detect
    //----------------------------------------------
    IBUF  hot_plug_detect_inst (
        .O (hot_plug_detect),
        .I (hpd)
    );
    //----------------------------------------------
    // AUX Channel
    //----------------------------------------------
   IBUFDS
    #(  .DIFF_TERM ("TRUE")
    ) aux_tx_in_channel_inst (
        .O  (aux_data_in),
        .I  (aux_tx_in_channel_p),
        .IB (aux_tx_in_channel_n)
    );

    OBUFTDS  aux_tx_out_channel_inst (
        .O   (aux_tx_out_channel_p),
        .OB  (aux_tx_out_channel_n),
        .I   (aux_data_out),
        .T   (aux_data_enable_n)
    );


 end //}
 endgenerate

 //----------------------------------------------
 // 7-Series GTX2
 //----------------------------------------------
 generate if ( ( ( pDEVICE_FAMILY == "virtex7" )   | ( pDEVICE_FAMILY == "kintex7" ) | ( pDEVICE_FAMILY == "virtexu" ) | ( pDEVICE_FAMILY == "kintexu" ) 
                  | ( pDEVICE_FAMILY == "kintexuplus" ) | ( pDEVICE_FAMILY == "zynquplus" )) & ( pLANE_COUNT == 1 ) )
 begin //{



    system_displayport_0_0_gt_7_series_wrapper_1
    #(
        .WRAPPER_SIM_GTRESET_SPEEDUP   ("TRUE")
    )
    gt_wrapper_inst
    (
        .GT0_RXDFEAGCHOLD_IN            (1'b 0),
        .GT0_RXDFELFHOLD_IN             (1'b 0),

        .GT0_TX8B10BEN_IN               (tx8b10ben),
        .GT0_RX8B10BEN_IN               (1'b1),
        .GT0_RXDFELPMRESET_IN           (1'b0), 
        .GT0_RXLPMLFHOLD_IN             (1'b0),   
        .GT0_RXLPMHFHOLD_IN             (1'b0), 
        .GT0_RXLPMHFOVRDEN_IN           (1'b0), 
        .GT0_RXCDRHOLD_IN               (1'b0), 
        .GT0_LOOPBACK_IN                (i_loopback), 
        .GT0_RXPOLARITY_IN              (1'b0),
        .GT0_TXPOLARITY_IN              (i_txpolarity_lane0),
        .GT0_DMONITOROUT_OUT            (),

        .GT0_RXLPMEN_IN                 (GT0_RXLPMEN_IN), 
        .GT0_DRPADDR_IN                 ({ 1'b 0, i_drp_addr }),
	
        .GT0_DRPCLK_IN                  (apb_clk),
        .GT0_DRPDI_IN                   (i_drp_write_data),
        .GT0_DRPDO_OUT                  (i_drp_read_data),
        .GT0_DRPEN_IN                   (i_drp_enable),
        .GT0_DRPRDY_OUT                 (i_drp_ready00),
        .GT0_DRPWE_IN                   (i_drp_write),
        .GT0_GTREFCLK0_IN               (lnk_clk_ibufds),
	.GT0_GTREFCLK1_IN               (1'b0),
        .GT0_GTREFCLKSEL_IN             (3'b001),
        .GT0_CPLLFBCLKLOST_OUT          (),
        .GT0_CPLLLOCK_OUT               (i_pll_lock_detect_tile_00),
        .GT0_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT0_CPLLREFCLKLOST_OUT         (),
        .GT0_CPLLRESET_IN               (i_phy_reset),
        .GT0_EYESCANRESET_IN            (1'b0),
        .GT0_EYESCANTRIGGER_IN          (1'b0),
        .GT0_EYESCANDATAERROR_OUT       (),
        .GT0_RXPD_IN                    (2'b 0),
        .GT0_TXPD_IN                    ({i_tx_power_down[0], i_tx_power_down[0]}),
        .GT0_RXUSERRDY_IN               (1'b 0),
        .GT0_RXCHARISK_OUT              (),
        .GT0_RXDISPERR_OUT              (),
        .GT0_RXNOTINTABLE_OUT           (),
        .GT0_RXBYTEISALIGNED_OUT        (),
        .GT0_RXCOMMADET_OUT             (),
        .GT0_RXMCOMMAALIGNEN_IN         (1'b 0),
        .GT0_RXPCOMMAALIGNEN_IN         (1'b 0),
        .GT0_RXPRBSCNTRESET_IN          (1'b 0),
        .GT0_RXPRBSERR_OUT              (),
        .GT0_RXPRBSSEL_IN               (3'b 0),
        .GT0_GTRXRESET_IN               (i_tx_phy_reset_2),
        .GT0_RXDATA_OUT                 (),
        .GT0_RXOUTCLK_OUT               (),
        .GT0_RXPCSRESET_IN              (1'b0),
        .GT0_RXPMARESET_IN              (1'b0),
        .GT0_RXUSRCLK_IN                (i_lnk_clk_out_buf),
        .GT0_RXUSRCLK2_IN               (i_lnk_clk_out_buf),
        .GT0_GTXRXN_IN                  (1'b 1),
        .GT0_GTXRXP_IN                  (1'b 1),
        .GT0_GTXTXN_OUT                 (i_lnk_tx_lane_n_w[0]),
        .GT0_GTXTXP_OUT                 (i_lnk_tx_lane_p_w[0]),


        .GT0_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
 //    .GT0_RXCDRRESET_IN              (i_tx_phy_reset_2),
        .GT0_RXELECIDLE_OUT             (),
        .GT0_RXBUFRESET_IN              (1'b0),
        .GT0_RXBUFSTATUS_OUT            (),
        .GT0_RXRESETDONE_OUT            (),

        .GT0_TXPOSTCURSOR_IN            (i_tx_postcursor_lane_0),
        .GT0_TXPRECURSOR_IN             (i_tx_precursor_lane_0),
        .GT0_TXUSERRDY_IN               (i_tx_user_ready),
        .GT0_TXCHARISK_IN               (lnk_tx_lane0_k_char),
        .GT0_TXCHARDISPVAL_IN           ({lnk_tx_lane0_override_disparity[6], lnk_tx_lane0_override_disparity[4], lnk_tx_lane0_override_disparity[2], lnk_tx_lane0_override_disparity[0]}),
        .GT0_TXCHARDISPMODE_IN          ({lnk_tx_lane0_override_disparity[7], lnk_tx_lane0_override_disparity[5], lnk_tx_lane0_override_disparity[3], lnk_tx_lane0_override_disparity[1]}),
        .GT0_GTTXRESET_IN               (i_tx_phy_reset_2),
        .GT0_TXDATA_IN                  (lnk_tx_lane0_data),
        .GT0_TXOUTCLK_OUT               (i_lnk_clk_out),
        .GT0_TXOUTCLKFABRIC_OUT         (),
        .GT0_TXOUTCLKPCS_OUT            (),
        .GT0_TXPCSRESET_IN              (i_pcs_reset),
        .GT0_TXPMARESET_IN              (i_pma_reset),
        .GT0_TXUSRCLK_IN                (i_lnk_clk_out2_buf),
        .GT0_TXUSRCLK2_IN               (i_lnk_clk_out2_buf),
        .GT0_TXDIFFCTRL_IN              (i_tx_voltage_swing_lane_0),
        .GT0_TXINHIBIT_IN               (gt_txinhibit),
        .GT0_TXBUFSTATUS_OUT            (i_tx_buffer_status_lane_0),
        .GT0_TXRESETDONE_OUT            (i_reset_done_tile_0[0]),
        .GT0_TXPRBSFORCEERR_IN          (i_prbs_force_err),
        .GT0_TXPRBSSEL_IN               (i_tx_enable_prbs7),
        //Common Ports - QPLL
        .GT0_QPLLCLK_IN                 (gt0_qpllclk_in),
        .GT0_QPLLREFCLK_IN              (gt0_qpllrefclk_in)
    );
 end //}
 else if ( ( ( pDEVICE_FAMILY == "virtex7" ) | ( pDEVICE_FAMILY == "kintex7" ) | ( pDEVICE_FAMILY == "virtexu" ) | ( pDEVICE_FAMILY == "kintexu" )
            |( pDEVICE_FAMILY == "kintexuplus" ) | ( pDEVICE_FAMILY == "zynquplus" )) & ( pLANE_COUNT == 2 ) )
 begin //{

    system_displayport_0_0_gt_7_series_wrapper_2
    #(
        .WRAPPER_SIM_GTRESET_SPEEDUP   ("TRUE")
    )
    gt_wrapper_inst
    (
        .GT0_RXDFEAGCHOLD_IN            (1'b 0),
        .GT0_RXDFELFHOLD_IN             (1'b 0),
        .GT1_RXDFEAGCHOLD_IN            (1'b 0),
        .GT1_RXDFELFHOLD_IN             (1'b 0),
        .GT0_TX8B10BEN_IN               (tx8b10ben),
        .GT0_RX8B10BEN_IN               (1'b1),
        .GT1_TX8B10BEN_IN               (tx8b10ben),
        .GT1_RX8B10BEN_IN               (1'b1),
        .GT0_RXDFELPMRESET_IN           (1'b0), 
        .GT0_RXLPMLFHOLD_IN             (1'b0),   
        .GT0_RXLPMHFHOLD_IN             (1'b0), 
        .GT0_RXLPMHFOVRDEN_IN           (1'b0), 
        .GT0_RXCDRHOLD_IN               (1'b0), 
        .GT0_LOOPBACK_IN                (i_loopback), 
        .GT0_RXPOLARITY_IN              (1'b0),
        .GT0_TXPOLARITY_IN              (i_txpolarity_lane0),
        .GT0_DMONITOROUT_OUT            (),

        .GT0_RXLPMEN_IN                 (GT0_RXLPMEN_IN), 
        .GT0_DRPADDR_IN                 ({ 1'b 0, i_drp_addr }),
	
        .GT0_DRPCLK_IN                  (apb_clk),
        .GT0_DRPDI_IN                   (i_drp_write_data),
        .GT0_DRPDO_OUT                  (i_drp_read_data),
        .GT0_DRPEN_IN                   (i_drp_enable),
        .GT0_DRPRDY_OUT                 (i_drp_ready00),
        .GT0_DRPWE_IN                   (i_drp_write),
        .GT0_GTREFCLK0_IN               (lnk_clk_ibufds),
	.GT0_GTREFCLK1_IN               (1'b0),
        .GT0_GTREFCLKSEL_IN             (3'b001),
        .GT0_CPLLFBCLKLOST_OUT          (),
        .GT0_CPLLLOCK_OUT               (i_pll_lock_detect_tile_00),
        .GT0_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT0_CPLLREFCLKLOST_OUT         (),
        .GT0_CPLLRESET_IN               (i_phy_reset),
        .GT0_EYESCANRESET_IN            (1'b0),
        .GT0_EYESCANTRIGGER_IN          (1'b0),
        .GT0_EYESCANDATAERROR_OUT       (),
        .GT0_RXPD_IN                    (2'b 0),
        .GT0_TXPD_IN                    ({i_tx_power_down[0], i_tx_power_down[0]}),
        .GT0_RXUSERRDY_IN               (1'b 0),
        .GT0_RXCHARISK_OUT              (),
        .GT0_RXDISPERR_OUT              (),
        .GT0_RXNOTINTABLE_OUT           (),
        .GT0_RXBYTEISALIGNED_OUT        (),
        .GT0_RXCOMMADET_OUT             (),
        .GT0_RXMCOMMAALIGNEN_IN         (1'b 0),
        .GT0_RXPCOMMAALIGNEN_IN         (1'b 0),
        .GT0_RXPRBSCNTRESET_IN          (1'b 0),
        .GT0_RXPRBSERR_OUT              (),
        .GT0_RXPRBSSEL_IN               (3'b 0),
        .GT0_GTRXRESET_IN               (i_tx_phy_reset_2),
        .GT0_RXDATA_OUT                 (),
        .GT0_RXOUTCLK_OUT               (),
        .GT0_RXPCSRESET_IN              (1'b0),
        .GT0_RXPMARESET_IN              (1'b0),
        .GT0_RXUSRCLK_IN                (i_lnk_clk_out_buf),
        .GT0_RXUSRCLK2_IN               (i_lnk_clk_out_buf),
        .GT0_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT0_RXELECIDLE_OUT             (),
        .GT0_RXBUFRESET_IN              (1'b0),
        .GT0_RXBUFSTATUS_OUT            (),
        .GT0_RXRESETDONE_OUT            (),
        .GT0_GTXRXN_IN                  (1'b 1),
        .GT0_GTXRXP_IN                  (1'b 1),
        .GT0_GTXTXN_OUT                 (i_lnk_tx_lane_n_w[0]),
        .GT0_GTXTXP_OUT                 (i_lnk_tx_lane_p_w[0]),



        .GT0_TXPOSTCURSOR_IN            (i_tx_postcursor_lane_0),
        .GT0_TXPRECURSOR_IN             (i_tx_precursor_lane_0),
        .GT0_TXUSERRDY_IN               (i_tx_user_ready),
        .GT0_TXCHARISK_IN               (lnk_tx_lane0_k_char),
        .GT0_TXCHARDISPVAL_IN           ({lnk_tx_lane0_override_disparity[6], lnk_tx_lane0_override_disparity[4], lnk_tx_lane0_override_disparity[2], lnk_tx_lane0_override_disparity[0]}),
        .GT0_TXCHARDISPMODE_IN          ({lnk_tx_lane0_override_disparity[7], lnk_tx_lane0_override_disparity[5], lnk_tx_lane0_override_disparity[3], lnk_tx_lane0_override_disparity[1]}),
        .GT0_GTTXRESET_IN               (i_tx_phy_reset_2),
        .GT0_TXDATA_IN                  (lnk_tx_lane0_data),
        .GT0_TXOUTCLK_OUT               (i_lnk_clk_out),
        .GT0_TXOUTCLKFABRIC_OUT         (),
        .GT0_TXOUTCLKPCS_OUT            (),
        .GT0_TXPCSRESET_IN              (i_pcs_reset),
        .GT0_TXPMARESET_IN              (i_pma_reset),
        .GT0_TXUSRCLK_IN                (i_lnk_clk_out2_buf),
        .GT0_TXUSRCLK2_IN               (i_lnk_clk_out2_buf),
        .GT0_TXDIFFCTRL_IN              (i_tx_voltage_swing_lane_0),
        .GT0_TXINHIBIT_IN               (gt_txinhibit),
   
        .GT0_TXBUFSTATUS_OUT            (i_tx_buffer_status_lane_0),
        .GT0_TXRESETDONE_OUT            (i_reset_done_tile_0[0]),
        .GT0_TXPRBSFORCEERR_IN          (i_prbs_force_err),
        .GT0_TXPRBSSEL_IN               (i_tx_enable_prbs7),
        .GT1_RXDFELPMRESET_IN           (1'b0), 
        .GT1_RXLPMLFHOLD_IN             (1'b0),   
        .GT1_RXLPMHFHOLD_IN             (1'b0), 
        .GT1_RXLPMHFOVRDEN_IN           (1'b0), 
        .GT1_RXCDRHOLD_IN               (1'b0), 
        .GT1_LOOPBACK_IN                (i_loopback), 
        .GT1_RXPOLARITY_IN              (1'b0),
        .GT1_TXPOLARITY_IN              (i_txpolarity_lane1),
        .GT1_DMONITOROUT_OUT            (),

        .GT1_RXLPMEN_IN                 (GT1_RXLPMEN_IN), 
        .GT1_DRPADDR_IN                 ({ 1'b 0, i_drp_addr }),
	
        .GT1_DRPCLK_IN                  (apb_clk),
        .GT1_DRPDI_IN                   (i_drp_write_data),
        .GT1_DRPDO_OUT                  (),
        .GT1_DRPEN_IN                   (i_drp_enable),
        .GT1_DRPRDY_OUT                 (i_drp_ready01),
        .GT1_DRPWE_IN                   (i_drp_write),
        .GT1_GTREFCLK0_IN               (lnk_clk_ibufds),
	.GT1_GTREFCLK1_IN               (1'b0),
        .GT1_GTREFCLKSEL_IN             (3'b001),
        .GT1_CPLLFBCLKLOST_OUT          (),
        .GT1_CPLLLOCK_OUT               (i_pll_lock_detect_tile_01),
        .GT1_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT1_CPLLREFCLKLOST_OUT         (),
        .GT1_CPLLRESET_IN               (i_phy_reset),
        .GT1_EYESCANRESET_IN            (1'b0),
        .GT1_EYESCANTRIGGER_IN          (1'b0),
        .GT1_EYESCANDATAERROR_OUT       (),
        .GT1_RXPD_IN                    (2'b 0),
        .GT1_TXPD_IN                    ({i_tx_power_down[1], i_tx_power_down[1]}),
        .GT1_RXUSERRDY_IN               (1'b 0),
        .GT1_RXCHARISK_OUT              (),
        .GT1_RXDISPERR_OUT              (),
        .GT1_RXNOTINTABLE_OUT           (),
        .GT1_RXBYTEISALIGNED_OUT        (),
        .GT1_RXCOMMADET_OUT             (),
        .GT1_RXMCOMMAALIGNEN_IN         (1'b 0),
        .GT1_RXPCOMMAALIGNEN_IN         (1'b 0),
        .GT1_RXPRBSCNTRESET_IN          (1'b 0),
        .GT1_RXPRBSERR_OUT              (),
        .GT1_RXPRBSSEL_IN               (3'b 0),
        .GT1_GTRXRESET_IN               (i_tx_phy_reset_2),
        .GT1_RXDATA_OUT                 (),
        .GT1_RXOUTCLK_OUT               (),
        .GT1_RXPCSRESET_IN              (1'b0),
        .GT1_RXPMARESET_IN              (1'b0),
        .GT1_RXUSRCLK_IN                (i_lnk_clk_out_buf),
        .GT1_RXUSRCLK2_IN               (i_lnk_clk_out_buf),
        .GT1_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT1_RXELECIDLE_OUT             (),
        .GT1_RXBUFRESET_IN              (1'b0),
        .GT1_RXBUFSTATUS_OUT            (),
        .GT1_RXRESETDONE_OUT            (),
        .GT1_GTXRXN_IN                  (1'b 1),
        .GT1_GTXRXP_IN                  (1'b 1),
        .GT1_GTXTXN_OUT                 (i_lnk_tx_lane_n_w[1]),
        .GT1_GTXTXP_OUT                 (i_lnk_tx_lane_p_w[1]),

        .GT1_TXPOSTCURSOR_IN            (i_tx_postcursor_lane_1),
        .GT1_TXPRECURSOR_IN             (i_tx_precursor_lane_1),
        .GT1_TXUSERRDY_IN               (i_tx_user_ready),
        .GT1_TXCHARISK_IN               (lnk_tx_lane1_k_char),
        .GT1_TXCHARDISPVAL_IN           ({lnk_tx_lane1_override_disparity[6], lnk_tx_lane1_override_disparity[4], lnk_tx_lane1_override_disparity[2], lnk_tx_lane1_override_disparity[0]}),
        .GT1_TXCHARDISPMODE_IN          ({lnk_tx_lane1_override_disparity[7], lnk_tx_lane1_override_disparity[5], lnk_tx_lane1_override_disparity[3], lnk_tx_lane1_override_disparity[1]}),
        .GT1_GTTXRESET_IN               (i_tx_phy_reset_2),
        .GT1_TXDATA_IN                  (lnk_tx_lane1_data),
        .GT1_TXOUTCLK_OUT               (),
        .GT1_TXOUTCLKFABRIC_OUT         (),
        .GT1_TXOUTCLKPCS_OUT            (),
        .GT1_TXPCSRESET_IN              (i_pcs_reset),
        .GT1_TXPMARESET_IN              (i_pma_reset),
        .GT1_TXUSRCLK_IN                (i_lnk_clk_out2_buf),
        .GT1_TXUSRCLK2_IN               (i_lnk_clk_out2_buf),
        .GT1_TXDIFFCTRL_IN              (i_tx_voltage_swing_lane_1),
        .GT1_TXINHIBIT_IN               (gt_txinhibit),
   
        .GT1_TXBUFSTATUS_OUT            (i_tx_buffer_status_lane_1),
        .GT1_TXRESETDONE_OUT            (i_reset_done_tile_0[1]),
        .GT1_TXPRBSFORCEERR_IN          (i_prbs_force_err),
        .GT1_TXPRBSSEL_IN               (i_tx_enable_prbs7),
        //Common Ports - QPLL
        .GT0_QPLLCLK_IN                 (gt0_qpllclk_in),
        .GT0_QPLLREFCLK_IN              (gt0_qpllrefclk_in)
    );
 end //}
 else if ( ( ( pDEVICE_FAMILY == "virtex7" ) | ( pDEVICE_FAMILY == "kintex7" ) | ( pDEVICE_FAMILY == "virtexu" ) | ( pDEVICE_FAMILY == "kintexu" ) 
           | ( pDEVICE_FAMILY == "kintexuplus" ) | ( pDEVICE_FAMILY == "zynquplus" )) & ( pLANE_COUNT == 4 ) )
 begin //{

    system_displayport_0_0_gt_7_series_wrapper_4
    #(
        .WRAPPER_SIM_GTRESET_SPEEDUP   ("TRUE")
    )
    gt_wrapper_inst
    (
        .GT0_RXDFEAGCHOLD_IN            (1'b 0),
        .GT0_RXDFELFHOLD_IN             (1'b 0),
        .GT1_RXDFEAGCHOLD_IN            (1'b 0),
        .GT1_RXDFELFHOLD_IN             (1'b 0),
        .GT2_RXDFEAGCHOLD_IN            (1'b 0),
        .GT2_RXDFELFHOLD_IN             (1'b 0),
        .GT3_RXDFEAGCHOLD_IN            (1'b 0),
        .GT3_RXDFELFHOLD_IN             (1'b 0),
        .GT0_TX8B10BEN_IN               (tx8b10ben),
        .GT0_RX8B10BEN_IN               (1'b1),
        .GT1_TX8B10BEN_IN               (tx8b10ben),
        .GT1_RX8B10BEN_IN               (1'b1),
        .GT2_TX8B10BEN_IN               (tx8b10ben),
        .GT2_RX8B10BEN_IN               (1'b1),
        .GT3_TX8B10BEN_IN               (tx8b10ben),
        .GT3_RX8B10BEN_IN               (1'b1),
        .GT0_RXDFELPMRESET_IN           (1'b0), 
        .GT0_RXLPMLFHOLD_IN             (1'b0),   
        .GT0_RXLPMHFHOLD_IN             (1'b0), 
        .GT0_RXLPMHFOVRDEN_IN           (1'b0), 
        .GT0_RXCDRHOLD_IN               (1'b0), 
        .GT0_LOOPBACK_IN                (i_loopback), 
        .GT0_RXPOLARITY_IN              (1'b0),
        .GT0_TXPOLARITY_IN              (i_txpolarity_lane0),
        .GT0_DMONITOROUT_OUT            (),

        .GT0_RXLPMEN_IN                 (GT0_RXLPMEN_IN),     
        .GT0_DRPADDR_IN                 ({ 1'b 0, i_drp_addr }),
	
        .GT0_DRPCLK_IN                  (apb_clk),
        .GT0_DRPDI_IN                   (i_drp_write_data),
        .GT0_DRPDO_OUT                  (i_drp_read_data),
        .GT0_DRPEN_IN                   (i_drp_enable),
        .GT0_DRPRDY_OUT                 (i_drp_ready00),
        .GT0_DRPWE_IN                   (i_drp_write),
        .GT0_GTREFCLK0_IN               (lnk_clk_ibufds),
	.GT0_GTREFCLK1_IN               (1'b0),
        .GT0_GTREFCLKSEL_IN             (3'b001),
        .GT0_CPLLFBCLKLOST_OUT          (),
        .GT0_CPLLLOCK_OUT               (i_pll_lock_detect_tile_00),
        .GT0_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT0_CPLLREFCLKLOST_OUT         (),
        .GT0_CPLLRESET_IN               (i_phy_reset),
        .GT0_EYESCANRESET_IN            (1'b0),
        .GT0_EYESCANTRIGGER_IN          (1'b0),
        .GT0_EYESCANDATAERROR_OUT       (),
        .GT0_RXPD_IN                    (2'b 0),
        .GT0_TXPD_IN                    ({i_tx_power_down[0], i_tx_power_down[0]}),
        .GT0_RXUSERRDY_IN               (1'b 0),
        .GT0_RXCHARISK_OUT              (),
        .GT0_RXDISPERR_OUT              (),
        .GT0_RXNOTINTABLE_OUT           (),
        .GT0_RXBYTEISALIGNED_OUT        (),
        .GT0_RXCOMMADET_OUT             (),
        .GT0_RXMCOMMAALIGNEN_IN         (1'b 0),
        .GT0_RXPCOMMAALIGNEN_IN         (1'b 0),
        .GT0_RXPRBSCNTRESET_IN          (1'b 0),
        .GT0_RXPRBSERR_OUT              (),
        .GT0_RXPRBSSEL_IN               (3'b 0),
        .GT0_GTRXRESET_IN               (i_tx_phy_reset_2),
        .GT0_RXDATA_OUT                 (),
        .GT0_RXOUTCLK_OUT               (),
        .GT0_RXPCSRESET_IN              (1'b0),
        .GT0_RXPMARESET_IN              (1'b0),
        .GT0_RXUSRCLK_IN                (i_lnk_clk_out_buf),
        .GT0_RXUSRCLK2_IN               (i_lnk_clk_out_buf),
        .GT0_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT0_RXELECIDLE_OUT             (),
        .GT0_RXBUFRESET_IN              (1'b0),
        .GT0_RXBUFSTATUS_OUT            (),
        .GT0_RXRESETDONE_OUT            (),
        .GT0_GTXRXN_IN                  (1'b 1),
        .GT0_GTXRXP_IN                  (1'b 1),
        .GT0_GTXTXN_OUT                 (i_lnk_tx_lane_n_w[0]),
        .GT0_GTXTXP_OUT                 (i_lnk_tx_lane_p_w[0]),

        .GT0_TXPOSTCURSOR_IN            (i_tx_postcursor_lane_0),
        .GT0_TXPRECURSOR_IN             (i_tx_precursor_lane_0),
        .GT0_TXUSERRDY_IN               (i_tx_user_ready),
        .GT0_TXCHARISK_IN               (lnk_tx_lane0_k_char),
        .GT0_TXCHARDISPVAL_IN           ({lnk_tx_lane0_override_disparity[6], lnk_tx_lane0_override_disparity[4], lnk_tx_lane0_override_disparity[2], lnk_tx_lane0_override_disparity[0]}),
        .GT0_TXCHARDISPMODE_IN          ({lnk_tx_lane0_override_disparity[7], lnk_tx_lane0_override_disparity[5], lnk_tx_lane0_override_disparity[3], lnk_tx_lane0_override_disparity[1]}),
        .GT0_GTTXRESET_IN               (i_tx_phy_reset_2),
        .GT0_TXDATA_IN                  (lnk_tx_lane0_data),
        .GT0_TXOUTCLK_OUT               (i_lnk_clk_out),
        .GT0_TXOUTCLKFABRIC_OUT         (),
        .GT0_TXOUTCLKPCS_OUT            (),
        .GT0_TXPCSRESET_IN              (i_pcs_reset),
        .GT0_TXPMARESET_IN              (i_pma_reset),
        .GT0_TXUSRCLK_IN                (i_lnk_clk_out2_buf),
        .GT0_TXUSRCLK2_IN               (i_lnk_clk_out2_buf),
        .GT0_TXDIFFCTRL_IN              (i_tx_voltage_swing_lane_0),
        .GT0_TXINHIBIT_IN               (gt_txinhibit),
   
        .GT0_TXBUFSTATUS_OUT            (i_tx_buffer_status_lane_0),
        .GT0_TXRESETDONE_OUT            (i_reset_done_tile_0[0]),
        .GT0_TXPRBSFORCEERR_IN          (i_prbs_force_err),
        .GT0_TXPRBSSEL_IN               (i_tx_enable_prbs7),

        .GT1_RXDFELPMRESET_IN           (1'b0), 
        .GT1_RXLPMLFHOLD_IN             (1'b0),   
        .GT1_RXLPMHFHOLD_IN             (1'b0), 
        .GT1_RXLPMHFOVRDEN_IN           (1'b0), 
        .GT1_RXCDRHOLD_IN               (1'b0), 
        .GT1_LOOPBACK_IN                (i_loopback), 
        .GT1_RXPOLARITY_IN              (1'b0),
        .GT1_TXPOLARITY_IN              (i_txpolarity_lane1),
        .GT1_DMONITOROUT_OUT            (),

        .GT1_RXLPMEN_IN                 (GT1_RXLPMEN_IN),   
        .GT1_DRPADDR_IN                 ({ 1'b 0, i_drp_addr }),
	
        .GT1_DRPCLK_IN                  (apb_clk),
        .GT1_DRPDI_IN                   (i_drp_write_data),
        .GT1_DRPDO_OUT                  (),
        .GT1_DRPEN_IN                   (i_drp_enable),
        .GT1_DRPRDY_OUT                 (i_drp_ready01),
        .GT1_DRPWE_IN                   (i_drp_write),
        .GT1_GTREFCLK0_IN               (lnk_clk_ibufds),
	.GT1_GTREFCLK1_IN               (1'b0),
        .GT1_GTREFCLKSEL_IN             (3'b001),
        .GT1_CPLLFBCLKLOST_OUT          (),
        .GT1_CPLLLOCK_OUT               (i_pll_lock_detect_tile_01),
        .GT1_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT1_CPLLREFCLKLOST_OUT         (),
        .GT1_CPLLRESET_IN               (i_phy_reset),
        .GT1_EYESCANRESET_IN            (1'b0),
        .GT1_EYESCANTRIGGER_IN          (1'b0),
        .GT1_EYESCANDATAERROR_OUT       (),
        .GT1_RXPD_IN                    (2'b 0),
        .GT1_TXPD_IN                    ({i_tx_power_down[1], i_tx_power_down[1]}),
        .GT1_RXUSERRDY_IN               (1'b 0),
        .GT1_RXCHARISK_OUT              (),
        .GT1_RXDISPERR_OUT              (),
        .GT1_RXNOTINTABLE_OUT           (),
        .GT1_RXBYTEISALIGNED_OUT        (),
        .GT1_RXCOMMADET_OUT             (),
        .GT1_RXMCOMMAALIGNEN_IN         (1'b 0),
        .GT1_RXPCOMMAALIGNEN_IN         (1'b 0),
        .GT1_RXPRBSCNTRESET_IN          (1'b 0),
        .GT1_RXPRBSERR_OUT              (),
        .GT1_RXPRBSSEL_IN               (3'b 0),
        .GT1_GTRXRESET_IN               (i_tx_phy_reset_2),
        .GT1_RXDATA_OUT                 (),
        .GT1_RXOUTCLK_OUT               (),
        .GT1_RXPCSRESET_IN              (1'b0),
        .GT1_RXPMARESET_IN              (1'b0),
        .GT1_RXUSRCLK_IN                (i_lnk_clk_out_buf),
        .GT1_RXUSRCLK2_IN               (i_lnk_clk_out_buf),
        .GT1_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT1_RXELECIDLE_OUT             (),
        .GT1_RXBUFRESET_IN              (1'b0),
        .GT1_RXBUFSTATUS_OUT            (),
        .GT1_RXRESETDONE_OUT            (),
        .GT1_GTXRXN_IN                  (1'b 1),
        .GT1_GTXRXP_IN                  (1'b 1),
        .GT1_GTXTXN_OUT                 (i_lnk_tx_lane_n_w[1]),
        .GT1_GTXTXP_OUT                 (i_lnk_tx_lane_p_w[1]),

        .GT1_TXPOSTCURSOR_IN            (i_tx_postcursor_lane_1),
        .GT1_TXPRECURSOR_IN             (i_tx_precursor_lane_1),
        .GT1_TXUSERRDY_IN               (i_tx_user_ready),
        .GT1_TXCHARISK_IN               (lnk_tx_lane1_k_char),
        .GT1_TXCHARDISPVAL_IN           ({lnk_tx_lane1_override_disparity[6], lnk_tx_lane1_override_disparity[4], lnk_tx_lane1_override_disparity[2], lnk_tx_lane1_override_disparity[0]}),
        .GT1_TXCHARDISPMODE_IN          ({lnk_tx_lane1_override_disparity[7], lnk_tx_lane1_override_disparity[5], lnk_tx_lane1_override_disparity[3], lnk_tx_lane1_override_disparity[1]}),
        .GT1_GTTXRESET_IN               (i_tx_phy_reset_2),
        .GT1_TXDATA_IN                  (lnk_tx_lane1_data),
        .GT1_TXOUTCLK_OUT               (),
        .GT1_TXOUTCLKFABRIC_OUT         (),
        .GT1_TXOUTCLKPCS_OUT            (),
        .GT1_TXPCSRESET_IN              (i_pcs_reset),
        .GT1_TXPMARESET_IN              (i_pma_reset),
        .GT1_TXUSRCLK_IN                (i_lnk_clk_out2_buf),
        .GT1_TXUSRCLK2_IN               (i_lnk_clk_out2_buf),
        .GT1_TXDIFFCTRL_IN              (i_tx_voltage_swing_lane_1),
        .GT1_TXINHIBIT_IN               (gt_txinhibit),
   
        .GT1_TXBUFSTATUS_OUT            (i_tx_buffer_status_lane_1),
        .GT1_TXRESETDONE_OUT            (i_reset_done_tile_0[1]),
        .GT1_TXPRBSFORCEERR_IN          (i_prbs_force_err),
        .GT1_TXPRBSSEL_IN               (i_tx_enable_prbs7),

        .GT2_RXDFELPMRESET_IN           (1'b0), 
        .GT2_RXLPMLFHOLD_IN             (1'b0),   
        .GT2_RXLPMHFHOLD_IN             (1'b0), 
        .GT2_RXLPMHFOVRDEN_IN           (1'b0), 
        .GT2_RXCDRHOLD_IN               (1'b0), 
        .GT2_LOOPBACK_IN                (i_loopback), 
        .GT2_RXPOLARITY_IN              (1'b0),
        .GT2_TXPOLARITY_IN              (i_txpolarity_lane2),
        .GT2_DMONITOROUT_OUT            (),

        .GT2_RXLPMEN_IN                 (GT2_RXLPMEN_IN),    
        .GT2_DRPADDR_IN                 ({ 1'b 0, i_drp_addr }),
	
        .GT2_DRPCLK_IN                  (apb_clk),
        .GT2_DRPDI_IN                   (i_drp_write_data),
        .GT2_DRPDO_OUT                  (),
        .GT2_DRPEN_IN                   (i_drp_enable),
        .GT2_DRPRDY_OUT                 (i_drp_ready10),
        .GT2_DRPWE_IN                   (i_drp_write),
        .GT2_GTREFCLK0_IN               (lnk_clk_ibufds),
	.GT2_GTREFCLK1_IN               (1'b0),
        .GT2_GTREFCLKSEL_IN             (3'b001),
        .GT2_CPLLFBCLKLOST_OUT          (),
        .GT2_CPLLLOCK_OUT               (i_pll_lock_detect_tile_10),
        .GT2_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT2_CPLLREFCLKLOST_OUT         (),
        .GT2_CPLLRESET_IN               (i_phy_reset),
        .GT2_EYESCANRESET_IN            (1'b0),
        .GT2_EYESCANTRIGGER_IN          (1'b0),
        .GT2_EYESCANDATAERROR_OUT       (),
        .GT2_RXPD_IN                    (2'b 0),
        .GT2_TXPD_IN                    ({i_tx_power_down[2], i_tx_power_down[2]}),
        .GT2_RXUSERRDY_IN               (1'b 0),
        .GT2_RXCHARISK_OUT              (),
        .GT2_RXDISPERR_OUT              (),
        .GT2_RXNOTINTABLE_OUT           (),
        .GT2_RXBYTEISALIGNED_OUT        (),
        .GT2_RXCOMMADET_OUT             (),
        .GT2_RXMCOMMAALIGNEN_IN         (1'b 0),
        .GT2_RXPCOMMAALIGNEN_IN         (1'b 0),
        .GT2_RXPRBSCNTRESET_IN          (1'b 0),
        .GT2_RXPRBSERR_OUT              (),
        .GT2_RXPRBSSEL_IN               (3'b 0),
        .GT2_GTRXRESET_IN               (i_tx_phy_reset_2),
        .GT2_RXDATA_OUT                 (),
        .GT2_RXOUTCLK_OUT               (),
        .GT2_RXPCSRESET_IN              (1'b0),
        .GT2_RXPMARESET_IN              (1'b0),
        .GT2_RXUSRCLK_IN                (i_lnk_clk_out_buf),
        .GT2_RXUSRCLK2_IN               (i_lnk_clk_out_buf),
        .GT2_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT2_RXELECIDLE_OUT             (),
        .GT2_RXBUFRESET_IN              (1'b0),
        .GT2_RXBUFSTATUS_OUT            (),
        .GT2_RXRESETDONE_OUT            (),
        .GT2_GTXRXN_IN                  (1'b 1),
        .GT2_GTXRXP_IN                  (1'b 1),
        .GT2_GTXTXN_OUT                 (i_lnk_tx_lane_n_w[2]),
        .GT2_GTXTXP_OUT                 (i_lnk_tx_lane_p_w[2]),

        .GT2_TXPOSTCURSOR_IN            (i_tx_postcursor_lane_2),
        .GT2_TXPRECURSOR_IN             (i_tx_precursor_lane_2),
        .GT2_TXUSERRDY_IN               (i_tx_user_ready),
        .GT2_TXCHARISK_IN               (lnk_tx_lane2_k_char),
        .GT2_TXCHARDISPVAL_IN           ({lnk_tx_lane2_override_disparity[6], lnk_tx_lane2_override_disparity[4], lnk_tx_lane2_override_disparity[2], lnk_tx_lane2_override_disparity[0]}),
        .GT2_TXCHARDISPMODE_IN          ({lnk_tx_lane2_override_disparity[7], lnk_tx_lane2_override_disparity[5], lnk_tx_lane2_override_disparity[3], lnk_tx_lane2_override_disparity[1]}),
        .GT2_GTTXRESET_IN               (i_tx_phy_reset_2),
        .GT2_TXDATA_IN                  (lnk_tx_lane2_data),
        .GT2_TXOUTCLK_OUT               (),
        .GT2_TXOUTCLKFABRIC_OUT         (),
        .GT2_TXOUTCLKPCS_OUT            (),
        .GT2_TXPCSRESET_IN              (i_pcs_reset),
        .GT2_TXPMARESET_IN              (i_pma_reset),
        .GT2_TXUSRCLK_IN                (i_lnk_clk_out2_buf),
        .GT2_TXUSRCLK2_IN               (i_lnk_clk_out2_buf),
        .GT2_TXDIFFCTRL_IN              (i_tx_voltage_swing_lane_2),
        .GT2_TXINHIBIT_IN               (gt_txinhibit),
   
        .GT2_TXBUFSTATUS_OUT            (i_tx_buffer_status_lane_2),
        .GT2_TXRESETDONE_OUT            (i_reset_done_tile_1[0]),
        .GT2_TXPRBSFORCEERR_IN          (i_prbs_force_err),
        .GT2_TXPRBSSEL_IN               (i_tx_enable_prbs7),

        .GT3_RXDFELPMRESET_IN           (1'b0), 
        .GT3_RXLPMLFHOLD_IN             (1'b0),   
        .GT3_RXLPMHFHOLD_IN             (1'b0), 
        .GT3_RXLPMHFOVRDEN_IN           (1'b0), 
        .GT3_RXCDRHOLD_IN               (1'b0), 
        .GT3_LOOPBACK_IN                (i_loopback), 
        .GT3_RXPOLARITY_IN              (1'b0),
        .GT3_TXPOLARITY_IN              (i_txpolarity_lane3),
        .GT3_DMONITOROUT_OUT            (),

        .GT3_RXLPMEN_IN                 (GT2_RXLPMEN_IN),   
        .GT3_DRPADDR_IN                 ({ 1'b 0, i_drp_addr }),
	
        .GT3_DRPCLK_IN                  (apb_clk),
        .GT3_DRPDI_IN                   (i_drp_write_data),
        .GT3_DRPDO_OUT                  (),
        .GT3_DRPEN_IN                   (i_drp_enable),
        .GT3_DRPRDY_OUT                 (i_drp_ready11),
        .GT3_DRPWE_IN                   (i_drp_write),
        .GT3_GTREFCLK0_IN               (lnk_clk_ibufds),
	.GT3_GTREFCLK1_IN               (1'b0),
        .GT3_GTREFCLKSEL_IN             (3'b001),
        .GT3_CPLLFBCLKLOST_OUT          (),
        .GT3_CPLLLOCK_OUT               (i_pll_lock_detect_tile_11),
        .GT3_CPLLLOCKDETCLK_IN          (apb_clk),
        .GT3_CPLLREFCLKLOST_OUT         (),
        .GT3_CPLLRESET_IN               (i_phy_reset),
        .GT3_EYESCANRESET_IN            (1'b0),
        .GT3_EYESCANTRIGGER_IN          (1'b0),
        .GT3_EYESCANDATAERROR_OUT       (),
        .GT3_RXPD_IN                    (2'b 0),
        .GT3_TXPD_IN                    ({i_tx_power_down[3], i_tx_power_down[3]}),
        .GT3_RXUSERRDY_IN               (1'b 0),
        .GT3_RXCHARISK_OUT              (),
        .GT3_RXDISPERR_OUT              (),
        .GT3_RXNOTINTABLE_OUT           (),
        .GT3_RXBYTEISALIGNED_OUT        (),
        .GT3_RXCOMMADET_OUT             (),
        .GT3_RXMCOMMAALIGNEN_IN         (1'b 0),
        .GT3_RXPCOMMAALIGNEN_IN         (1'b 0),
        .GT3_RXPRBSCNTRESET_IN          (1'b 0),
        .GT3_RXPRBSERR_OUT              (),
        .GT3_RXPRBSSEL_IN               (3'b 0),
        .GT3_GTRXRESET_IN               (i_tx_phy_reset_2),
        .GT3_RXDATA_OUT                 (),
        .GT3_RXOUTCLK_OUT               (),
        .GT3_RXPCSRESET_IN              (1'b0),
        .GT3_RXPMARESET_IN              (1'b0),
        .GT3_RXUSRCLK_IN                (i_lnk_clk_out_buf),
        .GT3_RXUSRCLK2_IN               (i_lnk_clk_out_buf),
        .GT3_RXCDRLOCK_OUT              (), // not used :: can be included into phy status
        .GT3_RXELECIDLE_OUT             (),
        .GT3_RXBUFRESET_IN              (1'b0),
        .GT3_RXBUFSTATUS_OUT            (),
        .GT3_RXRESETDONE_OUT            (),
        .GT3_GTXRXN_IN                  (1'b 1),
        .GT3_GTXRXP_IN                  (1'b 1),
        .GT3_GTXTXN_OUT                 (i_lnk_tx_lane_n_w[3]),
        .GT3_GTXTXP_OUT                 (i_lnk_tx_lane_p_w[3]),

        .GT3_TXPOSTCURSOR_IN            (i_tx_postcursor_lane_3),
        .GT3_TXPRECURSOR_IN             (i_tx_precursor_lane_3),
        .GT3_TXUSERRDY_IN               (i_tx_user_ready),
        .GT3_TXCHARISK_IN               (lnk_tx_lane3_k_char),
        .GT3_TXCHARDISPVAL_IN           ({lnk_tx_lane3_override_disparity[6], lnk_tx_lane3_override_disparity[4], lnk_tx_lane3_override_disparity[2], lnk_tx_lane3_override_disparity[0]}),
        .GT3_TXCHARDISPMODE_IN          ({lnk_tx_lane3_override_disparity[7], lnk_tx_lane3_override_disparity[5], lnk_tx_lane3_override_disparity[3], lnk_tx_lane3_override_disparity[1]}),
        .GT3_GTTXRESET_IN               (i_tx_phy_reset_2),
        .GT3_TXDATA_IN                  (lnk_tx_lane3_data),
        .GT3_TXOUTCLK_OUT               (),
        .GT3_TXOUTCLKFABRIC_OUT         (),
        .GT3_TXOUTCLKPCS_OUT            (),
        .GT3_TXPCSRESET_IN              (i_pcs_reset),
        .GT3_TXPMARESET_IN              (i_pma_reset),
        .GT3_TXUSRCLK_IN                (i_lnk_clk_out2_buf),
        .GT3_TXUSRCLK2_IN               (i_lnk_clk_out2_buf),
        .GT3_TXDIFFCTRL_IN              (i_tx_voltage_swing_lane_3),
        .GT3_TXINHIBIT_IN               (gt_txinhibit),
   
        .GT3_TXBUFSTATUS_OUT            (i_tx_buffer_status_lane_3),
        .GT3_TXRESETDONE_OUT            (i_reset_done_tile_1[1]),
        .GT3_TXPRBSFORCEERR_IN          (i_prbs_force_err),
        .GT3_TXPRBSSEL_IN               (i_tx_enable_prbs7),
        //Common Ports - QPLL
        .GT0_QPLLCLK_IN                 (gt0_qpllclk_in),
        .GT0_QPLLREFCLK_IN              (gt0_qpllrefclk_in)
    );
 end //}
 endgenerate

   // manual phase alligner end


 //--------------------------------------------------------------------
 // tie off unused GT instance signals
 //--------------------------------------------------------------------
 //--------------------------------------------------------------------
 generate if ( ( (pDEVICE_FAMILY == "virtex7") | (pDEVICE_FAMILY == "zynq") |
                 (pDEVICE_FAMILY == "kintexu") | (pDEVICE_FAMILY == "virtexu") |
                 (pDEVICE_FAMILY == "kintex7") | (pDEVICE_FAMILY == "artix7" ) |
		 (pDEVICE_FAMILY == "kintexuplus" ) | ( pDEVICE_FAMILY == "zynquplus" )) & ( pLANE_COUNT == 1 ) )
 begin
    assign i_drp_ready01                  = 1'b 1;
    assign i_pll_lock_detect_tile_01      = 1'b 1;
    assign i_reset_done_tile_0[1]         = 1'b 1;
    assign i_tx_buffer_status_lane_1      = 2'b 0;
 end
 endgenerate
 //--------------------------------------------------------------------
 // one or two lane case
 //--------------------------------------------------------------------
 generate if ( pLANE_COUNT != 4 )
 begin //{
    assign i_drp_ready10                 = 1'b 1;
    assign i_pll_lock_detect_tile_10     = 1'b 1;
    assign i_drp_ready11                 = 1'b 1;
    assign i_pll_lock_detect_tile_11     = 1'b 1;
    assign i_drp_ready[1]                = 1'b 1;
    assign i_reset_done_tile_1           = 2'b 11;
    assign i_tx_buffer_status_lane_2     = 2'b 0;
    assign i_tx_buffer_status_lane_3     = 2'b 0;
 end //}
 endgenerate



endmodule  // displayport_v9_0_5_tx_phy
