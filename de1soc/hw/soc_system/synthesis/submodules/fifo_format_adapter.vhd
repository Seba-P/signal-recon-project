-- fifo_format_adapter.vhd

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

entity fifo_format_adapter is
	port (
		clk          : in  std_logic                     := '0';             --                clk.clk
		reset        : in  std_logic                     := '0';             --              reset.reset
		sink_in      : in  std_logic_vector(23 downto 0) := (others => '0'); --     avalon_st_sink.data
		source_out_1 : out std_logic_vector(7 downto 0);                     -- avalon_st_source_1.data
		source_out_0 : out std_logic_vector(7 downto 0);                     -- avalon_st_source_0.data
		source_out_2 : out std_logic_vector(7 downto 0)                      -- avalon_st_source_2.data
	);
end entity fifo_format_adapter;

architecture rtl of fifo_format_adapter is
begin

	-- TODO: Auto-generated HDL template

	source_out_1 <= sink_in(15 downto 8);

	source_out_0 <= sink_in(7 downto 0);

	source_out_2 <= sink_in(23 downto 16);

end architecture rtl; -- of fifo_format_adapter
