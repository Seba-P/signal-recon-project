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
--*  15.07.2015  mifi  First version for the Altera DE1-SoC Board.
--*                    Based on the Verilog GHRD design from Terasic.
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

entity top is
   port ( 
      -- Input clock 
      CLOCK_50         : in    std_logic;
      
      -- LEDs
      LEDR             : out   std_logic_vector(9 downto 0);
                            
      -- Swithes and keys
      SW               : in    std_logic_vector(9 downto 0);
      KEY              : in    std_logic_vector(3 downto 0);
      
      -- HPS
      HPS_CONV_USB_N   : inout std_logic;
      
      HPS_DDR3_ADDR    : out   std_logic_vector(14 downto 0);
      HPS_DDR3_BA      : out   std_logic_vector(2 downto 0);      
      HPS_DDR3_CAS_N   : out   std_logic;
      HPS_DDR3_CKE     : out   std_logic;
      HPS_DDR3_CK_N    : out   std_logic;
      HPS_DDR3_CK_P    : out   std_logic;
      HPS_DDR3_CS_N    : out   std_logic;
      HPS_DDR3_DM      : out   std_logic_vector(3 downto 0);
      HPS_DDR3_DQ      : inout std_logic_vector(31 downto 0);
      HPS_DDR3_DQS_N   : inout std_logic_vector(3 downto 0);
      HPS_DDR3_DQS_P   : inout std_logic_vector(3 downto 0);
      HPS_DDR3_ODT     : out   std_logic;
      HPS_DDR3_RAS_N   : out   std_logic;
      HPS_DDR3_RESET_N : out   std_logic;
      HPS_DDR3_RZQ     : in    std_logic;
      HPS_DDR3_WE_N    : out   std_logic;
      
      HPS_ENET_GTX_CLK : out   std_logic;
      HPS_ENET_INT_N   : inout std_logic;
      HPS_ENET_MDC     : out   std_logic;
      HPS_ENET_MDIO    : inout std_logic;
      HPS_ENET_RX_CLK  : in    std_logic;
      HPS_ENET_RX_DATA : in    std_logic_vector(3 downto 0);
      HPS_ENET_RX_DV   : in    std_logic;
      HPS_ENET_TX_DATA : out   std_logic_vector(3 downto 0);
      HPS_ENET_TX_EN   : out   std_logic;
      HPS_FLASH_DATA   : inout std_logic_vector(3 downto 0);
      HPS_FLASH_DCLK   : out   std_logic;
      HPS_FLASH_NCSO   : out   std_logic;
      HPS_GSENSOR_INT  : inout std_logic;
      HPS_I2C1_SCLK    : inout std_logic;
      HPS_I2C1_SDAT    : inout std_logic;
      HPS_I2C2_SCLK    : inout std_logic;
      HPS_I2C2_SDAT    : inout std_logic;
      HPS_I2C_CONTROL  : inout std_logic; 
      HPS_KEY          : inout std_logic;
      HPS_LED          : inout std_logic;
      HPS_LTC_GPIO     : inout std_logic;
      HPS_SD_CLK       : out   std_logic;
      HPS_SD_CMD       : inout std_logic;
      HPS_SD_DATA      : inout std_logic_vector(3 downto 0);
      HPS_SPIM_CLK     : out   std_logic;
      HPS_SPIM_MISO    : in    std_logic;
      HPS_SPIM_MOSI    : out   std_logic;
      HPS_SPIM_SS      : inout std_logic;
      HPS_UART_RX      : in    std_logic;
      HPS_UART_TX      : out   std_logic;
      HPS_USB_CLKOUT   : in    std_logic;
      HPS_USB_DATA     : inout std_logic_vector(7 downto 0);
      HPS_USB_DIR      : in    std_logic;
      HPS_USB_NXT      : in    std_logic;
      HPS_USB_STP      : out   std_logic
   );
end entity top;


--*****************************************************************************
--*  DEFINE: Architecture                                                     *
--*****************************************************************************

