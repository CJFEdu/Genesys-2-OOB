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


