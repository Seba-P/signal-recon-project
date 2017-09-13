-- st_packet_signals_add.vhd

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

entity st_packet_signals_add is
	port (
		avalon_streaming_sink_ready           : out std_logic;                                       --   avalon_streaming_sink.ready
		avalon_streaming_sink_data            : in  std_logic_vector(7 downto 0) := (others => '0'); --                        .data
		avalon_streaming_sink_valid           : in  std_logic                    := '0';             --                        .valid
		avalon_streaming_source_data          : out std_logic_vector(7 downto 0);                    -- avalon_streaming_source.data
		avalon_streaming_source_endofpacket   : out std_logic;                                       --                        .endofpacket
		avalon_streaming_source_ready         : in  std_logic                    := '0';             --                        .ready
		avalon_streaming_source_startofpacket : out std_logic;                                       --                        .startofpacket
		avalon_streaming_source_valid         : out std_logic;                                       --                        .valid
		clock_sink_clk                        : in  std_logic                    := '0';             --              clock_sink.clk
		reset_sink_reset                      : in  std_logic                    := '0'              --              reset_sink.reset
	);
end entity st_packet_signals_add;

architecture rtl of st_packet_signals_add is
begin

	avalon_streaming_sink_ready <= avalon_streaming_source_ready;

	avalon_streaming_source_valid <= avalon_streaming_sink_valid;

	avalon_streaming_source_data <= avalon_streaming_sink_data;

	avalon_streaming_source_startofpacket <= '0';

	avalon_streaming_source_endofpacket <= '0';

end architecture rtl; -- of st_packet_signals_add
