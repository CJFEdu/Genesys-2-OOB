// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
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
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:ip:displayport:7.0
// IP Revision: 3

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module system_displayport_0_0 (
  s_axi_aclk,
  s_axi_aresetn,
  s_axi_awaddr,
  s_axi_awprot,
  s_axi_awvalid,
  s_axi_awready,
  s_axi_wdata,
  s_axi_wstrb,
  s_axi_wvalid,
  s_axi_wready,
  s_axi_bresp,
  s_axi_bvalid,
  s_axi_bready,
  s_axi_araddr,
  s_axi_arprot,
  s_axi_arvalid,
  s_axi_arready,
  s_axi_rdata,
  s_axi_rresp,
  s_axi_rvalid,
  s_axi_rready,
  axi_int,
  tx_vid_clk,
  tx_vid_rst,
  tx_vid_vsync,
  tx_vid_hsync,
  tx_vid_oddeven,
  tx_vid_enable,
  tx_vid_pixel0,
  tx_vid_pixel1,
  tx_bpc,
  tx_video_format,
  tx_ppc,
  lnk_tx_lane_p,
  lnk_tx_lane_n,
  tx_hpd,
  lnk_clk,
  common_qpll_clk_out,
  common_qpll_ref_clk_out,
  common_qpll_lock_out,
  lnk_clk_ibufds_out,
  lnk_clk_p,
  lnk_clk_n,
  aux_tx_channel_out_n,
  aux_tx_channel_out_p,
  aux_tx_channel_in_p,
  aux_tx_channel_in_n
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 dp_axilite_clk CLK" *)
input wire s_axi_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 dp_axilite_rst RST" *)
input wire s_axi_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite AWADDR" *)
input wire [31 : 0] s_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite AWPROT" *)
input wire [2 : 0] s_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite AWVALID" *)
input wire s_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite AWREADY" *)
output wire s_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite WDATA" *)
input wire [31 : 0] s_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite WSTRB" *)
input wire [3 : 0] s_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite WVALID" *)
input wire s_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite WREADY" *)
output wire s_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite BRESP" *)
output wire [1 : 0] s_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite BVALID" *)
output wire s_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite BREADY" *)
input wire s_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite ARADDR" *)
input wire [31 : 0] s_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite ARPROT" *)
input wire [2 : 0] s_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite ARVALID" *)
input wire s_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite ARREADY" *)
output wire s_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite RDATA" *)
output wire [31 : 0] s_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite RRESP" *)
output wire [1 : 0] s_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite RVALID" *)
output wire s_axi_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 dp_s_axilite RREADY" *)
input wire s_axi_rready;
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 dp_axilite_int INTERRUPT" *)
output wire axi_int;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 tx_vid_clk CLK" *)
input wire tx_vid_clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 tx_vid_rst RST" *)
input wire tx_vid_rst;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_tx_vid_intf_str0 TX_VID_VSYNC" *)
input wire tx_vid_vsync;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_tx_vid_intf_str0 TX_VID_HSYNC" *)
input wire tx_vid_hsync;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_tx_vid_intf_str0 TX_VID_ODDEVEN" *)
input wire tx_vid_oddeven;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_tx_vid_intf_str0 TX_VID_ENABLE" *)
input wire tx_vid_enable;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_tx_vid_intf_str0 TX_VID_PIXEL0" *)
input wire [47 : 0] tx_vid_pixel0;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_vid:1.0 dp_tx_vid_intf_str0 TX_VID_PIXEL1" *)
input wire [47 : 0] tx_vid_pixel1;
output wire [2 : 0] tx_bpc;
output wire [1 : 0] tx_video_format;
output wire [2 : 0] tx_ppc;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_main_lnk:1.0 dp_mainlink LNK_TX_LANE_P" *)
output wire [3 : 0] lnk_tx_lane_p;
(* X_INTERFACE_INFO = "xilinx.com:interface:dp_main_lnk:1.0 dp_mainlink LNK_TX_LANE_N" *)
output wire [3 : 0] lnk_tx_lane_n;
input wire tx_hpd;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 lnk_clk CLK" *)
output wire lnk_clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 common_qpll_clk_out CLK" *)
output wire common_qpll_clk_out;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 common_qpll_ref_clk_out CLK" *)
output wire common_qpll_ref_clk_out;
output wire common_qpll_lock_out;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 lnk_clk_ibufds_out CLK" *)
output wire lnk_clk_ibufds_out;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 lnk_clk_p CLK" *)
input wire lnk_clk_p;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 lnk_clk_n CLK" *)
input wire lnk_clk_n;
output wire aux_tx_channel_out_n;
output wire aux_tx_channel_out_p;
input wire aux_tx_channel_in_p;
input wire aux_tx_channel_in_n;

  system_displayport_0_0_dport_wrapper #(
    .C_COMPONENT_NAME("system_displayport_0_0"),
    .C_FAMILY("kintex7"),
    .C_DEVICE("xc7k325t"),
    .C_FLOW_DIRECTION(0),
    .C_PHY_TYPE_EXTERNAL(0),
    .C_GT_DATAWIDTH(2),
    .C_LANE_COUNT(4),
    .C_INCLUDE_HDCP(0),
    .C_SECONDARY_SUPPORT(0),
    .C_AUDIO_CHANNELS(2),
    .C_IEEE_OUI("000A35"),
    .C_VENDOR_SPECIFIC(0),
    .C_PROTOCOL_SELECTION(1),
    .C_LINK_RATE(20),
    .C_MST_ENABLE(0),
    .C_NUMBER_OF_MST_STREAMS(2),
    .C_MAX_BITS_PER_COLOR(8),
    .C_QUAD_PIXEL_ENABLE(0),
    .C_DUAL_PIXEL_ENABLE(1),
    .C_YCRCB_ENABLE(1),
    .C_YONLY_ENABLE(0),
    .C_BUF_BYPASS(0),
    .C_EDP_EN(0),
    .C_SIM_MODE(0)
  ) inst (
    .s_axi_aclk(s_axi_aclk),
    .s_axi_aresetn(s_axi_aresetn),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awprot(s_axi_awprot),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),
    .s_axi_bresp(s_axi_bresp),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arprot(s_axi_arprot),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),
    .axi_int(axi_int),
    .lnk_clk_ibufds(1'B0),
    .lnk_fwdclk_ibufds(1'B0),
    .tx_vid_clk(tx_vid_clk),
    .tx_vid_rst(tx_vid_rst),
    .tx_vid_vsync(tx_vid_vsync),
    .tx_vid_hsync(tx_vid_hsync),
    .tx_vid_oddeven(tx_vid_oddeven),
    .tx_vid_enable(tx_vid_enable),
    .tx_vid_pixel0(tx_vid_pixel0),
    .tx_vid_pixel1(tx_vid_pixel1),
    .tx_vid_pixel2(48'B0),
    .tx_vid_pixel3(48'B0),
    .tx_vid_clk_stream2(1'B0),
    .tx_vid_rst_stream2(1'B0),
    .tx_vid_vsync_stream2(1'B0),
    .tx_vid_hsync_stream2(1'B0),
    .tx_vid_oddeven_stream2(1'B0),
    .tx_vid_enable_stream2(1'B0),
    .tx_vid_pixel0_stream2(48'B0),
    .tx_vid_pixel1_stream2(48'B0),
    .tx_vid_pixel2_stream2(48'B0),
    .tx_vid_pixel3_stream2(48'B0),
    .tx_vid_clk_stream3(1'B0),
    .tx_vid_rst_stream3(1'B0),
    .tx_vid_vsync_stream3(1'B0),
    .tx_vid_hsync_stream3(1'B0),
    .tx_vid_oddeven_stream3(1'B0),
    .tx_vid_enable_stream3(1'B0),
    .tx_vid_pixel0_stream3(48'B0),
    .tx_vid_pixel1_stream3(48'B0),
    .tx_vid_pixel2_stream3(48'B0),
    .tx_vid_pixel3_stream3(48'B0),
    .tx_vid_clk_stream4(1'B0),
    .tx_vid_rst_stream4(1'B0),
    .tx_vid_vsync_stream4(1'B0),
    .tx_vid_hsync_stream4(1'B0),
    .tx_vid_oddeven_stream4(1'B0),
    .tx_vid_enable_stream4(1'B0),
    .tx_vid_pixel0_stream4(48'B0),
    .tx_vid_pixel1_stream4(48'B0),
    .tx_vid_pixel2_stream4(48'B0),
    .tx_vid_pixel3_stream4(48'B0),
    .tx_bpc(tx_bpc),
    .tx_video_format(tx_video_format),
    .tx_ppc(tx_ppc),
    .txss_axi_control(),
    .txss_axi_status(32'B0),
    .tx_video_format_stream2(),
    .tx_ppc_stream2(),
    .tx_video_format_stream3(),
    .tx_ppc_stream3(),
    .tx_video_format_stream4(),
    .tx_ppc_stream4(),
    .lnk_tx_lane_p(lnk_tx_lane_p),
    .lnk_tx_lane_n(lnk_tx_lane_n),
    .aux_tx_io_p(),
    .aux_tx_io_n(),
    .aux_tx_data_in(1'B0),
    .aux_tx_data_out(),
    .aux_tx_data_en_out_n(),
    .tx_hpd(tx_hpd),
    .rx_vid_clk(1'B0),
    .rx_vid_rst(1'B0),
    .rx_vid_vsync(),
    .rx_vid_hsync(),
    .rx_vid_oddeven(),
    .rx_vid_enable(),
    .rx_vid_pixel0(),
    .rx_vid_pixel1(),
    .rx_vid_pixel2(),
    .rx_vid_pixel3(),
    .rx_vid_clk_stream2(1'B0),
    .rx_vid_rst_stream2(1'B0),
    .rx_vid_vsync_stream2(),
    .rx_vid_hsync_stream2(),
    .rx_vid_oddeven_stream2(),
    .rx_vid_enable_stream2(),
    .rx_vid_pixel0_stream2(),
    .rx_vid_pixel1_stream2(),
    .rx_vid_pixel2_stream2(),
    .rx_vid_pixel3_stream2(),
    .rx_vid_clk_stream3(1'B0),
    .rx_vid_rst_stream3(1'B0),
    .rx_vid_vsync_stream3(),
    .rx_vid_hsync_stream3(),
    .rx_vid_oddeven_stream3(),
    .rx_vid_enable_stream3(),
    .rx_vid_pixel0_stream3(),
    .rx_vid_pixel1_stream3(),
    .rx_vid_pixel2_stream3(),
    .rx_vid_pixel3_stream3(),
    .rx_vid_clk_stream4(1'B0),
    .rx_vid_rst_stream4(1'B0),
    .rx_vid_vsync_stream4(),
    .rx_vid_hsync_stream4(),
    .rx_vid_oddeven_stream4(),
    .rx_vid_enable_stream4(),
    .rx_vid_pixel0_stream4(),
    .rx_vid_pixel1_stream4(),
    .rx_vid_pixel2_stream4(),
    .rx_vid_pixel3_stream4(),
    .lnk_m_vid(),
    .lnk_n_vid(),
    .lnk_rx_lane_p(4'B0),
    .lnk_rx_lane_n(4'B0),
    .aux_rx_io_p(),
    .aux_rx_io_n(),
    .aux_rx_data_in(1'B0),
    .aux_rx_data_out(),
    .aux_rx_data_en_out_n(),
    .rx_hpd(),
    .i2c_sda_in(1'B1),
    .i2c_sda_enable_n(),
    .i2c_sda_o(),
    .i2c_scl_in(1'B1),
    .i2c_scl_enable_n(),
    .i2c_scl_o(),
    .s_aud_axis_aclk(1'B0),
    .s_aud_axis_aresetn(1'B1),
    .aud_clk(1'B0),
    .aud_rst(1'B0),
    .s_axis_audio_ingress_tdata(32'B0),
    .s_axis_audio_ingress_tid(8'B0),
    .s_axis_audio_ingress_tvalid(1'B0),
    .s_axis_audio_ingress_tready(),
    .tx_lnk_clk(1'B0),
    .lnk_tx_axi4s_lane0_tdata(),
    .lnk_tx_axi4s_lane0_tuser(),
    .lnk_tx_axi4s_lane0_tvalid(),
    .lnk_tx_axi4s_lane0_tready(1'B0),
    .lnk_tx_axi4s_lane1_tdata(),
    .lnk_tx_axi4s_lane1_tuser(),
    .lnk_tx_axi4s_lane1_tvalid(),
    .lnk_tx_axi4s_lane1_tready(1'B0),
    .lnk_tx_axi4s_lane2_tdata(),
    .lnk_tx_axi4s_lane2_tuser(),
    .lnk_tx_axi4s_lane2_tvalid(),
    .lnk_tx_axi4s_lane2_tready(1'B0),
    .lnk_tx_axi4s_lane3_tdata(),
    .lnk_tx_axi4s_lane3_tuser(),
    .lnk_tx_axi4s_lane3_tvalid(),
    .lnk_tx_axi4s_lane3_tready(1'B0),
    .lnk_tx_sb_status_axi4s_tdata(8'B0),
    .lnk_tx_sb_status_axi4s_tvalid(1'B0),
    .lnk_tx_sb_status_axi4s_tready(),
    .rx_lnk_clk(1'B0),
    .lnk_rx_axi4s_lane0_tdata(32'B0),
    .lnk_rx_axi4s_lane0_tuser(12'B0),
    .lnk_rx_axi4s_lane0_tvalid(1'B0),
    .lnk_rx_axi4s_lane0_tready(),
    .lnk_rx_axi4s_lane1_tdata(32'B0),
    .lnk_rx_axi4s_lane1_tuser(12'B0),
    .lnk_rx_axi4s_lane1_tvalid(1'B0),
    .lnk_rx_axi4s_lane1_tready(),
    .lnk_rx_axi4s_lane2_tdata(32'B0),
    .lnk_rx_axi4s_lane2_tuser(12'B0),
    .lnk_rx_axi4s_lane2_tvalid(1'B0),
    .lnk_rx_axi4s_lane2_tready(),
    .lnk_rx_axi4s_lane3_tdata(32'B0),
    .lnk_rx_axi4s_lane3_tuser(12'B0),
    .lnk_rx_axi4s_lane3_tvalid(1'B0),
    .lnk_rx_axi4s_lane3_tready(),
    .lnk_rx_sb_status_axi4s_tdata(16'B0),
    .lnk_rx_sb_status_axi4s_tvalid(1'B0),
    .lnk_rx_sb_status_axi4s_tready(),
    .lnk_rx_sb_control_axi4s_tdata(),
    .lnk_rx_sb_control_axi4s_tvalid(),
    .lnk_rx_sb_control_axi4s_tready(1'B0),
    .lnk_m_aud(),
    .lnk_n_aud(),
    .m_aud_axis_aclk(1'B0),
    .m_aud_axis_aresetn(1'B1),
    .m_axis_audio_egress_tdata(),
    .m_axis_audio_egress_tid(),
    .m_axis_audio_egress_tvalid(),
    .m_axis_audio_egress_tready(1'B0),
    .link_bw_high_out(),
    .link_bw_hbr2_out(),
    .bw_changed_out(),
    .phy_pll_reset_out(),
    .common_qpll_clk(1'B0),
    .common_qpll_lock(1'B0),
    .common_qpll_ref_clk(1'B0),
    .pll0_lock(1'B0),
    .pll1_lock(1'B0),
    .pll0_clk(1'B0),
    .pll0_ref_clk(1'B0),
    .pll1_clk(1'B0),
    .pll1_ref_clk(1'B0),
    .link_debug_gt0(),
    .link_debug_gt1(),
    .link_debug_gt2(),
    .link_debug_gt3(),
    .link_debug_control(),
    .aux_debug_bus(),
    .lnk_clk(lnk_clk),
    .rx_vid_pixel_mode(),
    .rx_vid_msa_hres(),
    .rx_vid_msa_vres(),
    .rx_vid_msa_hres_stream2(),
    .rx_vid_msa_hres_stream3(),
    .rx_vid_msa_hres_stream4(),
    .rx_vid_msa_vres_stream2(),
    .rx_vid_msa_vres_stream3(),
    .rx_vid_msa_vres_stream4(),
    .rx_bpc(),
    .rx_bpc_stream2(),
    .rx_bpc_stream3(),
    .rx_bpc_stream4(),
    .rx_cformat(),
    .rx_cformat_stream2(),
    .rx_cformat_stream3(),
    .rx_cformat_stream4(),
    .common_qpll_clk_out(common_qpll_clk_out),
    .common_qpll_ref_clk_out(common_qpll_ref_clk_out),
    .common_qpll_lock_out(common_qpll_lock_out),
    .pll0_lock_out(),
    .pll1_lock_out(),
    .pll0_clk_out(),
    .pll0_ref_clk_out(),
    .pll1_clk_out(),
    .pll1_ref_clk_out(),
    .lnk_clk_ibufds_out(lnk_clk_ibufds_out),
    .lnk_clk_p(lnk_clk_p),
    .lnk_clk_n(lnk_clk_n),
    .lnk_fwdclk_p(1'B1),
    .lnk_fwdclk_n(1'B0),
    .aux_tx_channel_out_n(aux_tx_channel_out_n),
    .aux_tx_channel_out_p(aux_tx_channel_out_p),
    .aux_tx_channel_in_p(aux_tx_channel_in_p),
    .aux_tx_channel_in_n(aux_tx_channel_in_n),
    .aux_rx_channel_in_n(1'B0),
    .aux_rx_channel_in_p(1'B1),
    .aux_rx_channel_out_p(),
    .aux_rx_channel_out_n(),
    .hdcp_egress_data(),
    .hdcp_egress_tuser(),
    .hdcp_egress_tready(1'B0),
    .hdcp_egress_tvalid(),
    .hdcp_ingress_data(128'B0),
    .hdcp_ingress_tuser(16'B0),
    .hdcp_ingress_tready(),
    .hdcp_ingress_tvalid(1'B0),
    .hdcp_status(8'B0),
    .hdcp_ingress_clk(1'B0),
    .hdcp_egress_clk(),
    .hdcp_ingress_clken(1'B0),
    .hdcp_egress_clken(),
    .hdcp_rst()
  );
endmodule
