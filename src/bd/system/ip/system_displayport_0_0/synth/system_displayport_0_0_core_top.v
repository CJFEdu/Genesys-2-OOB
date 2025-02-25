
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
`include "displayport_v9_0_5_rx_defs.v"
`include "displayport_v9_0_5_rx_dpcd_defs.v"

(* DowngradeIPIdentifiedWarnings = "yes" *)
module system_displayport_0_0_core_top
#(
  parameter  C_FAMILY                 = "virtex7",
  parameter  C_COMPONENT_NAME         = "displayport_v4",
  parameter  C_LANE_COUNT             = 4,
  parameter  C_FLOW_DIRECTION         = 1,
  parameter  C_PHY_TYPE_EXTERNAL      = 1,
  parameter  C_INCLUDE_HDCP           = 0,
  parameter  C_INCLUDE_HDCP22         = 0,
  parameter  C_SECONDARY_SUPPORT      = 0,
  parameter  C_IEEE_OUI               = "000A35",
  parameter  C_AUDIO_CHANNELS         = 8,
  parameter  C_S_BASEADDR             = "CA400000",
  parameter  C_S_HIGHADDR             = "CA40FFFF",
  parameter  C_PROTOCOL_SELECTION     = 0,
  parameter  C_LINK_RATE              = 6,
  parameter  C_MST_ENABLE             = 0,
  parameter  C_NUMBER_OF_MST_STREAMS  = 2,
  parameter  C_MAX_BITS_PER_COLOR     = 16,
  parameter  C_QUAD_PIXEL_ENABLE      = 1,
  parameter  C_DUAL_PIXEL_ENABLE      = 1,
  parameter  C_YCRCB_ENABLE           = 1,
  parameter  C_YONLY_ENABLE           = 0,
  parameter  C_VENDOR_SPECIFIC        = 0,
  parameter  C_DATA_WIDTH             = 2,
  parameter  C_BUF_BYPASS             = 0,
  parameter  C_EDP_EN                 = 0,
  parameter  C_IS_VERSAL              = 0,
  parameter  C_SIM_MODE               = 0,
  parameter  C_INCLUDE_FEC_PORTS      = 0,
  parameter  C_FEC_ENCODER_DELAY      = 0,
  parameter  C_ENABLE_DSC             = 0
)
(
   input  wire                    s_axi_aclk           , // group DP_S_AXILITE
   input  wire                    s_axi_aresetn        , // group DP_S_AXILITE
   input  wire    [31:0]          s_axi_awaddr         , // group DP_S_AXILITE
   input  wire    [2:0]           s_axi_awprot         , // group DP_S_AXILITE
   input  wire                    s_axi_awvalid        , // group DP_S_AXILITE
   output wire                    s_axi_awready        , // group DP_S_AXILITE
   input  wire    [31:0]          s_axi_wdata          , // group DP_S_AXILITE
   input  wire    [3:0]           s_axi_wstrb          , // group DP_S_AXILITE
   input  wire                    s_axi_wvalid         , // group DP_S_AXILITE
   output wire                    s_axi_wready         , // group DP_S_AXILITE
   output wire    [1:0]           s_axi_bresp          , // group DP_S_AXILITE
   output wire                    s_axi_bvalid         , // group DP_S_AXILITE
   input  wire                    s_axi_bready         , // group DP_S_AXILITE
   input  wire    [31:0]          s_axi_araddr         , // group DP_S_AXILITE
   input  wire    [2:0]           s_axi_arprot         , // group DP_S_AXILITE
   input  wire                    s_axi_arvalid        , // group DP_S_AXILITE
   output wire                    s_axi_arready        , // group DP_S_AXILITE
   output wire    [31:0]          s_axi_rdata          , // group DP_S_AXILITE
   output wire    [1:0]           s_axi_rresp          , // group DP_S_AXILITE
   output wire                    s_axi_rvalid         , // group DP_S_AXILITE
   input  wire                    s_axi_rready         , // group DP_S_AXILITE
   output wire                    axi_int              , // group DP_S_AXILITE

   input  wire                    tx_vid_clk           , // group VIDEO_IF
   input  wire                    tx_vid_rst           , // group VIDEO_IF
   input  wire                    tx_vid_vsync         , // group VIDEO_IF
   input  wire                    tx_vid_hsync         , // group VIDEO_IF
   input  wire                    tx_vid_oddeven       , // group VIDEO_IF
   input  wire                    tx_vid_enable        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel0        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel1        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel2        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel3        , // group VIDEO_IF

   input  wire                    tx_vid_clk_stream2           , // group VIDEO_IF
   input  wire                    tx_vid_rst_stream2           , // group VIDEO_IF
   input  wire                    tx_vid_vsync_stream2         , // group VIDEO_IF
   input  wire                    tx_vid_hsync_stream2         , // group VIDEO_IF
   input  wire                    tx_vid_oddeven_stream2       , // group VIDEO_IF
   input  wire                    tx_vid_enable_stream2        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel0_stream2        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel1_stream2        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel2_stream2        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel3_stream2        , // group VIDEO_IF

   input  wire                    tx_vid_clk_stream3           , // group VIDEO_IF
   input  wire                    tx_vid_rst_stream3           , // group VIDEO_IF
   input  wire                    tx_vid_vsync_stream3         , // group VIDEO_IF
   input  wire                    tx_vid_hsync_stream3         , // group VIDEO_IF
   input  wire                    tx_vid_oddeven_stream3       , // group VIDEO_IF
   input  wire                    tx_vid_enable_stream3        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel0_stream3        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel1_stream3        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel2_stream3        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel3_stream3        , // group VIDEO_IF

   input  wire                    tx_vid_clk_stream4           , // group VIDEO_IF
   input  wire                    tx_vid_rst_stream4           , // group VIDEO_IF
   input  wire                    tx_vid_vsync_stream4         , // group VIDEO_IF
   input  wire                    tx_vid_hsync_stream4         , // group VIDEO_IF
   input  wire                    tx_vid_oddeven_stream4       , // group VIDEO_IF
   input  wire                    tx_vid_enable_stream4        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel0_stream4        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel1_stream4        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel2_stream4        , // group VIDEO_IF
   input  wire    [47:0]          tx_vid_pixel3_stream4        , // group VIDEO_IF
   
   input wire     [31:0]          txss_axi_status,  //Status from TX Subsystem sub Ip's
   output wire    [31:0]          txss_axi_control, //Control to TX Subsystem sub Ip's
   
   output wire [C_LANE_COUNT-1:0] lnk_tx_lane_p        ,
   output wire [C_LANE_COUNT-1:0] lnk_tx_lane_n        ,
   input  wire                    lnk_clk_ibufds       ,
   input  wire                    lnk_fwdclk_ibufds    , // DP159 FW clock
   output wire                    lnk_clk              ,
   output wire                    phy_pll_reset_out    ,

   output wire [68:0]             link_debug_gt0       ,
   output wire [68:0]             link_debug_gt1       ,
   output wire [68:0]             link_debug_gt2       ,
   output wire [68:0]             link_debug_gt3       ,
   output wire [95:0]             link_debug_control   ,
   output wire [3:0]              aux_debug_bus        ,

   // GT Common Ports (QPLL) - For GTX/GTH
   input  wire                    common_qpll_clk      ,
   input  wire                    common_qpll_lock     ,
   input  wire                    common_qpll_ref_clk  ,
   // GT Common Ports (PLL) - For GTP
   input  wire                    pll0_lock             ,
   input  wire                    pll1_lock             ,
   input  wire                    pll0_clk             ,
   input  wire                    pll0_ref_clk         ,
   input  wire                    pll1_clk             ,
   input  wire                    pll1_ref_clk         ,



   output wire                    aux_tx_channel_out_p , // group AUXIO
   output wire                    aux_tx_channel_out_n , // group AUXIO
   input  wire                    aux_tx_channel_in_p  , // group AUXIO
   input  wire                    aux_tx_channel_in_n  , // group AUXIO
   input  wire                    tx_hpd               ,
   output wire [31:0]  tx_gt_ctrl_out,
   output wire [2:0]   tx_bpc,
   output wire [2:0]   tx_video_format,
   output wire [2:0]   tx_ppc,
   output wire [2:0]   tx_video_format_stream2,
   output wire [2:0]   tx_ppc_stream2,
   output wire [2:0]   tx_video_format_stream3,
   output wire [2:0]   tx_ppc_stream3,
   output wire [2:0]   tx_video_format_stream4,
   output wire [2:0]   tx_ppc_stream4,

   input  wire                    rx_vid_clk           , // group VIDEO_IF
   input  wire                    rx_vid_rst           , // group VIDEO_IF
   output wire  [2:0]             rx_vid_pixel_mode    ,                   
   output wire                    rx_vid_vsync         , // group VIDEO_IF
   output wire                    rx_vid_hsync         , // group VIDEO_IF
   output wire                    rx_vid_oddeven       , // group VIDEO_IF
   output wire                    rx_vid_enable        , // group VIDEO_IF
   output wire                    rx_enable_dsc        , 
   output wire    [2:0]           rx_num_active_lanes  , 
   output wire    [11:0]          rx_vid_valid_per_pixel  , 
   output wire                    rx_vid_last          , 
   output wire    [47:0]          rx_vid_pixel0        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel1        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel2        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel3        , // group VIDEO_IF

   input  wire                    rx_vid_clk_stream2           , // group VIDEO_IF
   input  wire                    rx_vid_rst_stream2           , // group VIDEO_IF
   output wire                    rx_vid_vsync_stream2         , // group VIDEO_IF
   output wire                    rx_vid_hsync_stream2         , // group VIDEO_IF
   output wire                    rx_vid_oddeven_stream2       , // group VIDEO_IF
   output wire                    rx_vid_enable_stream2        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel0_stream2        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel1_stream2        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel2_stream2        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel3_stream2        , // group VIDEO_IF

   input  wire                    rx_vid_clk_stream3           , // group VIDEO_IF
   input  wire                    rx_vid_rst_stream3           , // group VIDEO_IF
   output wire                    rx_vid_vsync_stream3         , // group VIDEO_IF
   output wire                    rx_vid_hsync_stream3         , // group VIDEO_IF
   output wire                    rx_vid_oddeven_stream3       , // group VIDEO_IF
   output wire                    rx_vid_enable_stream3        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel0_stream3        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel1_stream3        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel2_stream3        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel3_stream3        , // group VIDEO_IF

   input  wire                    rx_vid_clk_stream4           , // group VIDEO_IF
   input  wire                    rx_vid_rst_stream4           , // group VIDEO_IF
   output wire                    rx_vid_vsync_stream4         , // group VIDEO_IF
   output wire                    rx_vid_hsync_stream4         , // group VIDEO_IF
   output wire                    rx_vid_oddeven_stream4       , // group VIDEO_IF
   output wire                    rx_vid_enable_stream4        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel0_stream4        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel1_stream4        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel2_stream4        , // group VIDEO_IF
   output wire    [47:0]          rx_vid_pixel3_stream4        , // group VIDEO_IF

   output wire    [15:0]          rx_vid_msa_hres,
   output wire    [15:0]          rx_vid_msa_vres,
   output wire    [15:0]          rx_vid_msa_hres_stream2,
   output wire    [15:0]          rx_vid_msa_vres_stream2,
   output wire    [15:0]          rx_vid_msa_hres_stream3,
   output wire    [15:0]          rx_vid_msa_vres_stream3,
   output wire    [15:0]          rx_vid_msa_hres_stream4,
   output wire    [15:0]          rx_vid_msa_vres_stream4,

   output wire    [2:0]           rx_bpc,
   output wire    [2:0]           rx_bpc_stream2,
   output wire    [2:0]           rx_bpc_stream3,
   output wire    [2:0]           rx_bpc_stream4,

   output wire    [2:0]           rx_cformat,
   output wire    [2:0]           rx_cformat_stream2,
   output wire    [2:0]           rx_cformat_stream3,
   output wire    [2:0]           rx_cformat_stream4,

   output wire    [23:0]          lnk_m_vid            ,
   output wire    [23:0]          lnk_n_vid            ,
    output wire                   aux_rx_channel_out_p,           // group AUXIO
    output wire                   aux_rx_channel_out_n,           // group AUXIO
    input  wire                   aux_rx_channel_in_p,            // group AUXIO
    input  wire                   aux_rx_channel_in_n,            // group AUXIO
   // RX Signals 
   input  wire [C_LANE_COUNT-1:0] lnk_rx_lane_p        ,
   input  wire [C_LANE_COUNT-1:0] lnk_rx_lane_n        ,


   output wire [31:0]  rx_gt_ctrl_out,
   output wire                    rx_hpd               ,
   input  wire                    i2c_sda_in           ,
   output wire                    i2c_sda_enable_n     ,
   input  wire                    i2c_scl_in           ,
   output wire                    i2c_scl_enable_n     ,

   input  wire                    aud_clk              ,
   input  wire                    aud_rst              ,
   input  wire                    aud_axis_aclk        ,
   input  wire                    aud_axis_aresetn     ,
   input wire [31:0]              s_axis_audio_ingress_tdata,
   input wire [7:0]               s_axis_audio_ingress_tid,
   input wire                     s_axis_audio_ingress_tvalid,
   output wire                    s_axis_audio_ingress_tready,
   output wire [7:0]              m_axis_audio_egress_tid,
   output wire [31:0]             m_axis_audio_egress_tdata,
   input  wire                    m_axis_audio_egress_tready,
   output wire                    m_axis_audio_egress_tvalid,

   output wire    [23:0]          lnk_m_aud            ,
   output wire    [23:0]          lnk_n_aud            ,
   output wire                    link_bw_high_out     ,
   output wire                    link_bw_hbr2_out     ,
   output wire                    bw_changed_out       ,

   // HDCP Data path signals 
   output wire                    hdcp_egress_clk      ,
   input  wire                    hdcp_ingress_clk     ,
   input  wire                    hdcp_ingress_clken   ,
   output wire                    hdcp_egress_clken    ,
   output wire                    hdcp_rst             ,

   input  wire [7:0]              hdcp_status          ,

   output wire [127:0]            hdcp_egress_data     ,
   output wire [15:0]             hdcp_egress_tuser    ,
   input  wire                    hdcp_egress_tready   ,
   output wire                    hdcp_egress_tvalid   ,
 
    input  wire [127:0]            hdcp_ingress_data    ,
   input  wire [15:0]             hdcp_ingress_tuser   ,
   output wire                    hdcp_ingress_tready  ,
   input  wire                    hdcp_ingress_tvalid  ,

   // ACR (Audio Clock Regeneration) Interface
   output wire [23:0]             acr_m_aud, 
   output wire [23:0]             acr_n_aud, 
   output wire                    acr_valid,

    // PPS AXI-4 Stream IF
    output wire [31:0]            m_axis_rx_pps_tdata,   
    output wire                   m_axis_rx_pps_tvalid,
    output wire                   m_axis_rx_pps_tuser,   
    output wire                   m_axis_rx_pps_tlast,   
    input  wire                   m_axis_rx_pps_tready,  

   output wire                      fec_tx_clken            ,
   output wire                      fec_tx_reset            ,
   output wire [1:0]                fec_tx_num_lanes        ,
   output wire [1:0]                fec_tx_valid_in         ,
   output wire [7:0]                fec_tx_data_ll_enc_in   ,
   output wire [7:0]                fec_tx_data_ph_in       ,
   output wire [63:0]               fec_tx_data_in          ,
   output wire [7:0]                fec_tx_data_k_in        ,
   input wire [63:0]                fec_tx_data_out         ,
   input wire [7:0]                 fec_tx_data_k_out       ,
   input  wire [7:0]                fec_tx_val_out          ,
   input  wire [7:0]                fec_data_rd_ovr_out     ,
   input  wire [7:0]                fec_data_rd_val_out     , 
   output wire [15:0]               axi_tran_per_horiz_line ,
   output wire [15:0]               vtg_hactive             ,
   output wire                      tx_enable_dsc           ,
//   output wire [511:0]              debug_bus_main_lnk      ,
//   output wire [511:0]              debug_bus_main_vid      ,
   
   output wire                      fec_rx_clken            ,
   output wire                      fec_rx_reset            ,
   output wire [1:0]                fec_rx_valid_in         ,
   output wire [79:0]               fec_rx_data_in          ,
   output wire                      fec_rx_enable_in        ,
   output wire [1:0]                fec_rx_num_lanes        ,
   input wire [63:0]                fec_rx_data_out         ,
   input wire [7:0]                 fec_rx_data_k_out       ,
   input wire                       fec_rx_val_out          ,
   input wire [7:0]                 fec_rx_pm_out           ,
   input wire [7:0]                 fec_rx_ph_out           ,           
   output wire [314:0]              dsc_rx_debug_bus_vid    ,      
   output wire [49:0]               dsc_rx_debug_bus_lnk          
  );

    //---------------------------------------------
    // global internal wires
    //---------------------------------------------
    wire            axi_reset;
    //---------------------------------------------
    // tx internal wires
    //---------------------------------------------
    wire [7:0]      lnk_tx_lane0_override_disparity;
    wire [3:0]      lnk_tx_lane0_k_char;           
    wire [31:0]     lnk_tx_lane0_data;             
    wire [7:0]      lnk_tx_lane1_override_disparity;
    wire [3:0]      lnk_tx_lane1_k_char;          
    wire [31:0]     lnk_tx_lane1_data;           
    wire [7:0]      lnk_tx_lane2_override_disparity;
    wire [3:0]      lnk_tx_lane2_k_char;
    wire [31:0]     lnk_tx_lane2_data;             
    wire [7:0]      lnk_tx_lane3_override_disparity;
    wire [3:0]      lnk_tx_lane3_k_char; 
    wire [31:0]     lnk_tx_lane3_data;           
    wire            tx_aux_data_out;
    wire            tx_aux_data_in;
    wire            tx_aux_data_enable_n;
    wire `tDPORT_TX_PHY_CONFIG  cfg_tx_phy_config;
    wire `tDPORT_TX_PHY_STATUS  cfg_tx_phy_status;
    localparam CFG_STATUS_WIDTH = 50;
    wire            tx_hot_plug_detect;
    wire [3:0]      lnk_tx_disp_lane0_value;           
    wire [3:0]      lnk_tx_disp_lane0_mode;           
    wire [3:0]      lnk_tx_disp_lane1_value;           
    wire [3:0]      lnk_tx_disp_lane1_mode;           
    wire [3:0]      lnk_tx_disp_lane2_value;           
    wire [3:0]      lnk_tx_disp_lane2_mode;           
    wire [3:0]      lnk_tx_disp_lane3_value;           
    wire [3:0]      lnk_tx_disp_lane3_mode;           




    //---------------------------------------------
    // rx internal wires
    //---------------------------------------------
    wire            rx_aux_data_in;
    wire            rx_aux_data_out;
    wire            rx_aux_data_enable_n;
    wire            access_train_lane_set;
    wire            access_link_bw_set;
    wire            rx_hot_plug_detect;
    wire [3:0]      lnk_rx_lane0_k_char;
    wire [(31 + (8*C_INCLUDE_FEC_PORTS)):0]     lnk_rx_lane0_data;
    wire [3:0]      lnk_rx_lane0_symbol_error;
    wire [3:0]      lnk_rx_lane0_disparity_error;
    wire [3:0]      lnk_rx_lane1_k_char;
    wire [(31 + (8*C_INCLUDE_FEC_PORTS)):0]     lnk_rx_lane1_data;
    wire [3:0]      lnk_rx_lane1_symbol_error;
    wire [3:0]      lnk_rx_lane1_disparity_error;
    wire [3:0]      lnk_rx_lane2_k_char;
    wire [(31 + (8*C_INCLUDE_FEC_PORTS)):0]     lnk_rx_lane2_data;
    wire [3:0]      lnk_rx_lane2_symbol_error;
    wire [3:0]      lnk_rx_lane2_disparity_error;
    wire [3:0]      lnk_rx_lane3_k_char;
    wire [(31 + (8*C_INCLUDE_FEC_PORTS)):0]     lnk_rx_lane3_data;
    wire [3:0]      lnk_rx_lane3_symbol_error;
    wire [3:0]      lnk_rx_lane3_disparity_error;
    wire            lnk_rx_gt_buf_rst;
    wire `tDPORT_RX_PHY_CONFIG   cfg_rx_phy_config;
    wire `tDPORT_RX_PHY_STATUS   cfg_rx_phy_status;
    wire `tDPORT_RX_DPCD_REGS    cfg_rx_dpcd_regs;
    wire `tDPORT_RX_VIDMODE_REGS cfg_rx_vidmode_regs;
    wire `tDPORT_RX_VIDMODE_REGS cfg_rx_vidmode_regs_stream2;
    wire `tDPORT_RX_VIDMODE_REGS cfg_rx_vidmode_regs_stream3;
    wire `tDPORT_RX_VIDMODE_REGS cfg_rx_vidmode_regs_stream4;


generate if ( C_FLOW_DIRECTION == 0 )
begin






    //----------------------------------------------
    // Displayport TX link component
    //----------------------------------------------
    displayport_v9_0_5_txlink_top #(
        .C_FAMILY                ( C_FAMILY                ),
        .C_COMPONENT_NAME        ( C_COMPONENT_NAME        ),
        .C_LANE_COUNT            ( C_LANE_COUNT            ),
        .C_FLOW_DIRECTION        ( C_FLOW_DIRECTION        ),
        .C_INCLUDE_HDCP          ( C_INCLUDE_HDCP          ),
        .C_SECONDARY_SUPPORT     ( C_SECONDARY_SUPPORT     ),
        .C_IEEE_OUI              ( C_IEEE_OUI              ),
        .C_AUDIO_CHANNELS        ( C_AUDIO_CHANNELS        ),
        .C_S_BASEADDR            ( C_S_BASEADDR            ),
        .C_S_HIGHADDR            ( C_S_HIGHADDR            ),
        .C_PROTOCOL_SELECTION    ( C_PROTOCOL_SELECTION    ),
        .C_LINK_RATE             ( C_LINK_RATE             ),
        .C_MST_ENABLE            ( C_MST_ENABLE            ),
        .C_NUMBER_OF_MST_STREAMS ( C_NUMBER_OF_MST_STREAMS ),
        .C_MAX_BITS_PER_COLOR    ( C_MAX_BITS_PER_COLOR    ),
        .C_QUAD_PIXEL_ENABLE     ( C_QUAD_PIXEL_ENABLE     ),
        .C_DUAL_PIXEL_ENABLE     ( C_DUAL_PIXEL_ENABLE     ),
        .C_YCRCB_ENABLE          ( C_YCRCB_ENABLE          ),
        .C_YONLY_ENABLE          ( C_YONLY_ENABLE          ),
        .C_VENDOR_SPECIFIC       ( C_VENDOR_SPECIFIC       ),
        .C_DATA_WIDTH            ( C_DATA_WIDTH        ),
	.C_EDP_EN                ( C_EDP_EN                ),
	.C_IS_VERSAL             ( C_IS_VERSAL             ),
	.C_SIM_MODE              ( C_SIM_MODE              ),
	.C_INCLUDE_FEC_PORTS     ( C_INCLUDE_FEC_PORTS     ),
	.C_FEC_ENCODER_DELAY     ( C_FEC_ENCODER_DELAY     ),
	.C_ENABLE_DSC            ( C_ENABLE_DSC            )
    ) dport_link_inst (
        .axi_reset                             (axi_reset),
        .s_axi_aclk                            (s_axi_aclk),   
        .s_axi_aresetn                         (s_axi_aresetn),
        .s_axi_awaddr                          (s_axi_awaddr), 
        .s_axi_awprot                          (s_axi_awprot), 
        .s_axi_awvalid                         (s_axi_awvalid),
        .s_axi_awready                         (s_axi_awready),
        .s_axi_wdata                           (s_axi_wdata),  
        .s_axi_wstrb                           (s_axi_wstrb),  
        .s_axi_wvalid                          (s_axi_wvalid), 
        .s_axi_wready                          (s_axi_wready), 
        .s_axi_bresp                           (s_axi_bresp),  
        .s_axi_bvalid                          (s_axi_bvalid), 
        .s_axi_bready                          (s_axi_bready), 
        .s_axi_araddr                          (s_axi_araddr), 
        .s_axi_arprot                          (s_axi_arprot), 
        .s_axi_arvalid                         (s_axi_arvalid),
        .s_axi_arready                         (s_axi_arready),
        .s_axi_rdata                           (s_axi_rdata),  
        .s_axi_rresp                           (s_axi_rresp),  
        .s_axi_rvalid                          (s_axi_rvalid), 
        .s_axi_rready                          (s_axi_rready), 
        .axi_int                               (axi_int),

        .tx_vid_clk                            (tx_vid_clk),
        .tx_vid_rst                            (tx_vid_rst),
        .tx_vid_vsync                          (tx_vid_vsync),
        .tx_vid_hsync                          (tx_vid_hsync),
        .tx_vid_oddeven                        (tx_vid_oddeven),
        .tx_vid_enable                         (tx_vid_enable),
        .tx_vid_pixel0                         (tx_vid_pixel0),
        .tx_vid_pixel1                         (tx_vid_pixel1),
        .tx_vid_pixel2                         (tx_vid_pixel2),
        .tx_vid_pixel3                         (tx_vid_pixel3),

        .tx_vid_clk_stream2                    (tx_vid_clk_stream2    ),   
        .tx_vid_rst_stream2                    (tx_vid_rst_stream2    ), 
        .tx_vid_vsync_stream2                  (tx_vid_vsync_stream2  ), 
        .tx_vid_hsync_stream2                  (tx_vid_hsync_stream2  ),
        .tx_vid_oddeven_stream2                (tx_vid_oddeven_stream2),
        .tx_vid_enable_stream2                 (tx_vid_enable_stream2 ),
        .tx_vid_pixel0_stream2                 (tx_vid_pixel0_stream2 ),
        .tx_vid_pixel1_stream2                 (tx_vid_pixel1_stream2 ),
        .tx_vid_pixel2_stream2                 (tx_vid_pixel2_stream2 ),
        .tx_vid_pixel3_stream2                 (tx_vid_pixel3_stream2 ),
   
        .tx_vid_clk_stream3                    (tx_vid_clk_stream3    ),   
        .tx_vid_rst_stream3                    (tx_vid_rst_stream3    ), 
        .tx_vid_vsync_stream3                  (tx_vid_vsync_stream3  ), 
        .tx_vid_hsync_stream3                  (tx_vid_hsync_stream3  ),
        .tx_vid_oddeven_stream3                (tx_vid_oddeven_stream3),
        .tx_vid_enable_stream3                 (tx_vid_enable_stream3 ),
        .tx_vid_pixel0_stream3                 (tx_vid_pixel0_stream3 ),
        .tx_vid_pixel1_stream3                 (tx_vid_pixel1_stream3 ),
        .tx_vid_pixel2_stream3                 (tx_vid_pixel2_stream3 ),
        .tx_vid_pixel3_stream3                 (tx_vid_pixel3_stream3 ),
                                            
        .tx_vid_clk_stream4                    (tx_vid_clk_stream4    ),   
        .tx_vid_rst_stream4                    (tx_vid_rst_stream4    ), 
        .tx_vid_vsync_stream4                  (tx_vid_vsync_stream4  ), 
        .tx_vid_hsync_stream4                  (tx_vid_hsync_stream4  ),
        .tx_vid_oddeven_stream4                (tx_vid_oddeven_stream4),
        .tx_vid_enable_stream4                 (tx_vid_enable_stream4 ),
        .tx_vid_pixel0_stream4                 (tx_vid_pixel0_stream4 ),
        .tx_vid_pixel1_stream4                 (tx_vid_pixel1_stream4 ),
        .tx_vid_pixel2_stream4                 (tx_vid_pixel2_stream4 ),
        .tx_vid_pixel3_stream4                 (tx_vid_pixel3_stream4 ),

        .hdcp_ingress_clk                      (hdcp_ingress_clk      ),
        .hdcp_egress_clk                       (hdcp_egress_clk       ),
        .hdcp_ingress_clken                    (hdcp_ingress_clken    ),
        .hdcp_egress_clken                     (hdcp_egress_clken     ),
        .hdcp_rst                              (hdcp_rst              ),
        .hdcp_status                           (hdcp_status           ),
        .hdcp_egress_data                      (hdcp_egress_data      ),
        .hdcp_egress_tuser                     (hdcp_egress_tuser     ),
        .hdcp_egress_tready                    (hdcp_egress_tready    ),
        .hdcp_egress_tvalid                    (hdcp_egress_tvalid    ),
        .hdcp_ingress_data                     (hdcp_ingress_data     ),
        .hdcp_ingress_tuser                    (hdcp_ingress_tuser    ),
        .hdcp_ingress_tready                   (hdcp_ingress_tready   ),
        .hdcp_ingress_tvalid                   (hdcp_ingress_tvalid   ),

        .tx_lnk_clk                            (lnk_clk),
        .tx_lnk_tx_lane0_override_disparity    (lnk_tx_lane0_override_disparity),
        .tx_lnk_tx_lane0_k_char                (lnk_tx_lane0_k_char),
        .tx_lnk_tx_lane0_data                  (lnk_tx_lane0_data),              
        .tx_lnk_tx_lane1_override_disparity    (lnk_tx_lane1_override_disparity),
        .tx_lnk_tx_lane1_k_char                (lnk_tx_lane1_k_char),            
        .tx_lnk_tx_lane1_data                  (lnk_tx_lane1_data),              
        .tx_lnk_tx_lane2_override_disparity    (lnk_tx_lane2_override_disparity),
        .tx_lnk_tx_lane2_k_char                (lnk_tx_lane2_k_char),            
        .tx_lnk_tx_lane2_data                  (lnk_tx_lane2_data),              
        .tx_lnk_tx_lane3_override_disparity    (lnk_tx_lane3_override_disparity),
        .tx_lnk_tx_lane3_k_char                (lnk_tx_lane3_k_char),            
        .tx_lnk_tx_lane3_data                  (lnk_tx_lane3_data),              
        .tx_cfg_tx_phy_config                  (cfg_tx_phy_config),
        .tx_cfg_tx_phy_status                  (cfg_tx_phy_status),
        .tx_aux_data_in                        (tx_aux_data_in),
        .tx_aux_data_out                       (tx_aux_data_out),
        .tx_aux_data_enable_n                  (tx_aux_data_enable_n),
        .tx_hot_plug_detect                    (tx_hot_plug_detect),
        .tx_gt_ctrl_out                        (tx_gt_ctrl_out),
        .tx_bpc                                (tx_bpc),
        .tx_video_format                       (tx_video_format),
        .tx_ppc                                (tx_ppc),
	     .txss_axi_control                      (txss_axi_control),
	     .txss_axi_status                       (txss_axi_status),
        .tx_video_format_stream2               (tx_video_format_stream2),
        .tx_ppc_stream2                        (tx_ppc_stream2),
        .tx_video_format_stream3               (tx_video_format_stream3),
        .tx_ppc_stream3                        (tx_ppc_stream3),
        .tx_video_format_stream4               (tx_video_format_stream4),
        .tx_ppc_stream4                        (tx_ppc_stream4),

        .tx_aud_clk                            (aud_clk),
        .tx_s_axis_audio_ingress_aclk          (aud_axis_aclk),
        .tx_s_axis_audio_ingress_aresetn       (aud_axis_aresetn),
        .tx_s_axis_audio_ingress_tdata         (s_axis_audio_ingress_tdata),
        .tx_s_axis_audio_ingress_tid           (s_axis_audio_ingress_tid),
        .tx_s_axis_audio_ingress_tvalid        (s_axis_audio_ingress_tvalid),
        .tx_s_axis_audio_ingress_tready        (s_axis_audio_ingress_tready),

        .tx_s_axis_audio_ingress_aclk_stream2          (1'b0   ),
        .tx_s_axis_audio_ingress_aresetn_stream2       (1'b0   ),
        .tx_s_axis_audio_ingress_tdata_stream2         (32'h0  ),
        .tx_s_axis_audio_ingress_tid_stream2           (8'b00000000 ),
        .tx_s_axis_audio_ingress_tvalid_stream2        (1'b0   ),
        .tx_s_axis_audio_ingress_tready_stream2        (       ),

        .tx_s_axis_audio_ingress_aclk_stream3          (1'b0   ),
        .tx_s_axis_audio_ingress_aresetn_stream3       (1'b0   ),
        .tx_s_axis_audio_ingress_tdata_stream3         (32'h0  ),
        .tx_s_axis_audio_ingress_tid_stream3           (8'b00000000 ),
        .tx_s_axis_audio_ingress_tvalid_stream3        (1'b0   ),
        .tx_s_axis_audio_ingress_tready_stream3        (       ),

        .tx_s_axis_audio_ingress_aclk_stream4          (1'b0   ),
        .tx_s_axis_audio_ingress_aresetn_stream4       (1'b0   ),
        .tx_s_axis_audio_ingress_tdata_stream4         (32'h0  ),
        .tx_s_axis_audio_ingress_tid_stream4           (8'b00000000 ),
        .tx_s_axis_audio_ingress_tvalid_stream4        (1'b0   ),
        .tx_s_axis_audio_ingress_tready_stream4        (       ),
        .fec_tx_clken           (fec_tx_clken         ),     
        .fec_tx_reset           (fec_tx_reset         ),     
        .fec_tx_num_lanes       (fec_tx_num_lanes     ),     
        .fec_tx_valid_in        (fec_tx_valid_in      ),     
        .fec_tx_data_ll_enc_in  (fec_tx_data_ll_enc_in),     
        .fec_tx_data_ph_in      (fec_tx_data_ph_in    ),     
        .fec_tx_data_in         (fec_tx_data_in       ),     
        .fec_tx_data_k_in       (fec_tx_data_k_in     ),     
        .fec_tx_data_out        (fec_tx_data_out      ),
        .fec_tx_data_k_out      (fec_tx_data_k_out    ),
        .fec_tx_val_out         (fec_tx_val_out       ),
        .fec_data_rd_ovr_out    (fec_data_rd_ovr_out  ),
        .fec_data_rd_val_out    (fec_data_rd_val_out  ),
        .axi_tran_per_horiz_line(axi_tran_per_horiz_line),    
        .vtg_hactive            (vtg_hactive            ),    
        .enable_dsc             (tx_enable_dsc          )
        //.debug_bus_main_lnk     (debug_bus_main_lnk     ),
        //.debug_bus_main_vid     (debug_bus_main_vid     )
    );


    //Driver 0's to Rx ports
    assign  rx_vid_pixel_mode =  3'h0;    
    assign  rx_vid_vsync     =  1'b0;    
    assign  rx_vid_hsync     =  1'b0;
    assign  rx_vid_oddeven   =  1'b0;
    assign  rx_vid_enable    =  1'b0;
    assign  rx_vid_valid_per_pixel    =  12'd0;
    assign  rx_vid_last      =  1'd0;
    assign  rx_enable_dsc    = 1'd0;
    assign  rx_num_active_lanes    = 3'd0;
    assign  rx_vid_pixel0    = 48'h0;
    assign  rx_vid_pixel1    = 48'h0;
    assign  rx_vid_pixel2    = 48'h0;
    assign  rx_vid_pixel3    = 48'h0;

    assign  rx_vid_vsync_stream2     =  1'b0;    
    assign  rx_vid_hsync_stream2     =  1'b0;
    assign  rx_vid_oddeven_stream2   =  1'b0;
    assign  rx_vid_enable_stream2    =  1'b0;
    assign  rx_vid_pixel0_stream2    = 48'h0;
    assign  rx_vid_pixel1_stream2    = 48'h0;
    assign  rx_vid_pixel2_stream2    = 48'h0;
    assign  rx_vid_pixel3_stream2    = 48'h0;

    assign  rx_vid_vsync_stream3     =  1'b0;    
    assign  rx_vid_hsync_stream3     =  1'b0;
    assign  rx_vid_oddeven_stream3   =  1'b0;
    assign  rx_vid_enable_stream3    =  1'b0;
    assign  rx_vid_pixel0_stream3    = 48'h0;
    assign  rx_vid_pixel1_stream3    = 48'h0;
    assign  rx_vid_pixel2_stream3    = 48'h0;
    assign  rx_vid_pixel3_stream3    = 48'h0;

    assign  rx_vid_vsync_stream4     =  1'b0;    
    assign  rx_vid_hsync_stream4     =  1'b0;
    assign  rx_vid_oddeven_stream4   =  1'b0;
    assign  rx_vid_enable_stream4    =  1'b0;
    assign  rx_vid_pixel0_stream4    = 48'h0;
    assign  rx_vid_pixel1_stream4    = 48'h0;
    assign  rx_vid_pixel2_stream4    = 48'h0;
    assign  rx_vid_pixel3_stream4    = 48'h0;

    assign  rx_vid_msa_hres          = 16'h0;
    assign  rx_vid_msa_vres          = 16'h0;
    assign  rx_vid_msa_hres_stream2  = 16'h0;
    assign  rx_vid_msa_vres_stream2  = 16'h0;
    assign  rx_vid_msa_hres_stream3  = 16'h0;
    assign  rx_vid_msa_vres_stream3  = 16'h0;
    assign  rx_vid_msa_hres_stream4  = 16'h0;
    assign  rx_vid_msa_vres_stream4  = 16'h0;

    assign  lnk_m_vid  = 24'h0;
    assign  lnk_n_vid  = 24'h0;
    assign  rx_hpd     =  1'b0;
    assign  i2c_sda_enable_n   =  1'b1;
    assign  i2c_scl_enable_n   =  1'b1;
  
   assign lnk_m_aud            = 24'h0; 
   assign lnk_n_aud            = 24'h0; 

   assign rx_bpc         = 3'd0;
   assign rx_bpc_stream2 = 3'd0;
   assign rx_bpc_stream3 = 3'd0;
   assign rx_bpc_stream4 = 3'd0;
   assign rx_cformat         = 3'd0;
   assign rx_cformat_stream2 = 3'd0;
   assign rx_cformat_stream3 = 3'd0;
   assign rx_cformat_stream4 = 3'd0;
   
   assign          fec_rx_clken       = 1'b0  ; 
   assign          fec_rx_reset       = 1'b0  ; 
   assign          fec_rx_valid_in    = 2'd0  ; 
   assign          fec_rx_data_in     = 80'd0 ;
   assign          fec_rx_enable_in   = 1'b0  ;
   assign          fec_rx_num_lanes   = 2'd0  ;
   assign          dsc_rx_debug_bus_vid   = 0;
   assign          dsc_rx_debug_bus_lnk   = 0;

end

else if ( C_FLOW_DIRECTION == 1 )
begin
   assign         fec_tx_clken          = 1'b0 ;      
   assign         fec_tx_reset          = 1'b0 ;         
   assign         fec_tx_num_lanes      = 2'd0 ;     
   assign         fec_tx_valid_in       = 2'd0 ;     
   assign         fec_tx_data_ll_enc_in = 8'd0 ;     
   assign         fec_tx_data_ph_in     = 8'd0 ;     
   assign         fec_tx_data_in        = 64'd0;     
   assign         fec_tx_data_k_in      = 8'd0 ;     
   assign         axi_tran_per_horiz_line = 16'd0; 
   assign         vtg_hactive             = 16'd0; 
   assign         tx_enable_dsc           = 1'd0 ; 
   //assign         debug_bus_main_lnk      = 512'd0 ; 
   //assign         debug_bus_main_vid      = 512'd0 ; 


   assign rx_vid_msa_hres         = cfg_rx_vidmode_regs[`kCFG_RX_VIDMODE_HRES];
   assign rx_vid_msa_vres         = cfg_rx_vidmode_regs[`kCFG_RX_VIDMODE_VRES];
   assign rx_vid_msa_hres_stream2 = 16'h0000;
   assign rx_vid_msa_vres_stream2 = 16'h0000;
   assign rx_vid_msa_hres_stream3 = 16'h0000;
   assign rx_vid_msa_vres_stream3 = 16'h0000;
   assign rx_vid_msa_hres_stream4 = 16'h0000;
   assign rx_vid_msa_vres_stream4 = 16'h0000;
   if(C_ENABLE_DSC == 1)
   begin
        assign rx_bpc                  = rx_enable_dsc ? 3'b001 : cfg_rx_vidmode_regs[135:133];
   end
   else
   begin
        assign rx_bpc                  = cfg_rx_vidmode_regs[135:133];
   end
   assign rx_bpc_stream2          = 3'd0;
   assign rx_bpc_stream3          = 3'd0;
   assign rx_bpc_stream4          = 3'd0;
   if(C_ENABLE_DSC == 1)
   begin
        assign rx_cformat              = rx_enable_dsc ? 3'b000 : {cfg_rx_vidmode_regs[143],cfg_rx_vidmode_regs[130:129]};
   end
   else
   begin
        assign rx_cformat              = {cfg_rx_vidmode_regs[143],cfg_rx_vidmode_regs[130:129]};
   end
   assign rx_cformat_stream2      = 3'd0;
   assign rx_cformat_stream3      = 3'd0;
   assign rx_cformat_stream4      = 3'd0;
    //----------------------------------------------
    // DisplayPort RX link controller
    //----------------------------------------------
    displayport_v9_0_5_rxlink_top #(
        .C_FAMILY                ( C_FAMILY                ),
        .C_COMPONENT_NAME        ( C_COMPONENT_NAME        ),
        .C_LANE_COUNT            ( C_LANE_COUNT            ),
        .C_FLOW_DIRECTION        ( C_FLOW_DIRECTION        ),
        .C_INCLUDE_HDCP          ( C_INCLUDE_HDCP          ),
        .C_SECONDARY_SUPPORT     ( C_SECONDARY_SUPPORT     ),
        .C_IEEE_OUI              ( C_IEEE_OUI              ),
        .C_AUDIO_CHANNELS        ( C_AUDIO_CHANNELS        ),
        .C_S_BASEADDR            ( C_S_BASEADDR            ),
        .C_S_HIGHADDR            ( C_S_HIGHADDR            ),
        .C_PROTOCOL_SELECTION    ( C_PROTOCOL_SELECTION    ),
        .C_LINK_RATE             ( C_LINK_RATE             ),
        .C_MST_ENABLE            ( C_MST_ENABLE            ),
        .C_NUMBER_OF_MST_STREAMS ( C_NUMBER_OF_MST_STREAMS ),
        .C_MAX_BITS_PER_COLOR    ( C_MAX_BITS_PER_COLOR    ),
        .C_QUAD_PIXEL_ENABLE     ( C_QUAD_PIXEL_ENABLE     ),
        .C_DUAL_PIXEL_ENABLE     ( C_DUAL_PIXEL_ENABLE     ),
        .C_YCRCB_ENABLE          ( C_YCRCB_ENABLE          ),
        .C_YONLY_ENABLE          ( C_YONLY_ENABLE          ),
        .C_VENDOR_SPECIFIC       ( C_VENDOR_SPECIFIC       ),
        .C_DATA_WIDTH            ( C_DATA_WIDTH        ),
	.C_EDP_EN                ( C_EDP_EN                ),
	.C_IS_VERSAL             ( C_IS_VERSAL             ),
	.C_SIM_MODE              ( C_SIM_MODE              ),
	.C_INCLUDE_FEC_PORTS     ( C_INCLUDE_FEC_PORTS     ),
	.C_ENABLE_DSC            ( C_ENABLE_DSC            )
    ) dport_link_inst (
        .axi_reset                       (axi_reset),
        .s_axi_aclk                      (s_axi_aclk),   
        .s_axi_aresetn                   (s_axi_aresetn),
        .s_axi_awaddr                    (s_axi_awaddr), 
        .s_axi_awprot                    (s_axi_awprot), 
        .s_axi_awvalid                   (s_axi_awvalid),
        .s_axi_awready                   (s_axi_awready),
        .s_axi_wdata                     (s_axi_wdata),  
        .s_axi_wstrb                     (s_axi_wstrb),  
        .s_axi_wvalid                    (s_axi_wvalid), 
        .s_axi_wready                    (s_axi_wready), 
        .s_axi_bresp                     (s_axi_bresp),  
        .s_axi_bvalid                    (s_axi_bvalid), 
        .s_axi_bready                    (s_axi_bready), 
        .s_axi_araddr                    (s_axi_araddr), 
        .s_axi_arprot                    (s_axi_arprot), 
        .s_axi_arvalid                   (s_axi_arvalid),
        .s_axi_arready                   (s_axi_arready),
        .s_axi_rdata                     (s_axi_rdata),  
        .s_axi_rresp                     (s_axi_rresp),  
        .s_axi_rvalid                    (s_axi_rvalid), 
        .s_axi_rready                    (s_axi_rready), 
        .axi_int                         (axi_int),

        .rx_vid_clk                      (rx_vid_clk),
        .rx_vid_rst                      (rx_vid_rst),
        .rx_vid_pixel_mode             	 (rx_vid_pixel_mode), 
        .rx_vid_vsync                    (rx_vid_vsync),
        .rx_vid_hsync                    (rx_vid_hsync),
        .rx_vid_oddeven                  (rx_vid_oddeven),
        .rx_vid_enable                   (rx_vid_enable),
        .rx_vid_valid_per_pixel          (rx_vid_valid_per_pixel),
        .rx_vid_last                     (rx_vid_last),
        .rx_vid_pixel0                   (rx_vid_pixel0),
        .rx_vid_pixel1                   (rx_vid_pixel1),
        .rx_vid_pixel2                   (rx_vid_pixel2),
        .rx_vid_pixel3                   (rx_vid_pixel3),
        .rx_enable_dsc                   (rx_enable_dsc),
        .rx_num_active_lanes             (rx_num_active_lanes),

        .rx_vid_clk_stream2 			(rx_vid_clk),
        .rx_vid_rst_stream2              	(rx_vid_rst),
        .rx_vid_vsync_stream2                  	(rx_vid_vsync_stream2  ), 
        .rx_vid_hsync_stream2                  	(rx_vid_hsync_stream2  ),
        .rx_vid_oddeven_stream2                	(rx_vid_oddeven_stream2),
        .rx_vid_enable_stream2                 	(rx_vid_enable_stream2 ),
        .rx_vid_pixel0_stream2                 	(rx_vid_pixel0_stream2 ),
        .rx_vid_pixel1_stream2                 	(rx_vid_pixel1_stream2 ),
        .rx_vid_pixel2_stream2                 	(rx_vid_pixel2_stream2 ),
        .rx_vid_pixel3_stream2                 	(rx_vid_pixel3_stream2 ),

        .rx_vid_clk_stream3              	(rx_vid_clk),
        .rx_vid_rst_stream3              	(rx_vid_rst),
        .rx_vid_vsync_stream3                  	(rx_vid_vsync_stream3  ), 
        .rx_vid_hsync_stream3                  	(rx_vid_hsync_stream3  ),
        .rx_vid_oddeven_stream3                	(rx_vid_oddeven_stream3),
        .rx_vid_enable_stream3                 	(rx_vid_enable_stream3 ),
        .rx_vid_pixel0_stream3                 	(rx_vid_pixel0_stream3 ),
        .rx_vid_pixel1_stream3                 	(rx_vid_pixel1_stream3 ),
        .rx_vid_pixel2_stream3                 	(rx_vid_pixel2_stream3 ),
        .rx_vid_pixel3_stream3                 	(rx_vid_pixel3_stream3 ),
 
        .rx_vid_clk_stream4                  	(rx_vid_clk),
        .rx_vid_rst_stream4                     (rx_vid_rst),
        .rx_vid_vsync_stream4                  	(rx_vid_vsync_stream4  ), 
        .rx_vid_hsync_stream4                  	(rx_vid_hsync_stream4  ),
        .rx_vid_oddeven_stream4                	(rx_vid_oddeven_stream4),
        .rx_vid_enable_stream4                 	(rx_vid_enable_stream4 ),
        .rx_vid_pixel0_stream4                 	(rx_vid_pixel0_stream4 ),
        .rx_vid_pixel1_stream4                 	(rx_vid_pixel1_stream4 ),
        .rx_vid_pixel2_stream4                 	(rx_vid_pixel2_stream4 ),
        .rx_vid_pixel3_stream4                 	(rx_vid_pixel3_stream4 ),
 

        .hdcp_ingress_clk                      (hdcp_ingress_clk      ),
        .hdcp_egress_clk                       (hdcp_egress_clk       ),
        .hdcp_ingress_clken                    (hdcp_ingress_clken    ),
        .hdcp_egress_clken                     (hdcp_egress_clken     ),
        .hdcp_rst                              (hdcp_rst              ),
        .hdcp_status                           (hdcp_status           ),
        .hdcp_egress_data                      (hdcp_egress_data      ),
        .hdcp_egress_tuser                     (hdcp_egress_tuser     ),
        .hdcp_egress_tready                    (hdcp_egress_tready    ),
        .hdcp_egress_tvalid                    (hdcp_egress_tvalid    ),
        .hdcp_ingress_data                     (hdcp_ingress_data     ),
        .hdcp_ingress_tuser                    (hdcp_ingress_tuser    ),
        .hdcp_ingress_tready                   (hdcp_ingress_tready   ),
        .hdcp_ingress_tvalid                   (hdcp_ingress_tvalid   ),
 
        .rx_gt_ctrl_out                  (rx_gt_ctrl_out),
        .rx_lnk_m_vid                    (lnk_m_vid),
        .rx_lnk_n_vid                    (lnk_n_vid),
        .rx_lnk_m_aud                    (lnk_m_aud),
        .rx_lnk_n_aud                    (lnk_n_aud),
        .rx_lnk_clk                      (lnk_clk),
        .rx_lnk_rx_lane0_k_char          (lnk_rx_lane0_k_char),
        .rx_lnk_rx_lane0_data            (lnk_rx_lane0_data),
        .rx_lnk_rx_lane0_symbol_error    (lnk_rx_lane0_symbol_error),
        .rx_lnk_rx_lane0_disparity_error (lnk_rx_lane0_disparity_error),
        .rx_lnk_rx_lane1_k_char          (lnk_rx_lane1_k_char),
        .rx_lnk_rx_lane1_data            (lnk_rx_lane1_data),
        .rx_lnk_rx_lane1_symbol_error    (lnk_rx_lane1_symbol_error),
        .rx_lnk_rx_lane1_disparity_error (lnk_rx_lane1_disparity_error),
        .rx_lnk_rx_lane2_k_char          (lnk_rx_lane2_k_char),
        .rx_lnk_rx_lane2_data            (lnk_rx_lane2_data),
        .rx_lnk_rx_lane2_symbol_error    (lnk_rx_lane2_symbol_error),
        .rx_lnk_rx_lane2_disparity_error (lnk_rx_lane2_disparity_error),
        .rx_lnk_rx_lane3_k_char          (lnk_rx_lane3_k_char),
        .rx_lnk_rx_lane3_data            (lnk_rx_lane3_data),
        .rx_lnk_rx_lane3_symbol_error    (lnk_rx_lane3_symbol_error),
        .rx_lnk_rx_lane3_disparity_error (lnk_rx_lane3_disparity_error),
        .rx_lnk_rx_gt_buf_rst            (lnk_rx_gt_buf_rst),
        .rx_dpcd_write_synchronize       (),
        .rx_cfg_rx_dpcd_regs             (cfg_rx_dpcd_regs),
        .rx_cfg_rx_phy_config            (cfg_rx_phy_config),
        .rx_cfg_rx_phy_status            (cfg_rx_phy_status),
        .rx_cfg_rx_vidmode_regs          (cfg_rx_vidmode_regs),
        .rx_cfg_rx_vidmode_regs_stream2  (cfg_rx_vidmode_regs_stream2),
        .rx_cfg_rx_vidmode_regs_stream3  (cfg_rx_vidmode_regs_stream3),
        .rx_cfg_rx_vidmode_regs_stream4  (cfg_rx_vidmode_regs_stream4),
        .rx_aux_data_in                  (rx_aux_data_in),
        .rx_aux_data_out                 (rx_aux_data_out),
        .rx_aux_data_enable_n            (rx_aux_data_enable_n),
        .rx_i2c_sda_in                   (i2c_sda_in),
        .rx_i2c_sda_enable_n             (i2c_sda_enable_n),
        .rx_i2c_scl_in                   (i2c_scl_in),
        .rx_i2c_scl_enable_n             (i2c_scl_enable_n),
        .rx_hot_plug_detect              (rx_hot_plug_detect),
        .access_link_bw_set              (access_link_bw_set),
        .access_train_lane_set           (access_train_lane_set),

        .rx_aud_rst                      (aud_rst),
        .rx_m_axis_audio_egress_aclk     (aud_axis_aclk),
        .rx_m_axis_audio_egress_tdata    (m_axis_audio_egress_tdata),
        .rx_m_axis_audio_egress_tid      (m_axis_audio_egress_tid),
        .rx_m_axis_audio_egress_tvalid   (m_axis_audio_egress_tvalid),
        .rx_m_axis_audio_egress_tready   (m_axis_audio_egress_tready),

        .rx_m_axis_audio_egress_aclk_stream2     (1'b0),
        .rx_m_axis_audio_egress_tdata_stream2    (),
        .rx_m_axis_audio_egress_tid_stream2      (),
        .rx_m_axis_audio_egress_tvalid_stream2   (),
        .rx_m_axis_audio_egress_tready_stream2   (1'b0),

        .rx_m_axis_audio_egress_aclk_stream3     (1'b0),
        .rx_m_axis_audio_egress_tdata_stream3    (),
        .rx_m_axis_audio_egress_tid_stream3      (),
        .rx_m_axis_audio_egress_tvalid_stream3   (),
        .rx_m_axis_audio_egress_tready_stream3   (1'b0),

        .rx_m_axis_audio_egress_aclk_stream4     (1'b0),
        .rx_m_axis_audio_egress_tdata_stream4    (),
        .rx_m_axis_audio_egress_tid_stream4      (),
        .rx_m_axis_audio_egress_tvalid_stream4   (),
        .rx_m_axis_audio_egress_tready_stream4   (1'b0),

        .debug_sec_port                          (),
        .acr_m_aud                               (acr_m_aud),
        .acr_n_aud                               (acr_n_aud),
        .acr_valid                               (acr_valid),
        .m_axis_rx_pps_tdata                     (m_axis_rx_pps_tdata),   
        .m_axis_rx_pps_tvalid                    (m_axis_rx_pps_tvalid),
        .m_axis_rx_pps_tuser                     (m_axis_rx_pps_tuser),   
        .m_axis_rx_pps_tlast                     (m_axis_rx_pps_tlast),   
        .m_axis_rx_pps_tready                    (m_axis_rx_pps_tready),        
        .fec_rx_clken       (fec_rx_clken     ),          
        .fec_rx_reset       (fec_rx_reset     ),         
        .fec_rx_valid_in    (fec_rx_valid_in  ),         
        .fec_rx_ph_out      (fec_rx_ph_out    ),         
        .fec_rx_data_in     (fec_rx_data_in   ),         
        .fec_rx_enable_in   (fec_rx_enable_in ),    
        .fec_rx_num_lanes   (fec_rx_num_lanes ),    
        .fec_rx_data_out    (fec_rx_data_out  ),     
        .fec_rx_data_k_out  (fec_rx_data_k_out),     
        .fec_rx_val_out     (fec_rx_val_out   ),             
        .fec_rx_pm_out      (fec_rx_pm_out    ),     
        .dsc_debug_bus_vid  (/*dsc_rx_debug_bus_vid*/    ),
        .dsc_debug_bus_lnk  (/*dsc_rx_debug_bus_lnk*/    )

    );
   assign          dsc_rx_debug_bus_vid   = 0;
   assign          dsc_rx_debug_bus_lnk   = 0;

end
endgenerate

generate if (( C_FLOW_DIRECTION == 0 ) && (C_PHY_TYPE_EXTERNAL == 0 ))
begin
    //----------------------------------------------
    // PHY component
    //----------------------------------------------
    system_displayport_0_0_tx_phy
    #(
        .pDEVICE_FAMILY     (C_FAMILY),
        .pTCQ               (100),
        .pLANE_COUNT        (C_LANE_COUNT),
        .pAC_CAP_DISABLE    ("TRUE"),
        .pDATA_WIDTH        (C_DATA_WIDTH),
	.pBUF_BYPASS        (C_BUF_BYPASS)
    ) dport_tx_phy_inst
    (    
        .lnk_clk_ibufds                       (lnk_clk_ibufds),
        .lnk_clk                              (lnk_clk),
        .lnk_tx_lane0_override_disparity      (lnk_tx_lane0_override_disparity),
        .lnk_tx_lane0_k_char                  (lnk_tx_lane0_k_char),
        .lnk_tx_lane0_data                    (lnk_tx_lane0_data),              
        .lnk_tx_lane1_override_disparity      (lnk_tx_lane1_override_disparity),
        .lnk_tx_lane1_k_char                  (lnk_tx_lane1_k_char),            
        .lnk_tx_lane1_data                    (lnk_tx_lane1_data),              
        .lnk_tx_lane2_override_disparity      (lnk_tx_lane2_override_disparity),
        .lnk_tx_lane2_k_char                  (lnk_tx_lane2_k_char),            
        .lnk_tx_lane2_data                    (lnk_tx_lane2_data),              
        .lnk_tx_lane3_override_disparity      (lnk_tx_lane3_override_disparity),
        .lnk_tx_lane3_k_char                  (lnk_tx_lane3_k_char),            
        .lnk_tx_lane3_data                    (lnk_tx_lane3_data),
        .lnk_tx_lane_p                        (lnk_tx_lane_p),
        .lnk_tx_lane_n                        (lnk_tx_lane_n),
        .cfg_tx_phy_config                    (cfg_tx_phy_config),
        .cfg_tx_phy_status                    (cfg_tx_phy_status),
        .apb_clk                              (s_axi_aclk),
        .apb_reset                            (axi_reset),

        .aux_data_out                         (tx_aux_data_out),
        .aux_data_in                          (tx_aux_data_in),
        .aux_data_enable_n                    (tx_aux_data_enable_n),
        .aux_tx_out_channel_p                 (aux_tx_channel_out_p),           
        .aux_tx_out_channel_n                 (aux_tx_channel_out_n),
        .aux_tx_in_channel_p                  (aux_tx_channel_in_p),
        .aux_tx_in_channel_n                  (aux_tx_channel_in_n),
        .hpd                                  (tx_hpd),
        .hot_plug_detect                      (tx_hot_plug_detect),
        .link_bw_high_out                     (link_bw_high_out),
        .link_bw_hbr2_out                     (link_bw_hbr2_out),
        .bw_changed_out                       (bw_changed_out),
        .phy_pll_reset_out                    (phy_pll_reset_out),


        .gt0_qpllclk_in                       (common_qpll_clk),
        .gt0_qpllclk_lock                     (common_qpll_lock),
        .gt0_qpllrefclk_in                    (common_qpll_ref_clk)
    );
end
endgenerate

generate if (( C_FLOW_DIRECTION == 1 ) && (C_PHY_TYPE_EXTERNAL == 0 ) )
begin 
    assign lnk_tx_lane_p = 'h0;
    assign lnk_tx_lane_n = 'h0;
    //----------------------------------------------
    // DisplayPort PHY
    //----------------------------------------------
    system_displayport_0_0_rx_phy
    #(
        .pDEVICE_FAMILY     (C_FAMILY),
        .pTCQ               (100),
        .pLANE_COUNT        (C_LANE_COUNT),
        .pAC_CAP_DISABLE    ("TRUE"),
        .pDATA_WIDTH        (C_DATA_WIDTH)
    ) dport_rx_phy_inst
    (    
        // main link transceiver interface
        .lnk_clk_ibufds                 (lnk_clk_ibufds),
        .lnk_fwdclk_ibufds              (lnk_fwdclk_ibufds),
        .lnk_clk                        (lnk_clk),
        .lnk_rx_lane0_kchar             (lnk_rx_lane0_k_char),          
        .lnk_rx_lane0_data              (lnk_rx_lane0_data),            
        .lnk_rx_lane0_symbol_error      (lnk_rx_lane0_symbol_error),    
        .lnk_rx_lane0_disparity_error   (lnk_rx_lane0_disparity_error), 
        .lnk_rx_lane1_kchar             (lnk_rx_lane1_k_char),          
        .lnk_rx_lane1_data              (lnk_rx_lane1_data),            
        .lnk_rx_lane1_symbol_error      (lnk_rx_lane1_symbol_error),    
        .lnk_rx_lane1_disparity_error   (lnk_rx_lane1_disparity_error), 
        .lnk_rx_lane2_kchar             (lnk_rx_lane2_k_char),          
        .lnk_rx_lane2_data              (lnk_rx_lane2_data),            
        .lnk_rx_lane2_symbol_error      (lnk_rx_lane2_symbol_error),    
        .lnk_rx_lane2_disparity_error   (lnk_rx_lane2_disparity_error), 
        .lnk_rx_lane3_kchar             (lnk_rx_lane3_k_char),          
        .lnk_rx_lane3_data              (lnk_rx_lane3_data),            
        .lnk_rx_lane3_symbol_error      (lnk_rx_lane3_symbol_error),    
        .lnk_rx_lane3_disparity_error   (lnk_rx_lane3_disparity_error), 
        .lnk_rx_gt_buf_rst              (lnk_rx_gt_buf_rst), 
        .lnk_rx_lane_p                  (lnk_rx_lane_p),
        .lnk_rx_lane_n                  (lnk_rx_lane_n),
        // control signals
        .access_link_bw_set             (access_link_bw_set),
        .access_train_lane_set          (access_train_lane_set),
        // configuration and status
        .cfg_rx_dpcd_regs               (cfg_rx_dpcd_regs),
        .cfg_rx_phy_config              (cfg_rx_phy_config),
        .cfg_rx_phy_status              (cfg_rx_phy_status),
        .apb_clk                        (s_axi_aclk),
        .apb_reset                      (axi_reset),

        // AUX channel interface
        .aux_data_out                   (rx_aux_data_out),
        .aux_data_in                    (rx_aux_data_in),
        .aux_data_enable_n              (rx_aux_data_enable_n),
        .aux_rx_out_channel_p           (aux_rx_channel_out_p),
        .aux_rx_out_channel_n           (aux_rx_channel_out_n),
        .aux_rx_in_channel_p            (aux_rx_channel_in_p),
        .aux_rx_in_channel_n            (aux_rx_channel_in_n),
       // HPD interface
        .hpd                            (rx_hpd),
        .hot_plug_detect                (rx_hot_plug_detect),
        .link_bw_high_out               (link_bw_high_out),
        .link_bw_hbr2_out               (link_bw_hbr2_out),
        .bw_changed_out                 (bw_changed_out),
        .phy_pll_reset_out              (phy_pll_reset_out),

        .gt0_qpllclk_in                 (common_qpll_clk),
        .gt0_qpllclk_lock               (common_qpll_lock),
        .gt0_qpllrefclk_in              (common_qpll_ref_clk)
    );

end
endgenerate

  assign aux_debug_bus      = 4'h0;
  assign link_debug_gt0     = 69'h0;
  assign link_debug_gt1     = 69'h0;
  assign link_debug_gt2     = 69'h0;
  assign link_debug_gt3     = 69'h0;
  assign link_debug_control = 96'h0;



endmodule
