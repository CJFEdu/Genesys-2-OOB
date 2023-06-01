--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
--Date        : Thu Jun  1 00:03:07 2023
--Host        : LAPTOP-TVFDO2QR running 64-bit major release  (build 9200)
--Command     : generate_target system_wrapper.bd
--Design      : system_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_wrapper is
  port (
    AUD_ADC_SDATA : in STD_LOGIC;
    AUD_ADDR_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    AUD_ADDR_1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    AUD_BCLK : out STD_LOGIC;
    AUD_DAC_SDATA : out STD_LOGIC;
    AUD_LRCLK : out STD_LOGIC;
    AUD_MCLK : out STD_LOGIC;
    DDR3_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR3_cas_n : out STD_LOGIC;
    DDR3_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_dm : out STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR3_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR3_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR3_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR3_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_ras_n : out STD_LOGIC;
    DDR3_reset_n : out STD_LOGIC;
    DDR3_we_n : out STD_LOGIC;
    aud_scl_io : inout STD_LOGIC;
    aud_sda_io : inout STD_LOGIC;
    btnc : in STD_LOGIC;
    btnd : in STD_LOGIC;
    btnl : in STD_LOGIC;
    btnr : in STD_LOGIC;
    btnu : in STD_LOGIC;
    cpu_resetn : in STD_LOGIC;
    dp_aux_in_n : in STD_LOGIC;
    dp_aux_in_p : in STD_LOGIC;
    dp_aux_out_n : out STD_LOGIC;
    dp_aux_out_p : out STD_LOGIC;
    dp_hpd : in STD_LOGIC;
    dp_lnk_clk_n : in STD_LOGIC;
    dp_lnk_clk_p : in STD_LOGIC;
    dp_tx_lane_n : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dp_tx_lane_p : out STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_intb : in STD_LOGIC;
    fan_en : out STD_LOGIC;
    hdmi_rx_hpa : out STD_LOGIC_VECTOR ( 0 to 0 );
    led : out STD_LOGIC_VECTOR ( 7 downto 0 );
    oled_gpio : out STD_LOGIC_VECTOR ( 3 downto 0 );
    oled_sclk : out STD_LOGIC;
    oled_sdin : out STD_LOGIC;
    phy_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    power_iic_scl_io : inout STD_LOGIC;
    power_iic_sda_io : inout STD_LOGIC;
    ps2_clk : inout STD_LOGIC;
    ps2_data : inout STD_LOGIC;
    qspi_io0_io : inout STD_LOGIC;
    qspi_io1_io : inout STD_LOGIC;
    qspi_io2_io : inout STD_LOGIC;
    qspi_io3_io : inout STD_LOGIC;
    qspi_ss_io : inout STD_LOGIC_VECTOR ( 0 to 0 );
    rgmii_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_rx_ctl : in STD_LOGIC;
    rgmii_rxc : in STD_LOGIC;
    rgmii_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_tx_ctl : out STD_LOGIC;
    rgmii_txc : out STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 7 downto 0 );
    sysclk_clk_n : in STD_LOGIC;
    sysclk_clk_p : in STD_LOGIC;
    uart_rxd_out : out STD_LOGIC;
    uart_txd_in : in STD_LOGIC;
    vga_b : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_g : out STD_LOGIC_VECTOR ( 5 downto 0 );
    vga_hs : out STD_LOGIC;
    vga_r : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_vs : out STD_LOGIC
  );
end system_wrapper;