architecture syn of top is

   --------------------------------------------------------
   -- Define all constants here
   --------------------------------------------------------
   
   --------------------------------------------------------
   -- Define all components which are included here
   --------------------------------------------------------
   
   component pll_sys
      port ( 
         refclk   : in  std_logic := '0';
         rst      : in  std_logic := '0';
         outclk_0 : out std_logic;
         outclk_1 : out std_logic;
         locked   : out std_logic 
      );
   end component pll_sys;


   component heartbeat is
      port (  
         clk_i     : in  std_logic := '0';
         counter_o : out std_logic
      );
   end component heartbeat;
   
   
   component soc_system is
      port (
         clk_clk                              : in    std_logic                     := 'X';             -- clk
         reset_reset_n                        : in    std_logic                     := 'X';             -- reset_n
      
         hps_0_h2f_reset_reset_n              : out   std_logic;                                        -- reset_n
         
         led_pio_export                       : out   std_logic_vector(9 downto 0);                     -- export
         dipsw_pio_export                     : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
         button_pio_export                    : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
         
         memory_mem_a                         : out   std_logic_vector(14 downto 0);                    -- mem_a
         memory_mem_ba                        : out   std_logic_vector(2 downto 0);                     -- mem_ba
         memory_mem_ck                        : out   std_logic;                                        -- mem_ck
         memory_mem_ck_n                      : out   std_logic;                                        -- mem_ck_n
         memory_mem_cke                       : out   std_logic;                                        -- mem_cke
         memory_mem_cs_n                      : out   std_logic;                                        -- mem_cs_n
         memory_mem_ras_n                     : out   std_logic;                                        -- mem_ras_n
         memory_mem_cas_n                     : out   std_logic;                                        -- mem_cas_n
         memory_mem_we_n                      : out   std_logic;                                        -- mem_we_n
         memory_mem_reset_n                   : out   std_logic;                                        -- mem_reset_n
         memory_mem_dq                        : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
         memory_mem_dqs                       : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
         memory_mem_dqs_n                     : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
         memory_mem_odt                       : out   std_logic;                                        -- mem_odt
         memory_mem_dm                        : out   std_logic_vector(3 downto 0);                     -- mem_dm
         memory_oct_rzqin                     : in    std_logic                     := 'X';             -- oct_rzqin
         
         hps_io_hps_io_emac1_inst_TX_CLK      : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
         hps_io_hps_io_emac1_inst_TXD0        : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
         hps_io_hps_io_emac1_inst_TXD1        : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
         hps_io_hps_io_emac1_inst_TXD2        : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
         hps_io_hps_io_emac1_inst_TXD3        : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
         hps_io_hps_io_emac1_inst_RXD0        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
         hps_io_hps_io_emac1_inst_MDIO        : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
         hps_io_hps_io_emac1_inst_MDC         : out   std_logic;                                        -- hps_io_emac1_inst_MDC
         hps_io_hps_io_emac1_inst_RX_CTL      : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
         hps_io_hps_io_emac1_inst_TX_CTL      : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
         hps_io_hps_io_emac1_inst_RX_CLK      : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
         hps_io_hps_io_emac1_inst_RXD1        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
         hps_io_hps_io_emac1_inst_RXD2        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
         hps_io_hps_io_emac1_inst_RXD3        : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
         hps_io_hps_io_qspi_inst_IO0          : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO0
         hps_io_hps_io_qspi_inst_IO1          : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO1
         hps_io_hps_io_qspi_inst_IO2          : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO2
         hps_io_hps_io_qspi_inst_IO3          : inout std_logic                     := 'X';             -- hps_io_qspi_inst_IO3
         hps_io_hps_io_qspi_inst_SS0          : out   std_logic;                                        -- hps_io_qspi_inst_SS0
         hps_io_hps_io_qspi_inst_CLK          : out   std_logic;                                        -- hps_io_qspi_inst_CLK
         hps_io_hps_io_sdio_inst_CMD          : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
         hps_io_hps_io_sdio_inst_D0           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
         hps_io_hps_io_sdio_inst_D1           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
         hps_io_hps_io_sdio_inst_CLK          : out   std_logic;                                        -- hps_io_sdio_inst_CLK
         hps_io_hps_io_sdio_inst_D2           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
         hps_io_hps_io_sdio_inst_D3           : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
         hps_io_hps_io_usb1_inst_D0           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
         hps_io_hps_io_usb1_inst_D1           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
         hps_io_hps_io_usb1_inst_D2           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
         hps_io_hps_io_usb1_inst_D3           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
         hps_io_hps_io_usb1_inst_D4           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
         hps_io_hps_io_usb1_inst_D5           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
         hps_io_hps_io_usb1_inst_D6           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
         hps_io_hps_io_usb1_inst_D7           : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
         hps_io_hps_io_usb1_inst_CLK          : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
         hps_io_hps_io_usb1_inst_STP          : out   std_logic;                                        -- hps_io_usb1_inst_STP
         hps_io_hps_io_usb1_inst_DIR          : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
         hps_io_hps_io_usb1_inst_NXT          : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
         hps_io_hps_io_spim1_inst_CLK         : out   std_logic;                                        -- hps_io_spim1_inst_CLK
         hps_io_hps_io_spim1_inst_MOSI        : out   std_logic;                                        -- hps_io_spim1_inst_MOSI
         hps_io_hps_io_spim1_inst_MISO        : in    std_logic                     := 'X';             -- hps_io_spim1_inst_MISO
         hps_io_hps_io_spim1_inst_SS0         : out   std_logic;                                        -- hps_io_spim1_inst_SS0
         hps_io_hps_io_uart0_inst_RX          : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
         hps_io_hps_io_uart0_inst_TX          : out   std_logic;                                        -- hps_io_uart0_inst_TX
         hps_io_hps_io_i2c0_inst_SDA          : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SDA
         hps_io_hps_io_i2c0_inst_SCL          : inout std_logic                     := 'X';             -- hps_io_i2c0_inst_SCL
         hps_io_hps_io_i2c1_inst_SDA          : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SDA
         hps_io_hps_io_i2c1_inst_SCL          : inout std_logic                     := 'X';             -- hps_io_i2c1_inst_SCL
         hps_io_hps_io_gpio_inst_GPIO09       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO09
         hps_io_hps_io_gpio_inst_GPIO35       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO35
         hps_io_hps_io_gpio_inst_GPIO40       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO40
         hps_io_hps_io_gpio_inst_GPIO48       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO48
         hps_io_hps_io_gpio_inst_GPIO53       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO53
         hps_io_hps_io_gpio_inst_GPIO54       : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO54
         hps_io_hps_io_gpio_inst_GPIO61       : inout std_logic                     := 'X'              -- hps_io_gpio_inst_GPIO61
      );
   end component soc_system;
   

   --------------------------------------------------------
   -- Define all local signals here
   --------------------------------------------------------
   signal sys_clk          : std_logic := '0';
   signal clk_10           : std_logic := '0';
   signal pll_locked       : std_logic := '0';
   signal reset            : std_logic := '0';
   signal reset_s1         : std_logic := '1';
   signal reset_s2         : std_logic := '1';
   signal reset_s3         : std_logic := '1';
   signal sys_rst          : std_logic;

   signal hps_fpga_reset_n : std_logic;
   
   signal led_red          : std_logic_vector(9 downto 0); 

