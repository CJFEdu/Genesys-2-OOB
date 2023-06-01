# file: system_displayport_0_0.xdc (IP Level XDC)

#-----------------------------------------------------------------
## Clock Constraints
#-----------------------------------------------------------------

#Ignoring the paths with CDC synchronizer
set_false_path -to [get_pins -hier *sync_flop_0*/D]
set_false_path -from [get_cells -hierarchical  -filter {NAME =~*/aux_data_enable_n_reg}]

# Assuming 135 MHz GT Reference Clock
#create_clock  -period 3.704   [get_ports lnk_clk]
create_clock -period 3.704 [get_pins -hierarchical -filter {name=~*gt0*TXOUTCLK}]
create_clock -period 3.704 [get_pins -hierarchical -filter {name=~*gt0*RXOUTCLK}]
#create_clock  -period 3.704   [get_pins -hierarchical *ref_clk_out_bufg*/O]



create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-4 -description "HRES config will be stable for longer time" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_vid_frmt_inst/input_size_reg*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "MSA will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[190]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "MSA will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[190]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[156]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[157]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[158]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[159]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[160]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[161]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[162]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[163]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[164]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[165]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[166]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[167]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[168]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[169]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[170]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[171]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "MSA_MISC0 will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[191]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "MSA_MISC0 will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[192]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "MSA_MISC0 will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[195]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "MSA_MISC0 will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[196]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "MSA_MISC0 will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[197]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "MSA_MISC1 will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[205]*}]] \
  -to   *PIN  
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_USER_PIXEL_WIDTH parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[254]*}]] \
  -to   *PIN  
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_USER_PIXEL_WIDTH parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[255]*}]] \
  -to   *PIN  
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_USER_PIXEL_WIDTH parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[256]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "LANE_COUNT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[8]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_user_inst/sync_lane_count_reg[0]*}]]  
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "LANE_COUNT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[9]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_user_inst/sync_lane_count_reg[1]*}]]  
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "LANE_COUNT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[10]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_user_inst/sync_lane_count_reg[2]*}]]  
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "LANE_COUNT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[11]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_user_inst/sync_lane_count_reg[3]*}]]  
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "LANE_COUNT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[12]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_user_inst/sync_lane_count_reg[4]*}]]  
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[164]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]

create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "MSA_MISC0 will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[199]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_HTOTAL will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[65]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_HTOTAL will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[70]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_HTOTAL will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[72]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_HTOTAL will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[74]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_VTOTAL will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[80]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_VTOTAL will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[83]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_VTOTAL will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[85]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_VSTART will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[151]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_VSTART will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[151]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_VSTART will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[152]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_HSTART will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[135]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_HSTART will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[138]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "MSA_MISC1 will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[202]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "MSA_MISC1 will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[203]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "MSA_MISC1 will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[204]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[165]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_HRES will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[171]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "TX_INTERLACED will not change often and configured before frame transfer" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[281]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_framing_table_lane*_byte*_inst/lnk_table_data_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-11 -description "fifo reset is generted per stream" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_vid_pack_inst/user_fifo_reset_reg*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "audio datapath" \
  -from *PIN  \
  -to [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_secondary_inst/sync_cell_sec_idle_starts/sync_flop_*_reg*}]] 
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "audio datapath" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_secondary_inst/sync_cell_sec_idle_starts/sync_flop_*_reg*}]]  \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "audio datapath" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_link_inst/audio_signal_stream*.sync_cell_mst_audio_stream_no_inst/sync_flop*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-10 -description "audio datapath" \
  -from *PIN \
  -to  [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_secondary_inst/sync_cell_aud_pkt_id_mismatch_inst/sync_flop_0_reg*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "CFG_TIME_VSC_EXT_TO_VSYNC parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[573]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-11 -description "CFG_TIME_VSC_EXT_TO_VSYNC parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[573]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-11 -description "TX_AUDIO_ENABLE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_sec_regs_reg[0]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_MIN_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[406]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_MIN_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[406]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_MIN_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[407]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_MIN_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[408]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_MIN_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[409]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_MIN_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[410]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_MIN_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[411]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_MIN_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[412]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_FRAC_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[413]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_FRAC_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[414]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_FRAC_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[415]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_FRAC_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[416]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_FRAC_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[417]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_FRAC_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[418]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_FRAC_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[419]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_FRAC_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[420]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_FRAC_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[421]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_FRAC_BYTES_PER_TU parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[422]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_TRANSFER_UNIT_SIZE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[257]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_TRANSFER_UNIT_SIZE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[258]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_TRANSFER_UNIT_SIZE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[259]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_TRANSFER_UNIT_SIZE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[260]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_TRANSFER_UNIT_SIZE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[261]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_TRANSFER_UNIT_SIZE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[262]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[263]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[264]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[265]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[266]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[267]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[268]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[269]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[270]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[271]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[272]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[273]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[274]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[274]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[275]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[276]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[277]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[278]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[279]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_WORDS_PER_LINE parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[280]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[230]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[231]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[232]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[233]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[234]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[235]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[236]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[237]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[238]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[239]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[240]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[241]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[242]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[243]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[244]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[245]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[246]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[247]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[248]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[249]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[250]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[251]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[252]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_N_VID parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[253]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_POLARITY parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[187]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[425]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[426]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[427]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[428]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[429]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_sec_regs_reg[*]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_sec_packet_inst/i_naud_reg[*]*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_POLARITY parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[187]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[425]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[426]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[427]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[428]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_regs_reg[429]*}]] \
  -to   *PIN
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "TX_INIT_WAIT parameter" \
  -from [get_pins -quiet -filter {REF_PIN_NAME=~*C} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_apb_inst/cfg_tx_sec_regs_reg[*]*}]] \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_sec_packet_inst/i_naud_reg[*]*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-1 -description "Flop based synchronizer is in place" \
  -from *PIN \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*D} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_reset_inst/i_lnk_reset_sr_reg[*]*}]]
create_waiver -scope -internal -quiet -user displayport_tx -tags 10897 -type CDC -id CDC-7 -description "Flop based synchronizer is in place" \
  -from *PIN \
  -to   [get_pins -quiet -filter {REF_PIN_NAME=~*PRE} -of_objects [get_cells -hierarchical -filter {NAME =~ *tx_reset_inst/i_lnk_reset_sr_reg[*]*}]]