architecture STRUCTURE of system_wrapper is
  component system is
  port (
    DDR3_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR3_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR3_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR3_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR3_ras_n : out STD_LOGIC;
    DDR3_cas_n : out STD_LOGIC;
    DDR3_we_n : out STD_LOGIC;
    DDR3_reset_n : out STD_LOGIC;
    DDR3_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_dm : out STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR3_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    power_iic_scl_i : in STD_LOGIC;
    power_iic_scl_o : out STD_LOGIC;
    power_iic_scl_t : out STD_LOGIC;
    power_iic_sda_i : in STD_LOGIC;
    power_iic_sda_o : out STD_LOGIC;
    power_iic_sda_t : out STD_LOGIC;
    qspi_io0_i : in STD_LOGIC;
    qspi_io0_o : out STD_LOGIC;
    qspi_io0_t : out STD_LOGIC;
    qspi_io1_i : in STD_LOGIC;
    qspi_io1_o : out STD_LOGIC;
    qspi_io1_t : out STD_LOGIC;
    qspi_io2_i : in STD_LOGIC;
    qspi_io2_o : out STD_LOGIC;
    qspi_io2_t : out STD_LOGIC;
    qspi_io3_i : in STD_LOGIC;
    qspi_io3_o : out STD_LOGIC;
    qspi_io3_t : out STD_LOGIC;
    qspi_ss_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    qspi_ss_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    qspi_ss_t : out STD_LOGIC;
    rgmii_rd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_rx_ctl : in STD_LOGIC;
    rgmii_rxc : in STD_LOGIC;
    rgmii_td : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgmii_tx_ctl : out STD_LOGIC;
    rgmii_txc : out STD_LOGIC;
    sysclk_clk_p : in STD_LOGIC;
    sysclk_clk_n : in STD_LOGIC;
    AUD_ADC_SDATA : in STD_LOGIC;
    ps2_clk : inout STD_LOGIC;
    ps2_data : inout STD_LOGIC;
    phy_rst_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    oled_gpio : out STD_LOGIC_VECTOR ( 3 downto 0 );
    oled_sdin : out STD_LOGIC;
    oled_sclk : out STD_LOGIC;
    uart_rxd_out : out STD_LOGIC;
    btnc : in STD_LOGIC;
    btnd : in STD_LOGIC;
    btnl : in STD_LOGIC;
    btnr : in STD_LOGIC;
    btnu : in STD_LOGIC;
    cpu_resetn : in STD_LOGIC;
    AUD_BCLK : out STD_LOGIC;
    AUD_LRCLK : out STD_LOGIC;
    AUD_MCLK : out STD_LOGIC;
    AUD_DAC_SDATA : out STD_LOGIC;
    dp_aux_in_n : in STD_LOGIC;
    dp_aux_in_p : in STD_LOGIC;
    dp_hpd : in STD_LOGIC;
    dp_lnk_clk_n : in STD_LOGIC;
    dp_lnk_clk_p : in STD_LOGIC;
    eth_intb : in STD_LOGIC;
    hdmi_rx_hpa : out STD_LOGIC_VECTOR ( 0 to 0 );
    uart_txd_in : in STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 7 downto 0 );
    led : out STD_LOGIC_VECTOR ( 7 downto 0 );
    dp_aux_out_n : out STD_LOGIC;
    dp_aux_out_p : out STD_LOGIC;
    dp_tx_lane_n : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dp_tx_lane_p : out STD_LOGIC_VECTOR ( 3 downto 0 );
    vga_b : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_g : out STD_LOGIC_VECTOR ( 5 downto 0 );
    vga_hs : out STD_LOGIC;
    vga_r : out STD_LOGIC_VECTOR ( 4 downto 0 );
    vga_vs : out STD_LOGIC;
    fan_en : out STD_LOGIC;
    AUD_ADDR_1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    AUD_ADDR_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    aud_scl_i : in STD_LOGIC;
    aud_scl_o : out STD_LOGIC;
    aud_scl_t : out STD_LOGIC;
    aud_sda_i : in STD_LOGIC;
    aud_sda_o : out STD_LOGIC;
    aud_sda_t : out STD_LOGIC
  );
  end component system;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal aud_scl_i : STD_LOGIC;
  signal aud_scl_o : STD_LOGIC;
  signal aud_scl_t : STD_LOGIC;
  signal aud_sda_i : STD_LOGIC;
  signal aud_sda_o : STD_LOGIC;
  signal aud_sda_t : STD_LOGIC;
  signal power_iic_scl_i : STD_LOGIC;
  signal power_iic_scl_o : STD_LOGIC;
  signal power_iic_scl_t : STD_LOGIC;
  signal power_iic_sda_i : STD_LOGIC;
  signal power_iic_sda_o : STD_LOGIC;
  signal power_iic_sda_t : STD_LOGIC;
  signal qspi_io0_i : STD_LOGIC;
  signal qspi_io0_o : STD_LOGIC;
  signal qspi_io0_t : STD_LOGIC;
  signal qspi_io1_i : STD_LOGIC;
  signal qspi_io1_o : STD_LOGIC;
  signal qspi_io1_t : STD_LOGIC;
  signal qspi_io2_i : STD_LOGIC;
  signal qspi_io2_o : STD_LOGIC;
  signal qspi_io2_t : STD_LOGIC;
  signal qspi_io3_i : STD_LOGIC;
  signal qspi_io3_o : STD_LOGIC;
  signal qspi_io3_t : STD_LOGIC;
  signal qspi_ss_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal qspi_ss_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal qspi_ss_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal qspi_ss_t : STD_LOGIC;
