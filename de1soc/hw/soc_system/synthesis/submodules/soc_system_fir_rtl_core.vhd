-- ------------------------------------------------------------------------- 
-- Intel Altera DSP Builder Advanced Flow Tools Release Version 16.1
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2016 Intel Corporation.  All rights reserved.
-- Your use of  Intel  Corporation's design tools,  logic functions and other
-- software and tools,  and its AMPP  partner logic functions, and  any output
-- files  any of the  foregoing  device programming or simulation files),  and
-- any associated  documentation or information are expressly subject  to  the
-- terms and conditions  of the Intel FPGA Software License Agreement,
-- Intel  MegaCore  Function  License  Agreement, or other applicable license
-- agreement,  including,  without limitation,  that your use  is for the sole
-- purpose of  programming  logic  devices  manufactured by Intel and sold by
-- Intel or its authorized  distributors.  Please  refer  to  the  applicable
-- agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from soc_system_fir_rtl_core
-- VHDL created on Thu Jun 22 02:58:58 2017


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity soc_system_fir_rtl_core is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_1 : in std_logic_vector(7 downto 0);  -- sfix8
        enable_i : in std_logic_vector(0 downto 0);  -- sfix1
        xOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        xOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        xOut_0 : out std_logic_vector(23 downto 0);  -- sfix24
        xOut_1 : out std_logic_vector(23 downto 0);  -- sfix24
        clk : in std_logic;
        areset : in std_logic
    );
end soc_system_fir_rtl_core;

