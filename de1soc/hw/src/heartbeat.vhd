--*****************************************************************************
--*  Copyright (c) 2015 by Michael Fischer (www.emb4fun.de)
--*  All rights reserved.
--*
--*  Redistribution and use in source and binary forms, with or without 
--*  modification, are permitted provided that the following conditions 
--*  are met:
--*  
--*  1. Redistributions of source code must retain the above copyright 
--*     notice, this list of conditions and the following disclaimer.
--*  2. Redistributions in binary form must reproduce the above copyright
--*     notice, this list of conditions and the following disclaimer in the 
--*     documentation and/or other materials provided with the distribution.
--*  3. Neither the name of the author nor the names of its contributors may 
--*     be used to endorse or promote products derived from this software 
--*     without specific prior written permission.
--*
--*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
--*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
--*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
--*  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
--*  THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
--*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
--*  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS 
--*  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
--*  AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
--*  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
--*  THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF 
--*  SUCH DAMAGE.
--*
--*****************************************************************************
--*  History:
--*
--*  23.05.2015  mifi  First version.
--*****************************************************************************

--*****************************************************************************
--*  DEFINE: Library                                                          *
--*****************************************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


--*****************************************************************************
--*  DEFINE: Entity                                                           *
--*****************************************************************************

entity heartbeat is
   port (  
      clk_i     : in  std_logic := '0';
      counter_o : out std_logic
   );
end entity heartbeat;


--*****************************************************************************
--*  DEFINE: Architecture                                                     *
--*****************************************************************************

architecture syn of heartbeat is

   --------------------------------------------------------
   -- Define all constants here
   --------------------------------------------------------

   --------------------------------------------------------
   -- Define all components which are included here
   --------------------------------------------------------

   --------------------------------------------------------
   -- Define all local signals here
   --------------------------------------------------------
   
   signal counter_data : std_logic_vector(31 downto 0) := (others => '0');  
  
begin

   process (clk_i)
   begin
    
      if rising_edge(clk_i) then
         counter_data <= std_logic_vector(unsigned(counter_data) + 1);
      end if; 
    
   end process;
  
  
   --------------------------------------------------------
   -- Output
   --------------------------------------------------------
  
   counter_o <= counter_data(23);

end architecture syn;

-- *** EOF ***

