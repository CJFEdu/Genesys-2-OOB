--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Command: generate_target bd_4bad.bd
--Design : bd_4bad
--Purpose: IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_4bad is
  port (
    axi_rxd_arstn : in STD_LOGIC;
    axi_rxs_arstn : in STD_LOGIC;
    axi_txc_arstn : in STD_LOGIC;
    axi_txd_arstn : in STD_LOGIC;
    axis_clk : in STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    gtx_clk90_out : out STD_LOGIC;
    gtx_clk_out : out STD_LOGIC;
    interrupt : out STD_LOGIC;
    m_axis_rxd_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_rxd_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_rxd_tlast : out STD_LOGIC;
    m_axis_rxd_tready : in STD_LOGIC;
    m_axis_rxd_tvalid : out STD_LOGIC;
    m_axis_rxs_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_rxs_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_rxs_tlast : out STD_LOGIC;
    m_axis_rxs_tready : in STD_LOGIC;
    m_axis_rxs_tvalid : out STD_LOGIC;
    mac_irq : out STD_LOGIC;
    mdio_mdc : out STD_LOGIC;
    mdio_mdio_i : in STD_LOGIC;
    mdio_mdio_o : out STD_LOGIC;
    mdio_mdio_t : out STD_LOGIC;
    phy_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    ref_clk : in STD_LOGIC;
    rgmii_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_rx_ctl : in STD_LOGIC;
    rgmii_rxc : in STD_LOGIC;
    rgmii_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_tx_ctl : out STD_LOGIC;
    rgmii_txc : out STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 17 downto 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 17 downto 0 );
    s_axi_awready : out STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_lite_clk : in STD_LOGIC;
    s_axi_lite_resetn : in STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wready : out STD_LOGIC;
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axis_txc_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_txc_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_txc_tlast : in STD_LOGIC;
    s_axis_txc_tready : out STD_LOGIC;
    s_axis_txc_tvalid : in STD_LOGIC;
    s_axis_txd_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_txd_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_txd_tlast : in STD_LOGIC;
    s_axis_txd_tready : out STD_LOGIC;
    s_axis_txd_tvalid : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of bd_4bad : entity is "bd_4bad,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_4bad,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=6,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SBD,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of bd_4bad : entity is "system_axi_ethernet_0_0.hwdef";
end bd_4bad;