architecture normal of soc_system_fir_rtl_core is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_wi0_r0_split32_c_11_q : STD_LOGIC_VECTOR (7 downto 0);
    type u0_m0_wo0_cma0_a0type is array(0 to 31) of SIGNED(7 downto 0);
    signal u0_m0_wo0_cma0_a0 : u0_m0_wo0_cma0_a0type;
    attribute preserve : boolean;
    attribute preserve of u0_m0_wo0_cma0_a0 : signal is true;
    type u0_m0_wo0_cma0_c0type is array(0 to 31) of UNSIGNED(2 downto 0);
    signal u0_m0_wo0_cma0_c0 : u0_m0_wo0_cma0_c0type;
    attribute preserve of u0_m0_wo0_cma0_c0 : signal is true;
    type u0_m0_wo0_cma0_rtype is array(0 to 31) of SIGNED(10 downto 0);
    signal u0_m0_wo0_cma0_r : u0_m0_wo0_cma0_rtype;
    type u0_m0_wo0_cma0_ptype is array(0 to 31) of SIGNED(18 downto 0);
    signal u0_m0_wo0_cma0_p : u0_m0_wo0_cma0_ptype;
    type u0_m0_wo0_cma0_utype is array(0 to 31) of SIGNED(23 downto 0);
    signal u0_m0_wo0_cma0_u : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma0_w : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma0_x : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma0_y : u0_m0_wo0_cma0_utype;
    type u0_m0_wo0_cma0_k0type is array(0 to 7) of SIGNED(10 downto 0);
    signal u0_m0_wo0_cma0_k0 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k1 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k2 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k3 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k4 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k5 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k6 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k7 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k8 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k9 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k10 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k11 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k12 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k13 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k14 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k15 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k16 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k17 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k18 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k19 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(3,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k20 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k21 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k22 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k23 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k24 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k25 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k26 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k27 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k28 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k29 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k30 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(6,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k31 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_s : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma0_qq : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_cma0_q : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_cma1_a0 : u0_m0_wo0_cma0_a0type;
    attribute preserve of u0_m0_wo0_cma1_a0 : signal is true;
    signal u0_m0_wo0_cma1_c0 : u0_m0_wo0_cma0_c0type;
    attribute preserve of u0_m0_wo0_cma1_c0 : signal is true;
    signal u0_m0_wo0_cma1_r : u0_m0_wo0_cma0_rtype;
    signal u0_m0_wo0_cma1_p : u0_m0_wo0_cma0_ptype;
    signal u0_m0_wo0_cma1_u : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma1_w : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma1_x : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma1_y : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma1_k0 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-14,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k1 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-19,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k2 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-12,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k3 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k4 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(20,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k5 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(29,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k6 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(24,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k7 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k8 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-28,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k9 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-51,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k10 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-50,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k11 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k12 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(50,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k13 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(133,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k14 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(209,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k15 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(255,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k16 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(255,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k17 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(209,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k18 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(133,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k19 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(50,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k20 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k21 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-50,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k22 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-51,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k23 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-28,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k24 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k25 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(24,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k26 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(29,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k27 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(20,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k28 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k29 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-12,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k30 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-19,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k31 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-14,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_s : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma1_qq : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_cma1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_cma2_a0 : u0_m0_wo0_cma0_a0type;
    attribute preserve of u0_m0_wo0_cma2_a0 : signal is true;
    signal u0_m0_wo0_cma2_c0 : u0_m0_wo0_cma0_c0type;
    attribute preserve of u0_m0_wo0_cma2_c0 : signal is true;
    signal u0_m0_wo0_cma2_r : u0_m0_wo0_cma0_rtype;
    signal u0_m0_wo0_cma2_p : u0_m0_wo0_cma0_ptype;
    signal u0_m0_wo0_cma2_u : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma2_w : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma2_x : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma2_y : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma2_k0 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k1 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(6,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k2 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k3 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k4 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k5 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k6 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k7 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k8 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k9 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k10 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k11 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k12 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(3,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k13 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k14 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k15 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k16 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k17 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k18 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k19 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k20 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k21 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k22 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k23 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k24 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k25 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k26 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k27 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k28 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k29 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k30 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k31 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_s : u0_m0_wo0_cma0_utype;
    signal u0_m0_wo0_cma2_qq : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_cma2_q : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_mtree_add0_0_a : STD_LOGIC_VECTOR (22 downto 0);
    signal u0_m0_wo0_mtree_add0_0_b : STD_LOGIC_VECTOR (22 downto 0);
    signal u0_m0_wo0_mtree_add0_0_o : STD_LOGIC_VECTOR (22 downto 0);
    signal u0_m0_wo0_mtree_add0_0_q : STD_LOGIC_VECTOR (22 downto 0);
    signal u0_m0_wo0_mtree_add1_0_a : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_mtree_add1_0_b : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_mtree_add1_0_o : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_mtree_add1_0_q : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u1_m0_wo0_compute_q_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u1_m0_wo0_compute_q_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u1_m0_wo0_wi0_r0_split32_c_11_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u1_m0_wo0_cma0_a0 : u0_m0_wo0_cma0_a0type;
    attribute preserve of u1_m0_wo0_cma0_a0 : signal is true;
    signal u1_m0_wo0_cma0_c0 : u0_m0_wo0_cma0_c0type;
    attribute preserve of u1_m0_wo0_cma0_c0 : signal is true;
    signal u1_m0_wo0_cma0_r : u0_m0_wo0_cma0_rtype;
    signal u1_m0_wo0_cma0_p : u0_m0_wo0_cma0_ptype;
    signal u1_m0_wo0_cma0_u : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma0_w : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma0_x : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma0_y : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma0_k0 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k1 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k2 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k3 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k4 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k5 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k6 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k7 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k8 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k9 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k10 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k11 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k12 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k13 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k14 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k15 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k16 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k17 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k18 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k19 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(3,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k20 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k21 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k22 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k23 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k24 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k25 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k26 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k27 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k28 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k29 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k30 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(6,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_k31 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma0_s : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma0_qq : STD_LOGIC_VECTOR (23 downto 0);
    signal u1_m0_wo0_cma0_q : STD_LOGIC_VECTOR (23 downto 0);
    signal u1_m0_wo0_cma1_a0 : u0_m0_wo0_cma0_a0type;
    attribute preserve of u1_m0_wo0_cma1_a0 : signal is true;
    signal u1_m0_wo0_cma1_c0 : u0_m0_wo0_cma0_c0type;
    attribute preserve of u1_m0_wo0_cma1_c0 : signal is true;
    signal u1_m0_wo0_cma1_r : u0_m0_wo0_cma0_rtype;
    signal u1_m0_wo0_cma1_p : u0_m0_wo0_cma0_ptype;
    signal u1_m0_wo0_cma1_u : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma1_w : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma1_x : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma1_y : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma1_k0 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-14,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k1 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-19,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k2 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-12,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k3 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k4 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(20,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k5 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(29,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k6 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(24,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k7 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k8 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-28,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k9 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-51,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k10 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-50,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k11 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k12 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(50,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k13 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(133,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k14 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(209,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k15 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(255,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k16 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(255,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k17 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(209,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k18 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(133,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k19 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(50,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k20 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k21 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-50,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k22 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-51,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k23 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-28,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k24 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k25 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(24,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k26 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(29,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k27 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(20,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k28 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k29 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-12,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k30 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-19,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_k31 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-14,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma1_s : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma1_qq : STD_LOGIC_VECTOR (23 downto 0);
    signal u1_m0_wo0_cma1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal u1_m0_wo0_cma2_a0 : u0_m0_wo0_cma0_a0type;
    attribute preserve of u1_m0_wo0_cma2_a0 : signal is true;
    signal u1_m0_wo0_cma2_c0 : u0_m0_wo0_cma0_c0type;
    attribute preserve of u1_m0_wo0_cma2_c0 : signal is true;
    signal u1_m0_wo0_cma2_r : u0_m0_wo0_cma0_rtype;
    signal u1_m0_wo0_cma2_p : u0_m0_wo0_cma0_ptype;
    signal u1_m0_wo0_cma2_u : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma2_w : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma2_x : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma2_y : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma2_k0 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k1 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(6,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k2 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k3 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k4 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k5 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k6 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k7 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k8 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k9 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k10 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k11 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k12 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(3,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k13 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k14 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k15 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k16 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k17 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k18 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k19 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k20 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k21 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k22 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k23 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k24 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k25 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k26 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k27 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k28 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k29 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k30 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_k31 : u0_m0_wo0_cma0_k0type := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u1_m0_wo0_cma2_s : u0_m0_wo0_cma0_utype;
    signal u1_m0_wo0_cma2_qq : STD_LOGIC_VECTOR (23 downto 0);
    signal u1_m0_wo0_cma2_q : STD_LOGIC_VECTOR (23 downto 0);
    signal u1_m0_wo0_mtree_add0_0_a : STD_LOGIC_VECTOR (22 downto 0);
    signal u1_m0_wo0_mtree_add0_0_b : STD_LOGIC_VECTOR (22 downto 0);
    signal u1_m0_wo0_mtree_add0_0_o : STD_LOGIC_VECTOR (22 downto 0);
    signal u1_m0_wo0_mtree_add0_0_q : STD_LOGIC_VECTOR (22 downto 0);
    signal u1_m0_wo0_mtree_add1_0_a : STD_LOGIC_VECTOR (23 downto 0);
    signal u1_m0_wo0_mtree_add1_0_b : STD_LOGIC_VECTOR (23 downto 0);
    signal u1_m0_wo0_mtree_add1_0_o : STD_LOGIC_VECTOR (23 downto 0);
    signal u1_m0_wo0_mtree_add1_0_q : STD_LOGIC_VECTOR (23 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr32_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr32_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr32_rdcnt_eq : std_logic;
    attribute preserve of u0_m0_wo0_wi0_r0_delayr32_rdcnt_eq : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr32_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr32_sticky_ena_q : signal is true;
    signal u1_m0_wo0_wi0_r0_delayr32_mem_reset0 : std_logic;
    signal u1_m0_wo0_wi0_r0_delayr32_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve of u1_m0_wo0_wi0_r0_delayr32_rdcnt_i : signal is true;
    signal u1_m0_wo0_wi0_r0_delayr32_rdcnt_eq : std_logic;
    attribute preserve of u1_m0_wo0_wi0_r0_delayr32_rdcnt_eq : signal is true;
    signal u1_m0_wo0_wi0_r0_delayr32_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve of u1_m0_wo0_wi0_r0_delayr32_sticky_ena_q : signal is true;
    signal input_valid_a : STD_LOGIC_VECTOR (0 downto 0);
    signal input_valid_b : STD_LOGIC_VECTOR (0 downto 0);
    signal input_valid_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_rdmux_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_cmp_a : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_notEnable_a : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_nor_a : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_nor_b : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_enaAnd_a : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_enaAnd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_rdmux_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_cmp_a : STD_LOGIC_VECTOR (5 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_notEnable_a : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_nor_a : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_nor_b : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_enaAnd_a : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_enaAnd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal u1_m0_wo0_wi0_r0_delayr32_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal out0_m0_wo0_lineup_select_delay_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_split32_in : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_split32_b : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_r0_split32_c : STD_LOGIC_VECTOR (7 downto 0);
    signal u1_m0_wo0_wi0_r0_split32_in : STD_LOGIC_VECTOR (15 downto 0);
    signal u1_m0_wo0_wi0_r0_split32_b : STD_LOGIC_VECTOR (7 downto 0);
    signal u1_m0_wo0_wi0_r0_split32_c : STD_LOGIC_VECTOR (7 downto 0);
    signal out0_m0_wo0_assign_id5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_join32_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u1_m0_wo0_wi0_r0_join32_q : STD_LOGIC_VECTOR (15 downto 0);

begin


    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- u1_m0_wo0_wi0_r0_delayr32_notEnable(LOGICAL,457)@10
    u1_m0_wo0_wi0_r0_delayr32_notEnable_a <= STD_LOGIC_VECTOR(input_valid_q);
    u1_m0_wo0_wi0_r0_delayr32_notEnable_q <= not (u1_m0_wo0_wi0_r0_delayr32_notEnable_a);

    -- u1_m0_wo0_wi0_r0_delayr32_nor(LOGICAL,458)@10
    u1_m0_wo0_wi0_r0_delayr32_nor_a <= STD_LOGIC_VECTOR(u1_m0_wo0_wi0_r0_delayr32_notEnable_q);
    u1_m0_wo0_wi0_r0_delayr32_nor_b <= STD_LOGIC_VECTOR(u1_m0_wo0_wi0_r0_delayr32_sticky_ena_q);
    u1_m0_wo0_wi0_r0_delayr32_nor_q <= not (u1_m0_wo0_wi0_r0_delayr32_nor_a or u1_m0_wo0_wi0_r0_delayr32_nor_b);

    -- u1_m0_wo0_wi0_r0_delayr32_mem_last(CONSTANT,454)
    u1_m0_wo0_wi0_r0_delayr32_mem_last_q <= "011101";

    -- u1_m0_wo0_wi0_r0_delayr32_cmp(LOGICAL,455)@10
    u1_m0_wo0_wi0_r0_delayr32_cmp_a <= u1_m0_wo0_wi0_r0_delayr32_mem_last_q;
    u1_m0_wo0_wi0_r0_delayr32_cmp_b <= STD_LOGIC_VECTOR("0" & u1_m0_wo0_wi0_r0_delayr32_rdmux_q);
    u1_m0_wo0_wi0_r0_delayr32_cmp_q <= "1" WHEN u1_m0_wo0_wi0_r0_delayr32_cmp_a = u1_m0_wo0_wi0_r0_delayr32_cmp_b ELSE "0";

    -- u1_m0_wo0_wi0_r0_delayr32_cmpReg(REG,456)@10 + 1
    u1_m0_wo0_wi0_r0_delayr32_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u1_m0_wo0_wi0_r0_delayr32_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (input_valid_q = "1") THEN
                u1_m0_wo0_wi0_r0_delayr32_cmpReg_q <= STD_LOGIC_VECTOR(u1_m0_wo0_wi0_r0_delayr32_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- u1_m0_wo0_wi0_r0_delayr32_sticky_ena(REG,459)@10 + 1
    u1_m0_wo0_wi0_r0_delayr32_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u1_m0_wo0_wi0_r0_delayr32_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u1_m0_wo0_wi0_r0_delayr32_nor_q = "1") THEN
                u1_m0_wo0_wi0_r0_delayr32_sticky_ena_q <= STD_LOGIC_VECTOR(u1_m0_wo0_wi0_r0_delayr32_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u1_m0_wo0_wi0_r0_delayr32_enaAnd(LOGICAL,460)@10
    u1_m0_wo0_wi0_r0_delayr32_enaAnd_a <= STD_LOGIC_VECTOR(u1_m0_wo0_wi0_r0_delayr32_sticky_ena_q);
    u1_m0_wo0_wi0_r0_delayr32_enaAnd_b <= STD_LOGIC_VECTOR(input_valid_q);
    u1_m0_wo0_wi0_r0_delayr32_enaAnd_q <= u1_m0_wo0_wi0_r0_delayr32_enaAnd_a and u1_m0_wo0_wi0_r0_delayr32_enaAnd_b;

    -- u1_m0_wo0_wi0_r0_delayr32_rdcnt(COUNTER,451)@10 + 1
    -- low=0, high=30, step=1, init=0
    u1_m0_wo0_wi0_r0_delayr32_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u1_m0_wo0_wi0_r0_delayr32_rdcnt_i <= TO_UNSIGNED(0, 5);
            u1_m0_wo0_wi0_r0_delayr32_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (input_valid_q = "1") THEN
                IF (u1_m0_wo0_wi0_r0_delayr32_rdcnt_i = TO_UNSIGNED(29, 5)) THEN
                    u1_m0_wo0_wi0_r0_delayr32_rdcnt_eq <= '1';
                ELSE
                    u1_m0_wo0_wi0_r0_delayr32_rdcnt_eq <= '0';
                END IF;
                IF (u1_m0_wo0_wi0_r0_delayr32_rdcnt_eq = '1') THEN
                    u1_m0_wo0_wi0_r0_delayr32_rdcnt_i <= u1_m0_wo0_wi0_r0_delayr32_rdcnt_i + 2;
                ELSE
                    u1_m0_wo0_wi0_r0_delayr32_rdcnt_i <= u1_m0_wo0_wi0_r0_delayr32_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u1_m0_wo0_wi0_r0_delayr32_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u1_m0_wo0_wi0_r0_delayr32_rdcnt_i, 5)));

    -- u1_m0_wo0_wi0_r0_delayr32_rdmux(MUX,452)@10
    u1_m0_wo0_wi0_r0_delayr32_rdmux_s <= input_valid_q;
    u1_m0_wo0_wi0_r0_delayr32_rdmux_combproc: PROCESS (u1_m0_wo0_wi0_r0_delayr32_rdmux_s, u1_m0_wo0_wi0_r0_delayr32_wraddr_q, u1_m0_wo0_wi0_r0_delayr32_rdcnt_q)
    BEGIN
        CASE (u1_m0_wo0_wi0_r0_delayr32_rdmux_s) IS
            WHEN "0" => u1_m0_wo0_wi0_r0_delayr32_rdmux_q <= u1_m0_wo0_wi0_r0_delayr32_wraddr_q;
            WHEN "1" => u1_m0_wo0_wi0_r0_delayr32_rdmux_q <= u1_m0_wo0_wi0_r0_delayr32_rdcnt_q;
            WHEN OTHERS => u1_m0_wo0_wi0_r0_delayr32_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- xIn(PORTIN,2)@10

    -- u1_m0_wo0_wi0_r0_join32(BITJOIN,254)@10
    u1_m0_wo0_wi0_r0_join32_q <= u1_m0_wo0_wi0_r0_split32_b & xIn_1;

    -- input_valid(LOGICAL,3)@10
    input_valid_a <= STD_LOGIC_VECTOR(xIn_v);
    input_valid_b <= STD_LOGIC_VECTOR(enable_i);
    input_valid_q <= input_valid_a and input_valid_b;

    -- u1_m0_wo0_wi0_r0_delayr32_wraddr(REG,453)@10 + 1
    u1_m0_wo0_wi0_r0_delayr32_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u1_m0_wo0_wi0_r0_delayr32_wraddr_q <= "11110";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u1_m0_wo0_wi0_r0_delayr32_wraddr_q <= STD_LOGIC_VECTOR(u1_m0_wo0_wi0_r0_delayr32_rdmux_q);
        END IF;
    END PROCESS;

    -- u1_m0_wo0_wi0_r0_delayr32_mem(DUALMEM,450)@10 + 2
    u1_m0_wo0_wi0_r0_delayr32_mem_ia <= STD_LOGIC_VECTOR(u1_m0_wo0_wi0_r0_join32_q);
    u1_m0_wo0_wi0_r0_delayr32_mem_aa <= u1_m0_wo0_wi0_r0_delayr32_wraddr_q;
    u1_m0_wo0_wi0_r0_delayr32_mem_ab <= u1_m0_wo0_wi0_r0_delayr32_rdmux_q;
    u1_m0_wo0_wi0_r0_delayr32_mem_reset0 <= areset;
    u1_m0_wo0_wi0_r0_delayr32_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 5,
        numwords_a => 31,
        width_b => 16,
        widthad_b => 5,
        numwords_b => 31,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u1_m0_wo0_wi0_r0_delayr32_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u1_m0_wo0_wi0_r0_delayr32_mem_reset0,
        clock1 => clk,
        address_a => u1_m0_wo0_wi0_r0_delayr32_mem_aa,
        data_a => u1_m0_wo0_wi0_r0_delayr32_mem_ia,
        wren_a => input_valid_q(0),
        address_b => u1_m0_wo0_wi0_r0_delayr32_mem_ab,
        q_b => u1_m0_wo0_wi0_r0_delayr32_mem_iq
    );
    u1_m0_wo0_wi0_r0_delayr32_mem_q <= u1_m0_wo0_wi0_r0_delayr32_mem_iq(15 downto 0);

    -- u1_m0_wo0_wi0_r0_split32(BITSELECT,255)@10
    u1_m0_wo0_wi0_r0_split32_in <= STD_LOGIC_VECTOR(u1_m0_wo0_wi0_r0_delayr32_mem_q);
    u1_m0_wo0_wi0_r0_split32_b <= STD_LOGIC_VECTOR(u1_m0_wo0_wi0_r0_split32_in(7 downto 0));
    u1_m0_wo0_wi0_r0_split32_c <= STD_LOGIC_VECTOR(u1_m0_wo0_wi0_r0_split32_in(15 downto 8));

    -- d_u1_m0_wo0_wi0_r0_split32_c_11(DELAY,438)@10 + 1
    d_u1_m0_wo0_wi0_r0_split32_c_11 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u1_m0_wo0_wi0_r0_split32_c, xout => d_u1_m0_wo0_wi0_r0_split32_c_11_q, clk => clk, aclr => areset );

    -- d_u1_m0_wo0_compute_q_12(DELAY,437)@11 + 1
    d_u1_m0_wo0_compute_q_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u1_m0_wo0_compute_q_11_q, xout => d_u1_m0_wo0_compute_q_12_q, clk => clk, aclr => areset );

    -- d_u1_m0_wo0_compute_q_11(DELAY,436)@10 + 1
    d_u1_m0_wo0_compute_q_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => input_valid_q, xout => d_u1_m0_wo0_compute_q_11_q, clk => clk, aclr => areset );

    -- u1_m0_wo0_cma2(CHAINMULTADD,417)@11 + 2
    -- altera synthesis_off
    u1_m0_wo0_cma2_k0 <= (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k1 <= (
        0 => TO_SIGNED(6,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k2 <= (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k3 <= (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k4 <= (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k5 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k6 <= (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k7 <= (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k8 <= (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k9 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k10 <= (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k11 <= (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k12 <= (
        0 => TO_SIGNED(3,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k13 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k14 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k15 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k16 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k17 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k18 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k19 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k20 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k21 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k22 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k23 <= (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k24 <= (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k25 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k26 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k27 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k28 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k29 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k30 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma2_k31 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    -- altera synthesis_on
    u1_m0_wo0_cma2_r(0) <= u1_m0_wo0_cma2_k0(TO_INTEGER(u1_m0_wo0_cma2_c0(0)));
    u1_m0_wo0_cma2_r(1) <= u1_m0_wo0_cma2_k1(TO_INTEGER(u1_m0_wo0_cma2_c0(1)));
    u1_m0_wo0_cma2_r(2) <= u1_m0_wo0_cma2_k2(TO_INTEGER(u1_m0_wo0_cma2_c0(2)));
    u1_m0_wo0_cma2_r(3) <= u1_m0_wo0_cma2_k3(TO_INTEGER(u1_m0_wo0_cma2_c0(3)));
    u1_m0_wo0_cma2_r(4) <= u1_m0_wo0_cma2_k4(TO_INTEGER(u1_m0_wo0_cma2_c0(4)));
    u1_m0_wo0_cma2_r(5) <= u1_m0_wo0_cma2_k5(TO_INTEGER(u1_m0_wo0_cma2_c0(5)));
    u1_m0_wo0_cma2_r(6) <= u1_m0_wo0_cma2_k6(TO_INTEGER(u1_m0_wo0_cma2_c0(6)));
    u1_m0_wo0_cma2_r(7) <= u1_m0_wo0_cma2_k7(TO_INTEGER(u1_m0_wo0_cma2_c0(7)));
    u1_m0_wo0_cma2_r(8) <= u1_m0_wo0_cma2_k8(TO_INTEGER(u1_m0_wo0_cma2_c0(8)));
    u1_m0_wo0_cma2_r(9) <= u1_m0_wo0_cma2_k9(TO_INTEGER(u1_m0_wo0_cma2_c0(9)));
    u1_m0_wo0_cma2_r(10) <= u1_m0_wo0_cma2_k10(TO_INTEGER(u1_m0_wo0_cma2_c0(10)));
    u1_m0_wo0_cma2_r(11) <= u1_m0_wo0_cma2_k11(TO_INTEGER(u1_m0_wo0_cma2_c0(11)));
    u1_m0_wo0_cma2_r(12) <= u1_m0_wo0_cma2_k12(TO_INTEGER(u1_m0_wo0_cma2_c0(12)));
    u1_m0_wo0_cma2_r(13) <= u1_m0_wo0_cma2_k13(TO_INTEGER(u1_m0_wo0_cma2_c0(13)));
    u1_m0_wo0_cma2_r(14) <= u1_m0_wo0_cma2_k14(TO_INTEGER(u1_m0_wo0_cma2_c0(14)));
    u1_m0_wo0_cma2_r(15) <= u1_m0_wo0_cma2_k15(TO_INTEGER(u1_m0_wo0_cma2_c0(15)));
    u1_m0_wo0_cma2_r(16) <= u1_m0_wo0_cma2_k16(TO_INTEGER(u1_m0_wo0_cma2_c0(16)));
    u1_m0_wo0_cma2_r(17) <= u1_m0_wo0_cma2_k17(TO_INTEGER(u1_m0_wo0_cma2_c0(17)));
    u1_m0_wo0_cma2_r(18) <= u1_m0_wo0_cma2_k18(TO_INTEGER(u1_m0_wo0_cma2_c0(18)));
    u1_m0_wo0_cma2_r(19) <= u1_m0_wo0_cma2_k19(TO_INTEGER(u1_m0_wo0_cma2_c0(19)));
    u1_m0_wo0_cma2_r(20) <= u1_m0_wo0_cma2_k20(TO_INTEGER(u1_m0_wo0_cma2_c0(20)));
    u1_m0_wo0_cma2_r(21) <= u1_m0_wo0_cma2_k21(TO_INTEGER(u1_m0_wo0_cma2_c0(21)));
    u1_m0_wo0_cma2_r(22) <= u1_m0_wo0_cma2_k22(TO_INTEGER(u1_m0_wo0_cma2_c0(22)));
    u1_m0_wo0_cma2_r(23) <= u1_m0_wo0_cma2_k23(TO_INTEGER(u1_m0_wo0_cma2_c0(23)));
    u1_m0_wo0_cma2_r(24) <= u1_m0_wo0_cma2_k24(TO_INTEGER(u1_m0_wo0_cma2_c0(24)));
    u1_m0_wo0_cma2_r(25) <= u1_m0_wo0_cma2_k25(TO_INTEGER(u1_m0_wo0_cma2_c0(25)));
    u1_m0_wo0_cma2_r(26) <= u1_m0_wo0_cma2_k26(TO_INTEGER(u1_m0_wo0_cma2_c0(26)));
    u1_m0_wo0_cma2_r(27) <= u1_m0_wo0_cma2_k27(TO_INTEGER(u1_m0_wo0_cma2_c0(27)));
    u1_m0_wo0_cma2_r(28) <= u1_m0_wo0_cma2_k28(TO_INTEGER(u1_m0_wo0_cma2_c0(28)));
    u1_m0_wo0_cma2_r(29) <= u1_m0_wo0_cma2_k29(TO_INTEGER(u1_m0_wo0_cma2_c0(29)));
    u1_m0_wo0_cma2_r(30) <= u1_m0_wo0_cma2_k30(TO_INTEGER(u1_m0_wo0_cma2_c0(30)));
    u1_m0_wo0_cma2_r(31) <= u1_m0_wo0_cma2_k31(TO_INTEGER(u1_m0_wo0_cma2_c0(31)));
    u1_m0_wo0_cma2_p(0) <= u1_m0_wo0_cma2_a0(0) * u1_m0_wo0_cma2_r(0);
    u1_m0_wo0_cma2_p(1) <= u1_m0_wo0_cma2_a0(1) * u1_m0_wo0_cma2_r(1);
    u1_m0_wo0_cma2_p(2) <= u1_m0_wo0_cma2_a0(2) * u1_m0_wo0_cma2_r(2);
    u1_m0_wo0_cma2_p(3) <= u1_m0_wo0_cma2_a0(3) * u1_m0_wo0_cma2_r(3);
    u1_m0_wo0_cma2_p(4) <= u1_m0_wo0_cma2_a0(4) * u1_m0_wo0_cma2_r(4);
    u1_m0_wo0_cma2_p(5) <= u1_m0_wo0_cma2_a0(5) * u1_m0_wo0_cma2_r(5);
    u1_m0_wo0_cma2_p(6) <= u1_m0_wo0_cma2_a0(6) * u1_m0_wo0_cma2_r(6);
    u1_m0_wo0_cma2_p(7) <= u1_m0_wo0_cma2_a0(7) * u1_m0_wo0_cma2_r(7);
    u1_m0_wo0_cma2_p(8) <= u1_m0_wo0_cma2_a0(8) * u1_m0_wo0_cma2_r(8);
    u1_m0_wo0_cma2_p(9) <= u1_m0_wo0_cma2_a0(9) * u1_m0_wo0_cma2_r(9);
    u1_m0_wo0_cma2_p(10) <= u1_m0_wo0_cma2_a0(10) * u1_m0_wo0_cma2_r(10);
    u1_m0_wo0_cma2_p(11) <= u1_m0_wo0_cma2_a0(11) * u1_m0_wo0_cma2_r(11);
    u1_m0_wo0_cma2_p(12) <= u1_m0_wo0_cma2_a0(12) * u1_m0_wo0_cma2_r(12);
    u1_m0_wo0_cma2_p(13) <= u1_m0_wo0_cma2_a0(13) * u1_m0_wo0_cma2_r(13);
    u1_m0_wo0_cma2_p(14) <= u1_m0_wo0_cma2_a0(14) * u1_m0_wo0_cma2_r(14);
    u1_m0_wo0_cma2_p(15) <= u1_m0_wo0_cma2_a0(15) * u1_m0_wo0_cma2_r(15);
    u1_m0_wo0_cma2_p(16) <= u1_m0_wo0_cma2_a0(16) * u1_m0_wo0_cma2_r(16);
    u1_m0_wo0_cma2_p(17) <= u1_m0_wo0_cma2_a0(17) * u1_m0_wo0_cma2_r(17);
    u1_m0_wo0_cma2_p(18) <= u1_m0_wo0_cma2_a0(18) * u1_m0_wo0_cma2_r(18);
    u1_m0_wo0_cma2_p(19) <= u1_m0_wo0_cma2_a0(19) * u1_m0_wo0_cma2_r(19);
    u1_m0_wo0_cma2_p(20) <= u1_m0_wo0_cma2_a0(20) * u1_m0_wo0_cma2_r(20);
    u1_m0_wo0_cma2_p(21) <= u1_m0_wo0_cma2_a0(21) * u1_m0_wo0_cma2_r(21);
    u1_m0_wo0_cma2_p(22) <= u1_m0_wo0_cma2_a0(22) * u1_m0_wo0_cma2_r(22);
    u1_m0_wo0_cma2_p(23) <= u1_m0_wo0_cma2_a0(23) * u1_m0_wo0_cma2_r(23);
    u1_m0_wo0_cma2_p(24) <= u1_m0_wo0_cma2_a0(24) * u1_m0_wo0_cma2_r(24);
    u1_m0_wo0_cma2_p(25) <= u1_m0_wo0_cma2_a0(25) * u1_m0_wo0_cma2_r(25);
    u1_m0_wo0_cma2_p(26) <= u1_m0_wo0_cma2_a0(26) * u1_m0_wo0_cma2_r(26);
    u1_m0_wo0_cma2_p(27) <= u1_m0_wo0_cma2_a0(27) * u1_m0_wo0_cma2_r(27);
    u1_m0_wo0_cma2_p(28) <= u1_m0_wo0_cma2_a0(28) * u1_m0_wo0_cma2_r(28);
    u1_m0_wo0_cma2_p(29) <= u1_m0_wo0_cma2_a0(29) * u1_m0_wo0_cma2_r(29);
    u1_m0_wo0_cma2_p(30) <= u1_m0_wo0_cma2_a0(30) * u1_m0_wo0_cma2_r(30);
    u1_m0_wo0_cma2_p(31) <= u1_m0_wo0_cma2_a0(31) * u1_m0_wo0_cma2_r(31);
    u1_m0_wo0_cma2_u(0) <= RESIZE(u1_m0_wo0_cma2_p(0),24);
    u1_m0_wo0_cma2_u(1) <= RESIZE(u1_m0_wo0_cma2_p(1),24);
    u1_m0_wo0_cma2_u(2) <= RESIZE(u1_m0_wo0_cma2_p(2),24);
    u1_m0_wo0_cma2_u(3) <= RESIZE(u1_m0_wo0_cma2_p(3),24);
    u1_m0_wo0_cma2_u(4) <= RESIZE(u1_m0_wo0_cma2_p(4),24);
    u1_m0_wo0_cma2_u(5) <= RESIZE(u1_m0_wo0_cma2_p(5),24);
    u1_m0_wo0_cma2_u(6) <= RESIZE(u1_m0_wo0_cma2_p(6),24);
    u1_m0_wo0_cma2_u(7) <= RESIZE(u1_m0_wo0_cma2_p(7),24);
    u1_m0_wo0_cma2_u(8) <= RESIZE(u1_m0_wo0_cma2_p(8),24);
    u1_m0_wo0_cma2_u(9) <= RESIZE(u1_m0_wo0_cma2_p(9),24);
    u1_m0_wo0_cma2_u(10) <= RESIZE(u1_m0_wo0_cma2_p(10),24);
    u1_m0_wo0_cma2_u(11) <= RESIZE(u1_m0_wo0_cma2_p(11),24);
    u1_m0_wo0_cma2_u(12) <= RESIZE(u1_m0_wo0_cma2_p(12),24);
    u1_m0_wo0_cma2_u(13) <= RESIZE(u1_m0_wo0_cma2_p(13),24);
    u1_m0_wo0_cma2_u(14) <= RESIZE(u1_m0_wo0_cma2_p(14),24);
    u1_m0_wo0_cma2_u(15) <= RESIZE(u1_m0_wo0_cma2_p(15),24);
    u1_m0_wo0_cma2_u(16) <= RESIZE(u1_m0_wo0_cma2_p(16),24);
    u1_m0_wo0_cma2_u(17) <= RESIZE(u1_m0_wo0_cma2_p(17),24);
    u1_m0_wo0_cma2_u(18) <= RESIZE(u1_m0_wo0_cma2_p(18),24);
    u1_m0_wo0_cma2_u(19) <= RESIZE(u1_m0_wo0_cma2_p(19),24);
    u1_m0_wo0_cma2_u(20) <= RESIZE(u1_m0_wo0_cma2_p(20),24);
    u1_m0_wo0_cma2_u(21) <= RESIZE(u1_m0_wo0_cma2_p(21),24);
    u1_m0_wo0_cma2_u(22) <= RESIZE(u1_m0_wo0_cma2_p(22),24);
    u1_m0_wo0_cma2_u(23) <= RESIZE(u1_m0_wo0_cma2_p(23),24);
    u1_m0_wo0_cma2_u(24) <= RESIZE(u1_m0_wo0_cma2_p(24),24);
    u1_m0_wo0_cma2_u(25) <= RESIZE(u1_m0_wo0_cma2_p(25),24);
    u1_m0_wo0_cma2_u(26) <= RESIZE(u1_m0_wo0_cma2_p(26),24);
    u1_m0_wo0_cma2_u(27) <= RESIZE(u1_m0_wo0_cma2_p(27),24);
    u1_m0_wo0_cma2_u(28) <= RESIZE(u1_m0_wo0_cma2_p(28),24);
    u1_m0_wo0_cma2_u(29) <= RESIZE(u1_m0_wo0_cma2_p(29),24);
    u1_m0_wo0_cma2_u(30) <= RESIZE(u1_m0_wo0_cma2_p(30),24);
    u1_m0_wo0_cma2_u(31) <= RESIZE(u1_m0_wo0_cma2_p(31),24);
    u1_m0_wo0_cma2_w(0) <= u1_m0_wo0_cma2_u(0);
    u1_m0_wo0_cma2_w(1) <= u1_m0_wo0_cma2_u(1);
    u1_m0_wo0_cma2_w(2) <= u1_m0_wo0_cma2_u(2);
    u1_m0_wo0_cma2_w(3) <= u1_m0_wo0_cma2_u(3);
    u1_m0_wo0_cma2_w(4) <= u1_m0_wo0_cma2_u(4);
    u1_m0_wo0_cma2_w(5) <= u1_m0_wo0_cma2_u(5);
    u1_m0_wo0_cma2_w(6) <= u1_m0_wo0_cma2_u(6);
    u1_m0_wo0_cma2_w(7) <= u1_m0_wo0_cma2_u(7);
    u1_m0_wo0_cma2_w(8) <= u1_m0_wo0_cma2_u(8);
    u1_m0_wo0_cma2_w(9) <= u1_m0_wo0_cma2_u(9);
    u1_m0_wo0_cma2_w(10) <= u1_m0_wo0_cma2_u(10);
    u1_m0_wo0_cma2_w(11) <= u1_m0_wo0_cma2_u(11);
    u1_m0_wo0_cma2_w(12) <= u1_m0_wo0_cma2_u(12);
    u1_m0_wo0_cma2_w(13) <= u1_m0_wo0_cma2_u(13);
    u1_m0_wo0_cma2_w(14) <= u1_m0_wo0_cma2_u(14);
    u1_m0_wo0_cma2_w(15) <= u1_m0_wo0_cma2_u(15);
    u1_m0_wo0_cma2_w(16) <= u1_m0_wo0_cma2_u(16);
    u1_m0_wo0_cma2_w(17) <= u1_m0_wo0_cma2_u(17);
    u1_m0_wo0_cma2_w(18) <= u1_m0_wo0_cma2_u(18);
    u1_m0_wo0_cma2_w(19) <= u1_m0_wo0_cma2_u(19);
    u1_m0_wo0_cma2_w(20) <= u1_m0_wo0_cma2_u(20);
    u1_m0_wo0_cma2_w(21) <= u1_m0_wo0_cma2_u(21);
    u1_m0_wo0_cma2_w(22) <= u1_m0_wo0_cma2_u(22);
    u1_m0_wo0_cma2_w(23) <= u1_m0_wo0_cma2_u(23);
    u1_m0_wo0_cma2_w(24) <= u1_m0_wo0_cma2_u(24);
    u1_m0_wo0_cma2_w(25) <= u1_m0_wo0_cma2_u(25);
    u1_m0_wo0_cma2_w(26) <= u1_m0_wo0_cma2_u(26);
    u1_m0_wo0_cma2_w(27) <= u1_m0_wo0_cma2_u(27);
    u1_m0_wo0_cma2_w(28) <= u1_m0_wo0_cma2_u(28);
    u1_m0_wo0_cma2_w(29) <= u1_m0_wo0_cma2_u(29);
    u1_m0_wo0_cma2_w(30) <= u1_m0_wo0_cma2_u(30);
    u1_m0_wo0_cma2_w(31) <= u1_m0_wo0_cma2_u(31);
    u1_m0_wo0_cma2_x(0) <= u1_m0_wo0_cma2_w(0);
    u1_m0_wo0_cma2_x(1) <= u1_m0_wo0_cma2_w(1);
    u1_m0_wo0_cma2_x(2) <= u1_m0_wo0_cma2_w(2);
    u1_m0_wo0_cma2_x(3) <= u1_m0_wo0_cma2_w(3);
    u1_m0_wo0_cma2_x(4) <= u1_m0_wo0_cma2_w(4);
    u1_m0_wo0_cma2_x(5) <= u1_m0_wo0_cma2_w(5);
    u1_m0_wo0_cma2_x(6) <= u1_m0_wo0_cma2_w(6);
    u1_m0_wo0_cma2_x(7) <= u1_m0_wo0_cma2_w(7);
    u1_m0_wo0_cma2_x(8) <= u1_m0_wo0_cma2_w(8);
    u1_m0_wo0_cma2_x(9) <= u1_m0_wo0_cma2_w(9);
    u1_m0_wo0_cma2_x(10) <= u1_m0_wo0_cma2_w(10);
    u1_m0_wo0_cma2_x(11) <= u1_m0_wo0_cma2_w(11);
    u1_m0_wo0_cma2_x(12) <= u1_m0_wo0_cma2_w(12);
    u1_m0_wo0_cma2_x(13) <= u1_m0_wo0_cma2_w(13);
    u1_m0_wo0_cma2_x(14) <= u1_m0_wo0_cma2_w(14);
    u1_m0_wo0_cma2_x(15) <= u1_m0_wo0_cma2_w(15);
    u1_m0_wo0_cma2_x(16) <= u1_m0_wo0_cma2_w(16);
    u1_m0_wo0_cma2_x(17) <= u1_m0_wo0_cma2_w(17);
    u1_m0_wo0_cma2_x(18) <= u1_m0_wo0_cma2_w(18);
    u1_m0_wo0_cma2_x(19) <= u1_m0_wo0_cma2_w(19);
    u1_m0_wo0_cma2_x(20) <= u1_m0_wo0_cma2_w(20);
    u1_m0_wo0_cma2_x(21) <= u1_m0_wo0_cma2_w(21);
    u1_m0_wo0_cma2_x(22) <= u1_m0_wo0_cma2_w(22);
    u1_m0_wo0_cma2_x(23) <= u1_m0_wo0_cma2_w(23);
    u1_m0_wo0_cma2_x(24) <= u1_m0_wo0_cma2_w(24);
    u1_m0_wo0_cma2_x(25) <= u1_m0_wo0_cma2_w(25);
    u1_m0_wo0_cma2_x(26) <= u1_m0_wo0_cma2_w(26);
    u1_m0_wo0_cma2_x(27) <= u1_m0_wo0_cma2_w(27);
    u1_m0_wo0_cma2_x(28) <= u1_m0_wo0_cma2_w(28);
    u1_m0_wo0_cma2_x(29) <= u1_m0_wo0_cma2_w(29);
    u1_m0_wo0_cma2_x(30) <= u1_m0_wo0_cma2_w(30);
    u1_m0_wo0_cma2_x(31) <= u1_m0_wo0_cma2_w(31);
    u1_m0_wo0_cma2_y(0) <= u1_m0_wo0_cma2_s(1) + u1_m0_wo0_cma2_x(0);
    u1_m0_wo0_cma2_y(1) <= u1_m0_wo0_cma2_s(2) + u1_m0_wo0_cma2_x(1);
    u1_m0_wo0_cma2_y(2) <= u1_m0_wo0_cma2_s(3) + u1_m0_wo0_cma2_x(2);
    u1_m0_wo0_cma2_y(3) <= u1_m0_wo0_cma2_s(4) + u1_m0_wo0_cma2_x(3);
    u1_m0_wo0_cma2_y(4) <= u1_m0_wo0_cma2_s(5) + u1_m0_wo0_cma2_x(4);
    u1_m0_wo0_cma2_y(5) <= u1_m0_wo0_cma2_s(6) + u1_m0_wo0_cma2_x(5);
    u1_m0_wo0_cma2_y(6) <= u1_m0_wo0_cma2_s(7) + u1_m0_wo0_cma2_x(6);
    u1_m0_wo0_cma2_y(7) <= u1_m0_wo0_cma2_s(8) + u1_m0_wo0_cma2_x(7);
    u1_m0_wo0_cma2_y(8) <= u1_m0_wo0_cma2_s(9) + u1_m0_wo0_cma2_x(8);
    u1_m0_wo0_cma2_y(9) <= u1_m0_wo0_cma2_s(10) + u1_m0_wo0_cma2_x(9);
    u1_m0_wo0_cma2_y(10) <= u1_m0_wo0_cma2_s(11) + u1_m0_wo0_cma2_x(10);
    u1_m0_wo0_cma2_y(11) <= u1_m0_wo0_cma2_s(12) + u1_m0_wo0_cma2_x(11);
    u1_m0_wo0_cma2_y(12) <= u1_m0_wo0_cma2_s(13) + u1_m0_wo0_cma2_x(12);
    u1_m0_wo0_cma2_y(13) <= u1_m0_wo0_cma2_s(14) + u1_m0_wo0_cma2_x(13);
    u1_m0_wo0_cma2_y(14) <= u1_m0_wo0_cma2_s(15) + u1_m0_wo0_cma2_x(14);
    u1_m0_wo0_cma2_y(15) <= u1_m0_wo0_cma2_s(16) + u1_m0_wo0_cma2_x(15);
    u1_m0_wo0_cma2_y(16) <= u1_m0_wo0_cma2_s(17) + u1_m0_wo0_cma2_x(16);
    u1_m0_wo0_cma2_y(17) <= u1_m0_wo0_cma2_s(18) + u1_m0_wo0_cma2_x(17);
    u1_m0_wo0_cma2_y(18) <= u1_m0_wo0_cma2_s(19) + u1_m0_wo0_cma2_x(18);
    u1_m0_wo0_cma2_y(19) <= u1_m0_wo0_cma2_s(20) + u1_m0_wo0_cma2_x(19);
    u1_m0_wo0_cma2_y(20) <= u1_m0_wo0_cma2_s(21) + u1_m0_wo0_cma2_x(20);
    u1_m0_wo0_cma2_y(21) <= u1_m0_wo0_cma2_s(22) + u1_m0_wo0_cma2_x(21);
    u1_m0_wo0_cma2_y(22) <= u1_m0_wo0_cma2_s(23) + u1_m0_wo0_cma2_x(22);
    u1_m0_wo0_cma2_y(23) <= u1_m0_wo0_cma2_s(24) + u1_m0_wo0_cma2_x(23);
    u1_m0_wo0_cma2_y(24) <= u1_m0_wo0_cma2_s(25) + u1_m0_wo0_cma2_x(24);
    u1_m0_wo0_cma2_y(25) <= u1_m0_wo0_cma2_s(26) + u1_m0_wo0_cma2_x(25);
    u1_m0_wo0_cma2_y(26) <= u1_m0_wo0_cma2_s(27) + u1_m0_wo0_cma2_x(26);
    u1_m0_wo0_cma2_y(27) <= u1_m0_wo0_cma2_s(28) + u1_m0_wo0_cma2_x(27);
    u1_m0_wo0_cma2_y(28) <= u1_m0_wo0_cma2_s(29) + u1_m0_wo0_cma2_x(28);
    u1_m0_wo0_cma2_y(29) <= u1_m0_wo0_cma2_s(30) + u1_m0_wo0_cma2_x(29);
    u1_m0_wo0_cma2_y(30) <= u1_m0_wo0_cma2_s(31) + u1_m0_wo0_cma2_x(30);
    u1_m0_wo0_cma2_y(31) <= u1_m0_wo0_cma2_x(31);
    u1_m0_wo0_cma2_chainmultadd: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u1_m0_wo0_cma2_a0 <= (others => (others => '0'));
            u1_m0_wo0_cma2_c0 <= (others => (others => '0'));
            u1_m0_wo0_cma2_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u1_m0_wo0_compute_q_11_q = "1") THEN
                u1_m0_wo0_cma2_a0(0) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(1) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(2) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(3) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(4) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(5) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(6) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(7) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(8) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(9) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(10) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(11) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(12) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(13) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(14) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(15) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(16) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(17) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(18) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(19) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(20) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(21) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(22) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(23) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(24) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(25) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(26) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(27) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(28) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(29) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(30) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_a0(31) <= RESIZE(SIGNED(d_u1_m0_wo0_wi0_r0_split32_c_11_q),8);
                u1_m0_wo0_cma2_c0(0) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(1) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(2) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(3) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(4) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(5) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(6) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(7) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(8) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(9) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(10) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(11) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(12) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(13) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(14) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(15) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(16) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(17) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(18) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(19) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(20) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(21) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(22) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(23) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(24) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(25) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(26) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(27) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(28) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(29) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(30) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma2_c0(31) <= RESIZE(UNSIGNED(GND_q),3);
            END IF;
            IF (d_u1_m0_wo0_compute_q_12_q = "1") THEN
                u1_m0_wo0_cma2_s(0) <= u1_m0_wo0_cma2_y(0);
                u1_m0_wo0_cma2_s(1) <= u1_m0_wo0_cma2_y(1);
                u1_m0_wo0_cma2_s(2) <= u1_m0_wo0_cma2_y(2);
                u1_m0_wo0_cma2_s(3) <= u1_m0_wo0_cma2_y(3);
                u1_m0_wo0_cma2_s(4) <= u1_m0_wo0_cma2_y(4);
                u1_m0_wo0_cma2_s(5) <= u1_m0_wo0_cma2_y(5);
                u1_m0_wo0_cma2_s(6) <= u1_m0_wo0_cma2_y(6);
                u1_m0_wo0_cma2_s(7) <= u1_m0_wo0_cma2_y(7);
                u1_m0_wo0_cma2_s(8) <= u1_m0_wo0_cma2_y(8);
                u1_m0_wo0_cma2_s(9) <= u1_m0_wo0_cma2_y(9);
                u1_m0_wo0_cma2_s(10) <= u1_m0_wo0_cma2_y(10);
                u1_m0_wo0_cma2_s(11) <= u1_m0_wo0_cma2_y(11);
                u1_m0_wo0_cma2_s(12) <= u1_m0_wo0_cma2_y(12);
                u1_m0_wo0_cma2_s(13) <= u1_m0_wo0_cma2_y(13);
                u1_m0_wo0_cma2_s(14) <= u1_m0_wo0_cma2_y(14);
                u1_m0_wo0_cma2_s(15) <= u1_m0_wo0_cma2_y(15);
                u1_m0_wo0_cma2_s(16) <= u1_m0_wo0_cma2_y(16);
                u1_m0_wo0_cma2_s(17) <= u1_m0_wo0_cma2_y(17);
                u1_m0_wo0_cma2_s(18) <= u1_m0_wo0_cma2_y(18);
                u1_m0_wo0_cma2_s(19) <= u1_m0_wo0_cma2_y(19);
                u1_m0_wo0_cma2_s(20) <= u1_m0_wo0_cma2_y(20);
                u1_m0_wo0_cma2_s(21) <= u1_m0_wo0_cma2_y(21);
                u1_m0_wo0_cma2_s(22) <= u1_m0_wo0_cma2_y(22);
                u1_m0_wo0_cma2_s(23) <= u1_m0_wo0_cma2_y(23);
                u1_m0_wo0_cma2_s(24) <= u1_m0_wo0_cma2_y(24);
                u1_m0_wo0_cma2_s(25) <= u1_m0_wo0_cma2_y(25);
                u1_m0_wo0_cma2_s(26) <= u1_m0_wo0_cma2_y(26);
                u1_m0_wo0_cma2_s(27) <= u1_m0_wo0_cma2_y(27);
                u1_m0_wo0_cma2_s(28) <= u1_m0_wo0_cma2_y(28);
                u1_m0_wo0_cma2_s(29) <= u1_m0_wo0_cma2_y(29);
                u1_m0_wo0_cma2_s(30) <= u1_m0_wo0_cma2_y(30);
                u1_m0_wo0_cma2_s(31) <= u1_m0_wo0_cma2_y(31);
            END IF;
        END IF;
    END PROCESS;
    u1_m0_wo0_cma2_delay : dspba_delay
    GENERIC MAP ( width => 24, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u1_m0_wo0_cma2_s(0)(23 downto 0)), xout => u1_m0_wo0_cma2_qq, clk => clk, aclr => areset );
    u1_m0_wo0_cma2_q <= STD_LOGIC_VECTOR(u1_m0_wo0_cma2_qq(23 downto 0));

    -- u1_m0_wo0_cma1(CHAINMULTADD,416)@10 + 2
    -- altera synthesis_off
    u1_m0_wo0_cma1_k0 <= (
        0 => TO_SIGNED(-14,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k1 <= (
        0 => TO_SIGNED(-19,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k2 <= (
        0 => TO_SIGNED(-12,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k3 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k4 <= (
        0 => TO_SIGNED(20,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k5 <= (
        0 => TO_SIGNED(29,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k6 <= (
        0 => TO_SIGNED(24,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k7 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k8 <= (
        0 => TO_SIGNED(-28,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k9 <= (
        0 => TO_SIGNED(-51,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k10 <= (
        0 => TO_SIGNED(-50,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k11 <= (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k12 <= (
        0 => TO_SIGNED(50,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k13 <= (
        0 => TO_SIGNED(133,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k14 <= (
        0 => TO_SIGNED(209,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k15 <= (
        0 => TO_SIGNED(255,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k16 <= (
        0 => TO_SIGNED(255,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k17 <= (
        0 => TO_SIGNED(209,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k18 <= (
        0 => TO_SIGNED(133,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k19 <= (
        0 => TO_SIGNED(50,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k20 <= (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k21 <= (
        0 => TO_SIGNED(-50,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k22 <= (
        0 => TO_SIGNED(-51,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k23 <= (
        0 => TO_SIGNED(-28,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k24 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k25 <= (
        0 => TO_SIGNED(24,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k26 <= (
        0 => TO_SIGNED(29,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k27 <= (
        0 => TO_SIGNED(20,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k28 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k29 <= (
        0 => TO_SIGNED(-12,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k30 <= (
        0 => TO_SIGNED(-19,11),
        others => (others => '0'));
    u1_m0_wo0_cma1_k31 <= (
        0 => TO_SIGNED(-14,11),
        others => (others => '0'));
    -- altera synthesis_on
    u1_m0_wo0_cma1_r(0) <= u1_m0_wo0_cma1_k0(TO_INTEGER(u1_m0_wo0_cma1_c0(0)));
    u1_m0_wo0_cma1_r(1) <= u1_m0_wo0_cma1_k1(TO_INTEGER(u1_m0_wo0_cma1_c0(1)));
    u1_m0_wo0_cma1_r(2) <= u1_m0_wo0_cma1_k2(TO_INTEGER(u1_m0_wo0_cma1_c0(2)));
    u1_m0_wo0_cma1_r(3) <= u1_m0_wo0_cma1_k3(TO_INTEGER(u1_m0_wo0_cma1_c0(3)));
    u1_m0_wo0_cma1_r(4) <= u1_m0_wo0_cma1_k4(TO_INTEGER(u1_m0_wo0_cma1_c0(4)));
    u1_m0_wo0_cma1_r(5) <= u1_m0_wo0_cma1_k5(TO_INTEGER(u1_m0_wo0_cma1_c0(5)));
    u1_m0_wo0_cma1_r(6) <= u1_m0_wo0_cma1_k6(TO_INTEGER(u1_m0_wo0_cma1_c0(6)));
    u1_m0_wo0_cma1_r(7) <= u1_m0_wo0_cma1_k7(TO_INTEGER(u1_m0_wo0_cma1_c0(7)));
    u1_m0_wo0_cma1_r(8) <= u1_m0_wo0_cma1_k8(TO_INTEGER(u1_m0_wo0_cma1_c0(8)));
    u1_m0_wo0_cma1_r(9) <= u1_m0_wo0_cma1_k9(TO_INTEGER(u1_m0_wo0_cma1_c0(9)));
    u1_m0_wo0_cma1_r(10) <= u1_m0_wo0_cma1_k10(TO_INTEGER(u1_m0_wo0_cma1_c0(10)));
    u1_m0_wo0_cma1_r(11) <= u1_m0_wo0_cma1_k11(TO_INTEGER(u1_m0_wo0_cma1_c0(11)));
    u1_m0_wo0_cma1_r(12) <= u1_m0_wo0_cma1_k12(TO_INTEGER(u1_m0_wo0_cma1_c0(12)));
    u1_m0_wo0_cma1_r(13) <= u1_m0_wo0_cma1_k13(TO_INTEGER(u1_m0_wo0_cma1_c0(13)));
    u1_m0_wo0_cma1_r(14) <= u1_m0_wo0_cma1_k14(TO_INTEGER(u1_m0_wo0_cma1_c0(14)));
    u1_m0_wo0_cma1_r(15) <= u1_m0_wo0_cma1_k15(TO_INTEGER(u1_m0_wo0_cma1_c0(15)));
    u1_m0_wo0_cma1_r(16) <= u1_m0_wo0_cma1_k16(TO_INTEGER(u1_m0_wo0_cma1_c0(16)));
    u1_m0_wo0_cma1_r(17) <= u1_m0_wo0_cma1_k17(TO_INTEGER(u1_m0_wo0_cma1_c0(17)));
    u1_m0_wo0_cma1_r(18) <= u1_m0_wo0_cma1_k18(TO_INTEGER(u1_m0_wo0_cma1_c0(18)));
    u1_m0_wo0_cma1_r(19) <= u1_m0_wo0_cma1_k19(TO_INTEGER(u1_m0_wo0_cma1_c0(19)));
    u1_m0_wo0_cma1_r(20) <= u1_m0_wo0_cma1_k20(TO_INTEGER(u1_m0_wo0_cma1_c0(20)));
    u1_m0_wo0_cma1_r(21) <= u1_m0_wo0_cma1_k21(TO_INTEGER(u1_m0_wo0_cma1_c0(21)));
    u1_m0_wo0_cma1_r(22) <= u1_m0_wo0_cma1_k22(TO_INTEGER(u1_m0_wo0_cma1_c0(22)));
    u1_m0_wo0_cma1_r(23) <= u1_m0_wo0_cma1_k23(TO_INTEGER(u1_m0_wo0_cma1_c0(23)));
    u1_m0_wo0_cma1_r(24) <= u1_m0_wo0_cma1_k24(TO_INTEGER(u1_m0_wo0_cma1_c0(24)));
    u1_m0_wo0_cma1_r(25) <= u1_m0_wo0_cma1_k25(TO_INTEGER(u1_m0_wo0_cma1_c0(25)));
    u1_m0_wo0_cma1_r(26) <= u1_m0_wo0_cma1_k26(TO_INTEGER(u1_m0_wo0_cma1_c0(26)));
    u1_m0_wo0_cma1_r(27) <= u1_m0_wo0_cma1_k27(TO_INTEGER(u1_m0_wo0_cma1_c0(27)));
    u1_m0_wo0_cma1_r(28) <= u1_m0_wo0_cma1_k28(TO_INTEGER(u1_m0_wo0_cma1_c0(28)));
    u1_m0_wo0_cma1_r(29) <= u1_m0_wo0_cma1_k29(TO_INTEGER(u1_m0_wo0_cma1_c0(29)));
    u1_m0_wo0_cma1_r(30) <= u1_m0_wo0_cma1_k30(TO_INTEGER(u1_m0_wo0_cma1_c0(30)));
    u1_m0_wo0_cma1_r(31) <= u1_m0_wo0_cma1_k31(TO_INTEGER(u1_m0_wo0_cma1_c0(31)));
    u1_m0_wo0_cma1_p(0) <= u1_m0_wo0_cma1_a0(0) * u1_m0_wo0_cma1_r(0);
    u1_m0_wo0_cma1_p(1) <= u1_m0_wo0_cma1_a0(1) * u1_m0_wo0_cma1_r(1);
    u1_m0_wo0_cma1_p(2) <= u1_m0_wo0_cma1_a0(2) * u1_m0_wo0_cma1_r(2);
    u1_m0_wo0_cma1_p(3) <= u1_m0_wo0_cma1_a0(3) * u1_m0_wo0_cma1_r(3);
    u1_m0_wo0_cma1_p(4) <= u1_m0_wo0_cma1_a0(4) * u1_m0_wo0_cma1_r(4);
    u1_m0_wo0_cma1_p(5) <= u1_m0_wo0_cma1_a0(5) * u1_m0_wo0_cma1_r(5);
    u1_m0_wo0_cma1_p(6) <= u1_m0_wo0_cma1_a0(6) * u1_m0_wo0_cma1_r(6);
    u1_m0_wo0_cma1_p(7) <= u1_m0_wo0_cma1_a0(7) * u1_m0_wo0_cma1_r(7);
    u1_m0_wo0_cma1_p(8) <= u1_m0_wo0_cma1_a0(8) * u1_m0_wo0_cma1_r(8);
    u1_m0_wo0_cma1_p(9) <= u1_m0_wo0_cma1_a0(9) * u1_m0_wo0_cma1_r(9);
    u1_m0_wo0_cma1_p(10) <= u1_m0_wo0_cma1_a0(10) * u1_m0_wo0_cma1_r(10);
    u1_m0_wo0_cma1_p(11) <= u1_m0_wo0_cma1_a0(11) * u1_m0_wo0_cma1_r(11);
    u1_m0_wo0_cma1_p(12) <= u1_m0_wo0_cma1_a0(12) * u1_m0_wo0_cma1_r(12);
    u1_m0_wo0_cma1_p(13) <= u1_m0_wo0_cma1_a0(13) * u1_m0_wo0_cma1_r(13);
    u1_m0_wo0_cma1_p(14) <= u1_m0_wo0_cma1_a0(14) * u1_m0_wo0_cma1_r(14);
    u1_m0_wo0_cma1_p(15) <= u1_m0_wo0_cma1_a0(15) * u1_m0_wo0_cma1_r(15);
    u1_m0_wo0_cma1_p(16) <= u1_m0_wo0_cma1_a0(16) * u1_m0_wo0_cma1_r(16);
    u1_m0_wo0_cma1_p(17) <= u1_m0_wo0_cma1_a0(17) * u1_m0_wo0_cma1_r(17);
    u1_m0_wo0_cma1_p(18) <= u1_m0_wo0_cma1_a0(18) * u1_m0_wo0_cma1_r(18);
    u1_m0_wo0_cma1_p(19) <= u1_m0_wo0_cma1_a0(19) * u1_m0_wo0_cma1_r(19);
    u1_m0_wo0_cma1_p(20) <= u1_m0_wo0_cma1_a0(20) * u1_m0_wo0_cma1_r(20);
    u1_m0_wo0_cma1_p(21) <= u1_m0_wo0_cma1_a0(21) * u1_m0_wo0_cma1_r(21);
    u1_m0_wo0_cma1_p(22) <= u1_m0_wo0_cma1_a0(22) * u1_m0_wo0_cma1_r(22);
    u1_m0_wo0_cma1_p(23) <= u1_m0_wo0_cma1_a0(23) * u1_m0_wo0_cma1_r(23);
    u1_m0_wo0_cma1_p(24) <= u1_m0_wo0_cma1_a0(24) * u1_m0_wo0_cma1_r(24);
    u1_m0_wo0_cma1_p(25) <= u1_m0_wo0_cma1_a0(25) * u1_m0_wo0_cma1_r(25);
    u1_m0_wo0_cma1_p(26) <= u1_m0_wo0_cma1_a0(26) * u1_m0_wo0_cma1_r(26);
    u1_m0_wo0_cma1_p(27) <= u1_m0_wo0_cma1_a0(27) * u1_m0_wo0_cma1_r(27);
    u1_m0_wo0_cma1_p(28) <= u1_m0_wo0_cma1_a0(28) * u1_m0_wo0_cma1_r(28);
    u1_m0_wo0_cma1_p(29) <= u1_m0_wo0_cma1_a0(29) * u1_m0_wo0_cma1_r(29);
    u1_m0_wo0_cma1_p(30) <= u1_m0_wo0_cma1_a0(30) * u1_m0_wo0_cma1_r(30);
    u1_m0_wo0_cma1_p(31) <= u1_m0_wo0_cma1_a0(31) * u1_m0_wo0_cma1_r(31);
    u1_m0_wo0_cma1_u(0) <= RESIZE(u1_m0_wo0_cma1_p(0),24);
    u1_m0_wo0_cma1_u(1) <= RESIZE(u1_m0_wo0_cma1_p(1),24);
    u1_m0_wo0_cma1_u(2) <= RESIZE(u1_m0_wo0_cma1_p(2),24);
    u1_m0_wo0_cma1_u(3) <= RESIZE(u1_m0_wo0_cma1_p(3),24);
    u1_m0_wo0_cma1_u(4) <= RESIZE(u1_m0_wo0_cma1_p(4),24);
    u1_m0_wo0_cma1_u(5) <= RESIZE(u1_m0_wo0_cma1_p(5),24);
    u1_m0_wo0_cma1_u(6) <= RESIZE(u1_m0_wo0_cma1_p(6),24);
    u1_m0_wo0_cma1_u(7) <= RESIZE(u1_m0_wo0_cma1_p(7),24);
    u1_m0_wo0_cma1_u(8) <= RESIZE(u1_m0_wo0_cma1_p(8),24);
    u1_m0_wo0_cma1_u(9) <= RESIZE(u1_m0_wo0_cma1_p(9),24);
    u1_m0_wo0_cma1_u(10) <= RESIZE(u1_m0_wo0_cma1_p(10),24);
    u1_m0_wo0_cma1_u(11) <= RESIZE(u1_m0_wo0_cma1_p(11),24);
    u1_m0_wo0_cma1_u(12) <= RESIZE(u1_m0_wo0_cma1_p(12),24);
    u1_m0_wo0_cma1_u(13) <= RESIZE(u1_m0_wo0_cma1_p(13),24);
    u1_m0_wo0_cma1_u(14) <= RESIZE(u1_m0_wo0_cma1_p(14),24);
    u1_m0_wo0_cma1_u(15) <= RESIZE(u1_m0_wo0_cma1_p(15),24);
    u1_m0_wo0_cma1_u(16) <= RESIZE(u1_m0_wo0_cma1_p(16),24);
    u1_m0_wo0_cma1_u(17) <= RESIZE(u1_m0_wo0_cma1_p(17),24);
    u1_m0_wo0_cma1_u(18) <= RESIZE(u1_m0_wo0_cma1_p(18),24);
    u1_m0_wo0_cma1_u(19) <= RESIZE(u1_m0_wo0_cma1_p(19),24);
    u1_m0_wo0_cma1_u(20) <= RESIZE(u1_m0_wo0_cma1_p(20),24);
    u1_m0_wo0_cma1_u(21) <= RESIZE(u1_m0_wo0_cma1_p(21),24);
    u1_m0_wo0_cma1_u(22) <= RESIZE(u1_m0_wo0_cma1_p(22),24);
    u1_m0_wo0_cma1_u(23) <= RESIZE(u1_m0_wo0_cma1_p(23),24);
    u1_m0_wo0_cma1_u(24) <= RESIZE(u1_m0_wo0_cma1_p(24),24);
    u1_m0_wo0_cma1_u(25) <= RESIZE(u1_m0_wo0_cma1_p(25),24);
    u1_m0_wo0_cma1_u(26) <= RESIZE(u1_m0_wo0_cma1_p(26),24);
    u1_m0_wo0_cma1_u(27) <= RESIZE(u1_m0_wo0_cma1_p(27),24);
    u1_m0_wo0_cma1_u(28) <= RESIZE(u1_m0_wo0_cma1_p(28),24);
    u1_m0_wo0_cma1_u(29) <= RESIZE(u1_m0_wo0_cma1_p(29),24);
    u1_m0_wo0_cma1_u(30) <= RESIZE(u1_m0_wo0_cma1_p(30),24);
    u1_m0_wo0_cma1_u(31) <= RESIZE(u1_m0_wo0_cma1_p(31),24);
    u1_m0_wo0_cma1_w(0) <= u1_m0_wo0_cma1_u(0);
    u1_m0_wo0_cma1_w(1) <= u1_m0_wo0_cma1_u(1);
    u1_m0_wo0_cma1_w(2) <= u1_m0_wo0_cma1_u(2);
    u1_m0_wo0_cma1_w(3) <= u1_m0_wo0_cma1_u(3);
    u1_m0_wo0_cma1_w(4) <= u1_m0_wo0_cma1_u(4);
    u1_m0_wo0_cma1_w(5) <= u1_m0_wo0_cma1_u(5);
    u1_m0_wo0_cma1_w(6) <= u1_m0_wo0_cma1_u(6);
    u1_m0_wo0_cma1_w(7) <= u1_m0_wo0_cma1_u(7);
    u1_m0_wo0_cma1_w(8) <= u1_m0_wo0_cma1_u(8);
    u1_m0_wo0_cma1_w(9) <= u1_m0_wo0_cma1_u(9);
    u1_m0_wo0_cma1_w(10) <= u1_m0_wo0_cma1_u(10);
    u1_m0_wo0_cma1_w(11) <= u1_m0_wo0_cma1_u(11);
    u1_m0_wo0_cma1_w(12) <= u1_m0_wo0_cma1_u(12);
    u1_m0_wo0_cma1_w(13) <= u1_m0_wo0_cma1_u(13);
    u1_m0_wo0_cma1_w(14) <= u1_m0_wo0_cma1_u(14);
    u1_m0_wo0_cma1_w(15) <= u1_m0_wo0_cma1_u(15);
    u1_m0_wo0_cma1_w(16) <= u1_m0_wo0_cma1_u(16);
    u1_m0_wo0_cma1_w(17) <= u1_m0_wo0_cma1_u(17);
    u1_m0_wo0_cma1_w(18) <= u1_m0_wo0_cma1_u(18);
    u1_m0_wo0_cma1_w(19) <= u1_m0_wo0_cma1_u(19);
    u1_m0_wo0_cma1_w(20) <= u1_m0_wo0_cma1_u(20);
    u1_m0_wo0_cma1_w(21) <= u1_m0_wo0_cma1_u(21);
    u1_m0_wo0_cma1_w(22) <= u1_m0_wo0_cma1_u(22);
    u1_m0_wo0_cma1_w(23) <= u1_m0_wo0_cma1_u(23);
    u1_m0_wo0_cma1_w(24) <= u1_m0_wo0_cma1_u(24);
    u1_m0_wo0_cma1_w(25) <= u1_m0_wo0_cma1_u(25);
    u1_m0_wo0_cma1_w(26) <= u1_m0_wo0_cma1_u(26);
    u1_m0_wo0_cma1_w(27) <= u1_m0_wo0_cma1_u(27);
    u1_m0_wo0_cma1_w(28) <= u1_m0_wo0_cma1_u(28);
    u1_m0_wo0_cma1_w(29) <= u1_m0_wo0_cma1_u(29);
    u1_m0_wo0_cma1_w(30) <= u1_m0_wo0_cma1_u(30);
    u1_m0_wo0_cma1_w(31) <= u1_m0_wo0_cma1_u(31);
    u1_m0_wo0_cma1_x(0) <= u1_m0_wo0_cma1_w(0);
    u1_m0_wo0_cma1_x(1) <= u1_m0_wo0_cma1_w(1);
    u1_m0_wo0_cma1_x(2) <= u1_m0_wo0_cma1_w(2);
    u1_m0_wo0_cma1_x(3) <= u1_m0_wo0_cma1_w(3);
    u1_m0_wo0_cma1_x(4) <= u1_m0_wo0_cma1_w(4);
    u1_m0_wo0_cma1_x(5) <= u1_m0_wo0_cma1_w(5);
    u1_m0_wo0_cma1_x(6) <= u1_m0_wo0_cma1_w(6);
    u1_m0_wo0_cma1_x(7) <= u1_m0_wo0_cma1_w(7);
    u1_m0_wo0_cma1_x(8) <= u1_m0_wo0_cma1_w(8);
    u1_m0_wo0_cma1_x(9) <= u1_m0_wo0_cma1_w(9);
    u1_m0_wo0_cma1_x(10) <= u1_m0_wo0_cma1_w(10);
    u1_m0_wo0_cma1_x(11) <= u1_m0_wo0_cma1_w(11);
    u1_m0_wo0_cma1_x(12) <= u1_m0_wo0_cma1_w(12);
    u1_m0_wo0_cma1_x(13) <= u1_m0_wo0_cma1_w(13);
    u1_m0_wo0_cma1_x(14) <= u1_m0_wo0_cma1_w(14);
    u1_m0_wo0_cma1_x(15) <= u1_m0_wo0_cma1_w(15);
    u1_m0_wo0_cma1_x(16) <= u1_m0_wo0_cma1_w(16);
    u1_m0_wo0_cma1_x(17) <= u1_m0_wo0_cma1_w(17);
    u1_m0_wo0_cma1_x(18) <= u1_m0_wo0_cma1_w(18);
    u1_m0_wo0_cma1_x(19) <= u1_m0_wo0_cma1_w(19);
    u1_m0_wo0_cma1_x(20) <= u1_m0_wo0_cma1_w(20);
    u1_m0_wo0_cma1_x(21) <= u1_m0_wo0_cma1_w(21);
    u1_m0_wo0_cma1_x(22) <= u1_m0_wo0_cma1_w(22);
    u1_m0_wo0_cma1_x(23) <= u1_m0_wo0_cma1_w(23);
    u1_m0_wo0_cma1_x(24) <= u1_m0_wo0_cma1_w(24);
    u1_m0_wo0_cma1_x(25) <= u1_m0_wo0_cma1_w(25);
    u1_m0_wo0_cma1_x(26) <= u1_m0_wo0_cma1_w(26);
    u1_m0_wo0_cma1_x(27) <= u1_m0_wo0_cma1_w(27);
    u1_m0_wo0_cma1_x(28) <= u1_m0_wo0_cma1_w(28);
    u1_m0_wo0_cma1_x(29) <= u1_m0_wo0_cma1_w(29);
    u1_m0_wo0_cma1_x(30) <= u1_m0_wo0_cma1_w(30);
    u1_m0_wo0_cma1_x(31) <= u1_m0_wo0_cma1_w(31);
    u1_m0_wo0_cma1_y(0) <= u1_m0_wo0_cma1_s(1) + u1_m0_wo0_cma1_x(0);
    u1_m0_wo0_cma1_y(1) <= u1_m0_wo0_cma1_s(2) + u1_m0_wo0_cma1_x(1);
    u1_m0_wo0_cma1_y(2) <= u1_m0_wo0_cma1_s(3) + u1_m0_wo0_cma1_x(2);
    u1_m0_wo0_cma1_y(3) <= u1_m0_wo0_cma1_s(4) + u1_m0_wo0_cma1_x(3);
    u1_m0_wo0_cma1_y(4) <= u1_m0_wo0_cma1_s(5) + u1_m0_wo0_cma1_x(4);
    u1_m0_wo0_cma1_y(5) <= u1_m0_wo0_cma1_s(6) + u1_m0_wo0_cma1_x(5);
    u1_m0_wo0_cma1_y(6) <= u1_m0_wo0_cma1_s(7) + u1_m0_wo0_cma1_x(6);
    u1_m0_wo0_cma1_y(7) <= u1_m0_wo0_cma1_s(8) + u1_m0_wo0_cma1_x(7);
    u1_m0_wo0_cma1_y(8) <= u1_m0_wo0_cma1_s(9) + u1_m0_wo0_cma1_x(8);
    u1_m0_wo0_cma1_y(9) <= u1_m0_wo0_cma1_s(10) + u1_m0_wo0_cma1_x(9);
    u1_m0_wo0_cma1_y(10) <= u1_m0_wo0_cma1_s(11) + u1_m0_wo0_cma1_x(10);
    u1_m0_wo0_cma1_y(11) <= u1_m0_wo0_cma1_s(12) + u1_m0_wo0_cma1_x(11);
    u1_m0_wo0_cma1_y(12) <= u1_m0_wo0_cma1_s(13) + u1_m0_wo0_cma1_x(12);
    u1_m0_wo0_cma1_y(13) <= u1_m0_wo0_cma1_s(14) + u1_m0_wo0_cma1_x(13);
    u1_m0_wo0_cma1_y(14) <= u1_m0_wo0_cma1_s(15) + u1_m0_wo0_cma1_x(14);
    u1_m0_wo0_cma1_y(15) <= u1_m0_wo0_cma1_s(16) + u1_m0_wo0_cma1_x(15);
    u1_m0_wo0_cma1_y(16) <= u1_m0_wo0_cma1_s(17) + u1_m0_wo0_cma1_x(16);
    u1_m0_wo0_cma1_y(17) <= u1_m0_wo0_cma1_s(18) + u1_m0_wo0_cma1_x(17);
    u1_m0_wo0_cma1_y(18) <= u1_m0_wo0_cma1_s(19) + u1_m0_wo0_cma1_x(18);
    u1_m0_wo0_cma1_y(19) <= u1_m0_wo0_cma1_s(20) + u1_m0_wo0_cma1_x(19);
    u1_m0_wo0_cma1_y(20) <= u1_m0_wo0_cma1_s(21) + u1_m0_wo0_cma1_x(20);
    u1_m0_wo0_cma1_y(21) <= u1_m0_wo0_cma1_s(22) + u1_m0_wo0_cma1_x(21);
    u1_m0_wo0_cma1_y(22) <= u1_m0_wo0_cma1_s(23) + u1_m0_wo0_cma1_x(22);
    u1_m0_wo0_cma1_y(23) <= u1_m0_wo0_cma1_s(24) + u1_m0_wo0_cma1_x(23);
    u1_m0_wo0_cma1_y(24) <= u1_m0_wo0_cma1_s(25) + u1_m0_wo0_cma1_x(24);
    u1_m0_wo0_cma1_y(25) <= u1_m0_wo0_cma1_s(26) + u1_m0_wo0_cma1_x(25);
    u1_m0_wo0_cma1_y(26) <= u1_m0_wo0_cma1_s(27) + u1_m0_wo0_cma1_x(26);
    u1_m0_wo0_cma1_y(27) <= u1_m0_wo0_cma1_s(28) + u1_m0_wo0_cma1_x(27);
    u1_m0_wo0_cma1_y(28) <= u1_m0_wo0_cma1_s(29) + u1_m0_wo0_cma1_x(28);
    u1_m0_wo0_cma1_y(29) <= u1_m0_wo0_cma1_s(30) + u1_m0_wo0_cma1_x(29);
    u1_m0_wo0_cma1_y(30) <= u1_m0_wo0_cma1_s(31) + u1_m0_wo0_cma1_x(30);
    u1_m0_wo0_cma1_y(31) <= u1_m0_wo0_cma1_x(31);
    u1_m0_wo0_cma1_chainmultadd: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u1_m0_wo0_cma1_a0 <= (others => (others => '0'));
            u1_m0_wo0_cma1_c0 <= (others => (others => '0'));
            u1_m0_wo0_cma1_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (input_valid_q = "1") THEN
                u1_m0_wo0_cma1_a0(0) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(1) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(2) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(3) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(4) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(5) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(6) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(7) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(8) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(9) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(10) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(11) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(12) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(13) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(14) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(15) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(16) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(17) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(18) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(19) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(20) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(21) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(22) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(23) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(24) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(25) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(26) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(27) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(28) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(29) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(30) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_a0(31) <= RESIZE(SIGNED(u1_m0_wo0_wi0_r0_split32_b),8);
                u1_m0_wo0_cma1_c0(0) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(1) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(2) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(3) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(4) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(5) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(6) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(7) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(8) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(9) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(10) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(11) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(12) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(13) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(14) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(15) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(16) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(17) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(18) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(19) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(20) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(21) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(22) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(23) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(24) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(25) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(26) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(27) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(28) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(29) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(30) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma1_c0(31) <= RESIZE(UNSIGNED(GND_q),3);
            END IF;
            IF (d_u1_m0_wo0_compute_q_11_q = "1") THEN
                u1_m0_wo0_cma1_s(0) <= u1_m0_wo0_cma1_y(0);
                u1_m0_wo0_cma1_s(1) <= u1_m0_wo0_cma1_y(1);
                u1_m0_wo0_cma1_s(2) <= u1_m0_wo0_cma1_y(2);
                u1_m0_wo0_cma1_s(3) <= u1_m0_wo0_cma1_y(3);
                u1_m0_wo0_cma1_s(4) <= u1_m0_wo0_cma1_y(4);
                u1_m0_wo0_cma1_s(5) <= u1_m0_wo0_cma1_y(5);
                u1_m0_wo0_cma1_s(6) <= u1_m0_wo0_cma1_y(6);
                u1_m0_wo0_cma1_s(7) <= u1_m0_wo0_cma1_y(7);
                u1_m0_wo0_cma1_s(8) <= u1_m0_wo0_cma1_y(8);
                u1_m0_wo0_cma1_s(9) <= u1_m0_wo0_cma1_y(9);
                u1_m0_wo0_cma1_s(10) <= u1_m0_wo0_cma1_y(10);
                u1_m0_wo0_cma1_s(11) <= u1_m0_wo0_cma1_y(11);
                u1_m0_wo0_cma1_s(12) <= u1_m0_wo0_cma1_y(12);
                u1_m0_wo0_cma1_s(13) <= u1_m0_wo0_cma1_y(13);
                u1_m0_wo0_cma1_s(14) <= u1_m0_wo0_cma1_y(14);
                u1_m0_wo0_cma1_s(15) <= u1_m0_wo0_cma1_y(15);
                u1_m0_wo0_cma1_s(16) <= u1_m0_wo0_cma1_y(16);
                u1_m0_wo0_cma1_s(17) <= u1_m0_wo0_cma1_y(17);
                u1_m0_wo0_cma1_s(18) <= u1_m0_wo0_cma1_y(18);
                u1_m0_wo0_cma1_s(19) <= u1_m0_wo0_cma1_y(19);
                u1_m0_wo0_cma1_s(20) <= u1_m0_wo0_cma1_y(20);
                u1_m0_wo0_cma1_s(21) <= u1_m0_wo0_cma1_y(21);
                u1_m0_wo0_cma1_s(22) <= u1_m0_wo0_cma1_y(22);
                u1_m0_wo0_cma1_s(23) <= u1_m0_wo0_cma1_y(23);
                u1_m0_wo0_cma1_s(24) <= u1_m0_wo0_cma1_y(24);
                u1_m0_wo0_cma1_s(25) <= u1_m0_wo0_cma1_y(25);
                u1_m0_wo0_cma1_s(26) <= u1_m0_wo0_cma1_y(26);
                u1_m0_wo0_cma1_s(27) <= u1_m0_wo0_cma1_y(27);
                u1_m0_wo0_cma1_s(28) <= u1_m0_wo0_cma1_y(28);
                u1_m0_wo0_cma1_s(29) <= u1_m0_wo0_cma1_y(29);
                u1_m0_wo0_cma1_s(30) <= u1_m0_wo0_cma1_y(30);
                u1_m0_wo0_cma1_s(31) <= u1_m0_wo0_cma1_y(31);
            END IF;
        END IF;
    END PROCESS;
    u1_m0_wo0_cma1_delay : dspba_delay
    GENERIC MAP ( width => 24, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u1_m0_wo0_cma1_s(0)(23 downto 0)), xout => u1_m0_wo0_cma1_qq, clk => clk, aclr => areset );
    u1_m0_wo0_cma1_q <= STD_LOGIC_VECTOR(u1_m0_wo0_cma1_qq(23 downto 0));

    -- u1_m0_wo0_cma0(CHAINMULTADD,415)@10 + 2
    -- altera synthesis_off
    u1_m0_wo0_cma0_k0 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k1 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k2 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k3 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k4 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k5 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k6 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k7 <= (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k8 <= (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k9 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k10 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k11 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k12 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k13 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k14 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k15 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k16 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k17 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k18 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k19 <= (
        0 => TO_SIGNED(3,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k20 <= (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k21 <= (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k22 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k23 <= (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k24 <= (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k25 <= (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k26 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k27 <= (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k28 <= (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k29 <= (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k30 <= (
        0 => TO_SIGNED(6,11),
        others => (others => '0'));
    u1_m0_wo0_cma0_k31 <= (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    -- altera synthesis_on
    u1_m0_wo0_cma0_r(0) <= u1_m0_wo0_cma0_k0(TO_INTEGER(u1_m0_wo0_cma0_c0(0)));
    u1_m0_wo0_cma0_r(1) <= u1_m0_wo0_cma0_k1(TO_INTEGER(u1_m0_wo0_cma0_c0(1)));
    u1_m0_wo0_cma0_r(2) <= u1_m0_wo0_cma0_k2(TO_INTEGER(u1_m0_wo0_cma0_c0(2)));
    u1_m0_wo0_cma0_r(3) <= u1_m0_wo0_cma0_k3(TO_INTEGER(u1_m0_wo0_cma0_c0(3)));
    u1_m0_wo0_cma0_r(4) <= u1_m0_wo0_cma0_k4(TO_INTEGER(u1_m0_wo0_cma0_c0(4)));
    u1_m0_wo0_cma0_r(5) <= u1_m0_wo0_cma0_k5(TO_INTEGER(u1_m0_wo0_cma0_c0(5)));
    u1_m0_wo0_cma0_r(6) <= u1_m0_wo0_cma0_k6(TO_INTEGER(u1_m0_wo0_cma0_c0(6)));
    u1_m0_wo0_cma0_r(7) <= u1_m0_wo0_cma0_k7(TO_INTEGER(u1_m0_wo0_cma0_c0(7)));
    u1_m0_wo0_cma0_r(8) <= u1_m0_wo0_cma0_k8(TO_INTEGER(u1_m0_wo0_cma0_c0(8)));
    u1_m0_wo0_cma0_r(9) <= u1_m0_wo0_cma0_k9(TO_INTEGER(u1_m0_wo0_cma0_c0(9)));
    u1_m0_wo0_cma0_r(10) <= u1_m0_wo0_cma0_k10(TO_INTEGER(u1_m0_wo0_cma0_c0(10)));
    u1_m0_wo0_cma0_r(11) <= u1_m0_wo0_cma0_k11(TO_INTEGER(u1_m0_wo0_cma0_c0(11)));
    u1_m0_wo0_cma0_r(12) <= u1_m0_wo0_cma0_k12(TO_INTEGER(u1_m0_wo0_cma0_c0(12)));
    u1_m0_wo0_cma0_r(13) <= u1_m0_wo0_cma0_k13(TO_INTEGER(u1_m0_wo0_cma0_c0(13)));
    u1_m0_wo0_cma0_r(14) <= u1_m0_wo0_cma0_k14(TO_INTEGER(u1_m0_wo0_cma0_c0(14)));
    u1_m0_wo0_cma0_r(15) <= u1_m0_wo0_cma0_k15(TO_INTEGER(u1_m0_wo0_cma0_c0(15)));
    u1_m0_wo0_cma0_r(16) <= u1_m0_wo0_cma0_k16(TO_INTEGER(u1_m0_wo0_cma0_c0(16)));
    u1_m0_wo0_cma0_r(17) <= u1_m0_wo0_cma0_k17(TO_INTEGER(u1_m0_wo0_cma0_c0(17)));
    u1_m0_wo0_cma0_r(18) <= u1_m0_wo0_cma0_k18(TO_INTEGER(u1_m0_wo0_cma0_c0(18)));
    u1_m0_wo0_cma0_r(19) <= u1_m0_wo0_cma0_k19(TO_INTEGER(u1_m0_wo0_cma0_c0(19)));
    u1_m0_wo0_cma0_r(20) <= u1_m0_wo0_cma0_k20(TO_INTEGER(u1_m0_wo0_cma0_c0(20)));
    u1_m0_wo0_cma0_r(21) <= u1_m0_wo0_cma0_k21(TO_INTEGER(u1_m0_wo0_cma0_c0(21)));
    u1_m0_wo0_cma0_r(22) <= u1_m0_wo0_cma0_k22(TO_INTEGER(u1_m0_wo0_cma0_c0(22)));
    u1_m0_wo0_cma0_r(23) <= u1_m0_wo0_cma0_k23(TO_INTEGER(u1_m0_wo0_cma0_c0(23)));
    u1_m0_wo0_cma0_r(24) <= u1_m0_wo0_cma0_k24(TO_INTEGER(u1_m0_wo0_cma0_c0(24)));
    u1_m0_wo0_cma0_r(25) <= u1_m0_wo0_cma0_k25(TO_INTEGER(u1_m0_wo0_cma0_c0(25)));
    u1_m0_wo0_cma0_r(26) <= u1_m0_wo0_cma0_k26(TO_INTEGER(u1_m0_wo0_cma0_c0(26)));
    u1_m0_wo0_cma0_r(27) <= u1_m0_wo0_cma0_k27(TO_INTEGER(u1_m0_wo0_cma0_c0(27)));
    u1_m0_wo0_cma0_r(28) <= u1_m0_wo0_cma0_k28(TO_INTEGER(u1_m0_wo0_cma0_c0(28)));
    u1_m0_wo0_cma0_r(29) <= u1_m0_wo0_cma0_k29(TO_INTEGER(u1_m0_wo0_cma0_c0(29)));
    u1_m0_wo0_cma0_r(30) <= u1_m0_wo0_cma0_k30(TO_INTEGER(u1_m0_wo0_cma0_c0(30)));
    u1_m0_wo0_cma0_r(31) <= u1_m0_wo0_cma0_k31(TO_INTEGER(u1_m0_wo0_cma0_c0(31)));
    u1_m0_wo0_cma0_p(0) <= u1_m0_wo0_cma0_a0(0) * u1_m0_wo0_cma0_r(0);
    u1_m0_wo0_cma0_p(1) <= u1_m0_wo0_cma0_a0(1) * u1_m0_wo0_cma0_r(1);
    u1_m0_wo0_cma0_p(2) <= u1_m0_wo0_cma0_a0(2) * u1_m0_wo0_cma0_r(2);
    u1_m0_wo0_cma0_p(3) <= u1_m0_wo0_cma0_a0(3) * u1_m0_wo0_cma0_r(3);
    u1_m0_wo0_cma0_p(4) <= u1_m0_wo0_cma0_a0(4) * u1_m0_wo0_cma0_r(4);
    u1_m0_wo0_cma0_p(5) <= u1_m0_wo0_cma0_a0(5) * u1_m0_wo0_cma0_r(5);
    u1_m0_wo0_cma0_p(6) <= u1_m0_wo0_cma0_a0(6) * u1_m0_wo0_cma0_r(6);
    u1_m0_wo0_cma0_p(7) <= u1_m0_wo0_cma0_a0(7) * u1_m0_wo0_cma0_r(7);
    u1_m0_wo0_cma0_p(8) <= u1_m0_wo0_cma0_a0(8) * u1_m0_wo0_cma0_r(8);
    u1_m0_wo0_cma0_p(9) <= u1_m0_wo0_cma0_a0(9) * u1_m0_wo0_cma0_r(9);
    u1_m0_wo0_cma0_p(10) <= u1_m0_wo0_cma0_a0(10) * u1_m0_wo0_cma0_r(10);
    u1_m0_wo0_cma0_p(11) <= u1_m0_wo0_cma0_a0(11) * u1_m0_wo0_cma0_r(11);
    u1_m0_wo0_cma0_p(12) <= u1_m0_wo0_cma0_a0(12) * u1_m0_wo0_cma0_r(12);
    u1_m0_wo0_cma0_p(13) <= u1_m0_wo0_cma0_a0(13) * u1_m0_wo0_cma0_r(13);
    u1_m0_wo0_cma0_p(14) <= u1_m0_wo0_cma0_a0(14) * u1_m0_wo0_cma0_r(14);
    u1_m0_wo0_cma0_p(15) <= u1_m0_wo0_cma0_a0(15) * u1_m0_wo0_cma0_r(15);
    u1_m0_wo0_cma0_p(16) <= u1_m0_wo0_cma0_a0(16) * u1_m0_wo0_cma0_r(16);
    u1_m0_wo0_cma0_p(17) <= u1_m0_wo0_cma0_a0(17) * u1_m0_wo0_cma0_r(17);
    u1_m0_wo0_cma0_p(18) <= u1_m0_wo0_cma0_a0(18) * u1_m0_wo0_cma0_r(18);
    u1_m0_wo0_cma0_p(19) <= u1_m0_wo0_cma0_a0(19) * u1_m0_wo0_cma0_r(19);
    u1_m0_wo0_cma0_p(20) <= u1_m0_wo0_cma0_a0(20) * u1_m0_wo0_cma0_r(20);
    u1_m0_wo0_cma0_p(21) <= u1_m0_wo0_cma0_a0(21) * u1_m0_wo0_cma0_r(21);
    u1_m0_wo0_cma0_p(22) <= u1_m0_wo0_cma0_a0(22) * u1_m0_wo0_cma0_r(22);
    u1_m0_wo0_cma0_p(23) <= u1_m0_wo0_cma0_a0(23) * u1_m0_wo0_cma0_r(23);
    u1_m0_wo0_cma0_p(24) <= u1_m0_wo0_cma0_a0(24) * u1_m0_wo0_cma0_r(24);
    u1_m0_wo0_cma0_p(25) <= u1_m0_wo0_cma0_a0(25) * u1_m0_wo0_cma0_r(25);
    u1_m0_wo0_cma0_p(26) <= u1_m0_wo0_cma0_a0(26) * u1_m0_wo0_cma0_r(26);
    u1_m0_wo0_cma0_p(27) <= u1_m0_wo0_cma0_a0(27) * u1_m0_wo0_cma0_r(27);
    u1_m0_wo0_cma0_p(28) <= u1_m0_wo0_cma0_a0(28) * u1_m0_wo0_cma0_r(28);
    u1_m0_wo0_cma0_p(29) <= u1_m0_wo0_cma0_a0(29) * u1_m0_wo0_cma0_r(29);
    u1_m0_wo0_cma0_p(30) <= u1_m0_wo0_cma0_a0(30) * u1_m0_wo0_cma0_r(30);
    u1_m0_wo0_cma0_p(31) <= u1_m0_wo0_cma0_a0(31) * u1_m0_wo0_cma0_r(31);
    u1_m0_wo0_cma0_u(0) <= RESIZE(u1_m0_wo0_cma0_p(0),24);
    u1_m0_wo0_cma0_u(1) <= RESIZE(u1_m0_wo0_cma0_p(1),24);
    u1_m0_wo0_cma0_u(2) <= RESIZE(u1_m0_wo0_cma0_p(2),24);
    u1_m0_wo0_cma0_u(3) <= RESIZE(u1_m0_wo0_cma0_p(3),24);
    u1_m0_wo0_cma0_u(4) <= RESIZE(u1_m0_wo0_cma0_p(4),24);
    u1_m0_wo0_cma0_u(5) <= RESIZE(u1_m0_wo0_cma0_p(5),24);
    u1_m0_wo0_cma0_u(6) <= RESIZE(u1_m0_wo0_cma0_p(6),24);
    u1_m0_wo0_cma0_u(7) <= RESIZE(u1_m0_wo0_cma0_p(7),24);
    u1_m0_wo0_cma0_u(8) <= RESIZE(u1_m0_wo0_cma0_p(8),24);
    u1_m0_wo0_cma0_u(9) <= RESIZE(u1_m0_wo0_cma0_p(9),24);
    u1_m0_wo0_cma0_u(10) <= RESIZE(u1_m0_wo0_cma0_p(10),24);
    u1_m0_wo0_cma0_u(11) <= RESIZE(u1_m0_wo0_cma0_p(11),24);
    u1_m0_wo0_cma0_u(12) <= RESIZE(u1_m0_wo0_cma0_p(12),24);
    u1_m0_wo0_cma0_u(13) <= RESIZE(u1_m0_wo0_cma0_p(13),24);
    u1_m0_wo0_cma0_u(14) <= RESIZE(u1_m0_wo0_cma0_p(14),24);
    u1_m0_wo0_cma0_u(15) <= RESIZE(u1_m0_wo0_cma0_p(15),24);
    u1_m0_wo0_cma0_u(16) <= RESIZE(u1_m0_wo0_cma0_p(16),24);
    u1_m0_wo0_cma0_u(17) <= RESIZE(u1_m0_wo0_cma0_p(17),24);
    u1_m0_wo0_cma0_u(18) <= RESIZE(u1_m0_wo0_cma0_p(18),24);
    u1_m0_wo0_cma0_u(19) <= RESIZE(u1_m0_wo0_cma0_p(19),24);
    u1_m0_wo0_cma0_u(20) <= RESIZE(u1_m0_wo0_cma0_p(20),24);
    u1_m0_wo0_cma0_u(21) <= RESIZE(u1_m0_wo0_cma0_p(21),24);
    u1_m0_wo0_cma0_u(22) <= RESIZE(u1_m0_wo0_cma0_p(22),24);
    u1_m0_wo0_cma0_u(23) <= RESIZE(u1_m0_wo0_cma0_p(23),24);
    u1_m0_wo0_cma0_u(24) <= RESIZE(u1_m0_wo0_cma0_p(24),24);
    u1_m0_wo0_cma0_u(25) <= RESIZE(u1_m0_wo0_cma0_p(25),24);
    u1_m0_wo0_cma0_u(26) <= RESIZE(u1_m0_wo0_cma0_p(26),24);
    u1_m0_wo0_cma0_u(27) <= RESIZE(u1_m0_wo0_cma0_p(27),24);
    u1_m0_wo0_cma0_u(28) <= RESIZE(u1_m0_wo0_cma0_p(28),24);
    u1_m0_wo0_cma0_u(29) <= RESIZE(u1_m0_wo0_cma0_p(29),24);
    u1_m0_wo0_cma0_u(30) <= RESIZE(u1_m0_wo0_cma0_p(30),24);
    u1_m0_wo0_cma0_u(31) <= RESIZE(u1_m0_wo0_cma0_p(31),24);
    u1_m0_wo0_cma0_w(0) <= u1_m0_wo0_cma0_u(0);
    u1_m0_wo0_cma0_w(1) <= u1_m0_wo0_cma0_u(1);
    u1_m0_wo0_cma0_w(2) <= u1_m0_wo0_cma0_u(2);
    u1_m0_wo0_cma0_w(3) <= u1_m0_wo0_cma0_u(3);
    u1_m0_wo0_cma0_w(4) <= u1_m0_wo0_cma0_u(4);
    u1_m0_wo0_cma0_w(5) <= u1_m0_wo0_cma0_u(5);
    u1_m0_wo0_cma0_w(6) <= u1_m0_wo0_cma0_u(6);
    u1_m0_wo0_cma0_w(7) <= u1_m0_wo0_cma0_u(7);
    u1_m0_wo0_cma0_w(8) <= u1_m0_wo0_cma0_u(8);
    u1_m0_wo0_cma0_w(9) <= u1_m0_wo0_cma0_u(9);
    u1_m0_wo0_cma0_w(10) <= u1_m0_wo0_cma0_u(10);
    u1_m0_wo0_cma0_w(11) <= u1_m0_wo0_cma0_u(11);
    u1_m0_wo0_cma0_w(12) <= u1_m0_wo0_cma0_u(12);
    u1_m0_wo0_cma0_w(13) <= u1_m0_wo0_cma0_u(13);
    u1_m0_wo0_cma0_w(14) <= u1_m0_wo0_cma0_u(14);
    u1_m0_wo0_cma0_w(15) <= u1_m0_wo0_cma0_u(15);
    u1_m0_wo0_cma0_w(16) <= u1_m0_wo0_cma0_u(16);
    u1_m0_wo0_cma0_w(17) <= u1_m0_wo0_cma0_u(17);
    u1_m0_wo0_cma0_w(18) <= u1_m0_wo0_cma0_u(18);
    u1_m0_wo0_cma0_w(19) <= u1_m0_wo0_cma0_u(19);
    u1_m0_wo0_cma0_w(20) <= u1_m0_wo0_cma0_u(20);
    u1_m0_wo0_cma0_w(21) <= u1_m0_wo0_cma0_u(21);
    u1_m0_wo0_cma0_w(22) <= u1_m0_wo0_cma0_u(22);
    u1_m0_wo0_cma0_w(23) <= u1_m0_wo0_cma0_u(23);
    u1_m0_wo0_cma0_w(24) <= u1_m0_wo0_cma0_u(24);
    u1_m0_wo0_cma0_w(25) <= u1_m0_wo0_cma0_u(25);
    u1_m0_wo0_cma0_w(26) <= u1_m0_wo0_cma0_u(26);
    u1_m0_wo0_cma0_w(27) <= u1_m0_wo0_cma0_u(27);
    u1_m0_wo0_cma0_w(28) <= u1_m0_wo0_cma0_u(28);
    u1_m0_wo0_cma0_w(29) <= u1_m0_wo0_cma0_u(29);
    u1_m0_wo0_cma0_w(30) <= u1_m0_wo0_cma0_u(30);
    u1_m0_wo0_cma0_w(31) <= u1_m0_wo0_cma0_u(31);
    u1_m0_wo0_cma0_x(0) <= u1_m0_wo0_cma0_w(0);
    u1_m0_wo0_cma0_x(1) <= u1_m0_wo0_cma0_w(1);
    u1_m0_wo0_cma0_x(2) <= u1_m0_wo0_cma0_w(2);
    u1_m0_wo0_cma0_x(3) <= u1_m0_wo0_cma0_w(3);
    u1_m0_wo0_cma0_x(4) <= u1_m0_wo0_cma0_w(4);
    u1_m0_wo0_cma0_x(5) <= u1_m0_wo0_cma0_w(5);
    u1_m0_wo0_cma0_x(6) <= u1_m0_wo0_cma0_w(6);
    u1_m0_wo0_cma0_x(7) <= u1_m0_wo0_cma0_w(7);
    u1_m0_wo0_cma0_x(8) <= u1_m0_wo0_cma0_w(8);
    u1_m0_wo0_cma0_x(9) <= u1_m0_wo0_cma0_w(9);
    u1_m0_wo0_cma0_x(10) <= u1_m0_wo0_cma0_w(10);
    u1_m0_wo0_cma0_x(11) <= u1_m0_wo0_cma0_w(11);
    u1_m0_wo0_cma0_x(12) <= u1_m0_wo0_cma0_w(12);
    u1_m0_wo0_cma0_x(13) <= u1_m0_wo0_cma0_w(13);
    u1_m0_wo0_cma0_x(14) <= u1_m0_wo0_cma0_w(14);
    u1_m0_wo0_cma0_x(15) <= u1_m0_wo0_cma0_w(15);
    u1_m0_wo0_cma0_x(16) <= u1_m0_wo0_cma0_w(16);
    u1_m0_wo0_cma0_x(17) <= u1_m0_wo0_cma0_w(17);
    u1_m0_wo0_cma0_x(18) <= u1_m0_wo0_cma0_w(18);
    u1_m0_wo0_cma0_x(19) <= u1_m0_wo0_cma0_w(19);
    u1_m0_wo0_cma0_x(20) <= u1_m0_wo0_cma0_w(20);
    u1_m0_wo0_cma0_x(21) <= u1_m0_wo0_cma0_w(21);
    u1_m0_wo0_cma0_x(22) <= u1_m0_wo0_cma0_w(22);
    u1_m0_wo0_cma0_x(23) <= u1_m0_wo0_cma0_w(23);
    u1_m0_wo0_cma0_x(24) <= u1_m0_wo0_cma0_w(24);
    u1_m0_wo0_cma0_x(25) <= u1_m0_wo0_cma0_w(25);
    u1_m0_wo0_cma0_x(26) <= u1_m0_wo0_cma0_w(26);
    u1_m0_wo0_cma0_x(27) <= u1_m0_wo0_cma0_w(27);
    u1_m0_wo0_cma0_x(28) <= u1_m0_wo0_cma0_w(28);
    u1_m0_wo0_cma0_x(29) <= u1_m0_wo0_cma0_w(29);
    u1_m0_wo0_cma0_x(30) <= u1_m0_wo0_cma0_w(30);
    u1_m0_wo0_cma0_x(31) <= u1_m0_wo0_cma0_w(31);
    u1_m0_wo0_cma0_y(0) <= u1_m0_wo0_cma0_s(1) + u1_m0_wo0_cma0_x(0);
    u1_m0_wo0_cma0_y(1) <= u1_m0_wo0_cma0_s(2) + u1_m0_wo0_cma0_x(1);
    u1_m0_wo0_cma0_y(2) <= u1_m0_wo0_cma0_s(3) + u1_m0_wo0_cma0_x(2);
    u1_m0_wo0_cma0_y(3) <= u1_m0_wo0_cma0_s(4) + u1_m0_wo0_cma0_x(3);
    u1_m0_wo0_cma0_y(4) <= u1_m0_wo0_cma0_s(5) + u1_m0_wo0_cma0_x(4);
    u1_m0_wo0_cma0_y(5) <= u1_m0_wo0_cma0_s(6) + u1_m0_wo0_cma0_x(5);
    u1_m0_wo0_cma0_y(6) <= u1_m0_wo0_cma0_s(7) + u1_m0_wo0_cma0_x(6);
    u1_m0_wo0_cma0_y(7) <= u1_m0_wo0_cma0_s(8) + u1_m0_wo0_cma0_x(7);
    u1_m0_wo0_cma0_y(8) <= u1_m0_wo0_cma0_s(9) + u1_m0_wo0_cma0_x(8);
    u1_m0_wo0_cma0_y(9) <= u1_m0_wo0_cma0_s(10) + u1_m0_wo0_cma0_x(9);
    u1_m0_wo0_cma0_y(10) <= u1_m0_wo0_cma0_s(11) + u1_m0_wo0_cma0_x(10);
    u1_m0_wo0_cma0_y(11) <= u1_m0_wo0_cma0_s(12) + u1_m0_wo0_cma0_x(11);
    u1_m0_wo0_cma0_y(12) <= u1_m0_wo0_cma0_s(13) + u1_m0_wo0_cma0_x(12);
    u1_m0_wo0_cma0_y(13) <= u1_m0_wo0_cma0_s(14) + u1_m0_wo0_cma0_x(13);
    u1_m0_wo0_cma0_y(14) <= u1_m0_wo0_cma0_s(15) + u1_m0_wo0_cma0_x(14);
    u1_m0_wo0_cma0_y(15) <= u1_m0_wo0_cma0_s(16) + u1_m0_wo0_cma0_x(15);
    u1_m0_wo0_cma0_y(16) <= u1_m0_wo0_cma0_s(17) + u1_m0_wo0_cma0_x(16);
    u1_m0_wo0_cma0_y(17) <= u1_m0_wo0_cma0_s(18) + u1_m0_wo0_cma0_x(17);
    u1_m0_wo0_cma0_y(18) <= u1_m0_wo0_cma0_s(19) + u1_m0_wo0_cma0_x(18);
    u1_m0_wo0_cma0_y(19) <= u1_m0_wo0_cma0_s(20) + u1_m0_wo0_cma0_x(19);
    u1_m0_wo0_cma0_y(20) <= u1_m0_wo0_cma0_s(21) + u1_m0_wo0_cma0_x(20);
    u1_m0_wo0_cma0_y(21) <= u1_m0_wo0_cma0_s(22) + u1_m0_wo0_cma0_x(21);
    u1_m0_wo0_cma0_y(22) <= u1_m0_wo0_cma0_s(23) + u1_m0_wo0_cma0_x(22);
    u1_m0_wo0_cma0_y(23) <= u1_m0_wo0_cma0_s(24) + u1_m0_wo0_cma0_x(23);
    u1_m0_wo0_cma0_y(24) <= u1_m0_wo0_cma0_s(25) + u1_m0_wo0_cma0_x(24);
    u1_m0_wo0_cma0_y(25) <= u1_m0_wo0_cma0_s(26) + u1_m0_wo0_cma0_x(25);
    u1_m0_wo0_cma0_y(26) <= u1_m0_wo0_cma0_s(27) + u1_m0_wo0_cma0_x(26);
    u1_m0_wo0_cma0_y(27) <= u1_m0_wo0_cma0_s(28) + u1_m0_wo0_cma0_x(27);
    u1_m0_wo0_cma0_y(28) <= u1_m0_wo0_cma0_s(29) + u1_m0_wo0_cma0_x(28);
    u1_m0_wo0_cma0_y(29) <= u1_m0_wo0_cma0_s(30) + u1_m0_wo0_cma0_x(29);
    u1_m0_wo0_cma0_y(30) <= u1_m0_wo0_cma0_s(31) + u1_m0_wo0_cma0_x(30);
    u1_m0_wo0_cma0_y(31) <= u1_m0_wo0_cma0_x(31);
    u1_m0_wo0_cma0_chainmultadd: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u1_m0_wo0_cma0_a0 <= (others => (others => '0'));
            u1_m0_wo0_cma0_c0 <= (others => (others => '0'));
            u1_m0_wo0_cma0_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (input_valid_q = "1") THEN
                u1_m0_wo0_cma0_a0(0) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(1) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(2) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(3) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(4) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(5) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(6) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(7) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(8) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(9) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(10) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(11) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(12) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(13) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(14) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(15) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(16) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(17) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(18) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(19) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(20) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(21) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(22) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(23) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(24) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(25) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(26) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(27) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(28) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(29) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(30) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_a0(31) <= RESIZE(SIGNED(xIn_1),8);
                u1_m0_wo0_cma0_c0(0) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(1) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(2) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(3) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(4) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(5) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(6) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(7) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(8) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(9) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(10) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(11) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(12) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(13) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(14) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(15) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(16) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(17) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(18) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(19) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(20) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(21) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(22) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(23) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(24) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(25) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(26) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(27) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(28) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(29) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(30) <= RESIZE(UNSIGNED(GND_q),3);
                u1_m0_wo0_cma0_c0(31) <= RESIZE(UNSIGNED(GND_q),3);
            END IF;
            IF (d_u1_m0_wo0_compute_q_11_q = "1") THEN
                u1_m0_wo0_cma0_s(0) <= u1_m0_wo0_cma0_y(0);
                u1_m0_wo0_cma0_s(1) <= u1_m0_wo0_cma0_y(1);
                u1_m0_wo0_cma0_s(2) <= u1_m0_wo0_cma0_y(2);
                u1_m0_wo0_cma0_s(3) <= u1_m0_wo0_cma0_y(3);
                u1_m0_wo0_cma0_s(4) <= u1_m0_wo0_cma0_y(4);
                u1_m0_wo0_cma0_s(5) <= u1_m0_wo0_cma0_y(5);
                u1_m0_wo0_cma0_s(6) <= u1_m0_wo0_cma0_y(6);
                u1_m0_wo0_cma0_s(7) <= u1_m0_wo0_cma0_y(7);
                u1_m0_wo0_cma0_s(8) <= u1_m0_wo0_cma0_y(8);
                u1_m0_wo0_cma0_s(9) <= u1_m0_wo0_cma0_y(9);
                u1_m0_wo0_cma0_s(10) <= u1_m0_wo0_cma0_y(10);
                u1_m0_wo0_cma0_s(11) <= u1_m0_wo0_cma0_y(11);
                u1_m0_wo0_cma0_s(12) <= u1_m0_wo0_cma0_y(12);
                u1_m0_wo0_cma0_s(13) <= u1_m0_wo0_cma0_y(13);
                u1_m0_wo0_cma0_s(14) <= u1_m0_wo0_cma0_y(14);
                u1_m0_wo0_cma0_s(15) <= u1_m0_wo0_cma0_y(15);
                u1_m0_wo0_cma0_s(16) <= u1_m0_wo0_cma0_y(16);
                u1_m0_wo0_cma0_s(17) <= u1_m0_wo0_cma0_y(17);
                u1_m0_wo0_cma0_s(18) <= u1_m0_wo0_cma0_y(18);
                u1_m0_wo0_cma0_s(19) <= u1_m0_wo0_cma0_y(19);
                u1_m0_wo0_cma0_s(20) <= u1_m0_wo0_cma0_y(20);
                u1_m0_wo0_cma0_s(21) <= u1_m0_wo0_cma0_y(21);
                u1_m0_wo0_cma0_s(22) <= u1_m0_wo0_cma0_y(22);
                u1_m0_wo0_cma0_s(23) <= u1_m0_wo0_cma0_y(23);
                u1_m0_wo0_cma0_s(24) <= u1_m0_wo0_cma0_y(24);
                u1_m0_wo0_cma0_s(25) <= u1_m0_wo0_cma0_y(25);
                u1_m0_wo0_cma0_s(26) <= u1_m0_wo0_cma0_y(26);
                u1_m0_wo0_cma0_s(27) <= u1_m0_wo0_cma0_y(27);
                u1_m0_wo0_cma0_s(28) <= u1_m0_wo0_cma0_y(28);
                u1_m0_wo0_cma0_s(29) <= u1_m0_wo0_cma0_y(29);
                u1_m0_wo0_cma0_s(30) <= u1_m0_wo0_cma0_y(30);
                u1_m0_wo0_cma0_s(31) <= u1_m0_wo0_cma0_y(31);
            END IF;
        END IF;
    END PROCESS;
    u1_m0_wo0_cma0_delay : dspba_delay
    GENERIC MAP ( width => 24, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u1_m0_wo0_cma0_s(0)(23 downto 0)), xout => u1_m0_wo0_cma0_qq, clk => clk, aclr => areset );
    u1_m0_wo0_cma0_q <= STD_LOGIC_VECTOR(u1_m0_wo0_cma0_qq(23 downto 0));

    -- u1_m0_wo0_mtree_add0_0(ADD,418)@12 + 1
    u1_m0_wo0_mtree_add0_0_a <= STD_LOGIC_VECTOR(u1_m0_wo0_cma0_q(22 downto 0));
    u1_m0_wo0_mtree_add0_0_b <= STD_LOGIC_VECTOR(u1_m0_wo0_cma1_q(22 downto 0));
    u1_m0_wo0_mtree_add0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u1_m0_wo0_mtree_add0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u1_m0_wo0_mtree_add0_0_o <= STD_LOGIC_VECTOR(SIGNED(u1_m0_wo0_mtree_add0_0_a) + SIGNED(u1_m0_wo0_mtree_add0_0_b));
        END IF;
    END PROCESS;
    u1_m0_wo0_mtree_add0_0_q <= u1_m0_wo0_mtree_add0_0_o(22 downto 0);

    -- u1_m0_wo0_mtree_add1_0(ADD,419)@13 + 1
    u1_m0_wo0_mtree_add1_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 23 => u1_m0_wo0_mtree_add0_0_q(22)) & u1_m0_wo0_mtree_add0_0_q));
    u1_m0_wo0_mtree_add1_0_b <= STD_LOGIC_VECTOR(u1_m0_wo0_cma2_q);
    u1_m0_wo0_mtree_add1_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u1_m0_wo0_mtree_add1_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u1_m0_wo0_mtree_add1_0_o <= STD_LOGIC_VECTOR(SIGNED(u1_m0_wo0_mtree_add1_0_a) + SIGNED(u1_m0_wo0_mtree_add1_0_b));
        END IF;
    END PROCESS;
    u1_m0_wo0_mtree_add1_0_q <= u1_m0_wo0_mtree_add1_0_o(23 downto 0);

    -- u0_m0_wo0_wi0_r0_delayr32_notEnable(LOGICAL,446)@10
    u0_m0_wo0_wi0_r0_delayr32_notEnable_a <= STD_LOGIC_VECTOR(input_valid_q);
    u0_m0_wo0_wi0_r0_delayr32_notEnable_q <= not (u0_m0_wo0_wi0_r0_delayr32_notEnable_a);

    -- u0_m0_wo0_wi0_r0_delayr32_nor(LOGICAL,447)@10
    u0_m0_wo0_wi0_r0_delayr32_nor_a <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_notEnable_q);
    u0_m0_wo0_wi0_r0_delayr32_nor_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_sticky_ena_q);
    u0_m0_wo0_wi0_r0_delayr32_nor_q <= not (u0_m0_wo0_wi0_r0_delayr32_nor_a or u0_m0_wo0_wi0_r0_delayr32_nor_b);

    -- u0_m0_wo0_wi0_r0_delayr32_mem_last(CONSTANT,443)
    u0_m0_wo0_wi0_r0_delayr32_mem_last_q <= "011101";

    -- u0_m0_wo0_wi0_r0_delayr32_cmp(LOGICAL,444)@10
    u0_m0_wo0_wi0_r0_delayr32_cmp_a <= u0_m0_wo0_wi0_r0_delayr32_mem_last_q;
    u0_m0_wo0_wi0_r0_delayr32_cmp_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_delayr32_rdmux_q);
    u0_m0_wo0_wi0_r0_delayr32_cmp_q <= "1" WHEN u0_m0_wo0_wi0_r0_delayr32_cmp_a = u0_m0_wo0_wi0_r0_delayr32_cmp_b ELSE "0";

    -- u0_m0_wo0_wi0_r0_delayr32_cmpReg(REG,445)@10 + 1
    u0_m0_wo0_wi0_r0_delayr32_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr32_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (input_valid_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr32_cmpReg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr32_sticky_ena(REG,448)@10 + 1
    u0_m0_wo0_wi0_r0_delayr32_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr32_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr32_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr32_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr32_enaAnd(LOGICAL,449)@10
    u0_m0_wo0_wi0_r0_delayr32_enaAnd_a <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_sticky_ena_q);
    u0_m0_wo0_wi0_r0_delayr32_enaAnd_b <= STD_LOGIC_VECTOR(input_valid_q);
    u0_m0_wo0_wi0_r0_delayr32_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr32_enaAnd_a and u0_m0_wo0_wi0_r0_delayr32_enaAnd_b;

    -- u0_m0_wo0_wi0_r0_delayr32_rdcnt(COUNTER,440)@10 + 1
    -- low=0, high=30, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr32_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr32_rdcnt_i <= TO_UNSIGNED(0, 5);
            u0_m0_wo0_wi0_r0_delayr32_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (input_valid_q = "1") THEN
                IF (u0_m0_wo0_wi0_r0_delayr32_rdcnt_i = TO_UNSIGNED(29, 5)) THEN
                    u0_m0_wo0_wi0_r0_delayr32_rdcnt_eq <= '1';
                ELSE
                    u0_m0_wo0_wi0_r0_delayr32_rdcnt_eq <= '0';
                END IF;
                IF (u0_m0_wo0_wi0_r0_delayr32_rdcnt_eq = '1') THEN
                    u0_m0_wo0_wi0_r0_delayr32_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr32_rdcnt_i + 2;
                ELSE
                    u0_m0_wo0_wi0_r0_delayr32_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr32_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr32_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr32_rdcnt_i, 5)));

    -- u0_m0_wo0_wi0_r0_delayr32_rdmux(MUX,441)@10
    u0_m0_wo0_wi0_r0_delayr32_rdmux_s <= input_valid_q;
    u0_m0_wo0_wi0_r0_delayr32_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr32_rdmux_s, u0_m0_wo0_wi0_r0_delayr32_wraddr_q, u0_m0_wo0_wi0_r0_delayr32_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr32_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr32_rdmux_q <= u0_m0_wo0_wi0_r0_delayr32_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr32_rdmux_q <= u0_m0_wo0_wi0_r0_delayr32_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr32_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join32(BITJOIN,47)@10
    u0_m0_wo0_wi0_r0_join32_q <= u0_m0_wo0_wi0_r0_split32_b & xIn_0;

    -- u0_m0_wo0_wi0_r0_delayr32_wraddr(REG,442)@10 + 1
    u0_m0_wo0_wi0_r0_delayr32_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr32_wraddr_q <= "11110";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr32_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr32_mem(DUALMEM,439)@10 + 2
    u0_m0_wo0_wi0_r0_delayr32_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join32_q);
    u0_m0_wo0_wi0_r0_delayr32_mem_aa <= u0_m0_wo0_wi0_r0_delayr32_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr32_mem_ab <= u0_m0_wo0_wi0_r0_delayr32_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr32_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr32_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 5,
        numwords_a => 31,
        width_b => 16,
        widthad_b => 5,
        numwords_b => 31,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr32_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr32_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr32_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr32_mem_ia,
        wren_a => input_valid_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr32_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr32_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr32_mem_q <= u0_m0_wo0_wi0_r0_delayr32_mem_iq(15 downto 0);

    -- u0_m0_wo0_wi0_r0_split32(BITSELECT,48)@10
    u0_m0_wo0_wi0_r0_split32_in <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_mem_q);
    u0_m0_wo0_wi0_r0_split32_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_split32_in(7 downto 0));
    u0_m0_wo0_wi0_r0_split32_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_split32_in(15 downto 8));

    -- d_u0_m0_wo0_wi0_r0_split32_c_11(DELAY,434)@10 + 1
    d_u0_m0_wo0_wi0_r0_split32_c_11 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_split32_c, xout => d_u0_m0_wo0_wi0_r0_split32_c_11_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_12(DELAY,432)@11 + 1
    d_u0_m0_wo0_compute_q_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_11_q, xout => d_u0_m0_wo0_compute_q_12_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_11(DELAY,431)@10 + 1
    d_u0_m0_wo0_compute_q_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => input_valid_q, xout => d_u0_m0_wo0_compute_q_11_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_cma2(CHAINMULTADD,210)@11 + 2
    -- altera synthesis_off
    u0_m0_wo0_cma2_k0 <= (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k1 <= (
        0 => TO_SIGNED(6,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k2 <= (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k3 <= (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k4 <= (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k5 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k6 <= (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k7 <= (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k8 <= (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k9 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k10 <= (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k11 <= (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k12 <= (
        0 => TO_SIGNED(3,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k13 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k14 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k15 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k16 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k17 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k18 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k19 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k20 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k21 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k22 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k23 <= (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k24 <= (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k25 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k26 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k27 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k28 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k29 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k30 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k31 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_cma2_r(0) <= u0_m0_wo0_cma2_k0(TO_INTEGER(u0_m0_wo0_cma2_c0(0)));
    u0_m0_wo0_cma2_r(1) <= u0_m0_wo0_cma2_k1(TO_INTEGER(u0_m0_wo0_cma2_c0(1)));
    u0_m0_wo0_cma2_r(2) <= u0_m0_wo0_cma2_k2(TO_INTEGER(u0_m0_wo0_cma2_c0(2)));
    u0_m0_wo0_cma2_r(3) <= u0_m0_wo0_cma2_k3(TO_INTEGER(u0_m0_wo0_cma2_c0(3)));
    u0_m0_wo0_cma2_r(4) <= u0_m0_wo0_cma2_k4(TO_INTEGER(u0_m0_wo0_cma2_c0(4)));
    u0_m0_wo0_cma2_r(5) <= u0_m0_wo0_cma2_k5(TO_INTEGER(u0_m0_wo0_cma2_c0(5)));
    u0_m0_wo0_cma2_r(6) <= u0_m0_wo0_cma2_k6(TO_INTEGER(u0_m0_wo0_cma2_c0(6)));
    u0_m0_wo0_cma2_r(7) <= u0_m0_wo0_cma2_k7(TO_INTEGER(u0_m0_wo0_cma2_c0(7)));
    u0_m0_wo0_cma2_r(8) <= u0_m0_wo0_cma2_k8(TO_INTEGER(u0_m0_wo0_cma2_c0(8)));
    u0_m0_wo0_cma2_r(9) <= u0_m0_wo0_cma2_k9(TO_INTEGER(u0_m0_wo0_cma2_c0(9)));
    u0_m0_wo0_cma2_r(10) <= u0_m0_wo0_cma2_k10(TO_INTEGER(u0_m0_wo0_cma2_c0(10)));
    u0_m0_wo0_cma2_r(11) <= u0_m0_wo0_cma2_k11(TO_INTEGER(u0_m0_wo0_cma2_c0(11)));
    u0_m0_wo0_cma2_r(12) <= u0_m0_wo0_cma2_k12(TO_INTEGER(u0_m0_wo0_cma2_c0(12)));
    u0_m0_wo0_cma2_r(13) <= u0_m0_wo0_cma2_k13(TO_INTEGER(u0_m0_wo0_cma2_c0(13)));
    u0_m0_wo0_cma2_r(14) <= u0_m0_wo0_cma2_k14(TO_INTEGER(u0_m0_wo0_cma2_c0(14)));
    u0_m0_wo0_cma2_r(15) <= u0_m0_wo0_cma2_k15(TO_INTEGER(u0_m0_wo0_cma2_c0(15)));
    u0_m0_wo0_cma2_r(16) <= u0_m0_wo0_cma2_k16(TO_INTEGER(u0_m0_wo0_cma2_c0(16)));
    u0_m0_wo0_cma2_r(17) <= u0_m0_wo0_cma2_k17(TO_INTEGER(u0_m0_wo0_cma2_c0(17)));
    u0_m0_wo0_cma2_r(18) <= u0_m0_wo0_cma2_k18(TO_INTEGER(u0_m0_wo0_cma2_c0(18)));
    u0_m0_wo0_cma2_r(19) <= u0_m0_wo0_cma2_k19(TO_INTEGER(u0_m0_wo0_cma2_c0(19)));
    u0_m0_wo0_cma2_r(20) <= u0_m0_wo0_cma2_k20(TO_INTEGER(u0_m0_wo0_cma2_c0(20)));
    u0_m0_wo0_cma2_r(21) <= u0_m0_wo0_cma2_k21(TO_INTEGER(u0_m0_wo0_cma2_c0(21)));
    u0_m0_wo0_cma2_r(22) <= u0_m0_wo0_cma2_k22(TO_INTEGER(u0_m0_wo0_cma2_c0(22)));
    u0_m0_wo0_cma2_r(23) <= u0_m0_wo0_cma2_k23(TO_INTEGER(u0_m0_wo0_cma2_c0(23)));
    u0_m0_wo0_cma2_r(24) <= u0_m0_wo0_cma2_k24(TO_INTEGER(u0_m0_wo0_cma2_c0(24)));
    u0_m0_wo0_cma2_r(25) <= u0_m0_wo0_cma2_k25(TO_INTEGER(u0_m0_wo0_cma2_c0(25)));
    u0_m0_wo0_cma2_r(26) <= u0_m0_wo0_cma2_k26(TO_INTEGER(u0_m0_wo0_cma2_c0(26)));
    u0_m0_wo0_cma2_r(27) <= u0_m0_wo0_cma2_k27(TO_INTEGER(u0_m0_wo0_cma2_c0(27)));
    u0_m0_wo0_cma2_r(28) <= u0_m0_wo0_cma2_k28(TO_INTEGER(u0_m0_wo0_cma2_c0(28)));
    u0_m0_wo0_cma2_r(29) <= u0_m0_wo0_cma2_k29(TO_INTEGER(u0_m0_wo0_cma2_c0(29)));
    u0_m0_wo0_cma2_r(30) <= u0_m0_wo0_cma2_k30(TO_INTEGER(u0_m0_wo0_cma2_c0(30)));
    u0_m0_wo0_cma2_r(31) <= u0_m0_wo0_cma2_k31(TO_INTEGER(u0_m0_wo0_cma2_c0(31)));
    u0_m0_wo0_cma2_p(0) <= u0_m0_wo0_cma2_a0(0) * u0_m0_wo0_cma2_r(0);
    u0_m0_wo0_cma2_p(1) <= u0_m0_wo0_cma2_a0(1) * u0_m0_wo0_cma2_r(1);
    u0_m0_wo0_cma2_p(2) <= u0_m0_wo0_cma2_a0(2) * u0_m0_wo0_cma2_r(2);
    u0_m0_wo0_cma2_p(3) <= u0_m0_wo0_cma2_a0(3) * u0_m0_wo0_cma2_r(3);
    u0_m0_wo0_cma2_p(4) <= u0_m0_wo0_cma2_a0(4) * u0_m0_wo0_cma2_r(4);
    u0_m0_wo0_cma2_p(5) <= u0_m0_wo0_cma2_a0(5) * u0_m0_wo0_cma2_r(5);
    u0_m0_wo0_cma2_p(6) <= u0_m0_wo0_cma2_a0(6) * u0_m0_wo0_cma2_r(6);
    u0_m0_wo0_cma2_p(7) <= u0_m0_wo0_cma2_a0(7) * u0_m0_wo0_cma2_r(7);
    u0_m0_wo0_cma2_p(8) <= u0_m0_wo0_cma2_a0(8) * u0_m0_wo0_cma2_r(8);
    u0_m0_wo0_cma2_p(9) <= u0_m0_wo0_cma2_a0(9) * u0_m0_wo0_cma2_r(9);
    u0_m0_wo0_cma2_p(10) <= u0_m0_wo0_cma2_a0(10) * u0_m0_wo0_cma2_r(10);
    u0_m0_wo0_cma2_p(11) <= u0_m0_wo0_cma2_a0(11) * u0_m0_wo0_cma2_r(11);
    u0_m0_wo0_cma2_p(12) <= u0_m0_wo0_cma2_a0(12) * u0_m0_wo0_cma2_r(12);
    u0_m0_wo0_cma2_p(13) <= u0_m0_wo0_cma2_a0(13) * u0_m0_wo0_cma2_r(13);
    u0_m0_wo0_cma2_p(14) <= u0_m0_wo0_cma2_a0(14) * u0_m0_wo0_cma2_r(14);
    u0_m0_wo0_cma2_p(15) <= u0_m0_wo0_cma2_a0(15) * u0_m0_wo0_cma2_r(15);
    u0_m0_wo0_cma2_p(16) <= u0_m0_wo0_cma2_a0(16) * u0_m0_wo0_cma2_r(16);
    u0_m0_wo0_cma2_p(17) <= u0_m0_wo0_cma2_a0(17) * u0_m0_wo0_cma2_r(17);
    u0_m0_wo0_cma2_p(18) <= u0_m0_wo0_cma2_a0(18) * u0_m0_wo0_cma2_r(18);
    u0_m0_wo0_cma2_p(19) <= u0_m0_wo0_cma2_a0(19) * u0_m0_wo0_cma2_r(19);
    u0_m0_wo0_cma2_p(20) <= u0_m0_wo0_cma2_a0(20) * u0_m0_wo0_cma2_r(20);
    u0_m0_wo0_cma2_p(21) <= u0_m0_wo0_cma2_a0(21) * u0_m0_wo0_cma2_r(21);
    u0_m0_wo0_cma2_p(22) <= u0_m0_wo0_cma2_a0(22) * u0_m0_wo0_cma2_r(22);
    u0_m0_wo0_cma2_p(23) <= u0_m0_wo0_cma2_a0(23) * u0_m0_wo0_cma2_r(23);
    u0_m0_wo0_cma2_p(24) <= u0_m0_wo0_cma2_a0(24) * u0_m0_wo0_cma2_r(24);
    u0_m0_wo0_cma2_p(25) <= u0_m0_wo0_cma2_a0(25) * u0_m0_wo0_cma2_r(25);
    u0_m0_wo0_cma2_p(26) <= u0_m0_wo0_cma2_a0(26) * u0_m0_wo0_cma2_r(26);
    u0_m0_wo0_cma2_p(27) <= u0_m0_wo0_cma2_a0(27) * u0_m0_wo0_cma2_r(27);
    u0_m0_wo0_cma2_p(28) <= u0_m0_wo0_cma2_a0(28) * u0_m0_wo0_cma2_r(28);
    u0_m0_wo0_cma2_p(29) <= u0_m0_wo0_cma2_a0(29) * u0_m0_wo0_cma2_r(29);
    u0_m0_wo0_cma2_p(30) <= u0_m0_wo0_cma2_a0(30) * u0_m0_wo0_cma2_r(30);
    u0_m0_wo0_cma2_p(31) <= u0_m0_wo0_cma2_a0(31) * u0_m0_wo0_cma2_r(31);
    u0_m0_wo0_cma2_u(0) <= RESIZE(u0_m0_wo0_cma2_p(0),24);
    u0_m0_wo0_cma2_u(1) <= RESIZE(u0_m0_wo0_cma2_p(1),24);
    u0_m0_wo0_cma2_u(2) <= RESIZE(u0_m0_wo0_cma2_p(2),24);
    u0_m0_wo0_cma2_u(3) <= RESIZE(u0_m0_wo0_cma2_p(3),24);
    u0_m0_wo0_cma2_u(4) <= RESIZE(u0_m0_wo0_cma2_p(4),24);
    u0_m0_wo0_cma2_u(5) <= RESIZE(u0_m0_wo0_cma2_p(5),24);
    u0_m0_wo0_cma2_u(6) <= RESIZE(u0_m0_wo0_cma2_p(6),24);
    u0_m0_wo0_cma2_u(7) <= RESIZE(u0_m0_wo0_cma2_p(7),24);
    u0_m0_wo0_cma2_u(8) <= RESIZE(u0_m0_wo0_cma2_p(8),24);
    u0_m0_wo0_cma2_u(9) <= RESIZE(u0_m0_wo0_cma2_p(9),24);
    u0_m0_wo0_cma2_u(10) <= RESIZE(u0_m0_wo0_cma2_p(10),24);
    u0_m0_wo0_cma2_u(11) <= RESIZE(u0_m0_wo0_cma2_p(11),24);
    u0_m0_wo0_cma2_u(12) <= RESIZE(u0_m0_wo0_cma2_p(12),24);
    u0_m0_wo0_cma2_u(13) <= RESIZE(u0_m0_wo0_cma2_p(13),24);
    u0_m0_wo0_cma2_u(14) <= RESIZE(u0_m0_wo0_cma2_p(14),24);
    u0_m0_wo0_cma2_u(15) <= RESIZE(u0_m0_wo0_cma2_p(15),24);
    u0_m0_wo0_cma2_u(16) <= RESIZE(u0_m0_wo0_cma2_p(16),24);
    u0_m0_wo0_cma2_u(17) <= RESIZE(u0_m0_wo0_cma2_p(17),24);
    u0_m0_wo0_cma2_u(18) <= RESIZE(u0_m0_wo0_cma2_p(18),24);
    u0_m0_wo0_cma2_u(19) <= RESIZE(u0_m0_wo0_cma2_p(19),24);
    u0_m0_wo0_cma2_u(20) <= RESIZE(u0_m0_wo0_cma2_p(20),24);
    u0_m0_wo0_cma2_u(21) <= RESIZE(u0_m0_wo0_cma2_p(21),24);
    u0_m0_wo0_cma2_u(22) <= RESIZE(u0_m0_wo0_cma2_p(22),24);
    u0_m0_wo0_cma2_u(23) <= RESIZE(u0_m0_wo0_cma2_p(23),24);
    u0_m0_wo0_cma2_u(24) <= RESIZE(u0_m0_wo0_cma2_p(24),24);
    u0_m0_wo0_cma2_u(25) <= RESIZE(u0_m0_wo0_cma2_p(25),24);
    u0_m0_wo0_cma2_u(26) <= RESIZE(u0_m0_wo0_cma2_p(26),24);
    u0_m0_wo0_cma2_u(27) <= RESIZE(u0_m0_wo0_cma2_p(27),24);
    u0_m0_wo0_cma2_u(28) <= RESIZE(u0_m0_wo0_cma2_p(28),24);
    u0_m0_wo0_cma2_u(29) <= RESIZE(u0_m0_wo0_cma2_p(29),24);
    u0_m0_wo0_cma2_u(30) <= RESIZE(u0_m0_wo0_cma2_p(30),24);
    u0_m0_wo0_cma2_u(31) <= RESIZE(u0_m0_wo0_cma2_p(31),24);
    u0_m0_wo0_cma2_w(0) <= u0_m0_wo0_cma2_u(0);
    u0_m0_wo0_cma2_w(1) <= u0_m0_wo0_cma2_u(1);
    u0_m0_wo0_cma2_w(2) <= u0_m0_wo0_cma2_u(2);
    u0_m0_wo0_cma2_w(3) <= u0_m0_wo0_cma2_u(3);
    u0_m0_wo0_cma2_w(4) <= u0_m0_wo0_cma2_u(4);
    u0_m0_wo0_cma2_w(5) <= u0_m0_wo0_cma2_u(5);
    u0_m0_wo0_cma2_w(6) <= u0_m0_wo0_cma2_u(6);
    u0_m0_wo0_cma2_w(7) <= u0_m0_wo0_cma2_u(7);
    u0_m0_wo0_cma2_w(8) <= u0_m0_wo0_cma2_u(8);
    u0_m0_wo0_cma2_w(9) <= u0_m0_wo0_cma2_u(9);
    u0_m0_wo0_cma2_w(10) <= u0_m0_wo0_cma2_u(10);
    u0_m0_wo0_cma2_w(11) <= u0_m0_wo0_cma2_u(11);
    u0_m0_wo0_cma2_w(12) <= u0_m0_wo0_cma2_u(12);
    u0_m0_wo0_cma2_w(13) <= u0_m0_wo0_cma2_u(13);
    u0_m0_wo0_cma2_w(14) <= u0_m0_wo0_cma2_u(14);
    u0_m0_wo0_cma2_w(15) <= u0_m0_wo0_cma2_u(15);
    u0_m0_wo0_cma2_w(16) <= u0_m0_wo0_cma2_u(16);
    u0_m0_wo0_cma2_w(17) <= u0_m0_wo0_cma2_u(17);
    u0_m0_wo0_cma2_w(18) <= u0_m0_wo0_cma2_u(18);
    u0_m0_wo0_cma2_w(19) <= u0_m0_wo0_cma2_u(19);
    u0_m0_wo0_cma2_w(20) <= u0_m0_wo0_cma2_u(20);
    u0_m0_wo0_cma2_w(21) <= u0_m0_wo0_cma2_u(21);
    u0_m0_wo0_cma2_w(22) <= u0_m0_wo0_cma2_u(22);
    u0_m0_wo0_cma2_w(23) <= u0_m0_wo0_cma2_u(23);
    u0_m0_wo0_cma2_w(24) <= u0_m0_wo0_cma2_u(24);
    u0_m0_wo0_cma2_w(25) <= u0_m0_wo0_cma2_u(25);
    u0_m0_wo0_cma2_w(26) <= u0_m0_wo0_cma2_u(26);
    u0_m0_wo0_cma2_w(27) <= u0_m0_wo0_cma2_u(27);
    u0_m0_wo0_cma2_w(28) <= u0_m0_wo0_cma2_u(28);
    u0_m0_wo0_cma2_w(29) <= u0_m0_wo0_cma2_u(29);
    u0_m0_wo0_cma2_w(30) <= u0_m0_wo0_cma2_u(30);
    u0_m0_wo0_cma2_w(31) <= u0_m0_wo0_cma2_u(31);
    u0_m0_wo0_cma2_x(0) <= u0_m0_wo0_cma2_w(0);
    u0_m0_wo0_cma2_x(1) <= u0_m0_wo0_cma2_w(1);
    u0_m0_wo0_cma2_x(2) <= u0_m0_wo0_cma2_w(2);
    u0_m0_wo0_cma2_x(3) <= u0_m0_wo0_cma2_w(3);
    u0_m0_wo0_cma2_x(4) <= u0_m0_wo0_cma2_w(4);
    u0_m0_wo0_cma2_x(5) <= u0_m0_wo0_cma2_w(5);
    u0_m0_wo0_cma2_x(6) <= u0_m0_wo0_cma2_w(6);
    u0_m0_wo0_cma2_x(7) <= u0_m0_wo0_cma2_w(7);
    u0_m0_wo0_cma2_x(8) <= u0_m0_wo0_cma2_w(8);
    u0_m0_wo0_cma2_x(9) <= u0_m0_wo0_cma2_w(9);
    u0_m0_wo0_cma2_x(10) <= u0_m0_wo0_cma2_w(10);
    u0_m0_wo0_cma2_x(11) <= u0_m0_wo0_cma2_w(11);
    u0_m0_wo0_cma2_x(12) <= u0_m0_wo0_cma2_w(12);
    u0_m0_wo0_cma2_x(13) <= u0_m0_wo0_cma2_w(13);
    u0_m0_wo0_cma2_x(14) <= u0_m0_wo0_cma2_w(14);
    u0_m0_wo0_cma2_x(15) <= u0_m0_wo0_cma2_w(15);
    u0_m0_wo0_cma2_x(16) <= u0_m0_wo0_cma2_w(16);
    u0_m0_wo0_cma2_x(17) <= u0_m0_wo0_cma2_w(17);
    u0_m0_wo0_cma2_x(18) <= u0_m0_wo0_cma2_w(18);
    u0_m0_wo0_cma2_x(19) <= u0_m0_wo0_cma2_w(19);
    u0_m0_wo0_cma2_x(20) <= u0_m0_wo0_cma2_w(20);
    u0_m0_wo0_cma2_x(21) <= u0_m0_wo0_cma2_w(21);
    u0_m0_wo0_cma2_x(22) <= u0_m0_wo0_cma2_w(22);
    u0_m0_wo0_cma2_x(23) <= u0_m0_wo0_cma2_w(23);
    u0_m0_wo0_cma2_x(24) <= u0_m0_wo0_cma2_w(24);
    u0_m0_wo0_cma2_x(25) <= u0_m0_wo0_cma2_w(25);
    u0_m0_wo0_cma2_x(26) <= u0_m0_wo0_cma2_w(26);
    u0_m0_wo0_cma2_x(27) <= u0_m0_wo0_cma2_w(27);
    u0_m0_wo0_cma2_x(28) <= u0_m0_wo0_cma2_w(28);
    u0_m0_wo0_cma2_x(29) <= u0_m0_wo0_cma2_w(29);
    u0_m0_wo0_cma2_x(30) <= u0_m0_wo0_cma2_w(30);
    u0_m0_wo0_cma2_x(31) <= u0_m0_wo0_cma2_w(31);
    u0_m0_wo0_cma2_y(0) <= u0_m0_wo0_cma2_s(1) + u0_m0_wo0_cma2_x(0);
    u0_m0_wo0_cma2_y(1) <= u0_m0_wo0_cma2_s(2) + u0_m0_wo0_cma2_x(1);
    u0_m0_wo0_cma2_y(2) <= u0_m0_wo0_cma2_s(3) + u0_m0_wo0_cma2_x(2);
    u0_m0_wo0_cma2_y(3) <= u0_m0_wo0_cma2_s(4) + u0_m0_wo0_cma2_x(3);
    u0_m0_wo0_cma2_y(4) <= u0_m0_wo0_cma2_s(5) + u0_m0_wo0_cma2_x(4);
    u0_m0_wo0_cma2_y(5) <= u0_m0_wo0_cma2_s(6) + u0_m0_wo0_cma2_x(5);
    u0_m0_wo0_cma2_y(6) <= u0_m0_wo0_cma2_s(7) + u0_m0_wo0_cma2_x(6);
    u0_m0_wo0_cma2_y(7) <= u0_m0_wo0_cma2_s(8) + u0_m0_wo0_cma2_x(7);
    u0_m0_wo0_cma2_y(8) <= u0_m0_wo0_cma2_s(9) + u0_m0_wo0_cma2_x(8);
    u0_m0_wo0_cma2_y(9) <= u0_m0_wo0_cma2_s(10) + u0_m0_wo0_cma2_x(9);
    u0_m0_wo0_cma2_y(10) <= u0_m0_wo0_cma2_s(11) + u0_m0_wo0_cma2_x(10);
    u0_m0_wo0_cma2_y(11) <= u0_m0_wo0_cma2_s(12) + u0_m0_wo0_cma2_x(11);
    u0_m0_wo0_cma2_y(12) <= u0_m0_wo0_cma2_s(13) + u0_m0_wo0_cma2_x(12);
    u0_m0_wo0_cma2_y(13) <= u0_m0_wo0_cma2_s(14) + u0_m0_wo0_cma2_x(13);
    u0_m0_wo0_cma2_y(14) <= u0_m0_wo0_cma2_s(15) + u0_m0_wo0_cma2_x(14);
    u0_m0_wo0_cma2_y(15) <= u0_m0_wo0_cma2_s(16) + u0_m0_wo0_cma2_x(15);
    u0_m0_wo0_cma2_y(16) <= u0_m0_wo0_cma2_s(17) + u0_m0_wo0_cma2_x(16);
    u0_m0_wo0_cma2_y(17) <= u0_m0_wo0_cma2_s(18) + u0_m0_wo0_cma2_x(17);
    u0_m0_wo0_cma2_y(18) <= u0_m0_wo0_cma2_s(19) + u0_m0_wo0_cma2_x(18);
    u0_m0_wo0_cma2_y(19) <= u0_m0_wo0_cma2_s(20) + u0_m0_wo0_cma2_x(19);
    u0_m0_wo0_cma2_y(20) <= u0_m0_wo0_cma2_s(21) + u0_m0_wo0_cma2_x(20);
    u0_m0_wo0_cma2_y(21) <= u0_m0_wo0_cma2_s(22) + u0_m0_wo0_cma2_x(21);
    u0_m0_wo0_cma2_y(22) <= u0_m0_wo0_cma2_s(23) + u0_m0_wo0_cma2_x(22);
    u0_m0_wo0_cma2_y(23) <= u0_m0_wo0_cma2_s(24) + u0_m0_wo0_cma2_x(23);
    u0_m0_wo0_cma2_y(24) <= u0_m0_wo0_cma2_s(25) + u0_m0_wo0_cma2_x(24);
    u0_m0_wo0_cma2_y(25) <= u0_m0_wo0_cma2_s(26) + u0_m0_wo0_cma2_x(25);
    u0_m0_wo0_cma2_y(26) <= u0_m0_wo0_cma2_s(27) + u0_m0_wo0_cma2_x(26);
    u0_m0_wo0_cma2_y(27) <= u0_m0_wo0_cma2_s(28) + u0_m0_wo0_cma2_x(27);
    u0_m0_wo0_cma2_y(28) <= u0_m0_wo0_cma2_s(29) + u0_m0_wo0_cma2_x(28);
    u0_m0_wo0_cma2_y(29) <= u0_m0_wo0_cma2_s(30) + u0_m0_wo0_cma2_x(29);
    u0_m0_wo0_cma2_y(30) <= u0_m0_wo0_cma2_s(31) + u0_m0_wo0_cma2_x(30);
    u0_m0_wo0_cma2_y(31) <= u0_m0_wo0_cma2_x(31);
    u0_m0_wo0_cma2_chainmultadd: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma2_a0 <= (others => (others => '0'));
            u0_m0_wo0_cma2_c0 <= (others => (others => '0'));
            u0_m0_wo0_cma2_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_11_q = "1") THEN
                u0_m0_wo0_cma2_a0(0) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(1) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(2) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(3) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(4) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(5) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(6) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(7) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(8) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(9) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(10) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(11) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(12) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(13) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(14) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(15) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(16) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(17) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(18) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(19) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(20) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(21) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(22) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(23) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(24) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(25) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(26) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(27) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(28) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(29) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(30) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_a0(31) <= RESIZE(SIGNED(d_u0_m0_wo0_wi0_r0_split32_c_11_q),8);
                u0_m0_wo0_cma2_c0(0) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(1) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(2) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(3) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(4) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(5) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(6) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(7) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(8) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(9) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(10) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(11) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(12) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(13) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(14) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(15) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(16) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(17) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(18) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(19) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(20) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(21) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(22) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(23) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(24) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(25) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(26) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(27) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(28) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(29) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(30) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma2_c0(31) <= RESIZE(UNSIGNED(GND_q),3);
            END IF;
            IF (d_u0_m0_wo0_compute_q_12_q = "1") THEN
                u0_m0_wo0_cma2_s(0) <= u0_m0_wo0_cma2_y(0);
                u0_m0_wo0_cma2_s(1) <= u0_m0_wo0_cma2_y(1);
                u0_m0_wo0_cma2_s(2) <= u0_m0_wo0_cma2_y(2);
                u0_m0_wo0_cma2_s(3) <= u0_m0_wo0_cma2_y(3);
                u0_m0_wo0_cma2_s(4) <= u0_m0_wo0_cma2_y(4);
                u0_m0_wo0_cma2_s(5) <= u0_m0_wo0_cma2_y(5);
                u0_m0_wo0_cma2_s(6) <= u0_m0_wo0_cma2_y(6);
                u0_m0_wo0_cma2_s(7) <= u0_m0_wo0_cma2_y(7);
                u0_m0_wo0_cma2_s(8) <= u0_m0_wo0_cma2_y(8);
                u0_m0_wo0_cma2_s(9) <= u0_m0_wo0_cma2_y(9);
                u0_m0_wo0_cma2_s(10) <= u0_m0_wo0_cma2_y(10);
                u0_m0_wo0_cma2_s(11) <= u0_m0_wo0_cma2_y(11);
                u0_m0_wo0_cma2_s(12) <= u0_m0_wo0_cma2_y(12);
                u0_m0_wo0_cma2_s(13) <= u0_m0_wo0_cma2_y(13);
                u0_m0_wo0_cma2_s(14) <= u0_m0_wo0_cma2_y(14);
                u0_m0_wo0_cma2_s(15) <= u0_m0_wo0_cma2_y(15);
                u0_m0_wo0_cma2_s(16) <= u0_m0_wo0_cma2_y(16);
                u0_m0_wo0_cma2_s(17) <= u0_m0_wo0_cma2_y(17);
                u0_m0_wo0_cma2_s(18) <= u0_m0_wo0_cma2_y(18);
                u0_m0_wo0_cma2_s(19) <= u0_m0_wo0_cma2_y(19);
                u0_m0_wo0_cma2_s(20) <= u0_m0_wo0_cma2_y(20);
                u0_m0_wo0_cma2_s(21) <= u0_m0_wo0_cma2_y(21);
                u0_m0_wo0_cma2_s(22) <= u0_m0_wo0_cma2_y(22);
                u0_m0_wo0_cma2_s(23) <= u0_m0_wo0_cma2_y(23);
                u0_m0_wo0_cma2_s(24) <= u0_m0_wo0_cma2_y(24);
                u0_m0_wo0_cma2_s(25) <= u0_m0_wo0_cma2_y(25);
                u0_m0_wo0_cma2_s(26) <= u0_m0_wo0_cma2_y(26);
                u0_m0_wo0_cma2_s(27) <= u0_m0_wo0_cma2_y(27);
                u0_m0_wo0_cma2_s(28) <= u0_m0_wo0_cma2_y(28);
                u0_m0_wo0_cma2_s(29) <= u0_m0_wo0_cma2_y(29);
                u0_m0_wo0_cma2_s(30) <= u0_m0_wo0_cma2_y(30);
                u0_m0_wo0_cma2_s(31) <= u0_m0_wo0_cma2_y(31);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma2_delay : dspba_delay
    GENERIC MAP ( width => 24, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_cma2_s(0)(23 downto 0)), xout => u0_m0_wo0_cma2_qq, clk => clk, aclr => areset );
    u0_m0_wo0_cma2_q <= STD_LOGIC_VECTOR(u0_m0_wo0_cma2_qq(23 downto 0));

    -- u0_m0_wo0_cma1(CHAINMULTADD,209)@10 + 2
    -- altera synthesis_off
    u0_m0_wo0_cma1_k0 <= (
        0 => TO_SIGNED(-14,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k1 <= (
        0 => TO_SIGNED(-19,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k2 <= (
        0 => TO_SIGNED(-12,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k3 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k4 <= (
        0 => TO_SIGNED(20,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k5 <= (
        0 => TO_SIGNED(29,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k6 <= (
        0 => TO_SIGNED(24,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k7 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k8 <= (
        0 => TO_SIGNED(-28,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k9 <= (
        0 => TO_SIGNED(-51,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k10 <= (
        0 => TO_SIGNED(-50,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k11 <= (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k12 <= (
        0 => TO_SIGNED(50,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k13 <= (
        0 => TO_SIGNED(133,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k14 <= (
        0 => TO_SIGNED(209,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k15 <= (
        0 => TO_SIGNED(255,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k16 <= (
        0 => TO_SIGNED(255,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k17 <= (
        0 => TO_SIGNED(209,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k18 <= (
        0 => TO_SIGNED(133,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k19 <= (
        0 => TO_SIGNED(50,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k20 <= (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k21 <= (
        0 => TO_SIGNED(-50,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k22 <= (
        0 => TO_SIGNED(-51,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k23 <= (
        0 => TO_SIGNED(-28,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k24 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k25 <= (
        0 => TO_SIGNED(24,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k26 <= (
        0 => TO_SIGNED(29,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k27 <= (
        0 => TO_SIGNED(20,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k28 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k29 <= (
        0 => TO_SIGNED(-12,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k30 <= (
        0 => TO_SIGNED(-19,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k31 <= (
        0 => TO_SIGNED(-14,11),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_cma1_r(0) <= u0_m0_wo0_cma1_k0(TO_INTEGER(u0_m0_wo0_cma1_c0(0)));
    u0_m0_wo0_cma1_r(1) <= u0_m0_wo0_cma1_k1(TO_INTEGER(u0_m0_wo0_cma1_c0(1)));
    u0_m0_wo0_cma1_r(2) <= u0_m0_wo0_cma1_k2(TO_INTEGER(u0_m0_wo0_cma1_c0(2)));
    u0_m0_wo0_cma1_r(3) <= u0_m0_wo0_cma1_k3(TO_INTEGER(u0_m0_wo0_cma1_c0(3)));
    u0_m0_wo0_cma1_r(4) <= u0_m0_wo0_cma1_k4(TO_INTEGER(u0_m0_wo0_cma1_c0(4)));
    u0_m0_wo0_cma1_r(5) <= u0_m0_wo0_cma1_k5(TO_INTEGER(u0_m0_wo0_cma1_c0(5)));
    u0_m0_wo0_cma1_r(6) <= u0_m0_wo0_cma1_k6(TO_INTEGER(u0_m0_wo0_cma1_c0(6)));
    u0_m0_wo0_cma1_r(7) <= u0_m0_wo0_cma1_k7(TO_INTEGER(u0_m0_wo0_cma1_c0(7)));
    u0_m0_wo0_cma1_r(8) <= u0_m0_wo0_cma1_k8(TO_INTEGER(u0_m0_wo0_cma1_c0(8)));
    u0_m0_wo0_cma1_r(9) <= u0_m0_wo0_cma1_k9(TO_INTEGER(u0_m0_wo0_cma1_c0(9)));
    u0_m0_wo0_cma1_r(10) <= u0_m0_wo0_cma1_k10(TO_INTEGER(u0_m0_wo0_cma1_c0(10)));
    u0_m0_wo0_cma1_r(11) <= u0_m0_wo0_cma1_k11(TO_INTEGER(u0_m0_wo0_cma1_c0(11)));
    u0_m0_wo0_cma1_r(12) <= u0_m0_wo0_cma1_k12(TO_INTEGER(u0_m0_wo0_cma1_c0(12)));
    u0_m0_wo0_cma1_r(13) <= u0_m0_wo0_cma1_k13(TO_INTEGER(u0_m0_wo0_cma1_c0(13)));
    u0_m0_wo0_cma1_r(14) <= u0_m0_wo0_cma1_k14(TO_INTEGER(u0_m0_wo0_cma1_c0(14)));
    u0_m0_wo0_cma1_r(15) <= u0_m0_wo0_cma1_k15(TO_INTEGER(u0_m0_wo0_cma1_c0(15)));
    u0_m0_wo0_cma1_r(16) <= u0_m0_wo0_cma1_k16(TO_INTEGER(u0_m0_wo0_cma1_c0(16)));
    u0_m0_wo0_cma1_r(17) <= u0_m0_wo0_cma1_k17(TO_INTEGER(u0_m0_wo0_cma1_c0(17)));
    u0_m0_wo0_cma1_r(18) <= u0_m0_wo0_cma1_k18(TO_INTEGER(u0_m0_wo0_cma1_c0(18)));
    u0_m0_wo0_cma1_r(19) <= u0_m0_wo0_cma1_k19(TO_INTEGER(u0_m0_wo0_cma1_c0(19)));
    u0_m0_wo0_cma1_r(20) <= u0_m0_wo0_cma1_k20(TO_INTEGER(u0_m0_wo0_cma1_c0(20)));
    u0_m0_wo0_cma1_r(21) <= u0_m0_wo0_cma1_k21(TO_INTEGER(u0_m0_wo0_cma1_c0(21)));
    u0_m0_wo0_cma1_r(22) <= u0_m0_wo0_cma1_k22(TO_INTEGER(u0_m0_wo0_cma1_c0(22)));
    u0_m0_wo0_cma1_r(23) <= u0_m0_wo0_cma1_k23(TO_INTEGER(u0_m0_wo0_cma1_c0(23)));
    u0_m0_wo0_cma1_r(24) <= u0_m0_wo0_cma1_k24(TO_INTEGER(u0_m0_wo0_cma1_c0(24)));
    u0_m0_wo0_cma1_r(25) <= u0_m0_wo0_cma1_k25(TO_INTEGER(u0_m0_wo0_cma1_c0(25)));
    u0_m0_wo0_cma1_r(26) <= u0_m0_wo0_cma1_k26(TO_INTEGER(u0_m0_wo0_cma1_c0(26)));
    u0_m0_wo0_cma1_r(27) <= u0_m0_wo0_cma1_k27(TO_INTEGER(u0_m0_wo0_cma1_c0(27)));
    u0_m0_wo0_cma1_r(28) <= u0_m0_wo0_cma1_k28(TO_INTEGER(u0_m0_wo0_cma1_c0(28)));
    u0_m0_wo0_cma1_r(29) <= u0_m0_wo0_cma1_k29(TO_INTEGER(u0_m0_wo0_cma1_c0(29)));
    u0_m0_wo0_cma1_r(30) <= u0_m0_wo0_cma1_k30(TO_INTEGER(u0_m0_wo0_cma1_c0(30)));
    u0_m0_wo0_cma1_r(31) <= u0_m0_wo0_cma1_k31(TO_INTEGER(u0_m0_wo0_cma1_c0(31)));
    u0_m0_wo0_cma1_p(0) <= u0_m0_wo0_cma1_a0(0) * u0_m0_wo0_cma1_r(0);
    u0_m0_wo0_cma1_p(1) <= u0_m0_wo0_cma1_a0(1) * u0_m0_wo0_cma1_r(1);
    u0_m0_wo0_cma1_p(2) <= u0_m0_wo0_cma1_a0(2) * u0_m0_wo0_cma1_r(2);
    u0_m0_wo0_cma1_p(3) <= u0_m0_wo0_cma1_a0(3) * u0_m0_wo0_cma1_r(3);
    u0_m0_wo0_cma1_p(4) <= u0_m0_wo0_cma1_a0(4) * u0_m0_wo0_cma1_r(4);
    u0_m0_wo0_cma1_p(5) <= u0_m0_wo0_cma1_a0(5) * u0_m0_wo0_cma1_r(5);
    u0_m0_wo0_cma1_p(6) <= u0_m0_wo0_cma1_a0(6) * u0_m0_wo0_cma1_r(6);
    u0_m0_wo0_cma1_p(7) <= u0_m0_wo0_cma1_a0(7) * u0_m0_wo0_cma1_r(7);
    u0_m0_wo0_cma1_p(8) <= u0_m0_wo0_cma1_a0(8) * u0_m0_wo0_cma1_r(8);
    u0_m0_wo0_cma1_p(9) <= u0_m0_wo0_cma1_a0(9) * u0_m0_wo0_cma1_r(9);
    u0_m0_wo0_cma1_p(10) <= u0_m0_wo0_cma1_a0(10) * u0_m0_wo0_cma1_r(10);
    u0_m0_wo0_cma1_p(11) <= u0_m0_wo0_cma1_a0(11) * u0_m0_wo0_cma1_r(11);
    u0_m0_wo0_cma1_p(12) <= u0_m0_wo0_cma1_a0(12) * u0_m0_wo0_cma1_r(12);
    u0_m0_wo0_cma1_p(13) <= u0_m0_wo0_cma1_a0(13) * u0_m0_wo0_cma1_r(13);
    u0_m0_wo0_cma1_p(14) <= u0_m0_wo0_cma1_a0(14) * u0_m0_wo0_cma1_r(14);
    u0_m0_wo0_cma1_p(15) <= u0_m0_wo0_cma1_a0(15) * u0_m0_wo0_cma1_r(15);
    u0_m0_wo0_cma1_p(16) <= u0_m0_wo0_cma1_a0(16) * u0_m0_wo0_cma1_r(16);
    u0_m0_wo0_cma1_p(17) <= u0_m0_wo0_cma1_a0(17) * u0_m0_wo0_cma1_r(17);
    u0_m0_wo0_cma1_p(18) <= u0_m0_wo0_cma1_a0(18) * u0_m0_wo0_cma1_r(18);
    u0_m0_wo0_cma1_p(19) <= u0_m0_wo0_cma1_a0(19) * u0_m0_wo0_cma1_r(19);
    u0_m0_wo0_cma1_p(20) <= u0_m0_wo0_cma1_a0(20) * u0_m0_wo0_cma1_r(20);
    u0_m0_wo0_cma1_p(21) <= u0_m0_wo0_cma1_a0(21) * u0_m0_wo0_cma1_r(21);
    u0_m0_wo0_cma1_p(22) <= u0_m0_wo0_cma1_a0(22) * u0_m0_wo0_cma1_r(22);
    u0_m0_wo0_cma1_p(23) <= u0_m0_wo0_cma1_a0(23) * u0_m0_wo0_cma1_r(23);
    u0_m0_wo0_cma1_p(24) <= u0_m0_wo0_cma1_a0(24) * u0_m0_wo0_cma1_r(24);
    u0_m0_wo0_cma1_p(25) <= u0_m0_wo0_cma1_a0(25) * u0_m0_wo0_cma1_r(25);
    u0_m0_wo0_cma1_p(26) <= u0_m0_wo0_cma1_a0(26) * u0_m0_wo0_cma1_r(26);
    u0_m0_wo0_cma1_p(27) <= u0_m0_wo0_cma1_a0(27) * u0_m0_wo0_cma1_r(27);
    u0_m0_wo0_cma1_p(28) <= u0_m0_wo0_cma1_a0(28) * u0_m0_wo0_cma1_r(28);
    u0_m0_wo0_cma1_p(29) <= u0_m0_wo0_cma1_a0(29) * u0_m0_wo0_cma1_r(29);
    u0_m0_wo0_cma1_p(30) <= u0_m0_wo0_cma1_a0(30) * u0_m0_wo0_cma1_r(30);
    u0_m0_wo0_cma1_p(31) <= u0_m0_wo0_cma1_a0(31) * u0_m0_wo0_cma1_r(31);
    u0_m0_wo0_cma1_u(0) <= RESIZE(u0_m0_wo0_cma1_p(0),24);
    u0_m0_wo0_cma1_u(1) <= RESIZE(u0_m0_wo0_cma1_p(1),24);
    u0_m0_wo0_cma1_u(2) <= RESIZE(u0_m0_wo0_cma1_p(2),24);
    u0_m0_wo0_cma1_u(3) <= RESIZE(u0_m0_wo0_cma1_p(3),24);
    u0_m0_wo0_cma1_u(4) <= RESIZE(u0_m0_wo0_cma1_p(4),24);
    u0_m0_wo0_cma1_u(5) <= RESIZE(u0_m0_wo0_cma1_p(5),24);
    u0_m0_wo0_cma1_u(6) <= RESIZE(u0_m0_wo0_cma1_p(6),24);
    u0_m0_wo0_cma1_u(7) <= RESIZE(u0_m0_wo0_cma1_p(7),24);
    u0_m0_wo0_cma1_u(8) <= RESIZE(u0_m0_wo0_cma1_p(8),24);
    u0_m0_wo0_cma1_u(9) <= RESIZE(u0_m0_wo0_cma1_p(9),24);
    u0_m0_wo0_cma1_u(10) <= RESIZE(u0_m0_wo0_cma1_p(10),24);
    u0_m0_wo0_cma1_u(11) <= RESIZE(u0_m0_wo0_cma1_p(11),24);
    u0_m0_wo0_cma1_u(12) <= RESIZE(u0_m0_wo0_cma1_p(12),24);
    u0_m0_wo0_cma1_u(13) <= RESIZE(u0_m0_wo0_cma1_p(13),24);
    u0_m0_wo0_cma1_u(14) <= RESIZE(u0_m0_wo0_cma1_p(14),24);
    u0_m0_wo0_cma1_u(15) <= RESIZE(u0_m0_wo0_cma1_p(15),24);
    u0_m0_wo0_cma1_u(16) <= RESIZE(u0_m0_wo0_cma1_p(16),24);
    u0_m0_wo0_cma1_u(17) <= RESIZE(u0_m0_wo0_cma1_p(17),24);
    u0_m0_wo0_cma1_u(18) <= RESIZE(u0_m0_wo0_cma1_p(18),24);
    u0_m0_wo0_cma1_u(19) <= RESIZE(u0_m0_wo0_cma1_p(19),24);
    u0_m0_wo0_cma1_u(20) <= RESIZE(u0_m0_wo0_cma1_p(20),24);
    u0_m0_wo0_cma1_u(21) <= RESIZE(u0_m0_wo0_cma1_p(21),24);
    u0_m0_wo0_cma1_u(22) <= RESIZE(u0_m0_wo0_cma1_p(22),24);
    u0_m0_wo0_cma1_u(23) <= RESIZE(u0_m0_wo0_cma1_p(23),24);
    u0_m0_wo0_cma1_u(24) <= RESIZE(u0_m0_wo0_cma1_p(24),24);
    u0_m0_wo0_cma1_u(25) <= RESIZE(u0_m0_wo0_cma1_p(25),24);
    u0_m0_wo0_cma1_u(26) <= RESIZE(u0_m0_wo0_cma1_p(26),24);
    u0_m0_wo0_cma1_u(27) <= RESIZE(u0_m0_wo0_cma1_p(27),24);
    u0_m0_wo0_cma1_u(28) <= RESIZE(u0_m0_wo0_cma1_p(28),24);
    u0_m0_wo0_cma1_u(29) <= RESIZE(u0_m0_wo0_cma1_p(29),24);
    u0_m0_wo0_cma1_u(30) <= RESIZE(u0_m0_wo0_cma1_p(30),24);
    u0_m0_wo0_cma1_u(31) <= RESIZE(u0_m0_wo0_cma1_p(31),24);
    u0_m0_wo0_cma1_w(0) <= u0_m0_wo0_cma1_u(0);
    u0_m0_wo0_cma1_w(1) <= u0_m0_wo0_cma1_u(1);
    u0_m0_wo0_cma1_w(2) <= u0_m0_wo0_cma1_u(2);
    u0_m0_wo0_cma1_w(3) <= u0_m0_wo0_cma1_u(3);
    u0_m0_wo0_cma1_w(4) <= u0_m0_wo0_cma1_u(4);
    u0_m0_wo0_cma1_w(5) <= u0_m0_wo0_cma1_u(5);
    u0_m0_wo0_cma1_w(6) <= u0_m0_wo0_cma1_u(6);
    u0_m0_wo0_cma1_w(7) <= u0_m0_wo0_cma1_u(7);
    u0_m0_wo0_cma1_w(8) <= u0_m0_wo0_cma1_u(8);
    u0_m0_wo0_cma1_w(9) <= u0_m0_wo0_cma1_u(9);
    u0_m0_wo0_cma1_w(10) <= u0_m0_wo0_cma1_u(10);
    u0_m0_wo0_cma1_w(11) <= u0_m0_wo0_cma1_u(11);
    u0_m0_wo0_cma1_w(12) <= u0_m0_wo0_cma1_u(12);
    u0_m0_wo0_cma1_w(13) <= u0_m0_wo0_cma1_u(13);
    u0_m0_wo0_cma1_w(14) <= u0_m0_wo0_cma1_u(14);
    u0_m0_wo0_cma1_w(15) <= u0_m0_wo0_cma1_u(15);
    u0_m0_wo0_cma1_w(16) <= u0_m0_wo0_cma1_u(16);
    u0_m0_wo0_cma1_w(17) <= u0_m0_wo0_cma1_u(17);
    u0_m0_wo0_cma1_w(18) <= u0_m0_wo0_cma1_u(18);
    u0_m0_wo0_cma1_w(19) <= u0_m0_wo0_cma1_u(19);
    u0_m0_wo0_cma1_w(20) <= u0_m0_wo0_cma1_u(20);
    u0_m0_wo0_cma1_w(21) <= u0_m0_wo0_cma1_u(21);
    u0_m0_wo0_cma1_w(22) <= u0_m0_wo0_cma1_u(22);
    u0_m0_wo0_cma1_w(23) <= u0_m0_wo0_cma1_u(23);
    u0_m0_wo0_cma1_w(24) <= u0_m0_wo0_cma1_u(24);
    u0_m0_wo0_cma1_w(25) <= u0_m0_wo0_cma1_u(25);
    u0_m0_wo0_cma1_w(26) <= u0_m0_wo0_cma1_u(26);
    u0_m0_wo0_cma1_w(27) <= u0_m0_wo0_cma1_u(27);
    u0_m0_wo0_cma1_w(28) <= u0_m0_wo0_cma1_u(28);
    u0_m0_wo0_cma1_w(29) <= u0_m0_wo0_cma1_u(29);
    u0_m0_wo0_cma1_w(30) <= u0_m0_wo0_cma1_u(30);
    u0_m0_wo0_cma1_w(31) <= u0_m0_wo0_cma1_u(31);
    u0_m0_wo0_cma1_x(0) <= u0_m0_wo0_cma1_w(0);
    u0_m0_wo0_cma1_x(1) <= u0_m0_wo0_cma1_w(1);
    u0_m0_wo0_cma1_x(2) <= u0_m0_wo0_cma1_w(2);
    u0_m0_wo0_cma1_x(3) <= u0_m0_wo0_cma1_w(3);
    u0_m0_wo0_cma1_x(4) <= u0_m0_wo0_cma1_w(4);
    u0_m0_wo0_cma1_x(5) <= u0_m0_wo0_cma1_w(5);
    u0_m0_wo0_cma1_x(6) <= u0_m0_wo0_cma1_w(6);
    u0_m0_wo0_cma1_x(7) <= u0_m0_wo0_cma1_w(7);
    u0_m0_wo0_cma1_x(8) <= u0_m0_wo0_cma1_w(8);
    u0_m0_wo0_cma1_x(9) <= u0_m0_wo0_cma1_w(9);
    u0_m0_wo0_cma1_x(10) <= u0_m0_wo0_cma1_w(10);
    u0_m0_wo0_cma1_x(11) <= u0_m0_wo0_cma1_w(11);
    u0_m0_wo0_cma1_x(12) <= u0_m0_wo0_cma1_w(12);
    u0_m0_wo0_cma1_x(13) <= u0_m0_wo0_cma1_w(13);
    u0_m0_wo0_cma1_x(14) <= u0_m0_wo0_cma1_w(14);
    u0_m0_wo0_cma1_x(15) <= u0_m0_wo0_cma1_w(15);
    u0_m0_wo0_cma1_x(16) <= u0_m0_wo0_cma1_w(16);
    u0_m0_wo0_cma1_x(17) <= u0_m0_wo0_cma1_w(17);
    u0_m0_wo0_cma1_x(18) <= u0_m0_wo0_cma1_w(18);
    u0_m0_wo0_cma1_x(19) <= u0_m0_wo0_cma1_w(19);
    u0_m0_wo0_cma1_x(20) <= u0_m0_wo0_cma1_w(20);
    u0_m0_wo0_cma1_x(21) <= u0_m0_wo0_cma1_w(21);
    u0_m0_wo0_cma1_x(22) <= u0_m0_wo0_cma1_w(22);
    u0_m0_wo0_cma1_x(23) <= u0_m0_wo0_cma1_w(23);
    u0_m0_wo0_cma1_x(24) <= u0_m0_wo0_cma1_w(24);
    u0_m0_wo0_cma1_x(25) <= u0_m0_wo0_cma1_w(25);
    u0_m0_wo0_cma1_x(26) <= u0_m0_wo0_cma1_w(26);
    u0_m0_wo0_cma1_x(27) <= u0_m0_wo0_cma1_w(27);
    u0_m0_wo0_cma1_x(28) <= u0_m0_wo0_cma1_w(28);
    u0_m0_wo0_cma1_x(29) <= u0_m0_wo0_cma1_w(29);
    u0_m0_wo0_cma1_x(30) <= u0_m0_wo0_cma1_w(30);
    u0_m0_wo0_cma1_x(31) <= u0_m0_wo0_cma1_w(31);
    u0_m0_wo0_cma1_y(0) <= u0_m0_wo0_cma1_s(1) + u0_m0_wo0_cma1_x(0);
    u0_m0_wo0_cma1_y(1) <= u0_m0_wo0_cma1_s(2) + u0_m0_wo0_cma1_x(1);
    u0_m0_wo0_cma1_y(2) <= u0_m0_wo0_cma1_s(3) + u0_m0_wo0_cma1_x(2);
    u0_m0_wo0_cma1_y(3) <= u0_m0_wo0_cma1_s(4) + u0_m0_wo0_cma1_x(3);
    u0_m0_wo0_cma1_y(4) <= u0_m0_wo0_cma1_s(5) + u0_m0_wo0_cma1_x(4);
    u0_m0_wo0_cma1_y(5) <= u0_m0_wo0_cma1_s(6) + u0_m0_wo0_cma1_x(5);
    u0_m0_wo0_cma1_y(6) <= u0_m0_wo0_cma1_s(7) + u0_m0_wo0_cma1_x(6);
    u0_m0_wo0_cma1_y(7) <= u0_m0_wo0_cma1_s(8) + u0_m0_wo0_cma1_x(7);
    u0_m0_wo0_cma1_y(8) <= u0_m0_wo0_cma1_s(9) + u0_m0_wo0_cma1_x(8);
    u0_m0_wo0_cma1_y(9) <= u0_m0_wo0_cma1_s(10) + u0_m0_wo0_cma1_x(9);
    u0_m0_wo0_cma1_y(10) <= u0_m0_wo0_cma1_s(11) + u0_m0_wo0_cma1_x(10);
    u0_m0_wo0_cma1_y(11) <= u0_m0_wo0_cma1_s(12) + u0_m0_wo0_cma1_x(11);
    u0_m0_wo0_cma1_y(12) <= u0_m0_wo0_cma1_s(13) + u0_m0_wo0_cma1_x(12);
    u0_m0_wo0_cma1_y(13) <= u0_m0_wo0_cma1_s(14) + u0_m0_wo0_cma1_x(13);
    u0_m0_wo0_cma1_y(14) <= u0_m0_wo0_cma1_s(15) + u0_m0_wo0_cma1_x(14);
    u0_m0_wo0_cma1_y(15) <= u0_m0_wo0_cma1_s(16) + u0_m0_wo0_cma1_x(15);
    u0_m0_wo0_cma1_y(16) <= u0_m0_wo0_cma1_s(17) + u0_m0_wo0_cma1_x(16);
    u0_m0_wo0_cma1_y(17) <= u0_m0_wo0_cma1_s(18) + u0_m0_wo0_cma1_x(17);
    u0_m0_wo0_cma1_y(18) <= u0_m0_wo0_cma1_s(19) + u0_m0_wo0_cma1_x(18);
    u0_m0_wo0_cma1_y(19) <= u0_m0_wo0_cma1_s(20) + u0_m0_wo0_cma1_x(19);
    u0_m0_wo0_cma1_y(20) <= u0_m0_wo0_cma1_s(21) + u0_m0_wo0_cma1_x(20);
    u0_m0_wo0_cma1_y(21) <= u0_m0_wo0_cma1_s(22) + u0_m0_wo0_cma1_x(21);
    u0_m0_wo0_cma1_y(22) <= u0_m0_wo0_cma1_s(23) + u0_m0_wo0_cma1_x(22);
    u0_m0_wo0_cma1_y(23) <= u0_m0_wo0_cma1_s(24) + u0_m0_wo0_cma1_x(23);
    u0_m0_wo0_cma1_y(24) <= u0_m0_wo0_cma1_s(25) + u0_m0_wo0_cma1_x(24);
    u0_m0_wo0_cma1_y(25) <= u0_m0_wo0_cma1_s(26) + u0_m0_wo0_cma1_x(25);
    u0_m0_wo0_cma1_y(26) <= u0_m0_wo0_cma1_s(27) + u0_m0_wo0_cma1_x(26);
    u0_m0_wo0_cma1_y(27) <= u0_m0_wo0_cma1_s(28) + u0_m0_wo0_cma1_x(27);
    u0_m0_wo0_cma1_y(28) <= u0_m0_wo0_cma1_s(29) + u0_m0_wo0_cma1_x(28);
    u0_m0_wo0_cma1_y(29) <= u0_m0_wo0_cma1_s(30) + u0_m0_wo0_cma1_x(29);
    u0_m0_wo0_cma1_y(30) <= u0_m0_wo0_cma1_s(31) + u0_m0_wo0_cma1_x(30);
    u0_m0_wo0_cma1_y(31) <= u0_m0_wo0_cma1_x(31);
    u0_m0_wo0_cma1_chainmultadd: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma1_a0 <= (others => (others => '0'));
            u0_m0_wo0_cma1_c0 <= (others => (others => '0'));
            u0_m0_wo0_cma1_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (input_valid_q = "1") THEN
                u0_m0_wo0_cma1_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(4) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(5) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(6) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(7) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(8) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(9) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(10) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(11) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(12) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(13) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(14) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(15) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(16) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(17) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(18) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(19) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(20) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(21) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(22) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(23) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(24) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(25) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(26) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(27) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(28) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(29) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(30) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_a0(31) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),8);
                u0_m0_wo0_cma1_c0(0) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(1) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(2) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(3) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(4) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(5) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(6) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(7) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(8) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(9) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(10) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(11) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(12) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(13) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(14) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(15) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(16) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(17) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(18) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(19) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(20) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(21) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(22) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(23) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(24) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(25) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(26) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(27) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(28) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(29) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(30) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma1_c0(31) <= RESIZE(UNSIGNED(GND_q),3);
            END IF;
            IF (d_u0_m0_wo0_compute_q_11_q = "1") THEN
                u0_m0_wo0_cma1_s(0) <= u0_m0_wo0_cma1_y(0);
                u0_m0_wo0_cma1_s(1) <= u0_m0_wo0_cma1_y(1);
                u0_m0_wo0_cma1_s(2) <= u0_m0_wo0_cma1_y(2);
                u0_m0_wo0_cma1_s(3) <= u0_m0_wo0_cma1_y(3);
                u0_m0_wo0_cma1_s(4) <= u0_m0_wo0_cma1_y(4);
                u0_m0_wo0_cma1_s(5) <= u0_m0_wo0_cma1_y(5);
                u0_m0_wo0_cma1_s(6) <= u0_m0_wo0_cma1_y(6);
                u0_m0_wo0_cma1_s(7) <= u0_m0_wo0_cma1_y(7);
                u0_m0_wo0_cma1_s(8) <= u0_m0_wo0_cma1_y(8);
                u0_m0_wo0_cma1_s(9) <= u0_m0_wo0_cma1_y(9);
                u0_m0_wo0_cma1_s(10) <= u0_m0_wo0_cma1_y(10);
                u0_m0_wo0_cma1_s(11) <= u0_m0_wo0_cma1_y(11);
                u0_m0_wo0_cma1_s(12) <= u0_m0_wo0_cma1_y(12);
                u0_m0_wo0_cma1_s(13) <= u0_m0_wo0_cma1_y(13);
                u0_m0_wo0_cma1_s(14) <= u0_m0_wo0_cma1_y(14);
                u0_m0_wo0_cma1_s(15) <= u0_m0_wo0_cma1_y(15);
                u0_m0_wo0_cma1_s(16) <= u0_m0_wo0_cma1_y(16);
                u0_m0_wo0_cma1_s(17) <= u0_m0_wo0_cma1_y(17);
                u0_m0_wo0_cma1_s(18) <= u0_m0_wo0_cma1_y(18);
                u0_m0_wo0_cma1_s(19) <= u0_m0_wo0_cma1_y(19);
                u0_m0_wo0_cma1_s(20) <= u0_m0_wo0_cma1_y(20);
                u0_m0_wo0_cma1_s(21) <= u0_m0_wo0_cma1_y(21);
                u0_m0_wo0_cma1_s(22) <= u0_m0_wo0_cma1_y(22);
                u0_m0_wo0_cma1_s(23) <= u0_m0_wo0_cma1_y(23);
                u0_m0_wo0_cma1_s(24) <= u0_m0_wo0_cma1_y(24);
                u0_m0_wo0_cma1_s(25) <= u0_m0_wo0_cma1_y(25);
                u0_m0_wo0_cma1_s(26) <= u0_m0_wo0_cma1_y(26);
                u0_m0_wo0_cma1_s(27) <= u0_m0_wo0_cma1_y(27);
                u0_m0_wo0_cma1_s(28) <= u0_m0_wo0_cma1_y(28);
                u0_m0_wo0_cma1_s(29) <= u0_m0_wo0_cma1_y(29);
                u0_m0_wo0_cma1_s(30) <= u0_m0_wo0_cma1_y(30);
                u0_m0_wo0_cma1_s(31) <= u0_m0_wo0_cma1_y(31);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma1_delay : dspba_delay
    GENERIC MAP ( width => 24, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_cma1_s(0)(23 downto 0)), xout => u0_m0_wo0_cma1_qq, clk => clk, aclr => areset );
    u0_m0_wo0_cma1_q <= STD_LOGIC_VECTOR(u0_m0_wo0_cma1_qq(23 downto 0));

    -- u0_m0_wo0_cma0(CHAINMULTADD,208)@10 + 2
    -- altera synthesis_off
    u0_m0_wo0_cma0_k0 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k1 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k2 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k3 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k4 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k5 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k6 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k7 <= (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k8 <= (
        0 => TO_SIGNED(-1,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k9 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k10 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k11 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k12 <= (
        0 => TO_SIGNED(2,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k13 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k14 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k15 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k16 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k17 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k18 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k19 <= (
        0 => TO_SIGNED(3,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k20 <= (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k21 <= (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k22 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k23 <= (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k24 <= (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k25 <= (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k26 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k27 <= (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k28 <= (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k29 <= (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k30 <= (
        0 => TO_SIGNED(6,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k31 <= (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_cma0_r(0) <= u0_m0_wo0_cma0_k0(TO_INTEGER(u0_m0_wo0_cma0_c0(0)));
    u0_m0_wo0_cma0_r(1) <= u0_m0_wo0_cma0_k1(TO_INTEGER(u0_m0_wo0_cma0_c0(1)));
    u0_m0_wo0_cma0_r(2) <= u0_m0_wo0_cma0_k2(TO_INTEGER(u0_m0_wo0_cma0_c0(2)));
    u0_m0_wo0_cma0_r(3) <= u0_m0_wo0_cma0_k3(TO_INTEGER(u0_m0_wo0_cma0_c0(3)));
    u0_m0_wo0_cma0_r(4) <= u0_m0_wo0_cma0_k4(TO_INTEGER(u0_m0_wo0_cma0_c0(4)));
    u0_m0_wo0_cma0_r(5) <= u0_m0_wo0_cma0_k5(TO_INTEGER(u0_m0_wo0_cma0_c0(5)));
    u0_m0_wo0_cma0_r(6) <= u0_m0_wo0_cma0_k6(TO_INTEGER(u0_m0_wo0_cma0_c0(6)));
    u0_m0_wo0_cma0_r(7) <= u0_m0_wo0_cma0_k7(TO_INTEGER(u0_m0_wo0_cma0_c0(7)));
    u0_m0_wo0_cma0_r(8) <= u0_m0_wo0_cma0_k8(TO_INTEGER(u0_m0_wo0_cma0_c0(8)));
    u0_m0_wo0_cma0_r(9) <= u0_m0_wo0_cma0_k9(TO_INTEGER(u0_m0_wo0_cma0_c0(9)));
    u0_m0_wo0_cma0_r(10) <= u0_m0_wo0_cma0_k10(TO_INTEGER(u0_m0_wo0_cma0_c0(10)));
    u0_m0_wo0_cma0_r(11) <= u0_m0_wo0_cma0_k11(TO_INTEGER(u0_m0_wo0_cma0_c0(11)));
    u0_m0_wo0_cma0_r(12) <= u0_m0_wo0_cma0_k12(TO_INTEGER(u0_m0_wo0_cma0_c0(12)));
    u0_m0_wo0_cma0_r(13) <= u0_m0_wo0_cma0_k13(TO_INTEGER(u0_m0_wo0_cma0_c0(13)));
    u0_m0_wo0_cma0_r(14) <= u0_m0_wo0_cma0_k14(TO_INTEGER(u0_m0_wo0_cma0_c0(14)));
    u0_m0_wo0_cma0_r(15) <= u0_m0_wo0_cma0_k15(TO_INTEGER(u0_m0_wo0_cma0_c0(15)));
    u0_m0_wo0_cma0_r(16) <= u0_m0_wo0_cma0_k16(TO_INTEGER(u0_m0_wo0_cma0_c0(16)));
    u0_m0_wo0_cma0_r(17) <= u0_m0_wo0_cma0_k17(TO_INTEGER(u0_m0_wo0_cma0_c0(17)));
    u0_m0_wo0_cma0_r(18) <= u0_m0_wo0_cma0_k18(TO_INTEGER(u0_m0_wo0_cma0_c0(18)));
    u0_m0_wo0_cma0_r(19) <= u0_m0_wo0_cma0_k19(TO_INTEGER(u0_m0_wo0_cma0_c0(19)));
    u0_m0_wo0_cma0_r(20) <= u0_m0_wo0_cma0_k20(TO_INTEGER(u0_m0_wo0_cma0_c0(20)));
    u0_m0_wo0_cma0_r(21) <= u0_m0_wo0_cma0_k21(TO_INTEGER(u0_m0_wo0_cma0_c0(21)));
    u0_m0_wo0_cma0_r(22) <= u0_m0_wo0_cma0_k22(TO_INTEGER(u0_m0_wo0_cma0_c0(22)));
    u0_m0_wo0_cma0_r(23) <= u0_m0_wo0_cma0_k23(TO_INTEGER(u0_m0_wo0_cma0_c0(23)));
    u0_m0_wo0_cma0_r(24) <= u0_m0_wo0_cma0_k24(TO_INTEGER(u0_m0_wo0_cma0_c0(24)));
    u0_m0_wo0_cma0_r(25) <= u0_m0_wo0_cma0_k25(TO_INTEGER(u0_m0_wo0_cma0_c0(25)));
    u0_m0_wo0_cma0_r(26) <= u0_m0_wo0_cma0_k26(TO_INTEGER(u0_m0_wo0_cma0_c0(26)));
    u0_m0_wo0_cma0_r(27) <= u0_m0_wo0_cma0_k27(TO_INTEGER(u0_m0_wo0_cma0_c0(27)));
    u0_m0_wo0_cma0_r(28) <= u0_m0_wo0_cma0_k28(TO_INTEGER(u0_m0_wo0_cma0_c0(28)));
    u0_m0_wo0_cma0_r(29) <= u0_m0_wo0_cma0_k29(TO_INTEGER(u0_m0_wo0_cma0_c0(29)));
    u0_m0_wo0_cma0_r(30) <= u0_m0_wo0_cma0_k30(TO_INTEGER(u0_m0_wo0_cma0_c0(30)));
    u0_m0_wo0_cma0_r(31) <= u0_m0_wo0_cma0_k31(TO_INTEGER(u0_m0_wo0_cma0_c0(31)));
    u0_m0_wo0_cma0_p(0) <= u0_m0_wo0_cma0_a0(0) * u0_m0_wo0_cma0_r(0);
    u0_m0_wo0_cma0_p(1) <= u0_m0_wo0_cma0_a0(1) * u0_m0_wo0_cma0_r(1);
    u0_m0_wo0_cma0_p(2) <= u0_m0_wo0_cma0_a0(2) * u0_m0_wo0_cma0_r(2);
    u0_m0_wo0_cma0_p(3) <= u0_m0_wo0_cma0_a0(3) * u0_m0_wo0_cma0_r(3);
    u0_m0_wo0_cma0_p(4) <= u0_m0_wo0_cma0_a0(4) * u0_m0_wo0_cma0_r(4);
    u0_m0_wo0_cma0_p(5) <= u0_m0_wo0_cma0_a0(5) * u0_m0_wo0_cma0_r(5);
    u0_m0_wo0_cma0_p(6) <= u0_m0_wo0_cma0_a0(6) * u0_m0_wo0_cma0_r(6);
    u0_m0_wo0_cma0_p(7) <= u0_m0_wo0_cma0_a0(7) * u0_m0_wo0_cma0_r(7);
    u0_m0_wo0_cma0_p(8) <= u0_m0_wo0_cma0_a0(8) * u0_m0_wo0_cma0_r(8);
    u0_m0_wo0_cma0_p(9) <= u0_m0_wo0_cma0_a0(9) * u0_m0_wo0_cma0_r(9);
    u0_m0_wo0_cma0_p(10) <= u0_m0_wo0_cma0_a0(10) * u0_m0_wo0_cma0_r(10);
    u0_m0_wo0_cma0_p(11) <= u0_m0_wo0_cma0_a0(11) * u0_m0_wo0_cma0_r(11);
    u0_m0_wo0_cma0_p(12) <= u0_m0_wo0_cma0_a0(12) * u0_m0_wo0_cma0_r(12);
    u0_m0_wo0_cma0_p(13) <= u0_m0_wo0_cma0_a0(13) * u0_m0_wo0_cma0_r(13);
    u0_m0_wo0_cma0_p(14) <= u0_m0_wo0_cma0_a0(14) * u0_m0_wo0_cma0_r(14);
    u0_m0_wo0_cma0_p(15) <= u0_m0_wo0_cma0_a0(15) * u0_m0_wo0_cma0_r(15);
    u0_m0_wo0_cma0_p(16) <= u0_m0_wo0_cma0_a0(16) * u0_m0_wo0_cma0_r(16);
    u0_m0_wo0_cma0_p(17) <= u0_m0_wo0_cma0_a0(17) * u0_m0_wo0_cma0_r(17);
    u0_m0_wo0_cma0_p(18) <= u0_m0_wo0_cma0_a0(18) * u0_m0_wo0_cma0_r(18);
    u0_m0_wo0_cma0_p(19) <= u0_m0_wo0_cma0_a0(19) * u0_m0_wo0_cma0_r(19);
    u0_m0_wo0_cma0_p(20) <= u0_m0_wo0_cma0_a0(20) * u0_m0_wo0_cma0_r(20);
    u0_m0_wo0_cma0_p(21) <= u0_m0_wo0_cma0_a0(21) * u0_m0_wo0_cma0_r(21);
    u0_m0_wo0_cma0_p(22) <= u0_m0_wo0_cma0_a0(22) * u0_m0_wo0_cma0_r(22);
    u0_m0_wo0_cma0_p(23) <= u0_m0_wo0_cma0_a0(23) * u0_m0_wo0_cma0_r(23);
    u0_m0_wo0_cma0_p(24) <= u0_m0_wo0_cma0_a0(24) * u0_m0_wo0_cma0_r(24);
    u0_m0_wo0_cma0_p(25) <= u0_m0_wo0_cma0_a0(25) * u0_m0_wo0_cma0_r(25);
    u0_m0_wo0_cma0_p(26) <= u0_m0_wo0_cma0_a0(26) * u0_m0_wo0_cma0_r(26);
    u0_m0_wo0_cma0_p(27) <= u0_m0_wo0_cma0_a0(27) * u0_m0_wo0_cma0_r(27);
    u0_m0_wo0_cma0_p(28) <= u0_m0_wo0_cma0_a0(28) * u0_m0_wo0_cma0_r(28);
    u0_m0_wo0_cma0_p(29) <= u0_m0_wo0_cma0_a0(29) * u0_m0_wo0_cma0_r(29);
    u0_m0_wo0_cma0_p(30) <= u0_m0_wo0_cma0_a0(30) * u0_m0_wo0_cma0_r(30);
    u0_m0_wo0_cma0_p(31) <= u0_m0_wo0_cma0_a0(31) * u0_m0_wo0_cma0_r(31);
    u0_m0_wo0_cma0_u(0) <= RESIZE(u0_m0_wo0_cma0_p(0),24);
    u0_m0_wo0_cma0_u(1) <= RESIZE(u0_m0_wo0_cma0_p(1),24);
    u0_m0_wo0_cma0_u(2) <= RESIZE(u0_m0_wo0_cma0_p(2),24);
    u0_m0_wo0_cma0_u(3) <= RESIZE(u0_m0_wo0_cma0_p(3),24);
    u0_m0_wo0_cma0_u(4) <= RESIZE(u0_m0_wo0_cma0_p(4),24);
    u0_m0_wo0_cma0_u(5) <= RESIZE(u0_m0_wo0_cma0_p(5),24);
    u0_m0_wo0_cma0_u(6) <= RESIZE(u0_m0_wo0_cma0_p(6),24);
    u0_m0_wo0_cma0_u(7) <= RESIZE(u0_m0_wo0_cma0_p(7),24);
    u0_m0_wo0_cma0_u(8) <= RESIZE(u0_m0_wo0_cma0_p(8),24);
    u0_m0_wo0_cma0_u(9) <= RESIZE(u0_m0_wo0_cma0_p(9),24);
    u0_m0_wo0_cma0_u(10) <= RESIZE(u0_m0_wo0_cma0_p(10),24);
    u0_m0_wo0_cma0_u(11) <= RESIZE(u0_m0_wo0_cma0_p(11),24);
    u0_m0_wo0_cma0_u(12) <= RESIZE(u0_m0_wo0_cma0_p(12),24);
    u0_m0_wo0_cma0_u(13) <= RESIZE(u0_m0_wo0_cma0_p(13),24);
    u0_m0_wo0_cma0_u(14) <= RESIZE(u0_m0_wo0_cma0_p(14),24);
    u0_m0_wo0_cma0_u(15) <= RESIZE(u0_m0_wo0_cma0_p(15),24);
    u0_m0_wo0_cma0_u(16) <= RESIZE(u0_m0_wo0_cma0_p(16),24);
    u0_m0_wo0_cma0_u(17) <= RESIZE(u0_m0_wo0_cma0_p(17),24);
    u0_m0_wo0_cma0_u(18) <= RESIZE(u0_m0_wo0_cma0_p(18),24);
    u0_m0_wo0_cma0_u(19) <= RESIZE(u0_m0_wo0_cma0_p(19),24);
    u0_m0_wo0_cma0_u(20) <= RESIZE(u0_m0_wo0_cma0_p(20),24);
    u0_m0_wo0_cma0_u(21) <= RESIZE(u0_m0_wo0_cma0_p(21),24);
    u0_m0_wo0_cma0_u(22) <= RESIZE(u0_m0_wo0_cma0_p(22),24);
    u0_m0_wo0_cma0_u(23) <= RESIZE(u0_m0_wo0_cma0_p(23),24);
    u0_m0_wo0_cma0_u(24) <= RESIZE(u0_m0_wo0_cma0_p(24),24);
    u0_m0_wo0_cma0_u(25) <= RESIZE(u0_m0_wo0_cma0_p(25),24);
    u0_m0_wo0_cma0_u(26) <= RESIZE(u0_m0_wo0_cma0_p(26),24);
    u0_m0_wo0_cma0_u(27) <= RESIZE(u0_m0_wo0_cma0_p(27),24);
    u0_m0_wo0_cma0_u(28) <= RESIZE(u0_m0_wo0_cma0_p(28),24);
    u0_m0_wo0_cma0_u(29) <= RESIZE(u0_m0_wo0_cma0_p(29),24);
    u0_m0_wo0_cma0_u(30) <= RESIZE(u0_m0_wo0_cma0_p(30),24);
    u0_m0_wo0_cma0_u(31) <= RESIZE(u0_m0_wo0_cma0_p(31),24);
    u0_m0_wo0_cma0_w(0) <= u0_m0_wo0_cma0_u(0);
    u0_m0_wo0_cma0_w(1) <= u0_m0_wo0_cma0_u(1);
    u0_m0_wo0_cma0_w(2) <= u0_m0_wo0_cma0_u(2);
    u0_m0_wo0_cma0_w(3) <= u0_m0_wo0_cma0_u(3);
    u0_m0_wo0_cma0_w(4) <= u0_m0_wo0_cma0_u(4);
    u0_m0_wo0_cma0_w(5) <= u0_m0_wo0_cma0_u(5);
    u0_m0_wo0_cma0_w(6) <= u0_m0_wo0_cma0_u(6);
    u0_m0_wo0_cma0_w(7) <= u0_m0_wo0_cma0_u(7);
    u0_m0_wo0_cma0_w(8) <= u0_m0_wo0_cma0_u(8);
    u0_m0_wo0_cma0_w(9) <= u0_m0_wo0_cma0_u(9);
    u0_m0_wo0_cma0_w(10) <= u0_m0_wo0_cma0_u(10);
    u0_m0_wo0_cma0_w(11) <= u0_m0_wo0_cma0_u(11);
    u0_m0_wo0_cma0_w(12) <= u0_m0_wo0_cma0_u(12);
    u0_m0_wo0_cma0_w(13) <= u0_m0_wo0_cma0_u(13);
    u0_m0_wo0_cma0_w(14) <= u0_m0_wo0_cma0_u(14);
    u0_m0_wo0_cma0_w(15) <= u0_m0_wo0_cma0_u(15);
    u0_m0_wo0_cma0_w(16) <= u0_m0_wo0_cma0_u(16);
    u0_m0_wo0_cma0_w(17) <= u0_m0_wo0_cma0_u(17);
    u0_m0_wo0_cma0_w(18) <= u0_m0_wo0_cma0_u(18);
    u0_m0_wo0_cma0_w(19) <= u0_m0_wo0_cma0_u(19);
    u0_m0_wo0_cma0_w(20) <= u0_m0_wo0_cma0_u(20);
    u0_m0_wo0_cma0_w(21) <= u0_m0_wo0_cma0_u(21);
    u0_m0_wo0_cma0_w(22) <= u0_m0_wo0_cma0_u(22);
    u0_m0_wo0_cma0_w(23) <= u0_m0_wo0_cma0_u(23);
    u0_m0_wo0_cma0_w(24) <= u0_m0_wo0_cma0_u(24);
    u0_m0_wo0_cma0_w(25) <= u0_m0_wo0_cma0_u(25);
    u0_m0_wo0_cma0_w(26) <= u0_m0_wo0_cma0_u(26);
    u0_m0_wo0_cma0_w(27) <= u0_m0_wo0_cma0_u(27);
    u0_m0_wo0_cma0_w(28) <= u0_m0_wo0_cma0_u(28);
    u0_m0_wo0_cma0_w(29) <= u0_m0_wo0_cma0_u(29);
    u0_m0_wo0_cma0_w(30) <= u0_m0_wo0_cma0_u(30);
    u0_m0_wo0_cma0_w(31) <= u0_m0_wo0_cma0_u(31);
    u0_m0_wo0_cma0_x(0) <= u0_m0_wo0_cma0_w(0);
    u0_m0_wo0_cma0_x(1) <= u0_m0_wo0_cma0_w(1);
    u0_m0_wo0_cma0_x(2) <= u0_m0_wo0_cma0_w(2);
    u0_m0_wo0_cma0_x(3) <= u0_m0_wo0_cma0_w(3);
    u0_m0_wo0_cma0_x(4) <= u0_m0_wo0_cma0_w(4);
    u0_m0_wo0_cma0_x(5) <= u0_m0_wo0_cma0_w(5);
    u0_m0_wo0_cma0_x(6) <= u0_m0_wo0_cma0_w(6);
    u0_m0_wo0_cma0_x(7) <= u0_m0_wo0_cma0_w(7);
    u0_m0_wo0_cma0_x(8) <= u0_m0_wo0_cma0_w(8);
    u0_m0_wo0_cma0_x(9) <= u0_m0_wo0_cma0_w(9);
    u0_m0_wo0_cma0_x(10) <= u0_m0_wo0_cma0_w(10);
    u0_m0_wo0_cma0_x(11) <= u0_m0_wo0_cma0_w(11);
    u0_m0_wo0_cma0_x(12) <= u0_m0_wo0_cma0_w(12);
    u0_m0_wo0_cma0_x(13) <= u0_m0_wo0_cma0_w(13);
    u0_m0_wo0_cma0_x(14) <= u0_m0_wo0_cma0_w(14);
    u0_m0_wo0_cma0_x(15) <= u0_m0_wo0_cma0_w(15);
    u0_m0_wo0_cma0_x(16) <= u0_m0_wo0_cma0_w(16);
    u0_m0_wo0_cma0_x(17) <= u0_m0_wo0_cma0_w(17);
    u0_m0_wo0_cma0_x(18) <= u0_m0_wo0_cma0_w(18);
    u0_m0_wo0_cma0_x(19) <= u0_m0_wo0_cma0_w(19);
    u0_m0_wo0_cma0_x(20) <= u0_m0_wo0_cma0_w(20);
    u0_m0_wo0_cma0_x(21) <= u0_m0_wo0_cma0_w(21);
    u0_m0_wo0_cma0_x(22) <= u0_m0_wo0_cma0_w(22);
    u0_m0_wo0_cma0_x(23) <= u0_m0_wo0_cma0_w(23);
    u0_m0_wo0_cma0_x(24) <= u0_m0_wo0_cma0_w(24);
    u0_m0_wo0_cma0_x(25) <= u0_m0_wo0_cma0_w(25);
    u0_m0_wo0_cma0_x(26) <= u0_m0_wo0_cma0_w(26);
    u0_m0_wo0_cma0_x(27) <= u0_m0_wo0_cma0_w(27);
    u0_m0_wo0_cma0_x(28) <= u0_m0_wo0_cma0_w(28);
    u0_m0_wo0_cma0_x(29) <= u0_m0_wo0_cma0_w(29);
    u0_m0_wo0_cma0_x(30) <= u0_m0_wo0_cma0_w(30);
    u0_m0_wo0_cma0_x(31) <= u0_m0_wo0_cma0_w(31);
    u0_m0_wo0_cma0_y(0) <= u0_m0_wo0_cma0_s(1) + u0_m0_wo0_cma0_x(0);
    u0_m0_wo0_cma0_y(1) <= u0_m0_wo0_cma0_s(2) + u0_m0_wo0_cma0_x(1);
    u0_m0_wo0_cma0_y(2) <= u0_m0_wo0_cma0_s(3) + u0_m0_wo0_cma0_x(2);
    u0_m0_wo0_cma0_y(3) <= u0_m0_wo0_cma0_s(4) + u0_m0_wo0_cma0_x(3);
    u0_m0_wo0_cma0_y(4) <= u0_m0_wo0_cma0_s(5) + u0_m0_wo0_cma0_x(4);
    u0_m0_wo0_cma0_y(5) <= u0_m0_wo0_cma0_s(6) + u0_m0_wo0_cma0_x(5);
    u0_m0_wo0_cma0_y(6) <= u0_m0_wo0_cma0_s(7) + u0_m0_wo0_cma0_x(6);
    u0_m0_wo0_cma0_y(7) <= u0_m0_wo0_cma0_s(8) + u0_m0_wo0_cma0_x(7);
    u0_m0_wo0_cma0_y(8) <= u0_m0_wo0_cma0_s(9) + u0_m0_wo0_cma0_x(8);
    u0_m0_wo0_cma0_y(9) <= u0_m0_wo0_cma0_s(10) + u0_m0_wo0_cma0_x(9);
    u0_m0_wo0_cma0_y(10) <= u0_m0_wo0_cma0_s(11) + u0_m0_wo0_cma0_x(10);
    u0_m0_wo0_cma0_y(11) <= u0_m0_wo0_cma0_s(12) + u0_m0_wo0_cma0_x(11);
    u0_m0_wo0_cma0_y(12) <= u0_m0_wo0_cma0_s(13) + u0_m0_wo0_cma0_x(12);
    u0_m0_wo0_cma0_y(13) <= u0_m0_wo0_cma0_s(14) + u0_m0_wo0_cma0_x(13);
    u0_m0_wo0_cma0_y(14) <= u0_m0_wo0_cma0_s(15) + u0_m0_wo0_cma0_x(14);
    u0_m0_wo0_cma0_y(15) <= u0_m0_wo0_cma0_s(16) + u0_m0_wo0_cma0_x(15);
    u0_m0_wo0_cma0_y(16) <= u0_m0_wo0_cma0_s(17) + u0_m0_wo0_cma0_x(16);
    u0_m0_wo0_cma0_y(17) <= u0_m0_wo0_cma0_s(18) + u0_m0_wo0_cma0_x(17);
    u0_m0_wo0_cma0_y(18) <= u0_m0_wo0_cma0_s(19) + u0_m0_wo0_cma0_x(18);
    u0_m0_wo0_cma0_y(19) <= u0_m0_wo0_cma0_s(20) + u0_m0_wo0_cma0_x(19);
    u0_m0_wo0_cma0_y(20) <= u0_m0_wo0_cma0_s(21) + u0_m0_wo0_cma0_x(20);
    u0_m0_wo0_cma0_y(21) <= u0_m0_wo0_cma0_s(22) + u0_m0_wo0_cma0_x(21);
    u0_m0_wo0_cma0_y(22) <= u0_m0_wo0_cma0_s(23) + u0_m0_wo0_cma0_x(22);
    u0_m0_wo0_cma0_y(23) <= u0_m0_wo0_cma0_s(24) + u0_m0_wo0_cma0_x(23);
    u0_m0_wo0_cma0_y(24) <= u0_m0_wo0_cma0_s(25) + u0_m0_wo0_cma0_x(24);
    u0_m0_wo0_cma0_y(25) <= u0_m0_wo0_cma0_s(26) + u0_m0_wo0_cma0_x(25);
    u0_m0_wo0_cma0_y(26) <= u0_m0_wo0_cma0_s(27) + u0_m0_wo0_cma0_x(26);
    u0_m0_wo0_cma0_y(27) <= u0_m0_wo0_cma0_s(28) + u0_m0_wo0_cma0_x(27);
    u0_m0_wo0_cma0_y(28) <= u0_m0_wo0_cma0_s(29) + u0_m0_wo0_cma0_x(28);
    u0_m0_wo0_cma0_y(29) <= u0_m0_wo0_cma0_s(30) + u0_m0_wo0_cma0_x(29);
    u0_m0_wo0_cma0_y(30) <= u0_m0_wo0_cma0_s(31) + u0_m0_wo0_cma0_x(30);
    u0_m0_wo0_cma0_y(31) <= u0_m0_wo0_cma0_x(31);
    u0_m0_wo0_cma0_chainmultadd: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma0_a0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_c0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (input_valid_q = "1") THEN
                u0_m0_wo0_cma0_a0(0) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(1) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(2) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(3) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(4) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(5) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(6) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(7) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(8) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(9) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(10) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(11) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(12) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(13) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(14) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(15) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(16) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(17) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(18) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(19) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(20) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(21) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(22) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(23) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(24) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(25) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(26) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(27) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(28) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(29) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(30) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_a0(31) <= RESIZE(SIGNED(xIn_0),8);
                u0_m0_wo0_cma0_c0(0) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(1) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(2) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(3) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(4) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(5) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(6) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(7) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(8) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(9) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(10) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(11) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(12) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(13) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(14) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(15) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(16) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(17) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(18) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(19) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(20) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(21) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(22) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(23) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(24) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(25) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(26) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(27) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(28) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(29) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(30) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma0_c0(31) <= RESIZE(UNSIGNED(GND_q),3);
            END IF;
            IF (d_u0_m0_wo0_compute_q_11_q = "1") THEN
                u0_m0_wo0_cma0_s(0) <= u0_m0_wo0_cma0_y(0);
                u0_m0_wo0_cma0_s(1) <= u0_m0_wo0_cma0_y(1);
                u0_m0_wo0_cma0_s(2) <= u0_m0_wo0_cma0_y(2);
                u0_m0_wo0_cma0_s(3) <= u0_m0_wo0_cma0_y(3);
                u0_m0_wo0_cma0_s(4) <= u0_m0_wo0_cma0_y(4);
                u0_m0_wo0_cma0_s(5) <= u0_m0_wo0_cma0_y(5);
                u0_m0_wo0_cma0_s(6) <= u0_m0_wo0_cma0_y(6);
                u0_m0_wo0_cma0_s(7) <= u0_m0_wo0_cma0_y(7);
                u0_m0_wo0_cma0_s(8) <= u0_m0_wo0_cma0_y(8);
                u0_m0_wo0_cma0_s(9) <= u0_m0_wo0_cma0_y(9);
                u0_m0_wo0_cma0_s(10) <= u0_m0_wo0_cma0_y(10);
                u0_m0_wo0_cma0_s(11) <= u0_m0_wo0_cma0_y(11);
                u0_m0_wo0_cma0_s(12) <= u0_m0_wo0_cma0_y(12);
                u0_m0_wo0_cma0_s(13) <= u0_m0_wo0_cma0_y(13);
                u0_m0_wo0_cma0_s(14) <= u0_m0_wo0_cma0_y(14);
                u0_m0_wo0_cma0_s(15) <= u0_m0_wo0_cma0_y(15);
                u0_m0_wo0_cma0_s(16) <= u0_m0_wo0_cma0_y(16);
                u0_m0_wo0_cma0_s(17) <= u0_m0_wo0_cma0_y(17);
                u0_m0_wo0_cma0_s(18) <= u0_m0_wo0_cma0_y(18);
                u0_m0_wo0_cma0_s(19) <= u0_m0_wo0_cma0_y(19);
                u0_m0_wo0_cma0_s(20) <= u0_m0_wo0_cma0_y(20);
                u0_m0_wo0_cma0_s(21) <= u0_m0_wo0_cma0_y(21);
                u0_m0_wo0_cma0_s(22) <= u0_m0_wo0_cma0_y(22);
                u0_m0_wo0_cma0_s(23) <= u0_m0_wo0_cma0_y(23);
                u0_m0_wo0_cma0_s(24) <= u0_m0_wo0_cma0_y(24);
                u0_m0_wo0_cma0_s(25) <= u0_m0_wo0_cma0_y(25);
                u0_m0_wo0_cma0_s(26) <= u0_m0_wo0_cma0_y(26);
                u0_m0_wo0_cma0_s(27) <= u0_m0_wo0_cma0_y(27);
                u0_m0_wo0_cma0_s(28) <= u0_m0_wo0_cma0_y(28);
                u0_m0_wo0_cma0_s(29) <= u0_m0_wo0_cma0_y(29);
                u0_m0_wo0_cma0_s(30) <= u0_m0_wo0_cma0_y(30);
                u0_m0_wo0_cma0_s(31) <= u0_m0_wo0_cma0_y(31);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma0_delay : dspba_delay
    GENERIC MAP ( width => 24, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_cma0_s(0)(23 downto 0)), xout => u0_m0_wo0_cma0_qq, clk => clk, aclr => areset );
    u0_m0_wo0_cma0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_cma0_qq(23 downto 0));

    -- u0_m0_wo0_mtree_add0_0(ADD,211)@12 + 1
    u0_m0_wo0_mtree_add0_0_a <= STD_LOGIC_VECTOR(u0_m0_wo0_cma0_q(22 downto 0));
    u0_m0_wo0_mtree_add0_0_b <= STD_LOGIC_VECTOR(u0_m0_wo0_cma1_q(22 downto 0));
    u0_m0_wo0_mtree_add0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_0_a) + SIGNED(u0_m0_wo0_mtree_add0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_0_q <= u0_m0_wo0_mtree_add0_0_o(22 downto 0);

    -- u0_m0_wo0_mtree_add1_0(ADD,212)@13 + 1
    u0_m0_wo0_mtree_add1_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 23 => u0_m0_wo0_mtree_add0_0_q(22)) & u0_m0_wo0_mtree_add0_0_q));
    u0_m0_wo0_mtree_add1_0_b <= STD_LOGIC_VECTOR(u0_m0_wo0_cma2_q);
    u0_m0_wo0_mtree_add1_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_0_a) + SIGNED(u0_m0_wo0_mtree_add1_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_0_q <= u0_m0_wo0_mtree_add1_0_o(23 downto 0);

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- d_u0_m0_wo0_compute_q_13(DELAY,433)@12 + 1
    d_u0_m0_wo0_compute_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_12_q, xout => d_u0_m0_wo0_compute_q_13_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_oseq_gated_reg(REG,213)@13 + 1
    u0_m0_wo0_oseq_gated_reg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(d_u0_m0_wo0_compute_q_13_q);
        END IF;
    END PROCESS;

    -- out0_m0_wo0_lineup_select_delay_0(DELAY,422)@14
    out0_m0_wo0_lineup_select_delay_0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_reg_q);

    -- out0_m0_wo0_assign_id5(DELAY,424)@14
    out0_m0_wo0_assign_id5_q <= STD_LOGIC_VECTOR(out0_m0_wo0_lineup_select_delay_0_q);

    -- xOut(PORTOUT,429)@14 + 1
    xOut_v <= out0_m0_wo0_assign_id5_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_mtree_add1_0_q;
    xOut_1 <= u1_m0_wo0_mtree_add1_0_q;

END normal;