begin
aud_scl_iobuf: component IOBUF
     port map (
      I => aud_scl_o,
      IO => aud_scl_io,
      O => aud_scl_i,
      T => aud_scl_t
    );
aud_sda_iobuf: component IOBUF
     port map (
      I => aud_sda_o,
      IO => aud_sda_io,
      O => aud_sda_i,
      T => aud_sda_t
    );
power_iic_scl_iobuf: component IOBUF
     port map (
      I => power_iic_scl_o,
      IO => power_iic_scl_io,
      O => power_iic_scl_i,
      T => power_iic_scl_t
    );
power_iic_sda_iobuf: component IOBUF
     port map (
      I => power_iic_sda_o,
      IO => power_iic_sda_io,
      O => power_iic_sda_i,
      T => power_iic_sda_t
    );
qspi_io0_iobuf: component IOBUF
     port map (
      I => qspi_io0_o,
      IO => qspi_io0_io,
      O => qspi_io0_i,
      T => qspi_io0_t
    );
qspi_io1_iobuf: component IOBUF
     port map (
      I => qspi_io1_o,
      IO => qspi_io1_io,
      O => qspi_io1_i,
      T => qspi_io1_t
    );
qspi_io2_iobuf: component IOBUF
     port map (
      I => qspi_io2_o,
      IO => qspi_io2_io,
      O => qspi_io2_i,
      T => qspi_io2_t
    );
qspi_io3_iobuf: component IOBUF
     port map (
      I => qspi_io3_o,
      IO => qspi_io3_io,
      O => qspi_io3_i,
      T => qspi_io3_t
    );
qspi_ss_iobuf_0: component IOBUF
     port map (
      I => qspi_ss_o_0(0),
      IO => qspi_ss_io(0),
      O => qspi_ss_i_0(0),
      T => qspi_ss_t
    );
