# file: system_displayport_0_0_clocks.xdc (IP Level XDC)

#-----------------------------------------------------------------
# cross clock constraints 
#-----------------------------------------------------------------

set wr_vid_clock [get_clocks -of_objects [get_pins -hierarchical -filter {name=~*/tx_vid_clk*}]]

set_max_delay -datapath_only 40 -from [ get_clocks -of_objects [get_ports s_axi_aclk] ] -to  $wr_vid_clock 
set_max_delay -datapath_only 40 -from $wr_vid_clock -to  [ get_clocks -of_objects [get_ports s_axi_aclk] ]  

   set rd_lnk_clock [get_clocks -of_objects [get_pins -hierarchical -filter {name=~*gt0*TXOUTCLK}] ]
   set_max_delay -datapath_only 40 -from [ get_clocks -of_objects [get_ports s_axi_aclk] ] -to   [get_clocks -of_objects [get_pins -hierarchical -filter {name=~*gt0*TXOUTCLK}] ]
   set_max_delay -datapath_only 40 -from [get_clocks -of_objects [get_pins -hierarchical -filter {name=~*gt0*TXOUTCLK}] ] -to [ get_clocks -of_objects [get_ports s_axi_aclk] ]

set_max_delay -from [get_pins -of [get_cells -hierarchical -filter {NAME =~*/sync_lane_count_reg*}] -filter {REF_PIN_NAME == C}] -to [get_pins -of [get_cells -hierarchical -filter {NAME =~*/sync_lane_count_mask_reg*}] -filter {REF_PIN_NAME == D}] -datapath_only 40
set_max_delay -from [get_pins -of [get_cells -hierarchical -filter {NAME =~*/i_posted_vid_counter_reg*}] -filter {REF_PIN_NAME == C}] -to [get_pins -of [get_cells -hierarchical -filter {NAME =~*/lnk_m_vid_reg*}] -filter {REF_PIN_NAME == D}] -datapath_only 40
set_max_delay -from [get_pins -of [get_cells -hierarchical -filter {NAME =~*/input_size_reg*}] -filter {REF_PIN_NAME == C}] -to [get_pins -of [get_cells -hierarchical -filter {NAME =~*/sync_input_size_reg*}] -filter {REF_PIN_NAME == D}] -datapath_only 40 