architecture STRUCTURE of bd_4bad is
  component bd_4bad_eth_buf_0 is
  port (
    INTERRUPT : out STD_LOGIC;
    S_AXI_ACLK : in STD_LOGIC;
    S_AXI_ARESETN : in STD_LOGIC;
    S_AXI_AWADDR : in STD_LOGIC_VECTOR ( 17 downto 0 );
    S_AXI_AWVALID : in STD_LOGIC;
    S_AXI_AWREADY : out STD_LOGIC;
    S_AXI_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_WVALID : in STD_LOGIC;
    S_AXI_WREADY : out STD_LOGIC;
    S_AXI_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_BVALID : out STD_LOGIC;
    S_AXI_BREADY : in STD_LOGIC;
    S_AXI_ARADDR : in STD_LOGIC_VECTOR ( 17 downto 0 );
    S_AXI_ARVALID : in STD_LOGIC;
    S_AXI_ARREADY : out STD_LOGIC;
    S_AXI_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_RVALID : out STD_LOGIC;
    S_AXI_RREADY : in STD_LOGIC;
    EMAC_CLIENT_AUTONEG_INT : in STD_LOGIC;
    EMAC_RESET_DONE_INT : in STD_LOGIC;
    EMAC_RX_DCM_LOCKED_INT : in STD_LOGIC;
    PCSPMA_STATUS_VECTOR : in STD_LOGIC_VECTOR ( 15 downto 0 );
    AXI_STR_TXD_ACLK : in STD_LOGIC;
    AXI_STR_TXD_ARESETN : in STD_LOGIC;
    AXI_STR_TXD_TVALID : in STD_LOGIC;
    AXI_STR_TXD_TREADY : out STD_LOGIC;
    AXI_STR_TXD_TLAST : in STD_LOGIC;
    AXI_STR_TXD_TKEEP : in STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_STR_TXD_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    AXI_STR_TXC_ACLK : in STD_LOGIC;
    AXI_STR_TXC_ARESETN : in STD_LOGIC;
    AXI_STR_TXC_TVALID : in STD_LOGIC;
    AXI_STR_TXC_TREADY : out STD_LOGIC;
    AXI_STR_TXC_TLAST : in STD_LOGIC;
    AXI_STR_TXC_TKEEP : in STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_STR_TXC_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    AXI_STR_RXD_ACLK : in STD_LOGIC;
    AXI_STR_RXD_ARESETN : in STD_LOGIC;
    AXI_STR_RXD_VALID : out STD_LOGIC;
    AXI_STR_RXD_READY : in STD_LOGIC;
    AXI_STR_RXD_LAST : out STD_LOGIC;
    AXI_STR_RXD_KEEP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_STR_RXD_DATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    AXI_STR_RXS_ACLK : in STD_LOGIC;
    AXI_STR_RXS_ARESETN : in STD_LOGIC;
    AXI_STR_RXS_VALID : out STD_LOGIC;
    AXI_STR_RXS_READY : in STD_LOGIC;
    AXI_STR_RXS_LAST : out STD_LOGIC;
    AXI_STR_RXS_KEEP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    AXI_STR_RXS_DATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    pause_req : out STD_LOGIC;
    pause_val : out STD_LOGIC_VECTOR ( 16 to 31 );
    S_AXI_2TEMAC_AWADDR : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S_AXI_2TEMAC_AWVALID : out STD_LOGIC;
    S_AXI_2TEMAC_AWREADY : in STD_LOGIC;
    S_AXI_2TEMAC_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2TEMAC_WVALID : out STD_LOGIC;
    S_AXI_2TEMAC_WREADY : in STD_LOGIC;
    S_AXI_2TEMAC_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_2TEMAC_BVALID : in STD_LOGIC;
    S_AXI_2TEMAC_BREADY : out STD_LOGIC;
    S_AXI_2TEMAC_ARADDR : out STD_LOGIC_VECTOR ( 11 downto 0 );
    S_AXI_2TEMAC_ARVALID : out STD_LOGIC;
    S_AXI_2TEMAC_ARREADY : in STD_LOGIC;
    S_AXI_2TEMAC_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_2TEMAC_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_2TEMAC_RVALID : in STD_LOGIC;
    S_AXI_2TEMAC_RREADY : out STD_LOGIC;
    RX_CLK_ENABLE_IN : in STD_LOGIC;
    rx_statistics_vector : in STD_LOGIC_VECTOR ( 27 downto 0 );
    rx_statistics_valid : in STD_LOGIC;
    rx_mac_aclk : in STD_LOGIC;
    rx_reset : in STD_LOGIC;
    rx_axis_mac_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_axis_mac_tvalid : in STD_LOGIC;
    rx_axis_mac_tlast : in STD_LOGIC;
    rx_axis_mac_tuser : in STD_LOGIC;
    tx_ifg_delay : out STD_LOGIC_VECTOR ( 24 to 31 );
    tx_mac_aclk : in STD_LOGIC;
    tx_reset : in STD_LOGIC;
    tx_axis_mac_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_axis_mac_tvalid : out STD_LOGIC;
    tx_axis_mac_tlast : out STD_LOGIC;
    tx_axis_mac_tuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    tx_axis_mac_tready : in STD_LOGIC;
    speed_is_10_100 : in STD_LOGIC;
    RESET2PCSPMA : out STD_LOGIC;
    RESET2TEMACn : out STD_LOGIC;
    PHY_RST_N : out STD_LOGIC;
    mdio_i_top : in STD_LOGIC;
    mdio_o_top : out STD_LOGIC;
    mdio_t_top : out STD_LOGIC;
    mdc_top : out STD_LOGIC;
    mdio_t_pcspma : in STD_LOGIC;
    mdio_o_pcspma : in STD_LOGIC;
    mdio_i_temac : out STD_LOGIC;
    mdio_o_temac : in STD_LOGIC;
    mdio_t_temac : in STD_LOGIC;
    mdc_temac : in STD_LOGIC;
    GTX_CLK : in STD_LOGIC
  );
  end component bd_4bad_eth_buf_0;
  component bd_4bad_mac_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_resetn : in STD_LOGIC;
    gtx_clk : in STD_LOGIC;
    gtx_clk_out : out STD_LOGIC;
    gtx_clk90_out : out STD_LOGIC;
    glbl_rstn : in STD_LOGIC;
    rx_axi_rstn : in STD_LOGIC;
    tx_axi_rstn : in STD_LOGIC;
    rx_statistics_vector : out STD_LOGIC_VECTOR ( 27 downto 0 );
    rx_statistics_valid : out STD_LOGIC;
    rx_mac_aclk : out STD_LOGIC;
    rx_reset : out STD_LOGIC;
    rx_enable : out STD_LOGIC;
    rx_axis_filter_tuser : out STD_LOGIC_VECTOR ( 4 downto 0 );
    rx_axis_mac_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rx_axis_mac_tvalid : out STD_LOGIC;
    rx_axis_mac_tlast : out STD_LOGIC;
    rx_axis_mac_tuser : out STD_LOGIC;
    tx_ifg_delay : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_statistics_vector : out STD_LOGIC_VECTOR ( 31 downto 0 );
    tx_statistics_valid : out STD_LOGIC;
    tx_mac_aclk : out STD_LOGIC;
    tx_reset : out STD_LOGIC;
    tx_enable : out STD_LOGIC;
    tx_axis_mac_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    tx_axis_mac_tvalid : in STD_LOGIC;
    tx_axis_mac_tlast : in STD_LOGIC;
    tx_axis_mac_tuser : in STD_LOGIC_VECTOR ( 0 to 0 );
    tx_axis_mac_tready : out STD_LOGIC;
    pause_req : in STD_LOGIC;
    pause_val : in STD_LOGIC_VECTOR ( 15 downto 0 );
    refclk : in STD_LOGIC;
    speedis100 : out STD_LOGIC;
    speedis10100 : out STD_LOGIC;
    rgmii_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_tx_ctl : out STD_LOGIC;
    rgmii_txc : out STD_LOGIC;
    rgmii_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_rx_ctl : in STD_LOGIC;
    rgmii_rxc : in STD_LOGIC;
    inband_link_status : out STD_LOGIC;
    inband_clock_speed : out STD_LOGIC_VECTOR ( 1 downto 0 );
    inband_duplex_status : out STD_LOGIC;
    mdio_i : in STD_LOGIC;
    mdio_t : out STD_LOGIC;
    mdio_o : out STD_LOGIC;
    mdc : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    mac_irq : out STD_LOGIC
  );
  end component bd_4bad_mac_0;
  component bd_4bad_c_shift_ram_0_0 is
  port (
    D : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component bd_4bad_c_shift_ram_0_0;
  component bd_4bad_c_counter_binary_0_0 is
  port (
    CLK : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    THRESH0 : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 23 downto 0 )
  );
  end component bd_4bad_c_counter_binary_0_0;
  component bd_4bad_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component bd_4bad_xlconstant_0_0;
  component bd_4bad_util_vector_logic_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component bd_4bad_util_vector_logic_0_0;
  signal axi_rxd_arstn_1 : STD_LOGIC;
  signal axi_rxs_arstn_1 : STD_LOGIC;
  signal axi_txc_arstn_1 : STD_LOGIC;
  signal axi_txd_arstn_1 : STD_LOGIC;
  signal axis_clk_1 : STD_LOGIC;
  signal c_counter_binary_0_THRESH0 : STD_LOGIC;
  signal c_shift_ram_0_Q : STD_LOGIC_VECTOR ( 0 to 0 );
  signal eth_buf_AXI_STR_RXD_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal eth_buf_AXI_STR_RXD_TKEEP : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal eth_buf_AXI_STR_RXD_TLAST : STD_LOGIC;
  signal eth_buf_AXI_STR_RXD_TREADY : STD_LOGIC;
  signal eth_buf_AXI_STR_RXD_TVALID : STD_LOGIC;
  signal eth_buf_AXI_STR_RXS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal eth_buf_AXI_STR_RXS_TKEEP : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal eth_buf_AXI_STR_RXS_TLAST : STD_LOGIC;
  signal eth_buf_AXI_STR_RXS_TREADY : STD_LOGIC;
  signal eth_buf_AXI_STR_RXS_TVALID : STD_LOGIC;
  signal eth_buf_INTERRUPT : STD_LOGIC;
  signal eth_buf_RESET2TEMACn : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_ARADDR : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_ARREADY : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_ARVALID : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_AWADDR : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_AWREADY : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_AWVALID : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_BREADY : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_BVALID : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_RREADY : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_RVALID : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal eth_buf_S_AXI_2TEMAC_WREADY : STD_LOGIC;
  signal eth_buf_S_AXI_2TEMAC_WVALID : STD_LOGIC;
  signal eth_buf_TX_AXIS_MAC_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal eth_buf_TX_AXIS_MAC_TLAST : STD_LOGIC;
  signal eth_buf_TX_AXIS_MAC_TREADY : STD_LOGIC;
  signal eth_buf_TX_AXIS_MAC_TUSER : STD_LOGIC_VECTOR ( 0 to 0 );
  signal eth_buf_TX_AXIS_MAC_TVALID : STD_LOGIC;
  signal eth_buf_pause_req : STD_LOGIC;
  signal eth_buf_pause_val : STD_LOGIC_VECTOR ( 16 to 31 );
  signal eth_buf_tx_ifg_delay : STD_LOGIC_VECTOR ( 24 to 31 );
  signal gtx_clk_1 : STD_LOGIC;
  signal mac_gtx_clk90_out : STD_LOGIC;
  signal mac_gtx_clk_out : STD_LOGIC;
  signal mac_m_axis_rx_TDATA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal mac_m_axis_rx_TLAST : STD_LOGIC;
  signal mac_m_axis_rx_TUSER : STD_LOGIC;
  signal mac_m_axis_rx_TVALID : STD_LOGIC;
  signal mac_mac_irq : STD_LOGIC;
  signal mac_mdio_internal_MDC : STD_LOGIC;
  signal mac_mdio_internal_MDIO_I : STD_LOGIC;
  signal mac_mdio_internal_MDIO_O : STD_LOGIC;
  signal mac_mdio_internal_MDIO_T : STD_LOGIC;
  signal mac_rgmii_RD : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mac_rgmii_RXC : STD_LOGIC;
  signal mac_rgmii_RX_CTL : STD_LOGIC;
  signal mac_rgmii_TD : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mac_rgmii_TXC : STD_LOGIC;
  signal mac_rgmii_TX_CTL : STD_LOGIC;
  signal mac_rx_enable : STD_LOGIC;
  signal mac_rx_mac_aclk : STD_LOGIC;
  signal mac_rx_reset : STD_LOGIC;
  signal mac_rx_statistics_valid : STD_LOGIC;
  signal mac_rx_statistics_vector : STD_LOGIC_VECTOR ( 27 downto 0 );
  signal mac_speedis10100 : STD_LOGIC;
  signal mac_tx_mac_aclk : STD_LOGIC;
  signal mac_tx_reset : STD_LOGIC;
  signal ref_clk_1 : STD_LOGIC;
  signal s_axi_1_ARADDR : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal s_axi_1_ARREADY : STD_LOGIC;
  signal s_axi_1_ARVALID : STD_LOGIC;
  signal s_axi_1_AWADDR : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal s_axi_1_AWREADY : STD_LOGIC;
  signal s_axi_1_AWVALID : STD_LOGIC;
  signal s_axi_1_BREADY : STD_LOGIC;
  signal s_axi_1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s_axi_1_BVALID : STD_LOGIC;
  signal s_axi_1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axi_1_RREADY : STD_LOGIC;
  signal s_axi_1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s_axi_1_RVALID : STD_LOGIC;
  signal s_axi_1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axi_1_WREADY : STD_LOGIC;
  signal s_axi_1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s_axi_1_WVALID : STD_LOGIC;
  signal s_axi_lite_clk_1 : STD_LOGIC;
  signal s_axi_lite_resetn_1 : STD_LOGIC;
  signal s_axis_txc_1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_txc_1_TKEEP : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s_axis_txc_1_TLAST : STD_LOGIC;
  signal s_axis_txc_1_TREADY : STD_LOGIC;
  signal s_axis_txc_1_TVALID : STD_LOGIC;
  signal s_axis_txd_1_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s_axis_txd_1_TKEEP : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s_axis_txd_1_TLAST : STD_LOGIC;
  signal s_axis_txd_1_TREADY : STD_LOGIC;
  signal s_axis_txd_1_TVALID : STD_LOGIC;
  signal util_vector_logic_0_Res : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xlconstant_0_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_c_counter_binary_0_Q_UNCONNECTED : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal NLW_eth_buf_PHY_RST_N_UNCONNECTED : STD_LOGIC;
  signal NLW_eth_buf_RESET2PCSPMA_UNCONNECTED : STD_LOGIC;
  signal NLW_eth_buf_mdc_top_UNCONNECTED : STD_LOGIC;
  signal NLW_eth_buf_mdio_i_temac_UNCONNECTED : STD_LOGIC;
  signal NLW_eth_buf_mdio_o_top_UNCONNECTED : STD_LOGIC;
  signal NLW_eth_buf_mdio_t_top_UNCONNECTED : STD_LOGIC;
  signal NLW_mac_inband_duplex_status_UNCONNECTED : STD_LOGIC;
  signal NLW_mac_inband_link_status_UNCONNECTED : STD_LOGIC;
  signal NLW_mac_speedis100_UNCONNECTED : STD_LOGIC;
  signal NLW_mac_tx_enable_UNCONNECTED : STD_LOGIC;
  signal NLW_mac_tx_statistics_valid_UNCONNECTED : STD_LOGIC;
  signal NLW_mac_inband_clock_speed_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_mac_rx_axis_filter_tuser_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_mac_tx_statistics_vector_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of axi_rxd_arstn : signal is "xilinx.com:signal:reset:1.0 RST.AXI_RXD_ARSTN RST";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of axi_rxd_arstn : signal is "XIL_INTERFACENAME RST.AXI_RXD_ARSTN, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of axi_rxs_arstn : signal is "xilinx.com:signal:reset:1.0 RST.AXI_RXS_ARSTN RST";
  attribute X_INTERFACE_PARAMETER of axi_rxs_arstn : signal is "XIL_INTERFACENAME RST.AXI_RXS_ARSTN, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of axi_txc_arstn : signal is "xilinx.com:signal:reset:1.0 RST.AXI_TXC_ARSTN RST";
  attribute X_INTERFACE_PARAMETER of axi_txc_arstn : signal is "XIL_INTERFACENAME RST.AXI_TXC_ARSTN, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of axi_txd_arstn : signal is "xilinx.com:signal:reset:1.0 RST.AXI_TXD_ARSTN RST";
  attribute X_INTERFACE_PARAMETER of axi_txd_arstn : signal is "XIL_INTERFACENAME RST.AXI_TXD_ARSTN, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of axis_clk : signal is "xilinx.com:signal:clock:1.0 CLK.AXIS_CLK CLK";
  attribute X_INTERFACE_PARAMETER of axis_clk : signal is "XIL_INTERFACENAME CLK.AXIS_CLK, ASSOCIATED_BUSIF m_axis_rxd:m_axis_rxs:s_axis_txc:s_axis_txd, ASSOCIATED_RESET axi_rxd_arstn:axi_rxs_arstn:axi_txc_arstn:axi_txd_arstn, CLK_DOMAIN system_mig_7series_0_0_ui_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0";
  attribute X_INTERFACE_INFO of gtx_clk : signal is "xilinx.com:signal:clock:1.0 CLK.GTX_CLK CLK";
  attribute X_INTERFACE_PARAMETER of gtx_clk : signal is "XIL_INTERFACENAME CLK.GTX_CLK, CLK_DOMAIN system_mig_7series_0_0_ui_clk, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0";
  attribute X_INTERFACE_INFO of gtx_clk90_out : signal is "xilinx.com:signal:clock:1.0 CLK.GTX_CLK90_OUT CLK";
  attribute X_INTERFACE_PARAMETER of gtx_clk90_out : signal is "XIL_INTERFACENAME CLK.GTX_CLK90_OUT, CLK_DOMAIN bd_4bad_mac_0_gtx_clk90_out, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 90";
  attribute X_INTERFACE_INFO of gtx_clk_out : signal is "xilinx.com:signal:clock:1.0 CLK.GTX_CLK_OUT CLK";
  attribute X_INTERFACE_PARAMETER of gtx_clk_out : signal is "XIL_INTERFACENAME CLK.GTX_CLK_OUT, CLK_DOMAIN bd_4bad_mac_0_gtx_clk_out, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0";
  attribute X_INTERFACE_INFO of interrupt : signal is "xilinx.com:signal:interrupt:1.0 INTR.INTERRUPT INTERRUPT";
  attribute X_INTERFACE_PARAMETER of interrupt : signal is "XIL_INTERFACENAME INTR.INTERRUPT, PortWidth 1, SENSITIVITY LEVEL_HIGH";
  attribute X_INTERFACE_INFO of m_axis_rxd_tlast : signal is "xilinx.com:interface:axis:1.0 m_axis_rxd TLAST";
  attribute X_INTERFACE_INFO of m_axis_rxd_tready : signal is "xilinx.com:interface:axis:1.0 m_axis_rxd TREADY";
  attribute X_INTERFACE_INFO of m_axis_rxd_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis_rxd TVALID";
  attribute X_INTERFACE_INFO of m_axis_rxs_tlast : signal is "xilinx.com:interface:axis:1.0 m_axis_rxs TLAST";
  attribute X_INTERFACE_INFO of m_axis_rxs_tready : signal is "xilinx.com:interface:axis:1.0 m_axis_rxs TREADY";
  attribute X_INTERFACE_INFO of m_axis_rxs_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis_rxs TVALID";
  attribute X_INTERFACE_INFO of mac_irq : signal is "xilinx.com:signal:interrupt:1.0 INTR.MAC_IRQ INTERRUPT";
  attribute X_INTERFACE_PARAMETER of mac_irq : signal is "XIL_INTERFACENAME INTR.MAC_IRQ, PortWidth 1, SENSITIVITY EDGE_RISING";
  attribute X_INTERFACE_INFO of mdio_mdc : signal is "xilinx.com:interface:mdio:1.0 mdio MDC";
  attribute X_INTERFACE_PARAMETER of mdio_mdc : signal is "XIL_INTERFACENAME mdio, CAN_DEBUG false";
  attribute X_INTERFACE_INFO of mdio_mdio_i : signal is "xilinx.com:interface:mdio:1.0 mdio MDIO_I";
  attribute X_INTERFACE_INFO of mdio_mdio_o : signal is "xilinx.com:interface:mdio:1.0 mdio MDIO_O";
  attribute X_INTERFACE_INFO of mdio_mdio_t : signal is "xilinx.com:interface:mdio:1.0 mdio MDIO_T";
  attribute X_INTERFACE_INFO of ref_clk : signal is "xilinx.com:signal:clock:1.0 CLK.REF_CLK CLK";
  attribute X_INTERFACE_PARAMETER of ref_clk : signal is "XIL_INTERFACENAME CLK.REF_CLK, CLK_DOMAIN system_mig_7series_0_0_ui_clk, FREQ_HZ 200000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0";
  attribute X_INTERFACE_INFO of rgmii_rx_ctl : signal is "xilinx.com:interface:rgmii:1.0 rgmii RX_CTL";
  attribute X_INTERFACE_INFO of rgmii_rxc : signal is "xilinx.com:interface:rgmii:1.0 rgmii RXC";
  attribute X_INTERFACE_INFO of rgmii_tx_ctl : signal is "xilinx.com:interface:rgmii:1.0 rgmii TX_CTL";
  attribute X_INTERFACE_INFO of rgmii_txc : signal is "xilinx.com:interface:rgmii:1.0 rgmii TXC";
  attribute X_INTERFACE_INFO of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute X_INTERFACE_INFO of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARVALID";
  attribute X_INTERFACE_INFO of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute X_INTERFACE_INFO of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWVALID";
  attribute X_INTERFACE_INFO of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 s_axi BREADY";
  attribute X_INTERFACE_INFO of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute X_INTERFACE_INFO of s_axi_lite_clk : signal is "xilinx.com:signal:clock:1.0 CLK.S_AXI_LITE_CLK CLK";
  attribute X_INTERFACE_PARAMETER of s_axi_lite_clk : signal is "XIL_INTERFACENAME CLK.S_AXI_LITE_CLK, ASSOCIATED_BUSIF s_axi, ASSOCIATED_CLKEN CE, ASSOCIATED_RESET s_axi_lite_resetn, CLK_DOMAIN system_mig_7series_0_0_ui_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0";
  attribute X_INTERFACE_INFO of s_axi_lite_resetn : signal is "xilinx.com:signal:reset:1.0 RST.S_AXI_LITE_RESETN RST";
  attribute X_INTERFACE_PARAMETER of s_axi_lite_resetn : signal is "XIL_INTERFACENAME RST.S_AXI_LITE_RESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 s_axi RREADY";
  attribute X_INTERFACE_INFO of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute X_INTERFACE_INFO of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute X_INTERFACE_INFO of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi WVALID";
  attribute X_INTERFACE_INFO of s_axis_txc_tlast : signal is "xilinx.com:interface:axis:1.0 s_axis_txc TLAST";
  attribute X_INTERFACE_INFO of s_axis_txc_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_txc TREADY";
  attribute X_INTERFACE_INFO of s_axis_txc_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_txc TVALID";
  attribute X_INTERFACE_INFO of s_axis_txd_tlast : signal is "xilinx.com:interface:axis:1.0 s_axis_txd TLAST";
  attribute X_INTERFACE_INFO of s_axis_txd_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_txd TREADY";
  attribute X_INTERFACE_INFO of s_axis_txd_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_txd TVALID";
  attribute X_INTERFACE_INFO of m_axis_rxd_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis_rxd TDATA";
  attribute X_INTERFACE_PARAMETER of m_axis_rxd_tdata : signal is "XIL_INTERFACENAME m_axis_rxd, CLK_DOMAIN system_mig_7series_0_0_ui_clk, FREQ_HZ 100000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of m_axis_rxd_tkeep : signal is "xilinx.com:interface:axis:1.0 m_axis_rxd TKEEP";
  attribute X_INTERFACE_INFO of m_axis_rxs_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis_rxs TDATA";
  attribute X_INTERFACE_PARAMETER of m_axis_rxs_tdata : signal is "XIL_INTERFACENAME m_axis_rxs, CLK_DOMAIN system_mig_7series_0_0_ui_clk, FREQ_HZ 100000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of m_axis_rxs_tkeep : signal is "xilinx.com:interface:axis:1.0 m_axis_rxs TKEEP";
  attribute X_INTERFACE_INFO of phy_rst_n : signal is "xilinx.com:signal:reset:1.0 RST.PHY_RST_N RST";
  attribute X_INTERFACE_PARAMETER of phy_rst_n : signal is "XIL_INTERFACENAME RST.PHY_RST_N, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of rgmii_rd : signal is "xilinx.com:interface:rgmii:1.0 rgmii RD";
  attribute X_INTERFACE_INFO of rgmii_td : signal is "xilinx.com:interface:rgmii:1.0 rgmii TD";
  attribute X_INTERFACE_INFO of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 s_axi ARADDR";
  attribute X_INTERFACE_PARAMETER of s_axi_araddr : signal is "XIL_INTERFACENAME s_axi, ADDR_WIDTH 18, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN system_mig_7series_0_0_ui_clk, DATA_WIDTH 32, FREQ_HZ 100000000, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 0, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 2, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 2, NUM_WRITE_THREADS 1, PHASE 0, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 s_axi AWADDR";
  attribute X_INTERFACE_INFO of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 s_axi BRESP";
  attribute X_INTERFACE_INFO of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 s_axi RRESP";
  attribute X_INTERFACE_INFO of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 s_axi WDATA";
  attribute X_INTERFACE_INFO of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 s_axi WSTRB";
  attribute X_INTERFACE_INFO of s_axis_txc_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_txc TDATA";
  attribute X_INTERFACE_PARAMETER of s_axis_txc_tdata : signal is "XIL_INTERFACENAME s_axis_txc, CLK_DOMAIN system_mig_7series_0_0_ui_clk, FREQ_HZ 100000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of s_axis_txc_tkeep : signal is "xilinx.com:interface:axis:1.0 s_axis_txc TKEEP";
  attribute X_INTERFACE_INFO of s_axis_txd_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_txd TDATA";
  attribute X_INTERFACE_PARAMETER of s_axis_txd_tdata : signal is "XIL_INTERFACENAME s_axis_txd, CLK_DOMAIN system_mig_7series_0_0_ui_clk, FREQ_HZ 100000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of s_axis_txd_tkeep : signal is "xilinx.com:interface:axis:1.0 s_axis_txd TKEEP";