system_i: component system
     port map (
      AUD_ADC_SDATA => AUD_ADC_SDATA,
      AUD_ADDR_0(0) => AUD_ADDR_0(0),
      AUD_ADDR_1(0) => AUD_ADDR_1(0),
      AUD_BCLK => AUD_BCLK,
      AUD_DAC_SDATA => AUD_DAC_SDATA,
      AUD_LRCLK => AUD_LRCLK,
      AUD_MCLK => AUD_MCLK,
      DDR3_addr(14 downto 0) => DDR3_addr(14 downto 0),
      DDR3_ba(2 downto 0) => DDR3_ba(2 downto 0),
      DDR3_cas_n => DDR3_cas_n,
      DDR3_ck_n(0) => DDR3_ck_n(0),
      DDR3_ck_p(0) => DDR3_ck_p(0),
      DDR3_cke(0) => DDR3_cke(0),
      DDR3_cs_n(0) => DDR3_cs_n(0),
      DDR3_dm(3 downto 0) => DDR3_dm(3 downto 0),
      DDR3_dq(31 downto 0) => DDR3_dq(31 downto 0),
      DDR3_dqs_n(3 downto 0) => DDR3_dqs_n(3 downto 0),
      DDR3_dqs_p(3 downto 0) => DDR3_dqs_p(3 downto 0),
      DDR3_odt(0) => DDR3_odt(0),
      DDR3_ras_n => DDR3_ras_n,
      DDR3_reset_n => DDR3_reset_n,
      DDR3_we_n => DDR3_we_n,
      aud_scl_i => aud_scl_i,
      aud_scl_o => aud_scl_o,
      aud_scl_t => aud_scl_t,
      aud_sda_i => aud_sda_i,
      aud_sda_o => aud_sda_o,
      aud_sda_t => aud_sda_t,
      btnc => btnc,
      btnd => btnd,
      btnl => btnl,
      btnr => btnr,
      btnu => btnu,
      cpu_resetn => cpu_resetn,
      dp_aux_in_n => dp_aux_in_n,
      dp_aux_in_p => dp_aux_in_p,
      dp_aux_out_n => dp_aux_out_n,
      dp_aux_out_p => dp_aux_out_p,
      dp_hpd => dp_hpd,
      dp_lnk_clk_n => dp_lnk_clk_n,
      dp_lnk_clk_p => dp_lnk_clk_p,
      dp_tx_lane_n(3 downto 0) => dp_tx_lane_n(3 downto 0),
      dp_tx_lane_p(3 downto 0) => dp_tx_lane_p(3 downto 0),
      eth_intb => eth_intb,
      fan_en => fan_en,
      hdmi_rx_hpa(0) => hdmi_rx_hpa(0),
      led(7 downto 0) => led(7 downto 0),
      oled_gpio(3 downto 0) => oled_gpio(3 downto 0),
      oled_sclk => oled_sclk,
      oled_sdin => oled_sdin,
      phy_rst_n(0) => phy_rst_n(0),
      power_iic_scl_i => power_iic_scl_i,
      power_iic_scl_o => power_iic_scl_o,
      power_iic_scl_t => power_iic_scl_t,
      power_iic_sda_i => power_iic_sda_i,
      power_iic_sda_o => power_iic_sda_o,
      power_iic_sda_t => power_iic_sda_t,
      ps2_clk => ps2_clk,
      ps2_data => ps2_data,
      qspi_io0_i => qspi_io0_i,
      qspi_io0_o => qspi_io0_o,
      qspi_io0_t => qspi_io0_t,
      qspi_io1_i => qspi_io1_i,
      qspi_io1_o => qspi_io1_o,
      qspi_io1_t => qspi_io1_t,
      qspi_io2_i => qspi_io2_i,
      qspi_io2_o => qspi_io2_o,
      qspi_io2_t => qspi_io2_t,
      qspi_io3_i => qspi_io3_i,
      qspi_io3_o => qspi_io3_o,
      qspi_io3_t => qspi_io3_t,
      qspi_ss_i(0) => qspi_ss_i_0(0),
      qspi_ss_o(0) => qspi_ss_o_0(0),
      qspi_ss_t => qspi_ss_t,
      rgmii_rd(3 downto 0) => rgmii_rd(3 downto 0),
      rgmii_rx_ctl => rgmii_rx_ctl,
      rgmii_rxc => rgmii_rxc,
      rgmii_td(3 downto 0) => rgmii_td(3 downto 0),
      rgmii_tx_ctl => rgmii_tx_ctl,
      rgmii_txc => rgmii_txc,
      sw(7 downto 0) => sw(7 downto 0),
      sysclk_clk_n => sysclk_clk_n,
      sysclk_clk_p => sysclk_clk_p,
      uart_rxd_out => uart_rxd_out,
      uart_txd_in => uart_txd_in,
      vga_b(4 downto 0) => vga_b(4 downto 0),
      vga_g(5 downto 0) => vga_g(5 downto 0),
      vga_hs => vga_hs,
      vga_r(4 downto 0) => vga_r(4 downto 0),
      vga_vs => vga_vs
    );
end STRUCTURE;