begin

   --
   -- PLL
   --
   inst_pll_sys : pll_sys
      port map ( 
         refclk   => CLOCK_50,
         rst      => not KEY(3),
         outclk_0 => sys_clk,
         outclk_1 => clk_10,
         locked   => pll_locked
      );

   --
   -- In general it is a bad idea to use an asynchhronous Reset signal.
   -- But it is only a bad idea in case of asynchhronous deasserting. 
   -- Therefore the deasserting of the Reset signal must be synchronized.
   --               
               
   -- Asynchronous assert  
   reset <= '1' when ((KEY(3) = '0') OR (pll_locked = '0') OR (hps_fpga_reset_n = '0')) else '0';

   -- Synchronize deassert
   process (sys_clk, reset)
   begin
      if (reset = '1') then
         reset_s1 <= '1';
         reset_s2 <= '1';
         reset_s3 <= '1';
      elsif rising_edge(sys_clk) then
         reset_s1 <= '0';
         reset_s2 <= reset_s1;
         reset_s3 <= reset_s2; 
      end if;
   end process;   

   -- The deassert edge is now synchronized   
   sys_rst <= reset_s3; 
   
   
   --
   -- Heartbeat
   --
   inst_heartbeat : heartbeat 
      port map ( 
         clk_i     => clk_10,
         counter_o => LEDR(9)
      );
      
      
   --
   -- Qsys core
   --      
   inst_soc_system : soc_system
      port map ( 
         clk_clk                              => sys_clk,
         reset_reset_n                        => not sys_rst,
         
         -- HPS Reset output
         hps_0_h2f_reset_reset_n              => hps_fpga_reset_n,
         
         led_pio_export                       => led_red,
         dipsw_pio_export                     => SW,
         button_pio_export                    => KEY,
         
         -- HPS DDR
         memory_mem_a                         => HPS_DDR3_ADDR,
         memory_mem_ba                        => HPS_DDR3_BA,
         memory_mem_ck                        => HPS_DDR3_CK_P,
         memory_mem_ck_n                      => HPS_DDR3_CK_N,
         memory_mem_cke                       => HPS_DDR3_CKE,
         memory_mem_cs_n                      => HPS_DDR3_CS_N,
         memory_mem_ras_n                     => HPS_DDR3_RAS_N,
         memory_mem_cas_n                     => HPS_DDR3_CAS_N,
         memory_mem_we_n                      => HPS_DDR3_WE_N,
         memory_mem_reset_n                   => HPS_DDR3_RESET_N,
         memory_mem_dq                        => HPS_DDR3_DQ,
         memory_mem_dqs                       => HPS_DDR3_DQS_P,
         memory_mem_dqs_n                     => HPS_DDR3_DQS_N,
         memory_mem_odt                       => HPS_DDR3_ODT,
         memory_mem_dm                        => HPS_DDR3_DM,
         memory_oct_rzqin                     => HPS_DDR3_RZQ,
         
         -- HPS Ethernet
         hps_io_hps_io_emac1_inst_TX_CLK      => HPS_ENET_GTX_CLK,
         hps_io_hps_io_emac1_inst_TXD0        => HPS_ENET_TX_DATA(0),
         hps_io_hps_io_emac1_inst_TXD1        => HPS_ENET_TX_DATA(1),
         hps_io_hps_io_emac1_inst_TXD2        => HPS_ENET_TX_DATA(2),
         hps_io_hps_io_emac1_inst_TXD3        => HPS_ENET_TX_DATA(3),
         hps_io_hps_io_emac1_inst_RXD0        => HPS_ENET_RX_DATA(0),
         hps_io_hps_io_emac1_inst_MDIO        => HPS_ENET_MDIO,
         hps_io_hps_io_emac1_inst_MDC         => HPS_ENET_MDC,
         hps_io_hps_io_emac1_inst_RX_CTL      => HPS_ENET_RX_DV,
         hps_io_hps_io_emac1_inst_TX_CTL      => HPS_ENET_TX_EN,
         hps_io_hps_io_emac1_inst_RX_CLK      => HPS_ENET_RX_CLK,
         hps_io_hps_io_emac1_inst_RXD1        => HPS_ENET_RX_DATA(1),
         hps_io_hps_io_emac1_inst_RXD2        => HPS_ENET_RX_DATA(2),
         hps_io_hps_io_emac1_inst_RXD3        => HPS_ENET_RX_DATA(3),
         
         -- HPS QSPI
         hps_io_hps_io_qspi_inst_IO0          => HPS_FLASH_DATA(0),
         hps_io_hps_io_qspi_inst_IO1          => HPS_FLASH_DATA(1),
         hps_io_hps_io_qspi_inst_IO2          => HPS_FLASH_DATA(2),
         hps_io_hps_io_qspi_inst_IO3          => HPS_FLASH_DATA(3),
         hps_io_hps_io_qspi_inst_SS0          => HPS_FLASH_NCSO,
         hps_io_hps_io_qspi_inst_CLK          => HPS_FLASH_DCLK,
         
         --HPS SD card
         hps_io_hps_io_sdio_inst_CMD          => HPS_SD_CMD,
         hps_io_hps_io_sdio_inst_D0           => HPS_SD_DATA(0),
         hps_io_hps_io_sdio_inst_D1           => HPS_SD_DATA(1),
         hps_io_hps_io_sdio_inst_CLK          => HPS_SD_CLK,
         hps_io_hps_io_sdio_inst_D2           => HPS_SD_DATA(2),
         hps_io_hps_io_sdio_inst_D3           => HPS_SD_DATA(3),
                 
         -- HPS USB
         hps_io_hps_io_usb1_inst_D0           => HPS_USB_DATA(0),
         hps_io_hps_io_usb1_inst_D1           => HPS_USB_DATA(1),
         hps_io_hps_io_usb1_inst_D2           => HPS_USB_DATA(2),
         hps_io_hps_io_usb1_inst_D3           => HPS_USB_DATA(3),
         hps_io_hps_io_usb1_inst_D4           => HPS_USB_DATA(4),
         hps_io_hps_io_usb1_inst_D5           => HPS_USB_DATA(5),
         hps_io_hps_io_usb1_inst_D6           => HPS_USB_DATA(6),
         hps_io_hps_io_usb1_inst_D7           => HPS_USB_DATA(7),
         hps_io_hps_io_usb1_inst_CLK          => HPS_USB_CLKOUT,
         hps_io_hps_io_usb1_inst_STP          => HPS_USB_STP,
         hps_io_hps_io_usb1_inst_DIR          => HPS_USB_DIR,
         hps_io_hps_io_usb1_inst_NXT          => HPS_USB_NXT,
         
         -- HPS SPI
         hps_io_hps_io_spim1_inst_CLK         => HPS_SPIM_CLK,
         hps_io_hps_io_spim1_inst_MOSI        => HPS_SPIM_MOSI,
         hps_io_hps_io_spim1_inst_MISO        => HPS_SPIM_MISO,
         hps_io_hps_io_spim1_inst_SS0         => HPS_SPIM_SS,
         
         -- HPS UART
         hps_io_hps_io_uart0_inst_RX          => HPS_UART_RX,
         hps_io_hps_io_uart0_inst_TX          => HPS_UART_TX,
         
         -- HPS I2C1
         hps_io_hps_io_i2c0_inst_SDA          => HPS_I2C1_SDAT,
         hps_io_hps_io_i2c0_inst_SCL          => HPS_I2C1_SCLK,
         
         -- HPS I2C2
         hps_io_hps_io_i2c1_inst_SDA          => HPS_I2C2_SDAT,
         hps_io_hps_io_i2c1_inst_SCL          => HPS_I2C2_SCLK,
         
         -- HPS GPIO
         hps_io_hps_io_gpio_inst_GPIO09       => HPS_CONV_USB_N,
         hps_io_hps_io_gpio_inst_GPIO35       => HPS_ENET_INT_N,
         hps_io_hps_io_gpio_inst_GPIO40       => HPS_LTC_GPIO,
         hps_io_hps_io_gpio_inst_GPIO48       => HPS_I2C_CONTROL,
         hps_io_hps_io_gpio_inst_GPIO53       => HPS_LED,
         hps_io_hps_io_gpio_inst_GPIO54       => HPS_KEY,
         hps_io_hps_io_gpio_inst_GPIO61       => HPS_GSENSOR_INT
      );


   --------------------------------------------------------
   -- Output
   --------------------------------------------------------

   LEDR(8 downto 0) <= led_red(8 downto 0);
   
end architecture syn;

-- *** EOF ***