begin
  axi_rxd_arstn_1 <= axi_rxd_arstn;
  axi_rxs_arstn_1 <= axi_rxs_arstn;
  axi_txc_arstn_1 <= axi_txc_arstn;
  axi_txd_arstn_1 <= axi_txd_arstn;
  axis_clk_1 <= axis_clk;
  eth_buf_AXI_STR_RXD_TREADY <= m_axis_rxd_tready;
  eth_buf_AXI_STR_RXS_TREADY <= m_axis_rxs_tready;
  gtx_clk90_out <= mac_gtx_clk90_out;
  gtx_clk_1 <= gtx_clk;
  gtx_clk_out <= mac_gtx_clk_out;
  interrupt <= eth_buf_INTERRUPT;
  m_axis_rxd_tdata(31 downto 0) <= eth_buf_AXI_STR_RXD_TDATA(31 downto 0);
  m_axis_rxd_tkeep(3 downto 0) <= eth_buf_AXI_STR_RXD_TKEEP(3 downto 0);
  m_axis_rxd_tlast <= eth_buf_AXI_STR_RXD_TLAST;
  m_axis_rxd_tvalid <= eth_buf_AXI_STR_RXD_TVALID;
  m_axis_rxs_tdata(31 downto 0) <= eth_buf_AXI_STR_RXS_TDATA(31 downto 0);
  m_axis_rxs_tkeep(3 downto 0) <= eth_buf_AXI_STR_RXS_TKEEP(3 downto 0);
  m_axis_rxs_tlast <= eth_buf_AXI_STR_RXS_TLAST;
  m_axis_rxs_tvalid <= eth_buf_AXI_STR_RXS_TVALID;
  mac_irq <= mac_mac_irq;
  mac_mdio_internal_MDIO_I <= mdio_mdio_i;
  mac_rgmii_RD(3 downto 0) <= rgmii_rd(3 downto 0);
  mac_rgmii_RXC <= rgmii_rxc;
  mac_rgmii_RX_CTL <= rgmii_rx_ctl;
  mdio_mdc <= mac_mdio_internal_MDC;
  mdio_mdio_o <= mac_mdio_internal_MDIO_O;
  mdio_mdio_t <= mac_mdio_internal_MDIO_T;
  phy_rst_n(0) <= c_shift_ram_0_Q(0);
  ref_clk_1 <= ref_clk;
  rgmii_td(3 downto 0) <= mac_rgmii_TD(3 downto 0);
  rgmii_tx_ctl <= mac_rgmii_TX_CTL;
  rgmii_txc <= mac_rgmii_TXC;
  s_axi_1_ARADDR(17 downto 0) <= s_axi_araddr(17 downto 0);
  s_axi_1_ARVALID <= s_axi_arvalid;
  s_axi_1_AWADDR(17 downto 0) <= s_axi_awaddr(17 downto 0);
  s_axi_1_AWVALID <= s_axi_awvalid;
  s_axi_1_BREADY <= s_axi_bready;
  s_axi_1_RREADY <= s_axi_rready;
  s_axi_1_WDATA(31 downto 0) <= s_axi_wdata(31 downto 0);
  s_axi_1_WSTRB(3 downto 0) <= s_axi_wstrb(3 downto 0);
  s_axi_1_WVALID <= s_axi_wvalid;
  s_axi_arready <= s_axi_1_ARREADY;
  s_axi_awready <= s_axi_1_AWREADY;
  s_axi_bresp(1 downto 0) <= s_axi_1_BRESP(1 downto 0);
  s_axi_bvalid <= s_axi_1_BVALID;
  s_axi_lite_clk_1 <= s_axi_lite_clk;
  s_axi_lite_resetn_1 <= s_axi_lite_resetn;
  s_axi_rdata(31 downto 0) <= s_axi_1_RDATA(31 downto 0);
  s_axi_rresp(1 downto 0) <= s_axi_1_RRESP(1 downto 0);
  s_axi_rvalid <= s_axi_1_RVALID;
  s_axi_wready <= s_axi_1_WREADY;
  s_axis_txc_1_TDATA(31 downto 0) <= s_axis_txc_tdata(31 downto 0);
  s_axis_txc_1_TKEEP(3 downto 0) <= s_axis_txc_tkeep(3 downto 0);
  s_axis_txc_1_TLAST <= s_axis_txc_tlast;
  s_axis_txc_1_TVALID <= s_axis_txc_tvalid;
  s_axis_txc_tready <= s_axis_txc_1_TREADY;
  s_axis_txd_1_TDATA(31 downto 0) <= s_axis_txd_tdata(31 downto 0);
  s_axis_txd_1_TKEEP(3 downto 0) <= s_axis_txd_tkeep(3 downto 0);
  s_axis_txd_1_TLAST <= s_axis_txd_tlast;
  s_axis_txd_1_TVALID <= s_axis_txd_tvalid;
  s_axis_txd_tready <= s_axis_txd_1_TREADY;
