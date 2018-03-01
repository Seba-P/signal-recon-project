-- st2mm_data_adapter.vhd

-- This file was auto-generated as a prototype implementation of a module
-- created in component editor.  It ties off all outputs to ground and
-- ignores all inputs.  It needs to be edited to make it do something
-- useful.
-- 
-- This file will not be automatically regenerated.  You should check it in
-- to your version control system if you want to keep it.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity st2mm_data_adapter is
	port (
		avalon_st_sink_ready           : out std_logic;                                        --       avalon_st_sink.ready
		avalon_st_sink_data            : in  std_logic_vector(15 downto 0) := (others => '0'); --                     .data
		avalon_st_sink_valid           : in  std_logic                     := '0';             --                     .valid
		avalon_st_source_data          : out std_logic_vector(15 downto 0);                    --     avalon_st_source.data
		avalon_st_source_endofpacket   : out std_logic;                                        --                     .endofpacket
		avalon_st_source_ready         : in  std_logic                     := '0';             --                     .ready
		avalon_st_source_startofpacket : out std_logic;                                        --                     .startofpacket
		avalon_st_source_valid         : out std_logic;                                        --                     .valid
		avalon_st_clk_sink             : in  std_logic                     := '0';             --   avalon_st_clk_sink.clk
		avalon_st_clk_source           : in  std_logic                     := '0';             -- avalon_st_clk_source.clk
		avalon_st_reset                : in  std_logic                     := '0'              --      avalon_st_reset.reset
	);
end entity st2mm_data_adapter;

architecture rtl of st2mm_data_adapter is
begin

	avalon_st_sink_ready 			<= avalon_st_source_ready;
	avalon_st_source_valid 			<= avalon_st_sink_valid;
	avalon_st_source_data 			<= avalon_st_sink_data;
	avalon_st_source_startofpacket 	<= '0';
	avalon_st_source_endofpacket 	<= '0';

end architecture rtl; -- of st2mm_data_adapter