c_counter_binary_0: component bd_4bad_c_counter_binary_0_0
     port map (
      CLK => s_axi_lite_clk_1,
      Q(23 downto 0) => NLW_c_counter_binary_0_Q_UNCONNECTED(23 downto 0),
      SCLR => util_vector_logic_0_Res(0),
      THRESH0 => c_counter_binary_0_THRESH0
    );
c_shift_ram_0: component bd_4bad_c_shift_ram_0_0
     port map (
      CE => c_counter_binary_0_THRESH0,
      CLK => s_axi_lite_clk_1,
      D(0) => xlconstant_0_dout(0),
      Q(0) => c_shift_ram_0_Q(0),
      SCLR => util_vector_logic_0_Res(0)
    );
eth_buf: component bd_4bad_eth_buf_0
     port map (
      AXI_STR_RXD_ACLK => axis_clk_1,
      AXI_STR_RXD_ARESETN => axi_rxd_arstn_1,
      AXI_STR_RXD_DATA(31 downto 0) => eth_buf_AXI_STR_RXD_TDATA(31 downto 0),
      AXI_STR_RXD_KEEP(3 downto 0) => eth_buf_AXI_STR_RXD_TKEEP(3 downto 0),
      AXI_STR_RXD_LAST => eth_buf_AXI_STR_RXD_TLAST,
      AXI_STR_RXD_READY => eth_buf_AXI_STR_RXD_TREADY,
      AXI_STR_RXD_VALID => eth_buf_AXI_STR_RXD_TVALID,
      AXI_STR_RXS_ACLK => axis_clk_1,
      AXI_STR_RXS_ARESETN => axi_rxs_arstn_1,
      AXI_STR_RXS_DATA(31 downto 0) => eth_buf_AXI_STR_RXS_TDATA(31 downto 0),
      AXI_STR_RXS_KEEP(3 downto 0) => eth_buf_AXI_STR_RXS_TKEEP(3 downto 0),
      AXI_STR_RXS_LAST => eth_buf_AXI_STR_RXS_TLAST,
      AXI_STR_RXS_READY => eth_buf_AXI_STR_RXS_TREADY,
      AXI_STR_RXS_VALID => eth_buf_AXI_STR_RXS_TVALID,
      AXI_STR_TXC_ACLK => axis_clk_1,
      AXI_STR_TXC_ARESETN => axi_txc_arstn_1,
      AXI_STR_TXC_TDATA(31 downto 0) => s_axis_txc_1_TDATA(31 downto 0),
      AXI_STR_TXC_TKEEP(3 downto 0) => s_axis_txc_1_TKEEP(3 downto 0),
      AXI_STR_TXC_TLAST => s_axis_txc_1_TLAST,
      AXI_STR_TXC_TREADY => s_axis_txc_1_TREADY,
      AXI_STR_TXC_TVALID => s_axis_txc_1_TVALID,
      AXI_STR_TXD_ACLK => axis_clk_1,
      AXI_STR_TXD_ARESETN => axi_txd_arstn_1,
      AXI_STR_TXD_TDATA(31 downto 0) => s_axis_txd_1_TDATA(31 downto 0),
      AXI_STR_TXD_TKEEP(3 downto 0) => s_axis_txd_1_TKEEP(3 downto 0),
      AXI_STR_TXD_TLAST => s_axis_txd_1_TLAST,
      AXI_STR_TXD_TREADY => s_axis_txd_1_TREADY,
      AXI_STR_TXD_TVALID => s_axis_txd_1_TVALID,
      EMAC_CLIENT_AUTONEG_INT => '0',
      EMAC_RESET_DONE_INT => '1',
      EMAC_RX_DCM_LOCKED_INT => '1',
      GTX_CLK => gtx_clk_1,
      INTERRUPT => eth_buf_INTERRUPT,
      PCSPMA_STATUS_VECTOR(15 downto 0) => B"0000000000000000",
      PHY_RST_N => NLW_eth_buf_PHY_RST_N_UNCONNECTED,
      RESET2PCSPMA => NLW_eth_buf_RESET2PCSPMA_UNCONNECTED,
      RESET2TEMACn => eth_buf_RESET2TEMACn,
      RX_CLK_ENABLE_IN => mac_rx_enable,
      S_AXI_2TEMAC_ARADDR(11 downto 0) => eth_buf_S_AXI_2TEMAC_ARADDR(11 downto 0),
      S_AXI_2TEMAC_ARREADY => eth_buf_S_AXI_2TEMAC_ARREADY,
      S_AXI_2TEMAC_ARVALID => eth_buf_S_AXI_2TEMAC_ARVALID,
      S_AXI_2TEMAC_AWADDR(11 downto 0) => eth_buf_S_AXI_2TEMAC_AWADDR(11 downto 0),
      S_AXI_2TEMAC_AWREADY => eth_buf_S_AXI_2TEMAC_AWREADY,
      S_AXI_2TEMAC_AWVALID => eth_buf_S_AXI_2TEMAC_AWVALID,
      S_AXI_2TEMAC_BREADY => eth_buf_S_AXI_2TEMAC_BREADY,
      S_AXI_2TEMAC_BRESP(1 downto 0) => eth_buf_S_AXI_2TEMAC_BRESP(1 downto 0),
      S_AXI_2TEMAC_BVALID => eth_buf_S_AXI_2TEMAC_BVALID,
      S_AXI_2TEMAC_RDATA(31 downto 0) => eth_buf_S_AXI_2TEMAC_RDATA(31 downto 0),
      S_AXI_2TEMAC_RREADY => eth_buf_S_AXI_2TEMAC_RREADY,
      S_AXI_2TEMAC_RRESP(1 downto 0) => eth_buf_S_AXI_2TEMAC_RRESP(1 downto 0),
      S_AXI_2TEMAC_RVALID => eth_buf_S_AXI_2TEMAC_RVALID,
      S_AXI_2TEMAC_WDATA(31 downto 0) => eth_buf_S_AXI_2TEMAC_WDATA(31 downto 0),
      S_AXI_2TEMAC_WREADY => eth_buf_S_AXI_2TEMAC_WREADY,
      S_AXI_2TEMAC_WVALID => eth_buf_S_AXI_2TEMAC_WVALID,
      S_AXI_ACLK => s_axi_lite_clk_1,
      S_AXI_ARADDR(17 downto 0) => s_axi_1_ARADDR(17 downto 0),
      S_AXI_ARESETN => s_axi_lite_resetn_1,
      S_AXI_ARREADY => s_axi_1_ARREADY,
      S_AXI_ARVALID => s_axi_1_ARVALID,
      S_AXI_AWADDR(17 downto 0) => s_axi_1_AWADDR(17 downto 0),
      S_AXI_AWREADY => s_axi_1_AWREADY,
      S_AXI_AWVALID => s_axi_1_AWVALID,
      S_AXI_BREADY => s_axi_1_BREADY,
      S_AXI_BRESP(1 downto 0) => s_axi_1_BRESP(1 downto 0),
      S_AXI_BVALID => s_axi_1_BVALID,
      S_AXI_RDATA(31 downto 0) => s_axi_1_RDATA(31 downto 0),
      S_AXI_RREADY => s_axi_1_RREADY,
      S_AXI_RRESP(1 downto 0) => s_axi_1_RRESP(1 downto 0),
      S_AXI_RVALID => s_axi_1_RVALID,
      S_AXI_WDATA(31 downto 0) => s_axi_1_WDATA(31 downto 0),
      S_AXI_WREADY => s_axi_1_WREADY,
      S_AXI_WSTRB(3 downto 0) => s_axi_1_WSTRB(3 downto 0),
      S_AXI_WVALID => s_axi_1_WVALID,
      mdc_temac => '1',
      mdc_top => NLW_eth_buf_mdc_top_UNCONNECTED,
      mdio_i_temac => NLW_eth_buf_mdio_i_temac_UNCONNECTED,
      mdio_i_top => '1',
      mdio_o_pcspma => '0',
      mdio_o_temac => '1',
      mdio_o_top => NLW_eth_buf_mdio_o_top_UNCONNECTED,
      mdio_t_pcspma => '0',
      mdio_t_temac => '1',
      mdio_t_top => NLW_eth_buf_mdio_t_top_UNCONNECTED,
      pause_req => eth_buf_pause_req,
      pause_val(16 to 31) => eth_buf_pause_val(16 to 31),
      rx_axis_mac_tdata(7 downto 0) => mac_m_axis_rx_TDATA(7 downto 0),
      rx_axis_mac_tlast => mac_m_axis_rx_TLAST,
      rx_axis_mac_tuser => mac_m_axis_rx_TUSER,
      rx_axis_mac_tvalid => mac_m_axis_rx_TVALID,
      rx_mac_aclk => mac_rx_mac_aclk,
      rx_reset => mac_rx_reset,
      rx_statistics_valid => mac_rx_statistics_valid,
      rx_statistics_vector(27 downto 0) => mac_rx_statistics_vector(27 downto 0),
      speed_is_10_100 => mac_speedis10100,
      tx_axis_mac_tdata(7 downto 0) => eth_buf_TX_AXIS_MAC_TDATA(7 downto 0),
      tx_axis_mac_tlast => eth_buf_TX_AXIS_MAC_TLAST,
      tx_axis_mac_tready => eth_buf_TX_AXIS_MAC_TREADY,
      tx_axis_mac_tuser(0) => eth_buf_TX_AXIS_MAC_TUSER(0),
      tx_axis_mac_tvalid => eth_buf_TX_AXIS_MAC_TVALID,
      tx_ifg_delay(24 to 31) => eth_buf_tx_ifg_delay(24 to 31),
      tx_mac_aclk => mac_tx_mac_aclk,
      tx_reset => mac_tx_reset
    );
mac: component bd_4bad_mac_0
     port map (
      glbl_rstn => eth_buf_RESET2TEMACn,
      gtx_clk => gtx_clk_1,
      gtx_clk90_out => mac_gtx_clk90_out,
      gtx_clk_out => mac_gtx_clk_out,
      inband_clock_speed(1 downto 0) => NLW_mac_inband_clock_speed_UNCONNECTED(1 downto 0),
      inband_duplex_status => NLW_mac_inband_duplex_status_UNCONNECTED,
      inband_link_status => NLW_mac_inband_link_status_UNCONNECTED,
      mac_irq => mac_mac_irq,
      mdc => mac_mdio_internal_MDC,
      mdio_i => mac_mdio_internal_MDIO_I,
      mdio_o => mac_mdio_internal_MDIO_O,
      mdio_t => mac_mdio_internal_MDIO_T,
      pause_req => eth_buf_pause_req,
      pause_val(15) => eth_buf_pause_val(16),
      pause_val(14) => eth_buf_pause_val(17),
      pause_val(13) => eth_buf_pause_val(18),
      pause_val(12) => eth_buf_pause_val(19),
      pause_val(11) => eth_buf_pause_val(20),
      pause_val(10) => eth_buf_pause_val(21),
      pause_val(9) => eth_buf_pause_val(22),
      pause_val(8) => eth_buf_pause_val(23),
      pause_val(7) => eth_buf_pause_val(24),
      pause_val(6) => eth_buf_pause_val(25),
      pause_val(5) => eth_buf_pause_val(26),
      pause_val(4) => eth_buf_pause_val(27),
      pause_val(3) => eth_buf_pause_val(28),
      pause_val(2) => eth_buf_pause_val(29),
      pause_val(1) => eth_buf_pause_val(30),
      pause_val(0) => eth_buf_pause_val(31),
      refclk => ref_clk_1,
      rgmii_rx_ctl => mac_rgmii_RX_CTL,
      rgmii_rxc => mac_rgmii_RXC,
      rgmii_rxd(3 downto 0) => mac_rgmii_RD(3 downto 0),
      rgmii_tx_ctl => mac_rgmii_TX_CTL,
      rgmii_txc => mac_rgmii_TXC,
      rgmii_txd(3 downto 0) => mac_rgmii_TD(3 downto 0),
      rx_axi_rstn => eth_buf_RESET2TEMACn,
      rx_axis_filter_tuser(4 downto 0) => NLW_mac_rx_axis_filter_tuser_UNCONNECTED(4 downto 0),
      rx_axis_mac_tdata(7 downto 0) => mac_m_axis_rx_TDATA(7 downto 0),
      rx_axis_mac_tlast => mac_m_axis_rx_TLAST,
      rx_axis_mac_tuser => mac_m_axis_rx_TUSER,
      rx_axis_mac_tvalid => mac_m_axis_rx_TVALID,
      rx_enable => mac_rx_enable,
      rx_mac_aclk => mac_rx_mac_aclk,
      rx_reset => mac_rx_reset,
      rx_statistics_valid => mac_rx_statistics_valid,
      rx_statistics_vector(27 downto 0) => mac_rx_statistics_vector(27 downto 0),
      s_axi_aclk => s_axi_lite_clk_1,
      s_axi_araddr(11 downto 0) => eth_buf_S_AXI_2TEMAC_ARADDR(11 downto 0),
      s_axi_arready => eth_buf_S_AXI_2TEMAC_ARREADY,
      s_axi_arvalid => eth_buf_S_AXI_2TEMAC_ARVALID,
      s_axi_awaddr(11 downto 0) => eth_buf_S_AXI_2TEMAC_AWADDR(11 downto 0),
      s_axi_awready => eth_buf_S_AXI_2TEMAC_AWREADY,
      s_axi_awvalid => eth_buf_S_AXI_2TEMAC_AWVALID,
      s_axi_bready => eth_buf_S_AXI_2TEMAC_BREADY,
      s_axi_bresp(1 downto 0) => eth_buf_S_AXI_2TEMAC_BRESP(1 downto 0),
      s_axi_bvalid => eth_buf_S_AXI_2TEMAC_BVALID,
      s_axi_rdata(31 downto 0) => eth_buf_S_AXI_2TEMAC_RDATA(31 downto 0),
      s_axi_resetn => s_axi_lite_resetn_1,
      s_axi_rready => eth_buf_S_AXI_2TEMAC_RREADY,
      s_axi_rresp(1 downto 0) => eth_buf_S_AXI_2TEMAC_RRESP(1 downto 0),
      s_axi_rvalid => eth_buf_S_AXI_2TEMAC_RVALID,
      s_axi_wdata(31 downto 0) => eth_buf_S_AXI_2TEMAC_WDATA(31 downto 0),
      s_axi_wready => eth_buf_S_AXI_2TEMAC_WREADY,
      s_axi_wvalid => eth_buf_S_AXI_2TEMAC_WVALID,
      speedis100 => NLW_mac_speedis100_UNCONNECTED,
      speedis10100 => mac_speedis10100,
      tx_axi_rstn => eth_buf_RESET2TEMACn,
      tx_axis_mac_tdata(7 downto 0) => eth_buf_TX_AXIS_MAC_TDATA(7 downto 0),
      tx_axis_mac_tlast => eth_buf_TX_AXIS_MAC_TLAST,
      tx_axis_mac_tready => eth_buf_TX_AXIS_MAC_TREADY,
      tx_axis_mac_tuser(0) => eth_buf_TX_AXIS_MAC_TUSER(0),
      tx_axis_mac_tvalid => eth_buf_TX_AXIS_MAC_TVALID,
      tx_enable => NLW_mac_tx_enable_UNCONNECTED,
      tx_ifg_delay(7) => eth_buf_tx_ifg_delay(24),
      tx_ifg_delay(6) => eth_buf_tx_ifg_delay(25),
      tx_ifg_delay(5) => eth_buf_tx_ifg_delay(26),
      tx_ifg_delay(4) => eth_buf_tx_ifg_delay(27),
      tx_ifg_delay(3) => eth_buf_tx_ifg_delay(28),
      tx_ifg_delay(2) => eth_buf_tx_ifg_delay(29),
      tx_ifg_delay(1) => eth_buf_tx_ifg_delay(30),
      tx_ifg_delay(0) => eth_buf_tx_ifg_delay(31),
      tx_mac_aclk => mac_tx_mac_aclk,
      tx_reset => mac_tx_reset,
      tx_statistics_valid => NLW_mac_tx_statistics_valid_UNCONNECTED,
      tx_statistics_vector(31 downto 0) => NLW_mac_tx_statistics_vector_UNCONNECTED(31 downto 0)
    );
util_vector_logic_0: component bd_4bad_util_vector_logic_0_0
     port map (
      Op1(0) => s_axi_lite_resetn_1,
      Res(0) => util_vector_logic_0_Res(0)
    );
xlconstant_0: component bd_4bad_xlconstant_0_0
     port map (
      dout(0) => xlconstant_0_dout(0)
    );
end STRUCTURE;
