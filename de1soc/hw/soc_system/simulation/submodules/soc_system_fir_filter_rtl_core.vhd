-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 17.1 (Release Build #593)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2017 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from soc_system_fir_filter_rtl_core
-- VHDL created on Fri May 18 15:54:45 2018


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

entity soc_system_fir_filter_rtl_core is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(15 downto 0);  -- sfix16
        enable_i : in std_logic_vector(0 downto 0);  -- sfix1
        xOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        xOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        xOut_0 : out std_logic_vector(39 downto 0);  -- sfix40
        clk : in std_logic;
        areset : in std_logic
    );
end soc_system_fir_filter_rtl_core;

architecture normal of soc_system_fir_filter_rtl_core is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr129_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr130_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr131_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr132_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr133_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr134_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr135_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr136_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr137_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr138_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr139_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr140_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr141_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr142_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr143_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr144_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr161_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr162_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr163_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr164_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr165_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr166_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr167_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr168_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr169_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr170_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr171_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr172_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr173_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr174_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr175_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr176_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr193_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr194_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr195_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr196_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr197_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr198_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr199_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr200_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr201_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr202_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr203_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr204_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr205_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr206_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr207_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr208_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_cma0_reset : std_logic;
    type u0_m0_wo0_cma0_a0type is array(NATURAL range <>) of SIGNED(15 downto 0);
    signal u0_m0_wo0_cma0_a0 : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve : boolean;
    attribute preserve of u0_m0_wo0_cma0_a0 : signal is true;
    signal u0_m0_wo0_cma0_b0 : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma0_b0 : signal is true;
    type u0_m0_wo0_cma0_c0type is array(NATURAL range <>) of UNSIGNED(2 downto 0);
    signal u0_m0_wo0_cma0_c0 : u0_m0_wo0_cma0_c0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma0_c0 : signal is true;
    signal u0_m0_wo0_cma0_d : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma0_d : signal is true;
    type u0_m0_wo0_cma0_ltype is array(NATURAL range <>) of SIGNED(16 downto 0);
    signal u0_m0_wo0_cma0_l : u0_m0_wo0_cma0_ltype(0 to 31);
    type u0_m0_wo0_cma0_rtype is array(NATURAL range <>) of SIGNED(10 downto 0);
    signal u0_m0_wo0_cma0_r : u0_m0_wo0_cma0_rtype(0 to 31);
    type u0_m0_wo0_cma0_ptype is array(NATURAL range <>) of SIGNED(27 downto 0);
    signal u0_m0_wo0_cma0_p : u0_m0_wo0_cma0_ptype(0 to 31);
    type u0_m0_wo0_cma0_utype is array(NATURAL range <>) of SIGNED(32 downto 0);
    signal u0_m0_wo0_cma0_u : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma0_w : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma0_x : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma0_y : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma0_k0 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(13,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k1 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k2 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k3 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k4 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k5 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k6 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-5,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k7 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k8 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k9 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-7,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k10 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-7,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k11 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-5,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k12 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k13 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k14 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k15 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(8,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k16 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(10,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k17 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k18 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(13,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k19 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k20 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(8,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k21 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(3,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k22 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k23 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k24 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-13,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k25 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-18,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k26 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-20,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k27 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-20,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k28 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k29 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-11,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k30 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k31 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_s : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma0_qq : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_cma0_q : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_cma0_ena0 : std_logic;
    signal u0_m0_wo0_cma0_ena1 : std_logic;
    signal u0_m0_wo0_cma1_reset : std_logic;
    signal u0_m0_wo0_cma1_a0 : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma1_a0 : signal is true;
    signal u0_m0_wo0_cma1_b0 : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma1_b0 : signal is true;
    signal u0_m0_wo0_cma1_c0 : u0_m0_wo0_cma0_c0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma1_c0 : signal is true;
    signal u0_m0_wo0_cma1_d : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma1_d : signal is true;
    signal u0_m0_wo0_cma1_l : u0_m0_wo0_cma0_ltype(0 to 31);
    signal u0_m0_wo0_cma1_r : u0_m0_wo0_cma0_rtype(0 to 31);
    signal u0_m0_wo0_cma1_p : u0_m0_wo0_cma0_ptype(0 to 31);
    signal u0_m0_wo0_cma1_u : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma1_w : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma1_x : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma1_y : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma1_k0 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(14,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k1 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(22,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k2 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(28,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k3 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(30,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k4 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(29,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k5 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(23,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k6 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(13,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k7 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k8 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-11,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k9 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-24,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k10 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-35,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k11 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-42,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k12 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-44,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k13 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-40,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k14 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-30,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k15 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k16 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k17 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(20,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k18 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(38,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k19 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(52,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k20 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(60,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k21 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(61,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k22 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(53,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k23 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(38,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k24 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(17,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k25 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-7,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k26 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-33,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k27 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-57,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k28 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-75,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k29 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-84,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k30 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-82,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_k31 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-70,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma1_s : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma1_qq : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_cma1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_cma1_ena0 : std_logic;
    signal u0_m0_wo0_cma1_ena1 : std_logic;
    signal u0_m0_wo0_cma2_reset : std_logic;
    signal u0_m0_wo0_cma2_a0 : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma2_a0 : signal is true;
    signal u0_m0_wo0_cma2_b0 : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma2_b0 : signal is true;
    signal u0_m0_wo0_cma2_c0 : u0_m0_wo0_cma0_c0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma2_c0 : signal is true;
    signal u0_m0_wo0_cma2_d : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma2_d : signal is true;
    signal u0_m0_wo0_cma2_l : u0_m0_wo0_cma0_ltype(0 to 31);
    signal u0_m0_wo0_cma2_r : u0_m0_wo0_cma0_rtype(0 to 31);
    signal u0_m0_wo0_cma2_p : u0_m0_wo0_cma0_ptype(0 to 31);
    signal u0_m0_wo0_cma2_u : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma2_w : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma2_x : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma2_y : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma2_k0 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-47,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k1 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k2 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(18,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k3 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(53,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k4 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(84,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k5 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(105,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k6 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(115,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k7 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(109,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k8 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(89,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k9 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(55,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k10 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k11 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-35,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k12 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-82,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k13 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-121,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k14 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-147,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k15 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-155,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k16 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-144,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k17 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-112,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k18 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-64,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k19 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k20 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(62,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k21 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(124,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k22 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(174,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k23 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(205,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k24 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(212,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k25 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(190,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k26 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(142,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k27 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(71,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k28 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-14,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k29 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-105,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k30 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-189,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_k31 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-255,11),
        others => (others => '0'));
    signal u0_m0_wo0_cma2_s : u0_m0_wo0_cma0_utype(0 to 31);
    signal u0_m0_wo0_cma2_qq : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_cma2_q : STD_LOGIC_VECTOR (32 downto 0);
    signal u0_m0_wo0_cma2_ena0 : std_logic;
    signal u0_m0_wo0_cma2_ena1 : std_logic;
    signal u0_m0_wo0_cma3_reset : std_logic;
    signal u0_m0_wo0_cma3_a0 : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma3_a0 : signal is true;
    signal u0_m0_wo0_cma3_b0 : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma3_b0 : signal is true;
    signal u0_m0_wo0_cma3_c0 : u0_m0_wo0_cma0_c0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma3_c0 : signal is true;
    signal u0_m0_wo0_cma3_d : u0_m0_wo0_cma0_a0type(0 to 31);
    attribute preserve of u0_m0_wo0_cma3_d : signal is true;
    signal u0_m0_wo0_cma3_l : u0_m0_wo0_cma0_ltype(0 to 31);
    type u0_m0_wo0_cma3_rtype is array(NATURAL range <>) of SIGNED(12 downto 0);
    signal u0_m0_wo0_cma3_r : u0_m0_wo0_cma3_rtype(0 to 31);
    type u0_m0_wo0_cma3_ptype is array(NATURAL range <>) of SIGNED(29 downto 0);
    signal u0_m0_wo0_cma3_p : u0_m0_wo0_cma3_ptype(0 to 31);
    type u0_m0_wo0_cma3_utype is array(NATURAL range <>) of SIGNED(34 downto 0);
    signal u0_m0_wo0_cma3_u : u0_m0_wo0_cma3_utype(0 to 31);
    signal u0_m0_wo0_cma3_w : u0_m0_wo0_cma3_utype(0 to 31);
    signal u0_m0_wo0_cma3_x : u0_m0_wo0_cma3_utype(0 to 31);
    signal u0_m0_wo0_cma3_y : u0_m0_wo0_cma3_utype(0 to 31);
    signal u0_m0_wo0_cma3_k0 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-293,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k1 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-295,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k2 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-258,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k3 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-183,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k4 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-78,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k5 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(48,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k6 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(180,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k7 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(300,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k8 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(393,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k9 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(443,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k10 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(439,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k11 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(375,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k12 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(253,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k13 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(82,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k14 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-121,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k15 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-336,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k16 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-537,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k17 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-694,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k18 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-782,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k19 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-776,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k20 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-662,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k21 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-431,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k22 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(-85,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k23 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(360,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k24 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(883,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k25 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(1453,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k26 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(2030,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k27 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(2575,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k28 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(3049,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k29 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(3416,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k30 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(3648,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_k31 : u0_m0_wo0_cma3_rtype(0 to 7) := (
        0 => TO_SIGNED(3727,13),
        others => (others => '0'));
    signal u0_m0_wo0_cma3_s : u0_m0_wo0_cma3_utype(0 to 31);
    signal u0_m0_wo0_cma3_qq : STD_LOGIC_VECTOR (34 downto 0);
    signal u0_m0_wo0_cma3_q : STD_LOGIC_VECTOR (34 downto 0);
    signal u0_m0_wo0_cma3_ena0 : std_logic;
    signal u0_m0_wo0_cma3_ena1 : std_logic;
    signal u0_m0_wo0_mtree_add0_0_a : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add0_0_b : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add0_0_o : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add0_0_q : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add0_1_a : STD_LOGIC_VECTOR (35 downto 0);
    signal u0_m0_wo0_mtree_add0_1_b : STD_LOGIC_VECTOR (35 downto 0);
    signal u0_m0_wo0_mtree_add0_1_o : STD_LOGIC_VECTOR (35 downto 0);
    signal u0_m0_wo0_mtree_add0_1_q : STD_LOGIC_VECTOR (35 downto 0);
    signal u0_m0_wo0_mtree_add1_0_a : STD_LOGIC_VECTOR (36 downto 0);
    signal u0_m0_wo0_mtree_add1_0_b : STD_LOGIC_VECTOR (36 downto 0);
    signal u0_m0_wo0_mtree_add1_0_o : STD_LOGIC_VECTOR (36 downto 0);
    signal u0_m0_wo0_mtree_add1_0_q : STD_LOGIC_VECTOR (36 downto 0);
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr32_mem_ia : STD_LOGIC_VECTOR (47 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_iq : STD_LOGIC_VECTOR (47 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_q : STD_LOGIC_VECTOR (47 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr32_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr32_rdcnt_eq : std_logic;
    attribute preserve of u0_m0_wo0_wi0_r0_delayr32_rdcnt_eq : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr32_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr32_sticky_ena_q : signal is true;
    signal input_valid_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_rdmux_q : STD_LOGIC_VECTOR (4 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr160_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr192_q : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr224_q : STD_LOGIC_VECTOR (15 downto 0);
    signal out0_m0_wo0_lineup_select_delay_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_split32_b : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_split32_c : STD_LOGIC_VECTOR (15 downto 0);
    signal u0_m0_wo0_wi0_r0_split32_d : STD_LOGIC_VECTOR (15 downto 0);
    signal out0_m0_wo0_assign_id3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_join32_q : STD_LOGIC_VECTOR (47 downto 0);

begin


    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- u0_m0_wo0_wi0_r0_delayr129(DELAY,149)@10
    u0_m0_wo0_wi0_r0_delayr129 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_split32_d, xout => u0_m0_wo0_wi0_r0_delayr129_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr32_notEnable(LOGICAL,558)@10
    u0_m0_wo0_wi0_r0_delayr32_notEnable_q <= STD_LOGIC_VECTOR(not (input_valid_q));

    -- u0_m0_wo0_wi0_r0_delayr32_nor(LOGICAL,559)@10
    u0_m0_wo0_wi0_r0_delayr32_nor_q <= not (u0_m0_wo0_wi0_r0_delayr32_notEnable_q or u0_m0_wo0_wi0_r0_delayr32_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr32_mem_last(CONSTANT,555)
    u0_m0_wo0_wi0_r0_delayr32_mem_last_q <= "011101";

    -- u0_m0_wo0_wi0_r0_delayr32_cmp(LOGICAL,556)@10
    u0_m0_wo0_wi0_r0_delayr32_cmp_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_delayr32_rdmux_q);
    u0_m0_wo0_wi0_r0_delayr32_cmp_q <= "1" WHEN u0_m0_wo0_wi0_r0_delayr32_mem_last_q = u0_m0_wo0_wi0_r0_delayr32_cmp_b ELSE "0";

    -- u0_m0_wo0_wi0_r0_delayr32_cmpReg(REG,557)@10 + 1
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

    -- u0_m0_wo0_wi0_r0_delayr32_sticky_ena(REG,560)@10 + 1
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

    -- u0_m0_wo0_wi0_r0_delayr32_enaAnd(LOGICAL,561)@10
    u0_m0_wo0_wi0_r0_delayr32_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr32_sticky_ena_q and input_valid_q;

    -- u0_m0_wo0_wi0_r0_delayr32_rdcnt(COUNTER,552)@10 + 1
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

    -- u0_m0_wo0_wi0_r0_delayr32_rdmux(MUX,553)@10
    u0_m0_wo0_wi0_r0_delayr32_rdmux_s <= input_valid_q;
    u0_m0_wo0_wi0_r0_delayr32_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr32_rdmux_s, u0_m0_wo0_wi0_r0_delayr32_wraddr_q, u0_m0_wo0_wi0_r0_delayr32_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr32_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr32_rdmux_q <= u0_m0_wo0_wi0_r0_delayr32_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr32_rdmux_q <= u0_m0_wo0_wi0_r0_delayr32_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr32_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join32(BITJOIN,52)@10
    u0_m0_wo0_wi0_r0_join32_q <= u0_m0_wo0_wi0_r0_split32_c & u0_m0_wo0_wi0_r0_split32_b & xIn_0;

    -- u0_m0_wo0_wi0_r0_delayr32_wraddr(REG,554)@10 + 1
    u0_m0_wo0_wi0_r0_delayr32_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr32_wraddr_q <= "11110";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr32_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr32_mem(DUALMEM,551)@10 + 2
    u0_m0_wo0_wi0_r0_delayr32_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join32_q);
    u0_m0_wo0_wi0_r0_delayr32_mem_aa <= u0_m0_wo0_wi0_r0_delayr32_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr32_mem_ab <= u0_m0_wo0_wi0_r0_delayr32_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr32_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr32_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 48,
        widthad_a => 5,
        numwords_a => 31,
        width_b => 48,
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
    u0_m0_wo0_wi0_r0_delayr32_mem_q <= u0_m0_wo0_wi0_r0_delayr32_mem_iq(47 downto 0);

    -- u0_m0_wo0_wi0_r0_split32(BITSELECT,53)@10
    u0_m0_wo0_wi0_r0_split32_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_mem_q(15 downto 0));
    u0_m0_wo0_wi0_r0_split32_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_mem_q(31 downto 16));
    u0_m0_wo0_wi0_r0_split32_d <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr32_mem_q(47 downto 32));

    -- d_u0_m0_wo0_compute_q_11(DELAY,549)@10 + 1
    d_u0_m0_wo0_compute_q_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => input_valid_q, xout => d_u0_m0_wo0_compute_q_11_q, clk => clk, aclr => areset );

    -- input_valid(LOGICAL,3)@10
    input_valid_q <= xIn_v and enable_i;

    -- u0_m0_wo0_cma3(CHAINMULTADD,538)@10 + 2
    u0_m0_wo0_cma3_reset <= areset;
    u0_m0_wo0_cma3_ena0 <= input_valid_q(0);
    u0_m0_wo0_cma3_ena1 <= d_u0_m0_wo0_compute_q_11_q(0);
    u0_m0_wo0_cma3_l(0) <= RESIZE(u0_m0_wo0_cma3_a0(0),17) + RESIZE(u0_m0_wo0_cma3_b0(0),17);
    u0_m0_wo0_cma3_l(1) <= RESIZE(u0_m0_wo0_cma3_a0(1),17) + RESIZE(u0_m0_wo0_cma3_b0(1),17);
    u0_m0_wo0_cma3_l(2) <= RESIZE(u0_m0_wo0_cma3_a0(2),17) + RESIZE(u0_m0_wo0_cma3_b0(2),17);
    u0_m0_wo0_cma3_l(3) <= RESIZE(u0_m0_wo0_cma3_a0(3),17) + RESIZE(u0_m0_wo0_cma3_b0(3),17);
    u0_m0_wo0_cma3_l(4) <= RESIZE(u0_m0_wo0_cma3_a0(4),17) + RESIZE(u0_m0_wo0_cma3_b0(4),17);
    u0_m0_wo0_cma3_l(5) <= RESIZE(u0_m0_wo0_cma3_a0(5),17) + RESIZE(u0_m0_wo0_cma3_b0(5),17);
    u0_m0_wo0_cma3_l(6) <= RESIZE(u0_m0_wo0_cma3_a0(6),17) + RESIZE(u0_m0_wo0_cma3_b0(6),17);
    u0_m0_wo0_cma3_l(7) <= RESIZE(u0_m0_wo0_cma3_a0(7),17) + RESIZE(u0_m0_wo0_cma3_b0(7),17);
    u0_m0_wo0_cma3_l(8) <= RESIZE(u0_m0_wo0_cma3_a0(8),17) + RESIZE(u0_m0_wo0_cma3_b0(8),17);
    u0_m0_wo0_cma3_l(9) <= RESIZE(u0_m0_wo0_cma3_a0(9),17) + RESIZE(u0_m0_wo0_cma3_b0(9),17);
    u0_m0_wo0_cma3_l(10) <= RESIZE(u0_m0_wo0_cma3_a0(10),17) + RESIZE(u0_m0_wo0_cma3_b0(10),17);
    u0_m0_wo0_cma3_l(11) <= RESIZE(u0_m0_wo0_cma3_a0(11),17) + RESIZE(u0_m0_wo0_cma3_b0(11),17);
    u0_m0_wo0_cma3_l(12) <= RESIZE(u0_m0_wo0_cma3_a0(12),17) + RESIZE(u0_m0_wo0_cma3_b0(12),17);
    u0_m0_wo0_cma3_l(13) <= RESIZE(u0_m0_wo0_cma3_a0(13),17) + RESIZE(u0_m0_wo0_cma3_b0(13),17);
    u0_m0_wo0_cma3_l(14) <= RESIZE(u0_m0_wo0_cma3_a0(14),17) + RESIZE(u0_m0_wo0_cma3_b0(14),17);
    u0_m0_wo0_cma3_l(15) <= RESIZE(u0_m0_wo0_cma3_a0(15),17) + RESIZE(u0_m0_wo0_cma3_b0(15),17);
    u0_m0_wo0_cma3_l(16) <= RESIZE(u0_m0_wo0_cma3_a0(16),17) + RESIZE(u0_m0_wo0_cma3_b0(16),17);
    u0_m0_wo0_cma3_l(17) <= RESIZE(u0_m0_wo0_cma3_a0(17),17) + RESIZE(u0_m0_wo0_cma3_b0(17),17);
    u0_m0_wo0_cma3_l(18) <= RESIZE(u0_m0_wo0_cma3_a0(18),17) + RESIZE(u0_m0_wo0_cma3_b0(18),17);
    u0_m0_wo0_cma3_l(19) <= RESIZE(u0_m0_wo0_cma3_a0(19),17) + RESIZE(u0_m0_wo0_cma3_b0(19),17);
    u0_m0_wo0_cma3_l(20) <= RESIZE(u0_m0_wo0_cma3_a0(20),17) + RESIZE(u0_m0_wo0_cma3_b0(20),17);
    u0_m0_wo0_cma3_l(21) <= RESIZE(u0_m0_wo0_cma3_a0(21),17) + RESIZE(u0_m0_wo0_cma3_b0(21),17);
    u0_m0_wo0_cma3_l(22) <= RESIZE(u0_m0_wo0_cma3_a0(22),17) + RESIZE(u0_m0_wo0_cma3_b0(22),17);
    u0_m0_wo0_cma3_l(23) <= RESIZE(u0_m0_wo0_cma3_a0(23),17) + RESIZE(u0_m0_wo0_cma3_b0(23),17);
    u0_m0_wo0_cma3_l(24) <= RESIZE(u0_m0_wo0_cma3_a0(24),17) + RESIZE(u0_m0_wo0_cma3_b0(24),17);
    u0_m0_wo0_cma3_l(25) <= RESIZE(u0_m0_wo0_cma3_a0(25),17) + RESIZE(u0_m0_wo0_cma3_b0(25),17);
    u0_m0_wo0_cma3_l(26) <= RESIZE(u0_m0_wo0_cma3_a0(26),17) + RESIZE(u0_m0_wo0_cma3_b0(26),17);
    u0_m0_wo0_cma3_l(27) <= RESIZE(u0_m0_wo0_cma3_a0(27),17) + RESIZE(u0_m0_wo0_cma3_b0(27),17);
    u0_m0_wo0_cma3_l(28) <= RESIZE(u0_m0_wo0_cma3_a0(28),17) + RESIZE(u0_m0_wo0_cma3_b0(28),17);
    u0_m0_wo0_cma3_l(29) <= RESIZE(u0_m0_wo0_cma3_a0(29),17) + RESIZE(u0_m0_wo0_cma3_b0(29),17);
    u0_m0_wo0_cma3_l(30) <= RESIZE(u0_m0_wo0_cma3_a0(30),17) + RESIZE(u0_m0_wo0_cma3_b0(30),17);
    u0_m0_wo0_cma3_l(31) <= RESIZE(u0_m0_wo0_cma3_a0(31),17) + RESIZE(u0_m0_wo0_cma3_b0(31),17);
    -- altera synthesis_off
    u0_m0_wo0_cma3_k0 <= (
        0 => TO_SIGNED(-293,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k1 <= (
        0 => TO_SIGNED(-295,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k2 <= (
        0 => TO_SIGNED(-258,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k3 <= (
        0 => TO_SIGNED(-183,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k4 <= (
        0 => TO_SIGNED(-78,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k5 <= (
        0 => TO_SIGNED(48,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k6 <= (
        0 => TO_SIGNED(180,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k7 <= (
        0 => TO_SIGNED(300,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k8 <= (
        0 => TO_SIGNED(393,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k9 <= (
        0 => TO_SIGNED(443,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k10 <= (
        0 => TO_SIGNED(439,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k11 <= (
        0 => TO_SIGNED(375,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k12 <= (
        0 => TO_SIGNED(253,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k13 <= (
        0 => TO_SIGNED(82,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k14 <= (
        0 => TO_SIGNED(-121,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k15 <= (
        0 => TO_SIGNED(-336,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k16 <= (
        0 => TO_SIGNED(-537,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k17 <= (
        0 => TO_SIGNED(-694,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k18 <= (
        0 => TO_SIGNED(-782,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k19 <= (
        0 => TO_SIGNED(-776,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k20 <= (
        0 => TO_SIGNED(-662,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k21 <= (
        0 => TO_SIGNED(-431,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k22 <= (
        0 => TO_SIGNED(-85,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k23 <= (
        0 => TO_SIGNED(360,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k24 <= (
        0 => TO_SIGNED(883,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k25 <= (
        0 => TO_SIGNED(1453,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k26 <= (
        0 => TO_SIGNED(2030,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k27 <= (
        0 => TO_SIGNED(2575,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k28 <= (
        0 => TO_SIGNED(3049,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k29 <= (
        0 => TO_SIGNED(3416,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k30 <= (
        0 => TO_SIGNED(3648,13),
        others => (others => '0'));
    u0_m0_wo0_cma3_k31 <= (
        0 => TO_SIGNED(3727,13),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_cma3_r(0) <= u0_m0_wo0_cma3_k0(TO_INTEGER(u0_m0_wo0_cma3_c0(0)));
    u0_m0_wo0_cma3_r(1) <= u0_m0_wo0_cma3_k1(TO_INTEGER(u0_m0_wo0_cma3_c0(1)));
    u0_m0_wo0_cma3_r(2) <= u0_m0_wo0_cma3_k2(TO_INTEGER(u0_m0_wo0_cma3_c0(2)));
    u0_m0_wo0_cma3_r(3) <= u0_m0_wo0_cma3_k3(TO_INTEGER(u0_m0_wo0_cma3_c0(3)));
    u0_m0_wo0_cma3_r(4) <= u0_m0_wo0_cma3_k4(TO_INTEGER(u0_m0_wo0_cma3_c0(4)));
    u0_m0_wo0_cma3_r(5) <= u0_m0_wo0_cma3_k5(TO_INTEGER(u0_m0_wo0_cma3_c0(5)));
    u0_m0_wo0_cma3_r(6) <= u0_m0_wo0_cma3_k6(TO_INTEGER(u0_m0_wo0_cma3_c0(6)));
    u0_m0_wo0_cma3_r(7) <= u0_m0_wo0_cma3_k7(TO_INTEGER(u0_m0_wo0_cma3_c0(7)));
    u0_m0_wo0_cma3_r(8) <= u0_m0_wo0_cma3_k8(TO_INTEGER(u0_m0_wo0_cma3_c0(8)));
    u0_m0_wo0_cma3_r(9) <= u0_m0_wo0_cma3_k9(TO_INTEGER(u0_m0_wo0_cma3_c0(9)));
    u0_m0_wo0_cma3_r(10) <= u0_m0_wo0_cma3_k10(TO_INTEGER(u0_m0_wo0_cma3_c0(10)));
    u0_m0_wo0_cma3_r(11) <= u0_m0_wo0_cma3_k11(TO_INTEGER(u0_m0_wo0_cma3_c0(11)));
    u0_m0_wo0_cma3_r(12) <= u0_m0_wo0_cma3_k12(TO_INTEGER(u0_m0_wo0_cma3_c0(12)));
    u0_m0_wo0_cma3_r(13) <= u0_m0_wo0_cma3_k13(TO_INTEGER(u0_m0_wo0_cma3_c0(13)));
    u0_m0_wo0_cma3_r(14) <= u0_m0_wo0_cma3_k14(TO_INTEGER(u0_m0_wo0_cma3_c0(14)));
    u0_m0_wo0_cma3_r(15) <= u0_m0_wo0_cma3_k15(TO_INTEGER(u0_m0_wo0_cma3_c0(15)));
    u0_m0_wo0_cma3_r(16) <= u0_m0_wo0_cma3_k16(TO_INTEGER(u0_m0_wo0_cma3_c0(16)));
    u0_m0_wo0_cma3_r(17) <= u0_m0_wo0_cma3_k17(TO_INTEGER(u0_m0_wo0_cma3_c0(17)));
    u0_m0_wo0_cma3_r(18) <= u0_m0_wo0_cma3_k18(TO_INTEGER(u0_m0_wo0_cma3_c0(18)));
    u0_m0_wo0_cma3_r(19) <= u0_m0_wo0_cma3_k19(TO_INTEGER(u0_m0_wo0_cma3_c0(19)));
    u0_m0_wo0_cma3_r(20) <= u0_m0_wo0_cma3_k20(TO_INTEGER(u0_m0_wo0_cma3_c0(20)));
    u0_m0_wo0_cma3_r(21) <= u0_m0_wo0_cma3_k21(TO_INTEGER(u0_m0_wo0_cma3_c0(21)));
    u0_m0_wo0_cma3_r(22) <= u0_m0_wo0_cma3_k22(TO_INTEGER(u0_m0_wo0_cma3_c0(22)));
    u0_m0_wo0_cma3_r(23) <= u0_m0_wo0_cma3_k23(TO_INTEGER(u0_m0_wo0_cma3_c0(23)));
    u0_m0_wo0_cma3_r(24) <= u0_m0_wo0_cma3_k24(TO_INTEGER(u0_m0_wo0_cma3_c0(24)));
    u0_m0_wo0_cma3_r(25) <= u0_m0_wo0_cma3_k25(TO_INTEGER(u0_m0_wo0_cma3_c0(25)));
    u0_m0_wo0_cma3_r(26) <= u0_m0_wo0_cma3_k26(TO_INTEGER(u0_m0_wo0_cma3_c0(26)));
    u0_m0_wo0_cma3_r(27) <= u0_m0_wo0_cma3_k27(TO_INTEGER(u0_m0_wo0_cma3_c0(27)));
    u0_m0_wo0_cma3_r(28) <= u0_m0_wo0_cma3_k28(TO_INTEGER(u0_m0_wo0_cma3_c0(28)));
    u0_m0_wo0_cma3_r(29) <= u0_m0_wo0_cma3_k29(TO_INTEGER(u0_m0_wo0_cma3_c0(29)));
    u0_m0_wo0_cma3_r(30) <= u0_m0_wo0_cma3_k30(TO_INTEGER(u0_m0_wo0_cma3_c0(30)));
    u0_m0_wo0_cma3_r(31) <= u0_m0_wo0_cma3_k31(TO_INTEGER(u0_m0_wo0_cma3_c0(31)));
    u0_m0_wo0_cma3_p(0) <= u0_m0_wo0_cma3_l(0) * u0_m0_wo0_cma3_r(0);
    u0_m0_wo0_cma3_p(1) <= u0_m0_wo0_cma3_l(1) * u0_m0_wo0_cma3_r(1);
    u0_m0_wo0_cma3_p(2) <= u0_m0_wo0_cma3_l(2) * u0_m0_wo0_cma3_r(2);
    u0_m0_wo0_cma3_p(3) <= u0_m0_wo0_cma3_l(3) * u0_m0_wo0_cma3_r(3);
    u0_m0_wo0_cma3_p(4) <= u0_m0_wo0_cma3_l(4) * u0_m0_wo0_cma3_r(4);
    u0_m0_wo0_cma3_p(5) <= u0_m0_wo0_cma3_l(5) * u0_m0_wo0_cma3_r(5);
    u0_m0_wo0_cma3_p(6) <= u0_m0_wo0_cma3_l(6) * u0_m0_wo0_cma3_r(6);
    u0_m0_wo0_cma3_p(7) <= u0_m0_wo0_cma3_l(7) * u0_m0_wo0_cma3_r(7);
    u0_m0_wo0_cma3_p(8) <= u0_m0_wo0_cma3_l(8) * u0_m0_wo0_cma3_r(8);
    u0_m0_wo0_cma3_p(9) <= u0_m0_wo0_cma3_l(9) * u0_m0_wo0_cma3_r(9);
    u0_m0_wo0_cma3_p(10) <= u0_m0_wo0_cma3_l(10) * u0_m0_wo0_cma3_r(10);
    u0_m0_wo0_cma3_p(11) <= u0_m0_wo0_cma3_l(11) * u0_m0_wo0_cma3_r(11);
    u0_m0_wo0_cma3_p(12) <= u0_m0_wo0_cma3_l(12) * u0_m0_wo0_cma3_r(12);
    u0_m0_wo0_cma3_p(13) <= u0_m0_wo0_cma3_l(13) * u0_m0_wo0_cma3_r(13);
    u0_m0_wo0_cma3_p(14) <= u0_m0_wo0_cma3_l(14) * u0_m0_wo0_cma3_r(14);
    u0_m0_wo0_cma3_p(15) <= u0_m0_wo0_cma3_l(15) * u0_m0_wo0_cma3_r(15);
    u0_m0_wo0_cma3_p(16) <= u0_m0_wo0_cma3_l(16) * u0_m0_wo0_cma3_r(16);
    u0_m0_wo0_cma3_p(17) <= u0_m0_wo0_cma3_l(17) * u0_m0_wo0_cma3_r(17);
    u0_m0_wo0_cma3_p(18) <= u0_m0_wo0_cma3_l(18) * u0_m0_wo0_cma3_r(18);
    u0_m0_wo0_cma3_p(19) <= u0_m0_wo0_cma3_l(19) * u0_m0_wo0_cma3_r(19);
    u0_m0_wo0_cma3_p(20) <= u0_m0_wo0_cma3_l(20) * u0_m0_wo0_cma3_r(20);
    u0_m0_wo0_cma3_p(21) <= u0_m0_wo0_cma3_l(21) * u0_m0_wo0_cma3_r(21);
    u0_m0_wo0_cma3_p(22) <= u0_m0_wo0_cma3_l(22) * u0_m0_wo0_cma3_r(22);
    u0_m0_wo0_cma3_p(23) <= u0_m0_wo0_cma3_l(23) * u0_m0_wo0_cma3_r(23);
    u0_m0_wo0_cma3_p(24) <= u0_m0_wo0_cma3_l(24) * u0_m0_wo0_cma3_r(24);
    u0_m0_wo0_cma3_p(25) <= u0_m0_wo0_cma3_l(25) * u0_m0_wo0_cma3_r(25);
    u0_m0_wo0_cma3_p(26) <= u0_m0_wo0_cma3_l(26) * u0_m0_wo0_cma3_r(26);
    u0_m0_wo0_cma3_p(27) <= u0_m0_wo0_cma3_l(27) * u0_m0_wo0_cma3_r(27);
    u0_m0_wo0_cma3_p(28) <= u0_m0_wo0_cma3_l(28) * u0_m0_wo0_cma3_r(28);
    u0_m0_wo0_cma3_p(29) <= u0_m0_wo0_cma3_l(29) * u0_m0_wo0_cma3_r(29);
    u0_m0_wo0_cma3_p(30) <= u0_m0_wo0_cma3_l(30) * u0_m0_wo0_cma3_r(30);
    u0_m0_wo0_cma3_p(31) <= u0_m0_wo0_cma3_l(31) * u0_m0_wo0_cma3_r(31);
    u0_m0_wo0_cma3_u(0) <= RESIZE(u0_m0_wo0_cma3_p(0),35);
    u0_m0_wo0_cma3_u(1) <= RESIZE(u0_m0_wo0_cma3_p(1),35);
    u0_m0_wo0_cma3_u(2) <= RESIZE(u0_m0_wo0_cma3_p(2),35);
    u0_m0_wo0_cma3_u(3) <= RESIZE(u0_m0_wo0_cma3_p(3),35);
    u0_m0_wo0_cma3_u(4) <= RESIZE(u0_m0_wo0_cma3_p(4),35);
    u0_m0_wo0_cma3_u(5) <= RESIZE(u0_m0_wo0_cma3_p(5),35);
    u0_m0_wo0_cma3_u(6) <= RESIZE(u0_m0_wo0_cma3_p(6),35);
    u0_m0_wo0_cma3_u(7) <= RESIZE(u0_m0_wo0_cma3_p(7),35);
    u0_m0_wo0_cma3_u(8) <= RESIZE(u0_m0_wo0_cma3_p(8),35);
    u0_m0_wo0_cma3_u(9) <= RESIZE(u0_m0_wo0_cma3_p(9),35);
    u0_m0_wo0_cma3_u(10) <= RESIZE(u0_m0_wo0_cma3_p(10),35);
    u0_m0_wo0_cma3_u(11) <= RESIZE(u0_m0_wo0_cma3_p(11),35);
    u0_m0_wo0_cma3_u(12) <= RESIZE(u0_m0_wo0_cma3_p(12),35);
    u0_m0_wo0_cma3_u(13) <= RESIZE(u0_m0_wo0_cma3_p(13),35);
    u0_m0_wo0_cma3_u(14) <= RESIZE(u0_m0_wo0_cma3_p(14),35);
    u0_m0_wo0_cma3_u(15) <= RESIZE(u0_m0_wo0_cma3_p(15),35);
    u0_m0_wo0_cma3_u(16) <= RESIZE(u0_m0_wo0_cma3_p(16),35);
    u0_m0_wo0_cma3_u(17) <= RESIZE(u0_m0_wo0_cma3_p(17),35);
    u0_m0_wo0_cma3_u(18) <= RESIZE(u0_m0_wo0_cma3_p(18),35);
    u0_m0_wo0_cma3_u(19) <= RESIZE(u0_m0_wo0_cma3_p(19),35);
    u0_m0_wo0_cma3_u(20) <= RESIZE(u0_m0_wo0_cma3_p(20),35);
    u0_m0_wo0_cma3_u(21) <= RESIZE(u0_m0_wo0_cma3_p(21),35);
    u0_m0_wo0_cma3_u(22) <= RESIZE(u0_m0_wo0_cma3_p(22),35);
    u0_m0_wo0_cma3_u(23) <= RESIZE(u0_m0_wo0_cma3_p(23),35);
    u0_m0_wo0_cma3_u(24) <= RESIZE(u0_m0_wo0_cma3_p(24),35);
    u0_m0_wo0_cma3_u(25) <= RESIZE(u0_m0_wo0_cma3_p(25),35);
    u0_m0_wo0_cma3_u(26) <= RESIZE(u0_m0_wo0_cma3_p(26),35);
    u0_m0_wo0_cma3_u(27) <= RESIZE(u0_m0_wo0_cma3_p(27),35);
    u0_m0_wo0_cma3_u(28) <= RESIZE(u0_m0_wo0_cma3_p(28),35);
    u0_m0_wo0_cma3_u(29) <= RESIZE(u0_m0_wo0_cma3_p(29),35);
    u0_m0_wo0_cma3_u(30) <= RESIZE(u0_m0_wo0_cma3_p(30),35);
    u0_m0_wo0_cma3_u(31) <= RESIZE(u0_m0_wo0_cma3_p(31),35);
    u0_m0_wo0_cma3_w(0) <= u0_m0_wo0_cma3_u(0);
    u0_m0_wo0_cma3_w(1) <= u0_m0_wo0_cma3_u(1);
    u0_m0_wo0_cma3_w(2) <= u0_m0_wo0_cma3_u(2);
    u0_m0_wo0_cma3_w(3) <= u0_m0_wo0_cma3_u(3);
    u0_m0_wo0_cma3_w(4) <= u0_m0_wo0_cma3_u(4);
    u0_m0_wo0_cma3_w(5) <= u0_m0_wo0_cma3_u(5);
    u0_m0_wo0_cma3_w(6) <= u0_m0_wo0_cma3_u(6);
    u0_m0_wo0_cma3_w(7) <= u0_m0_wo0_cma3_u(7);
    u0_m0_wo0_cma3_w(8) <= u0_m0_wo0_cma3_u(8);
    u0_m0_wo0_cma3_w(9) <= u0_m0_wo0_cma3_u(9);
    u0_m0_wo0_cma3_w(10) <= u0_m0_wo0_cma3_u(10);
    u0_m0_wo0_cma3_w(11) <= u0_m0_wo0_cma3_u(11);
    u0_m0_wo0_cma3_w(12) <= u0_m0_wo0_cma3_u(12);
    u0_m0_wo0_cma3_w(13) <= u0_m0_wo0_cma3_u(13);
    u0_m0_wo0_cma3_w(14) <= u0_m0_wo0_cma3_u(14);
    u0_m0_wo0_cma3_w(15) <= u0_m0_wo0_cma3_u(15);
    u0_m0_wo0_cma3_w(16) <= u0_m0_wo0_cma3_u(16);
    u0_m0_wo0_cma3_w(17) <= u0_m0_wo0_cma3_u(17);
    u0_m0_wo0_cma3_w(18) <= u0_m0_wo0_cma3_u(18);
    u0_m0_wo0_cma3_w(19) <= u0_m0_wo0_cma3_u(19);
    u0_m0_wo0_cma3_w(20) <= u0_m0_wo0_cma3_u(20);
    u0_m0_wo0_cma3_w(21) <= u0_m0_wo0_cma3_u(21);
    u0_m0_wo0_cma3_w(22) <= u0_m0_wo0_cma3_u(22);
    u0_m0_wo0_cma3_w(23) <= u0_m0_wo0_cma3_u(23);
    u0_m0_wo0_cma3_w(24) <= u0_m0_wo0_cma3_u(24);
    u0_m0_wo0_cma3_w(25) <= u0_m0_wo0_cma3_u(25);
    u0_m0_wo0_cma3_w(26) <= u0_m0_wo0_cma3_u(26);
    u0_m0_wo0_cma3_w(27) <= u0_m0_wo0_cma3_u(27);
    u0_m0_wo0_cma3_w(28) <= u0_m0_wo0_cma3_u(28);
    u0_m0_wo0_cma3_w(29) <= u0_m0_wo0_cma3_u(29);
    u0_m0_wo0_cma3_w(30) <= u0_m0_wo0_cma3_u(30);
    u0_m0_wo0_cma3_w(31) <= u0_m0_wo0_cma3_u(31);
    u0_m0_wo0_cma3_x(0) <= u0_m0_wo0_cma3_w(0);
    u0_m0_wo0_cma3_x(1) <= u0_m0_wo0_cma3_w(1);
    u0_m0_wo0_cma3_x(2) <= u0_m0_wo0_cma3_w(2);
    u0_m0_wo0_cma3_x(3) <= u0_m0_wo0_cma3_w(3);
    u0_m0_wo0_cma3_x(4) <= u0_m0_wo0_cma3_w(4);
    u0_m0_wo0_cma3_x(5) <= u0_m0_wo0_cma3_w(5);
    u0_m0_wo0_cma3_x(6) <= u0_m0_wo0_cma3_w(6);
    u0_m0_wo0_cma3_x(7) <= u0_m0_wo0_cma3_w(7);
    u0_m0_wo0_cma3_x(8) <= u0_m0_wo0_cma3_w(8);
    u0_m0_wo0_cma3_x(9) <= u0_m0_wo0_cma3_w(9);
    u0_m0_wo0_cma3_x(10) <= u0_m0_wo0_cma3_w(10);
    u0_m0_wo0_cma3_x(11) <= u0_m0_wo0_cma3_w(11);
    u0_m0_wo0_cma3_x(12) <= u0_m0_wo0_cma3_w(12);
    u0_m0_wo0_cma3_x(13) <= u0_m0_wo0_cma3_w(13);
    u0_m0_wo0_cma3_x(14) <= u0_m0_wo0_cma3_w(14);
    u0_m0_wo0_cma3_x(15) <= u0_m0_wo0_cma3_w(15);
    u0_m0_wo0_cma3_x(16) <= u0_m0_wo0_cma3_w(16);
    u0_m0_wo0_cma3_x(17) <= u0_m0_wo0_cma3_w(17);
    u0_m0_wo0_cma3_x(18) <= u0_m0_wo0_cma3_w(18);
    u0_m0_wo0_cma3_x(19) <= u0_m0_wo0_cma3_w(19);
    u0_m0_wo0_cma3_x(20) <= u0_m0_wo0_cma3_w(20);
    u0_m0_wo0_cma3_x(21) <= u0_m0_wo0_cma3_w(21);
    u0_m0_wo0_cma3_x(22) <= u0_m0_wo0_cma3_w(22);
    u0_m0_wo0_cma3_x(23) <= u0_m0_wo0_cma3_w(23);
    u0_m0_wo0_cma3_x(24) <= u0_m0_wo0_cma3_w(24);
    u0_m0_wo0_cma3_x(25) <= u0_m0_wo0_cma3_w(25);
    u0_m0_wo0_cma3_x(26) <= u0_m0_wo0_cma3_w(26);
    u0_m0_wo0_cma3_x(27) <= u0_m0_wo0_cma3_w(27);
    u0_m0_wo0_cma3_x(28) <= u0_m0_wo0_cma3_w(28);
    u0_m0_wo0_cma3_x(29) <= u0_m0_wo0_cma3_w(29);
    u0_m0_wo0_cma3_x(30) <= u0_m0_wo0_cma3_w(30);
    u0_m0_wo0_cma3_x(31) <= u0_m0_wo0_cma3_w(31);
    u0_m0_wo0_cma3_y(0) <= u0_m0_wo0_cma3_s(1) + u0_m0_wo0_cma3_x(0);
    u0_m0_wo0_cma3_y(1) <= u0_m0_wo0_cma3_s(2) + u0_m0_wo0_cma3_x(1);
    u0_m0_wo0_cma3_y(2) <= u0_m0_wo0_cma3_s(3) + u0_m0_wo0_cma3_x(2);
    u0_m0_wo0_cma3_y(3) <= u0_m0_wo0_cma3_s(4) + u0_m0_wo0_cma3_x(3);
    u0_m0_wo0_cma3_y(4) <= u0_m0_wo0_cma3_s(5) + u0_m0_wo0_cma3_x(4);
    u0_m0_wo0_cma3_y(5) <= u0_m0_wo0_cma3_s(6) + u0_m0_wo0_cma3_x(5);
    u0_m0_wo0_cma3_y(6) <= u0_m0_wo0_cma3_s(7) + u0_m0_wo0_cma3_x(6);
    u0_m0_wo0_cma3_y(7) <= u0_m0_wo0_cma3_s(8) + u0_m0_wo0_cma3_x(7);
    u0_m0_wo0_cma3_y(8) <= u0_m0_wo0_cma3_s(9) + u0_m0_wo0_cma3_x(8);
    u0_m0_wo0_cma3_y(9) <= u0_m0_wo0_cma3_s(10) + u0_m0_wo0_cma3_x(9);
    u0_m0_wo0_cma3_y(10) <= u0_m0_wo0_cma3_s(11) + u0_m0_wo0_cma3_x(10);
    u0_m0_wo0_cma3_y(11) <= u0_m0_wo0_cma3_s(12) + u0_m0_wo0_cma3_x(11);
    u0_m0_wo0_cma3_y(12) <= u0_m0_wo0_cma3_s(13) + u0_m0_wo0_cma3_x(12);
    u0_m0_wo0_cma3_y(13) <= u0_m0_wo0_cma3_s(14) + u0_m0_wo0_cma3_x(13);
    u0_m0_wo0_cma3_y(14) <= u0_m0_wo0_cma3_s(15) + u0_m0_wo0_cma3_x(14);
    u0_m0_wo0_cma3_y(15) <= u0_m0_wo0_cma3_s(16) + u0_m0_wo0_cma3_x(15);
    u0_m0_wo0_cma3_y(16) <= u0_m0_wo0_cma3_s(17) + u0_m0_wo0_cma3_x(16);
    u0_m0_wo0_cma3_y(17) <= u0_m0_wo0_cma3_s(18) + u0_m0_wo0_cma3_x(17);
    u0_m0_wo0_cma3_y(18) <= u0_m0_wo0_cma3_s(19) + u0_m0_wo0_cma3_x(18);
    u0_m0_wo0_cma3_y(19) <= u0_m0_wo0_cma3_s(20) + u0_m0_wo0_cma3_x(19);
    u0_m0_wo0_cma3_y(20) <= u0_m0_wo0_cma3_s(21) + u0_m0_wo0_cma3_x(20);
    u0_m0_wo0_cma3_y(21) <= u0_m0_wo0_cma3_s(22) + u0_m0_wo0_cma3_x(21);
    u0_m0_wo0_cma3_y(22) <= u0_m0_wo0_cma3_s(23) + u0_m0_wo0_cma3_x(22);
    u0_m0_wo0_cma3_y(23) <= u0_m0_wo0_cma3_s(24) + u0_m0_wo0_cma3_x(23);
    u0_m0_wo0_cma3_y(24) <= u0_m0_wo0_cma3_s(25) + u0_m0_wo0_cma3_x(24);
    u0_m0_wo0_cma3_y(25) <= u0_m0_wo0_cma3_s(26) + u0_m0_wo0_cma3_x(25);
    u0_m0_wo0_cma3_y(26) <= u0_m0_wo0_cma3_s(27) + u0_m0_wo0_cma3_x(26);
    u0_m0_wo0_cma3_y(27) <= u0_m0_wo0_cma3_s(28) + u0_m0_wo0_cma3_x(27);
    u0_m0_wo0_cma3_y(28) <= u0_m0_wo0_cma3_s(29) + u0_m0_wo0_cma3_x(28);
    u0_m0_wo0_cma3_y(29) <= u0_m0_wo0_cma3_s(30) + u0_m0_wo0_cma3_x(29);
    u0_m0_wo0_cma3_y(30) <= u0_m0_wo0_cma3_s(31) + u0_m0_wo0_cma3_x(30);
    u0_m0_wo0_cma3_y(31) <= u0_m0_wo0_cma3_x(31);
    u0_m0_wo0_cma3_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma3_a0 <= (others => (others => '0'));
            u0_m0_wo0_cma3_b0 <= (others => (others => '0'));
            u0_m0_wo0_cma3_c0 <= (others => (others => '0'));
            u0_m0_wo0_cma3_d <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma3_ena0 = '1') THEN
                u0_m0_wo0_cma3_a0(0) <= u0_m0_wo0_cma3_d(1);
                u0_m0_wo0_cma3_a0(1) <= u0_m0_wo0_cma3_d(2);
                u0_m0_wo0_cma3_a0(2) <= u0_m0_wo0_cma3_d(3);
                u0_m0_wo0_cma3_a0(3) <= u0_m0_wo0_cma3_d(4);
                u0_m0_wo0_cma3_a0(4) <= u0_m0_wo0_cma3_d(5);
                u0_m0_wo0_cma3_a0(5) <= u0_m0_wo0_cma3_d(6);
                u0_m0_wo0_cma3_a0(6) <= u0_m0_wo0_cma3_d(7);
                u0_m0_wo0_cma3_a0(7) <= u0_m0_wo0_cma3_d(8);
                u0_m0_wo0_cma3_a0(8) <= u0_m0_wo0_cma3_d(9);
                u0_m0_wo0_cma3_a0(9) <= u0_m0_wo0_cma3_d(10);
                u0_m0_wo0_cma3_a0(10) <= u0_m0_wo0_cma3_d(11);
                u0_m0_wo0_cma3_a0(11) <= u0_m0_wo0_cma3_d(12);
                u0_m0_wo0_cma3_a0(12) <= u0_m0_wo0_cma3_d(13);
                u0_m0_wo0_cma3_a0(13) <= u0_m0_wo0_cma3_d(14);
                u0_m0_wo0_cma3_a0(14) <= u0_m0_wo0_cma3_d(15);
                u0_m0_wo0_cma3_a0(15) <= u0_m0_wo0_cma3_d(16);
                u0_m0_wo0_cma3_a0(16) <= u0_m0_wo0_cma3_d(17);
                u0_m0_wo0_cma3_a0(17) <= u0_m0_wo0_cma3_d(18);
                u0_m0_wo0_cma3_a0(18) <= u0_m0_wo0_cma3_d(19);
                u0_m0_wo0_cma3_a0(19) <= u0_m0_wo0_cma3_d(20);
                u0_m0_wo0_cma3_a0(20) <= u0_m0_wo0_cma3_d(21);
                u0_m0_wo0_cma3_a0(21) <= u0_m0_wo0_cma3_d(22);
                u0_m0_wo0_cma3_a0(22) <= u0_m0_wo0_cma3_d(23);
                u0_m0_wo0_cma3_a0(23) <= u0_m0_wo0_cma3_d(24);
                u0_m0_wo0_cma3_a0(24) <= u0_m0_wo0_cma3_d(25);
                u0_m0_wo0_cma3_a0(25) <= u0_m0_wo0_cma3_d(26);
                u0_m0_wo0_cma3_a0(26) <= u0_m0_wo0_cma3_d(27);
                u0_m0_wo0_cma3_a0(27) <= u0_m0_wo0_cma3_d(28);
                u0_m0_wo0_cma3_a0(28) <= u0_m0_wo0_cma3_d(29);
                u0_m0_wo0_cma3_a0(29) <= u0_m0_wo0_cma3_d(30);
                u0_m0_wo0_cma3_a0(30) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr129_q),16);
                u0_m0_wo0_cma3_a0(31) <= SIGNED(RESIZE(UNSIGNED(GND_q),16));
                u0_m0_wo0_cma3_b0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(4) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(5) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(6) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(7) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(8) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(9) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(10) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(11) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(12) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(13) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(14) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(15) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(16) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(17) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(18) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(19) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(20) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(21) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(22) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(23) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(24) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(25) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(26) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(27) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(28) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(29) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(30) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_b0(31) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_d),16);
                u0_m0_wo0_cma3_c0(0) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(1) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(2) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(3) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(4) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(5) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(6) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(7) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(8) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(9) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(10) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(11) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(12) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(13) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(14) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(15) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(16) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(17) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(18) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(19) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(20) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(21) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(22) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(23) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(24) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(25) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(26) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(27) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(28) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(29) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(30) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_c0(31) <= RESIZE(UNSIGNED(GND_q),3);
                u0_m0_wo0_cma3_d(0) <= u0_m0_wo0_cma3_a0(0);
                u0_m0_wo0_cma3_d(1) <= u0_m0_wo0_cma3_a0(1);
                u0_m0_wo0_cma3_d(2) <= u0_m0_wo0_cma3_a0(2);
                u0_m0_wo0_cma3_d(3) <= u0_m0_wo0_cma3_a0(3);
                u0_m0_wo0_cma3_d(4) <= u0_m0_wo0_cma3_a0(4);
                u0_m0_wo0_cma3_d(5) <= u0_m0_wo0_cma3_a0(5);
                u0_m0_wo0_cma3_d(6) <= u0_m0_wo0_cma3_a0(6);
                u0_m0_wo0_cma3_d(7) <= u0_m0_wo0_cma3_a0(7);
                u0_m0_wo0_cma3_d(8) <= u0_m0_wo0_cma3_a0(8);
                u0_m0_wo0_cma3_d(9) <= u0_m0_wo0_cma3_a0(9);
                u0_m0_wo0_cma3_d(10) <= u0_m0_wo0_cma3_a0(10);
                u0_m0_wo0_cma3_d(11) <= u0_m0_wo0_cma3_a0(11);
                u0_m0_wo0_cma3_d(12) <= u0_m0_wo0_cma3_a0(12);
                u0_m0_wo0_cma3_d(13) <= u0_m0_wo0_cma3_a0(13);
                u0_m0_wo0_cma3_d(14) <= u0_m0_wo0_cma3_a0(14);
                u0_m0_wo0_cma3_d(15) <= u0_m0_wo0_cma3_a0(15);
                u0_m0_wo0_cma3_d(16) <= u0_m0_wo0_cma3_a0(16);
                u0_m0_wo0_cma3_d(17) <= u0_m0_wo0_cma3_a0(17);
                u0_m0_wo0_cma3_d(18) <= u0_m0_wo0_cma3_a0(18);
                u0_m0_wo0_cma3_d(19) <= u0_m0_wo0_cma3_a0(19);
                u0_m0_wo0_cma3_d(20) <= u0_m0_wo0_cma3_a0(20);
                u0_m0_wo0_cma3_d(21) <= u0_m0_wo0_cma3_a0(21);
                u0_m0_wo0_cma3_d(22) <= u0_m0_wo0_cma3_a0(22);
                u0_m0_wo0_cma3_d(23) <= u0_m0_wo0_cma3_a0(23);
                u0_m0_wo0_cma3_d(24) <= u0_m0_wo0_cma3_a0(24);
                u0_m0_wo0_cma3_d(25) <= u0_m0_wo0_cma3_a0(25);
                u0_m0_wo0_cma3_d(26) <= u0_m0_wo0_cma3_a0(26);
                u0_m0_wo0_cma3_d(27) <= u0_m0_wo0_cma3_a0(27);
                u0_m0_wo0_cma3_d(28) <= u0_m0_wo0_cma3_a0(28);
                u0_m0_wo0_cma3_d(29) <= u0_m0_wo0_cma3_a0(29);
                u0_m0_wo0_cma3_d(30) <= u0_m0_wo0_cma3_a0(30);
                u0_m0_wo0_cma3_d(31) <= u0_m0_wo0_cma3_a0(31);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma3_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma3_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma3_ena1 = '1') THEN
                u0_m0_wo0_cma3_s(0) <= u0_m0_wo0_cma3_y(0);
                u0_m0_wo0_cma3_s(1) <= u0_m0_wo0_cma3_y(1);
                u0_m0_wo0_cma3_s(2) <= u0_m0_wo0_cma3_y(2);
                u0_m0_wo0_cma3_s(3) <= u0_m0_wo0_cma3_y(3);
                u0_m0_wo0_cma3_s(4) <= u0_m0_wo0_cma3_y(4);
                u0_m0_wo0_cma3_s(5) <= u0_m0_wo0_cma3_y(5);
                u0_m0_wo0_cma3_s(6) <= u0_m0_wo0_cma3_y(6);
                u0_m0_wo0_cma3_s(7) <= u0_m0_wo0_cma3_y(7);
                u0_m0_wo0_cma3_s(8) <= u0_m0_wo0_cma3_y(8);
                u0_m0_wo0_cma3_s(9) <= u0_m0_wo0_cma3_y(9);
                u0_m0_wo0_cma3_s(10) <= u0_m0_wo0_cma3_y(10);
                u0_m0_wo0_cma3_s(11) <= u0_m0_wo0_cma3_y(11);
                u0_m0_wo0_cma3_s(12) <= u0_m0_wo0_cma3_y(12);
                u0_m0_wo0_cma3_s(13) <= u0_m0_wo0_cma3_y(13);
                u0_m0_wo0_cma3_s(14) <= u0_m0_wo0_cma3_y(14);
                u0_m0_wo0_cma3_s(15) <= u0_m0_wo0_cma3_y(15);
                u0_m0_wo0_cma3_s(16) <= u0_m0_wo0_cma3_y(16);
                u0_m0_wo0_cma3_s(17) <= u0_m0_wo0_cma3_y(17);
                u0_m0_wo0_cma3_s(18) <= u0_m0_wo0_cma3_y(18);
                u0_m0_wo0_cma3_s(19) <= u0_m0_wo0_cma3_y(19);
                u0_m0_wo0_cma3_s(20) <= u0_m0_wo0_cma3_y(20);
                u0_m0_wo0_cma3_s(21) <= u0_m0_wo0_cma3_y(21);
                u0_m0_wo0_cma3_s(22) <= u0_m0_wo0_cma3_y(22);
                u0_m0_wo0_cma3_s(23) <= u0_m0_wo0_cma3_y(23);
                u0_m0_wo0_cma3_s(24) <= u0_m0_wo0_cma3_y(24);
                u0_m0_wo0_cma3_s(25) <= u0_m0_wo0_cma3_y(25);
                u0_m0_wo0_cma3_s(26) <= u0_m0_wo0_cma3_y(26);
                u0_m0_wo0_cma3_s(27) <= u0_m0_wo0_cma3_y(27);
                u0_m0_wo0_cma3_s(28) <= u0_m0_wo0_cma3_y(28);
                u0_m0_wo0_cma3_s(29) <= u0_m0_wo0_cma3_y(29);
                u0_m0_wo0_cma3_s(30) <= u0_m0_wo0_cma3_y(30);
                u0_m0_wo0_cma3_s(31) <= u0_m0_wo0_cma3_y(31);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma3_delay : dspba_delay
    GENERIC MAP ( width => 35, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_cma3_s(0)(34 downto 0)), xout => u0_m0_wo0_cma3_qq, clk => clk, aclr => areset );
    u0_m0_wo0_cma3_q <= STD_LOGIC_VECTOR(u0_m0_wo0_cma3_qq(34 downto 0));

    -- u0_m0_wo0_wi0_r0_delayr130(DELAY,150)@10
    u0_m0_wo0_wi0_r0_delayr130 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr129_q, xout => u0_m0_wo0_wi0_r0_delayr130_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr131(DELAY,151)@10
    u0_m0_wo0_wi0_r0_delayr131 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr130_q, xout => u0_m0_wo0_wi0_r0_delayr131_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr132(DELAY,152)@10
    u0_m0_wo0_wi0_r0_delayr132 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr131_q, xout => u0_m0_wo0_wi0_r0_delayr132_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr133(DELAY,153)@10
    u0_m0_wo0_wi0_r0_delayr133 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr132_q, xout => u0_m0_wo0_wi0_r0_delayr133_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr134(DELAY,154)@10
    u0_m0_wo0_wi0_r0_delayr134 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr133_q, xout => u0_m0_wo0_wi0_r0_delayr134_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr135(DELAY,155)@10
    u0_m0_wo0_wi0_r0_delayr135 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr134_q, xout => u0_m0_wo0_wi0_r0_delayr135_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr136(DELAY,156)@10
    u0_m0_wo0_wi0_r0_delayr136 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr135_q, xout => u0_m0_wo0_wi0_r0_delayr136_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr137(DELAY,157)@10
    u0_m0_wo0_wi0_r0_delayr137 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr136_q, xout => u0_m0_wo0_wi0_r0_delayr137_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr138(DELAY,158)@10
    u0_m0_wo0_wi0_r0_delayr138 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr137_q, xout => u0_m0_wo0_wi0_r0_delayr138_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr139(DELAY,159)@10
    u0_m0_wo0_wi0_r0_delayr139 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr138_q, xout => u0_m0_wo0_wi0_r0_delayr139_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr140(DELAY,160)@10
    u0_m0_wo0_wi0_r0_delayr140 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr139_q, xout => u0_m0_wo0_wi0_r0_delayr140_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr141(DELAY,161)@10
    u0_m0_wo0_wi0_r0_delayr141 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr140_q, xout => u0_m0_wo0_wi0_r0_delayr141_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr142(DELAY,162)@10
    u0_m0_wo0_wi0_r0_delayr142 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr141_q, xout => u0_m0_wo0_wi0_r0_delayr142_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr143(DELAY,163)@10
    u0_m0_wo0_wi0_r0_delayr143 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr142_q, xout => u0_m0_wo0_wi0_r0_delayr143_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr144(DELAY,164)@10
    u0_m0_wo0_wi0_r0_delayr144 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr143_q, xout => u0_m0_wo0_wi0_r0_delayr144_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr160(DELAY,180)@10
    u0_m0_wo0_wi0_r0_delayr160_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr144_q);

    -- u0_m0_wo0_cma2(CHAINMULTADD,537)@10 + 2
    u0_m0_wo0_cma2_reset <= areset;
    u0_m0_wo0_cma2_ena0 <= input_valid_q(0);
    u0_m0_wo0_cma2_ena1 <= d_u0_m0_wo0_compute_q_11_q(0);
    u0_m0_wo0_cma2_l(0) <= RESIZE(u0_m0_wo0_cma2_a0(0),17) + RESIZE(u0_m0_wo0_cma2_b0(0),17);
    u0_m0_wo0_cma2_l(1) <= RESIZE(u0_m0_wo0_cma2_a0(1),17) + RESIZE(u0_m0_wo0_cma2_b0(1),17);
    u0_m0_wo0_cma2_l(2) <= RESIZE(u0_m0_wo0_cma2_a0(2),17) + RESIZE(u0_m0_wo0_cma2_b0(2),17);
    u0_m0_wo0_cma2_l(3) <= RESIZE(u0_m0_wo0_cma2_a0(3),17) + RESIZE(u0_m0_wo0_cma2_b0(3),17);
    u0_m0_wo0_cma2_l(4) <= RESIZE(u0_m0_wo0_cma2_a0(4),17) + RESIZE(u0_m0_wo0_cma2_b0(4),17);
    u0_m0_wo0_cma2_l(5) <= RESIZE(u0_m0_wo0_cma2_a0(5),17) + RESIZE(u0_m0_wo0_cma2_b0(5),17);
    u0_m0_wo0_cma2_l(6) <= RESIZE(u0_m0_wo0_cma2_a0(6),17) + RESIZE(u0_m0_wo0_cma2_b0(6),17);
    u0_m0_wo0_cma2_l(7) <= RESIZE(u0_m0_wo0_cma2_a0(7),17) + RESIZE(u0_m0_wo0_cma2_b0(7),17);
    u0_m0_wo0_cma2_l(8) <= RESIZE(u0_m0_wo0_cma2_a0(8),17) + RESIZE(u0_m0_wo0_cma2_b0(8),17);
    u0_m0_wo0_cma2_l(9) <= RESIZE(u0_m0_wo0_cma2_a0(9),17) + RESIZE(u0_m0_wo0_cma2_b0(9),17);
    u0_m0_wo0_cma2_l(10) <= RESIZE(u0_m0_wo0_cma2_a0(10),17) + RESIZE(u0_m0_wo0_cma2_b0(10),17);
    u0_m0_wo0_cma2_l(11) <= RESIZE(u0_m0_wo0_cma2_a0(11),17) + RESIZE(u0_m0_wo0_cma2_b0(11),17);
    u0_m0_wo0_cma2_l(12) <= RESIZE(u0_m0_wo0_cma2_a0(12),17) + RESIZE(u0_m0_wo0_cma2_b0(12),17);
    u0_m0_wo0_cma2_l(13) <= RESIZE(u0_m0_wo0_cma2_a0(13),17) + RESIZE(u0_m0_wo0_cma2_b0(13),17);
    u0_m0_wo0_cma2_l(14) <= RESIZE(u0_m0_wo0_cma2_a0(14),17) + RESIZE(u0_m0_wo0_cma2_b0(14),17);
    u0_m0_wo0_cma2_l(15) <= RESIZE(u0_m0_wo0_cma2_a0(15),17) + RESIZE(u0_m0_wo0_cma2_b0(15),17);
    u0_m0_wo0_cma2_l(16) <= RESIZE(u0_m0_wo0_cma2_a0(16),17) + RESIZE(u0_m0_wo0_cma2_b0(16),17);
    u0_m0_wo0_cma2_l(17) <= RESIZE(u0_m0_wo0_cma2_a0(17),17) + RESIZE(u0_m0_wo0_cma2_b0(17),17);
    u0_m0_wo0_cma2_l(18) <= RESIZE(u0_m0_wo0_cma2_a0(18),17) + RESIZE(u0_m0_wo0_cma2_b0(18),17);
    u0_m0_wo0_cma2_l(19) <= RESIZE(u0_m0_wo0_cma2_a0(19),17) + RESIZE(u0_m0_wo0_cma2_b0(19),17);
    u0_m0_wo0_cma2_l(20) <= RESIZE(u0_m0_wo0_cma2_a0(20),17) + RESIZE(u0_m0_wo0_cma2_b0(20),17);
    u0_m0_wo0_cma2_l(21) <= RESIZE(u0_m0_wo0_cma2_a0(21),17) + RESIZE(u0_m0_wo0_cma2_b0(21),17);
    u0_m0_wo0_cma2_l(22) <= RESIZE(u0_m0_wo0_cma2_a0(22),17) + RESIZE(u0_m0_wo0_cma2_b0(22),17);
    u0_m0_wo0_cma2_l(23) <= RESIZE(u0_m0_wo0_cma2_a0(23),17) + RESIZE(u0_m0_wo0_cma2_b0(23),17);
    u0_m0_wo0_cma2_l(24) <= RESIZE(u0_m0_wo0_cma2_a0(24),17) + RESIZE(u0_m0_wo0_cma2_b0(24),17);
    u0_m0_wo0_cma2_l(25) <= RESIZE(u0_m0_wo0_cma2_a0(25),17) + RESIZE(u0_m0_wo0_cma2_b0(25),17);
    u0_m0_wo0_cma2_l(26) <= RESIZE(u0_m0_wo0_cma2_a0(26),17) + RESIZE(u0_m0_wo0_cma2_b0(26),17);
    u0_m0_wo0_cma2_l(27) <= RESIZE(u0_m0_wo0_cma2_a0(27),17) + RESIZE(u0_m0_wo0_cma2_b0(27),17);
    u0_m0_wo0_cma2_l(28) <= RESIZE(u0_m0_wo0_cma2_a0(28),17) + RESIZE(u0_m0_wo0_cma2_b0(28),17);
    u0_m0_wo0_cma2_l(29) <= RESIZE(u0_m0_wo0_cma2_a0(29),17) + RESIZE(u0_m0_wo0_cma2_b0(29),17);
    u0_m0_wo0_cma2_l(30) <= RESIZE(u0_m0_wo0_cma2_a0(30),17) + RESIZE(u0_m0_wo0_cma2_b0(30),17);
    u0_m0_wo0_cma2_l(31) <= RESIZE(u0_m0_wo0_cma2_a0(31),17) + RESIZE(u0_m0_wo0_cma2_b0(31),17);
    -- altera synthesis_off
    u0_m0_wo0_cma2_k0 <= (
        0 => TO_SIGNED(-47,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k1 <= (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k2 <= (
        0 => TO_SIGNED(18,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k3 <= (
        0 => TO_SIGNED(53,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k4 <= (
        0 => TO_SIGNED(84,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k5 <= (
        0 => TO_SIGNED(105,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k6 <= (
        0 => TO_SIGNED(115,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k7 <= (
        0 => TO_SIGNED(109,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k8 <= (
        0 => TO_SIGNED(89,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k9 <= (
        0 => TO_SIGNED(55,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k10 <= (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k11 <= (
        0 => TO_SIGNED(-35,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k12 <= (
        0 => TO_SIGNED(-82,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k13 <= (
        0 => TO_SIGNED(-121,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k14 <= (
        0 => TO_SIGNED(-147,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k15 <= (
        0 => TO_SIGNED(-155,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k16 <= (
        0 => TO_SIGNED(-144,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k17 <= (
        0 => TO_SIGNED(-112,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k18 <= (
        0 => TO_SIGNED(-64,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k19 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k20 <= (
        0 => TO_SIGNED(62,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k21 <= (
        0 => TO_SIGNED(124,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k22 <= (
        0 => TO_SIGNED(174,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k23 <= (
        0 => TO_SIGNED(205,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k24 <= (
        0 => TO_SIGNED(212,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k25 <= (
        0 => TO_SIGNED(190,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k26 <= (
        0 => TO_SIGNED(142,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k27 <= (
        0 => TO_SIGNED(71,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k28 <= (
        0 => TO_SIGNED(-14,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k29 <= (
        0 => TO_SIGNED(-105,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k30 <= (
        0 => TO_SIGNED(-189,11),
        others => (others => '0'));
    u0_m0_wo0_cma2_k31 <= (
        0 => TO_SIGNED(-255,11),
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
    u0_m0_wo0_cma2_p(0) <= u0_m0_wo0_cma2_l(0) * u0_m0_wo0_cma2_r(0);
    u0_m0_wo0_cma2_p(1) <= u0_m0_wo0_cma2_l(1) * u0_m0_wo0_cma2_r(1);
    u0_m0_wo0_cma2_p(2) <= u0_m0_wo0_cma2_l(2) * u0_m0_wo0_cma2_r(2);
    u0_m0_wo0_cma2_p(3) <= u0_m0_wo0_cma2_l(3) * u0_m0_wo0_cma2_r(3);
    u0_m0_wo0_cma2_p(4) <= u0_m0_wo0_cma2_l(4) * u0_m0_wo0_cma2_r(4);
    u0_m0_wo0_cma2_p(5) <= u0_m0_wo0_cma2_l(5) * u0_m0_wo0_cma2_r(5);
    u0_m0_wo0_cma2_p(6) <= u0_m0_wo0_cma2_l(6) * u0_m0_wo0_cma2_r(6);
    u0_m0_wo0_cma2_p(7) <= u0_m0_wo0_cma2_l(7) * u0_m0_wo0_cma2_r(7);
    u0_m0_wo0_cma2_p(8) <= u0_m0_wo0_cma2_l(8) * u0_m0_wo0_cma2_r(8);
    u0_m0_wo0_cma2_p(9) <= u0_m0_wo0_cma2_l(9) * u0_m0_wo0_cma2_r(9);
    u0_m0_wo0_cma2_p(10) <= u0_m0_wo0_cma2_l(10) * u0_m0_wo0_cma2_r(10);
    u0_m0_wo0_cma2_p(11) <= u0_m0_wo0_cma2_l(11) * u0_m0_wo0_cma2_r(11);
    u0_m0_wo0_cma2_p(12) <= u0_m0_wo0_cma2_l(12) * u0_m0_wo0_cma2_r(12);
    u0_m0_wo0_cma2_p(13) <= u0_m0_wo0_cma2_l(13) * u0_m0_wo0_cma2_r(13);
    u0_m0_wo0_cma2_p(14) <= u0_m0_wo0_cma2_l(14) * u0_m0_wo0_cma2_r(14);
    u0_m0_wo0_cma2_p(15) <= u0_m0_wo0_cma2_l(15) * u0_m0_wo0_cma2_r(15);
    u0_m0_wo0_cma2_p(16) <= u0_m0_wo0_cma2_l(16) * u0_m0_wo0_cma2_r(16);
    u0_m0_wo0_cma2_p(17) <= u0_m0_wo0_cma2_l(17) * u0_m0_wo0_cma2_r(17);
    u0_m0_wo0_cma2_p(18) <= u0_m0_wo0_cma2_l(18) * u0_m0_wo0_cma2_r(18);
    u0_m0_wo0_cma2_p(19) <= u0_m0_wo0_cma2_l(19) * u0_m0_wo0_cma2_r(19);
    u0_m0_wo0_cma2_p(20) <= u0_m0_wo0_cma2_l(20) * u0_m0_wo0_cma2_r(20);
    u0_m0_wo0_cma2_p(21) <= u0_m0_wo0_cma2_l(21) * u0_m0_wo0_cma2_r(21);
    u0_m0_wo0_cma2_p(22) <= u0_m0_wo0_cma2_l(22) * u0_m0_wo0_cma2_r(22);
    u0_m0_wo0_cma2_p(23) <= u0_m0_wo0_cma2_l(23) * u0_m0_wo0_cma2_r(23);
    u0_m0_wo0_cma2_p(24) <= u0_m0_wo0_cma2_l(24) * u0_m0_wo0_cma2_r(24);
    u0_m0_wo0_cma2_p(25) <= u0_m0_wo0_cma2_l(25) * u0_m0_wo0_cma2_r(25);
    u0_m0_wo0_cma2_p(26) <= u0_m0_wo0_cma2_l(26) * u0_m0_wo0_cma2_r(26);
    u0_m0_wo0_cma2_p(27) <= u0_m0_wo0_cma2_l(27) * u0_m0_wo0_cma2_r(27);
    u0_m0_wo0_cma2_p(28) <= u0_m0_wo0_cma2_l(28) * u0_m0_wo0_cma2_r(28);
    u0_m0_wo0_cma2_p(29) <= u0_m0_wo0_cma2_l(29) * u0_m0_wo0_cma2_r(29);
    u0_m0_wo0_cma2_p(30) <= u0_m0_wo0_cma2_l(30) * u0_m0_wo0_cma2_r(30);
    u0_m0_wo0_cma2_p(31) <= u0_m0_wo0_cma2_l(31) * u0_m0_wo0_cma2_r(31);
    u0_m0_wo0_cma2_u(0) <= RESIZE(u0_m0_wo0_cma2_p(0),33);
    u0_m0_wo0_cma2_u(1) <= RESIZE(u0_m0_wo0_cma2_p(1),33);
    u0_m0_wo0_cma2_u(2) <= RESIZE(u0_m0_wo0_cma2_p(2),33);
    u0_m0_wo0_cma2_u(3) <= RESIZE(u0_m0_wo0_cma2_p(3),33);
    u0_m0_wo0_cma2_u(4) <= RESIZE(u0_m0_wo0_cma2_p(4),33);
    u0_m0_wo0_cma2_u(5) <= RESIZE(u0_m0_wo0_cma2_p(5),33);
    u0_m0_wo0_cma2_u(6) <= RESIZE(u0_m0_wo0_cma2_p(6),33);
    u0_m0_wo0_cma2_u(7) <= RESIZE(u0_m0_wo0_cma2_p(7),33);
    u0_m0_wo0_cma2_u(8) <= RESIZE(u0_m0_wo0_cma2_p(8),33);
    u0_m0_wo0_cma2_u(9) <= RESIZE(u0_m0_wo0_cma2_p(9),33);
    u0_m0_wo0_cma2_u(10) <= RESIZE(u0_m0_wo0_cma2_p(10),33);
    u0_m0_wo0_cma2_u(11) <= RESIZE(u0_m0_wo0_cma2_p(11),33);
    u0_m0_wo0_cma2_u(12) <= RESIZE(u0_m0_wo0_cma2_p(12),33);
    u0_m0_wo0_cma2_u(13) <= RESIZE(u0_m0_wo0_cma2_p(13),33);
    u0_m0_wo0_cma2_u(14) <= RESIZE(u0_m0_wo0_cma2_p(14),33);
    u0_m0_wo0_cma2_u(15) <= RESIZE(u0_m0_wo0_cma2_p(15),33);
    u0_m0_wo0_cma2_u(16) <= RESIZE(u0_m0_wo0_cma2_p(16),33);
    u0_m0_wo0_cma2_u(17) <= RESIZE(u0_m0_wo0_cma2_p(17),33);
    u0_m0_wo0_cma2_u(18) <= RESIZE(u0_m0_wo0_cma2_p(18),33);
    u0_m0_wo0_cma2_u(19) <= RESIZE(u0_m0_wo0_cma2_p(19),33);
    u0_m0_wo0_cma2_u(20) <= RESIZE(u0_m0_wo0_cma2_p(20),33);
    u0_m0_wo0_cma2_u(21) <= RESIZE(u0_m0_wo0_cma2_p(21),33);
    u0_m0_wo0_cma2_u(22) <= RESIZE(u0_m0_wo0_cma2_p(22),33);
    u0_m0_wo0_cma2_u(23) <= RESIZE(u0_m0_wo0_cma2_p(23),33);
    u0_m0_wo0_cma2_u(24) <= RESIZE(u0_m0_wo0_cma2_p(24),33);
    u0_m0_wo0_cma2_u(25) <= RESIZE(u0_m0_wo0_cma2_p(25),33);
    u0_m0_wo0_cma2_u(26) <= RESIZE(u0_m0_wo0_cma2_p(26),33);
    u0_m0_wo0_cma2_u(27) <= RESIZE(u0_m0_wo0_cma2_p(27),33);
    u0_m0_wo0_cma2_u(28) <= RESIZE(u0_m0_wo0_cma2_p(28),33);
    u0_m0_wo0_cma2_u(29) <= RESIZE(u0_m0_wo0_cma2_p(29),33);
    u0_m0_wo0_cma2_u(30) <= RESIZE(u0_m0_wo0_cma2_p(30),33);
    u0_m0_wo0_cma2_u(31) <= RESIZE(u0_m0_wo0_cma2_p(31),33);
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
    u0_m0_wo0_cma2_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma2_a0 <= (others => (others => '0'));
            u0_m0_wo0_cma2_b0 <= (others => (others => '0'));
            u0_m0_wo0_cma2_c0 <= (others => (others => '0'));
            u0_m0_wo0_cma2_d <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma2_ena0 = '1') THEN
                u0_m0_wo0_cma2_a0(0) <= u0_m0_wo0_cma2_d(1);
                u0_m0_wo0_cma2_a0(1) <= u0_m0_wo0_cma2_d(2);
                u0_m0_wo0_cma2_a0(2) <= u0_m0_wo0_cma2_d(3);
                u0_m0_wo0_cma2_a0(3) <= u0_m0_wo0_cma2_d(4);
                u0_m0_wo0_cma2_a0(4) <= u0_m0_wo0_cma2_d(5);
                u0_m0_wo0_cma2_a0(5) <= u0_m0_wo0_cma2_d(6);
                u0_m0_wo0_cma2_a0(6) <= u0_m0_wo0_cma2_d(7);
                u0_m0_wo0_cma2_a0(7) <= u0_m0_wo0_cma2_d(8);
                u0_m0_wo0_cma2_a0(8) <= u0_m0_wo0_cma2_d(9);
                u0_m0_wo0_cma2_a0(9) <= u0_m0_wo0_cma2_d(10);
                u0_m0_wo0_cma2_a0(10) <= u0_m0_wo0_cma2_d(11);
                u0_m0_wo0_cma2_a0(11) <= u0_m0_wo0_cma2_d(12);
                u0_m0_wo0_cma2_a0(12) <= u0_m0_wo0_cma2_d(13);
                u0_m0_wo0_cma2_a0(13) <= u0_m0_wo0_cma2_d(14);
                u0_m0_wo0_cma2_a0(14) <= u0_m0_wo0_cma2_d(15);
                u0_m0_wo0_cma2_a0(15) <= u0_m0_wo0_cma2_d(16);
                u0_m0_wo0_cma2_a0(16) <= u0_m0_wo0_cma2_d(17);
                u0_m0_wo0_cma2_a0(17) <= u0_m0_wo0_cma2_d(18);
                u0_m0_wo0_cma2_a0(18) <= u0_m0_wo0_cma2_d(19);
                u0_m0_wo0_cma2_a0(19) <= u0_m0_wo0_cma2_d(20);
                u0_m0_wo0_cma2_a0(20) <= u0_m0_wo0_cma2_d(21);
                u0_m0_wo0_cma2_a0(21) <= u0_m0_wo0_cma2_d(22);
                u0_m0_wo0_cma2_a0(22) <= u0_m0_wo0_cma2_d(23);
                u0_m0_wo0_cma2_a0(23) <= u0_m0_wo0_cma2_d(24);
                u0_m0_wo0_cma2_a0(24) <= u0_m0_wo0_cma2_d(25);
                u0_m0_wo0_cma2_a0(25) <= u0_m0_wo0_cma2_d(26);
                u0_m0_wo0_cma2_a0(26) <= u0_m0_wo0_cma2_d(27);
                u0_m0_wo0_cma2_a0(27) <= u0_m0_wo0_cma2_d(28);
                u0_m0_wo0_cma2_a0(28) <= u0_m0_wo0_cma2_d(29);
                u0_m0_wo0_cma2_a0(29) <= u0_m0_wo0_cma2_d(30);
                u0_m0_wo0_cma2_a0(30) <= u0_m0_wo0_cma2_d(31);
                u0_m0_wo0_cma2_a0(31) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr160_q),16);
                u0_m0_wo0_cma2_b0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(4) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(5) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(6) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(7) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(8) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(9) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(10) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(11) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(12) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(13) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(14) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(15) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(16) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(17) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(18) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(19) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(20) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(21) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(22) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(23) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(24) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(25) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(26) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(27) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(28) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(29) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(30) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
                u0_m0_wo0_cma2_b0(31) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_c),16);
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
                u0_m0_wo0_cma2_d(0) <= u0_m0_wo0_cma2_a0(0);
                u0_m0_wo0_cma2_d(1) <= u0_m0_wo0_cma2_a0(1);
                u0_m0_wo0_cma2_d(2) <= u0_m0_wo0_cma2_a0(2);
                u0_m0_wo0_cma2_d(3) <= u0_m0_wo0_cma2_a0(3);
                u0_m0_wo0_cma2_d(4) <= u0_m0_wo0_cma2_a0(4);
                u0_m0_wo0_cma2_d(5) <= u0_m0_wo0_cma2_a0(5);
                u0_m0_wo0_cma2_d(6) <= u0_m0_wo0_cma2_a0(6);
                u0_m0_wo0_cma2_d(7) <= u0_m0_wo0_cma2_a0(7);
                u0_m0_wo0_cma2_d(8) <= u0_m0_wo0_cma2_a0(8);
                u0_m0_wo0_cma2_d(9) <= u0_m0_wo0_cma2_a0(9);
                u0_m0_wo0_cma2_d(10) <= u0_m0_wo0_cma2_a0(10);
                u0_m0_wo0_cma2_d(11) <= u0_m0_wo0_cma2_a0(11);
                u0_m0_wo0_cma2_d(12) <= u0_m0_wo0_cma2_a0(12);
                u0_m0_wo0_cma2_d(13) <= u0_m0_wo0_cma2_a0(13);
                u0_m0_wo0_cma2_d(14) <= u0_m0_wo0_cma2_a0(14);
                u0_m0_wo0_cma2_d(15) <= u0_m0_wo0_cma2_a0(15);
                u0_m0_wo0_cma2_d(16) <= u0_m0_wo0_cma2_a0(16);
                u0_m0_wo0_cma2_d(17) <= u0_m0_wo0_cma2_a0(17);
                u0_m0_wo0_cma2_d(18) <= u0_m0_wo0_cma2_a0(18);
                u0_m0_wo0_cma2_d(19) <= u0_m0_wo0_cma2_a0(19);
                u0_m0_wo0_cma2_d(20) <= u0_m0_wo0_cma2_a0(20);
                u0_m0_wo0_cma2_d(21) <= u0_m0_wo0_cma2_a0(21);
                u0_m0_wo0_cma2_d(22) <= u0_m0_wo0_cma2_a0(22);
                u0_m0_wo0_cma2_d(23) <= u0_m0_wo0_cma2_a0(23);
                u0_m0_wo0_cma2_d(24) <= u0_m0_wo0_cma2_a0(24);
                u0_m0_wo0_cma2_d(25) <= u0_m0_wo0_cma2_a0(25);
                u0_m0_wo0_cma2_d(26) <= u0_m0_wo0_cma2_a0(26);
                u0_m0_wo0_cma2_d(27) <= u0_m0_wo0_cma2_a0(27);
                u0_m0_wo0_cma2_d(28) <= u0_m0_wo0_cma2_a0(28);
                u0_m0_wo0_cma2_d(29) <= u0_m0_wo0_cma2_a0(29);
                u0_m0_wo0_cma2_d(30) <= u0_m0_wo0_cma2_a0(30);
                u0_m0_wo0_cma2_d(31) <= u0_m0_wo0_cma2_a0(31);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma2_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma2_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma2_ena1 = '1') THEN
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
    GENERIC MAP ( width => 33, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_cma2_s(0)(32 downto 0)), xout => u0_m0_wo0_cma2_qq, clk => clk, aclr => areset );
    u0_m0_wo0_cma2_q <= STD_LOGIC_VECTOR(u0_m0_wo0_cma2_qq(32 downto 0));

    -- u0_m0_wo0_mtree_add0_1(ADD,540)@12 + 1
    u0_m0_wo0_mtree_add0_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 33 => u0_m0_wo0_cma2_q(32)) & u0_m0_wo0_cma2_q));
    u0_m0_wo0_mtree_add0_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => u0_m0_wo0_cma3_q(34)) & u0_m0_wo0_cma3_q));
    u0_m0_wo0_mtree_add0_1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_1_a) + SIGNED(u0_m0_wo0_mtree_add0_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_1_q <= u0_m0_wo0_mtree_add0_1_o(35 downto 0);

    -- u0_m0_wo0_wi0_r0_delayr161(DELAY,181)@10
    u0_m0_wo0_wi0_r0_delayr161 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr160_q, xout => u0_m0_wo0_wi0_r0_delayr161_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr162(DELAY,182)@10
    u0_m0_wo0_wi0_r0_delayr162 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr161_q, xout => u0_m0_wo0_wi0_r0_delayr162_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr163(DELAY,183)@10
    u0_m0_wo0_wi0_r0_delayr163 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr162_q, xout => u0_m0_wo0_wi0_r0_delayr163_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr164(DELAY,184)@10
    u0_m0_wo0_wi0_r0_delayr164 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr163_q, xout => u0_m0_wo0_wi0_r0_delayr164_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr165(DELAY,185)@10
    u0_m0_wo0_wi0_r0_delayr165 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr164_q, xout => u0_m0_wo0_wi0_r0_delayr165_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr166(DELAY,186)@10
    u0_m0_wo0_wi0_r0_delayr166 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr165_q, xout => u0_m0_wo0_wi0_r0_delayr166_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr167(DELAY,187)@10
    u0_m0_wo0_wi0_r0_delayr167 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr166_q, xout => u0_m0_wo0_wi0_r0_delayr167_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr168(DELAY,188)@10
    u0_m0_wo0_wi0_r0_delayr168 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr167_q, xout => u0_m0_wo0_wi0_r0_delayr168_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr169(DELAY,189)@10
    u0_m0_wo0_wi0_r0_delayr169 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr168_q, xout => u0_m0_wo0_wi0_r0_delayr169_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr170(DELAY,190)@10
    u0_m0_wo0_wi0_r0_delayr170 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr169_q, xout => u0_m0_wo0_wi0_r0_delayr170_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr171(DELAY,191)@10
    u0_m0_wo0_wi0_r0_delayr171 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr170_q, xout => u0_m0_wo0_wi0_r0_delayr171_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr172(DELAY,192)@10
    u0_m0_wo0_wi0_r0_delayr172 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr171_q, xout => u0_m0_wo0_wi0_r0_delayr172_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr173(DELAY,193)@10
    u0_m0_wo0_wi0_r0_delayr173 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr172_q, xout => u0_m0_wo0_wi0_r0_delayr173_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr174(DELAY,194)@10
    u0_m0_wo0_wi0_r0_delayr174 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr173_q, xout => u0_m0_wo0_wi0_r0_delayr174_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr175(DELAY,195)@10
    u0_m0_wo0_wi0_r0_delayr175 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr174_q, xout => u0_m0_wo0_wi0_r0_delayr175_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr176(DELAY,196)@10
    u0_m0_wo0_wi0_r0_delayr176 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr175_q, xout => u0_m0_wo0_wi0_r0_delayr176_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr192(DELAY,212)@10
    u0_m0_wo0_wi0_r0_delayr192_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr176_q);

    -- u0_m0_wo0_cma1(CHAINMULTADD,536)@10 + 2
    u0_m0_wo0_cma1_reset <= areset;
    u0_m0_wo0_cma1_ena0 <= input_valid_q(0);
    u0_m0_wo0_cma1_ena1 <= d_u0_m0_wo0_compute_q_11_q(0);
    u0_m0_wo0_cma1_l(0) <= RESIZE(u0_m0_wo0_cma1_a0(0),17) + RESIZE(u0_m0_wo0_cma1_b0(0),17);
    u0_m0_wo0_cma1_l(1) <= RESIZE(u0_m0_wo0_cma1_a0(1),17) + RESIZE(u0_m0_wo0_cma1_b0(1),17);
    u0_m0_wo0_cma1_l(2) <= RESIZE(u0_m0_wo0_cma1_a0(2),17) + RESIZE(u0_m0_wo0_cma1_b0(2),17);
    u0_m0_wo0_cma1_l(3) <= RESIZE(u0_m0_wo0_cma1_a0(3),17) + RESIZE(u0_m0_wo0_cma1_b0(3),17);
    u0_m0_wo0_cma1_l(4) <= RESIZE(u0_m0_wo0_cma1_a0(4),17) + RESIZE(u0_m0_wo0_cma1_b0(4),17);
    u0_m0_wo0_cma1_l(5) <= RESIZE(u0_m0_wo0_cma1_a0(5),17) + RESIZE(u0_m0_wo0_cma1_b0(5),17);
    u0_m0_wo0_cma1_l(6) <= RESIZE(u0_m0_wo0_cma1_a0(6),17) + RESIZE(u0_m0_wo0_cma1_b0(6),17);
    u0_m0_wo0_cma1_l(7) <= RESIZE(u0_m0_wo0_cma1_a0(7),17) + RESIZE(u0_m0_wo0_cma1_b0(7),17);
    u0_m0_wo0_cma1_l(8) <= RESIZE(u0_m0_wo0_cma1_a0(8),17) + RESIZE(u0_m0_wo0_cma1_b0(8),17);
    u0_m0_wo0_cma1_l(9) <= RESIZE(u0_m0_wo0_cma1_a0(9),17) + RESIZE(u0_m0_wo0_cma1_b0(9),17);
    u0_m0_wo0_cma1_l(10) <= RESIZE(u0_m0_wo0_cma1_a0(10),17) + RESIZE(u0_m0_wo0_cma1_b0(10),17);
    u0_m0_wo0_cma1_l(11) <= RESIZE(u0_m0_wo0_cma1_a0(11),17) + RESIZE(u0_m0_wo0_cma1_b0(11),17);
    u0_m0_wo0_cma1_l(12) <= RESIZE(u0_m0_wo0_cma1_a0(12),17) + RESIZE(u0_m0_wo0_cma1_b0(12),17);
    u0_m0_wo0_cma1_l(13) <= RESIZE(u0_m0_wo0_cma1_a0(13),17) + RESIZE(u0_m0_wo0_cma1_b0(13),17);
    u0_m0_wo0_cma1_l(14) <= RESIZE(u0_m0_wo0_cma1_a0(14),17) + RESIZE(u0_m0_wo0_cma1_b0(14),17);
    u0_m0_wo0_cma1_l(15) <= RESIZE(u0_m0_wo0_cma1_a0(15),17) + RESIZE(u0_m0_wo0_cma1_b0(15),17);
    u0_m0_wo0_cma1_l(16) <= RESIZE(u0_m0_wo0_cma1_a0(16),17) + RESIZE(u0_m0_wo0_cma1_b0(16),17);
    u0_m0_wo0_cma1_l(17) <= RESIZE(u0_m0_wo0_cma1_a0(17),17) + RESIZE(u0_m0_wo0_cma1_b0(17),17);
    u0_m0_wo0_cma1_l(18) <= RESIZE(u0_m0_wo0_cma1_a0(18),17) + RESIZE(u0_m0_wo0_cma1_b0(18),17);
    u0_m0_wo0_cma1_l(19) <= RESIZE(u0_m0_wo0_cma1_a0(19),17) + RESIZE(u0_m0_wo0_cma1_b0(19),17);
    u0_m0_wo0_cma1_l(20) <= RESIZE(u0_m0_wo0_cma1_a0(20),17) + RESIZE(u0_m0_wo0_cma1_b0(20),17);
    u0_m0_wo0_cma1_l(21) <= RESIZE(u0_m0_wo0_cma1_a0(21),17) + RESIZE(u0_m0_wo0_cma1_b0(21),17);
    u0_m0_wo0_cma1_l(22) <= RESIZE(u0_m0_wo0_cma1_a0(22),17) + RESIZE(u0_m0_wo0_cma1_b0(22),17);
    u0_m0_wo0_cma1_l(23) <= RESIZE(u0_m0_wo0_cma1_a0(23),17) + RESIZE(u0_m0_wo0_cma1_b0(23),17);
    u0_m0_wo0_cma1_l(24) <= RESIZE(u0_m0_wo0_cma1_a0(24),17) + RESIZE(u0_m0_wo0_cma1_b0(24),17);
    u0_m0_wo0_cma1_l(25) <= RESIZE(u0_m0_wo0_cma1_a0(25),17) + RESIZE(u0_m0_wo0_cma1_b0(25),17);
    u0_m0_wo0_cma1_l(26) <= RESIZE(u0_m0_wo0_cma1_a0(26),17) + RESIZE(u0_m0_wo0_cma1_b0(26),17);
    u0_m0_wo0_cma1_l(27) <= RESIZE(u0_m0_wo0_cma1_a0(27),17) + RESIZE(u0_m0_wo0_cma1_b0(27),17);
    u0_m0_wo0_cma1_l(28) <= RESIZE(u0_m0_wo0_cma1_a0(28),17) + RESIZE(u0_m0_wo0_cma1_b0(28),17);
    u0_m0_wo0_cma1_l(29) <= RESIZE(u0_m0_wo0_cma1_a0(29),17) + RESIZE(u0_m0_wo0_cma1_b0(29),17);
    u0_m0_wo0_cma1_l(30) <= RESIZE(u0_m0_wo0_cma1_a0(30),17) + RESIZE(u0_m0_wo0_cma1_b0(30),17);
    u0_m0_wo0_cma1_l(31) <= RESIZE(u0_m0_wo0_cma1_a0(31),17) + RESIZE(u0_m0_wo0_cma1_b0(31),17);
    -- altera synthesis_off
    u0_m0_wo0_cma1_k0 <= (
        0 => TO_SIGNED(14,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k1 <= (
        0 => TO_SIGNED(22,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k2 <= (
        0 => TO_SIGNED(28,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k3 <= (
        0 => TO_SIGNED(30,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k4 <= (
        0 => TO_SIGNED(29,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k5 <= (
        0 => TO_SIGNED(23,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k6 <= (
        0 => TO_SIGNED(13,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k7 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k8 <= (
        0 => TO_SIGNED(-11,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k9 <= (
        0 => TO_SIGNED(-24,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k10 <= (
        0 => TO_SIGNED(-35,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k11 <= (
        0 => TO_SIGNED(-42,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k12 <= (
        0 => TO_SIGNED(-44,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k13 <= (
        0 => TO_SIGNED(-40,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k14 <= (
        0 => TO_SIGNED(-30,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k15 <= (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k16 <= (
        0 => TO_SIGNED(1,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k17 <= (
        0 => TO_SIGNED(20,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k18 <= (
        0 => TO_SIGNED(38,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k19 <= (
        0 => TO_SIGNED(52,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k20 <= (
        0 => TO_SIGNED(60,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k21 <= (
        0 => TO_SIGNED(61,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k22 <= (
        0 => TO_SIGNED(53,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k23 <= (
        0 => TO_SIGNED(38,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k24 <= (
        0 => TO_SIGNED(17,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k25 <= (
        0 => TO_SIGNED(-7,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k26 <= (
        0 => TO_SIGNED(-33,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k27 <= (
        0 => TO_SIGNED(-57,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k28 <= (
        0 => TO_SIGNED(-75,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k29 <= (
        0 => TO_SIGNED(-84,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k30 <= (
        0 => TO_SIGNED(-82,11),
        others => (others => '0'));
    u0_m0_wo0_cma1_k31 <= (
        0 => TO_SIGNED(-70,11),
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
    u0_m0_wo0_cma1_p(0) <= u0_m0_wo0_cma1_l(0) * u0_m0_wo0_cma1_r(0);
    u0_m0_wo0_cma1_p(1) <= u0_m0_wo0_cma1_l(1) * u0_m0_wo0_cma1_r(1);
    u0_m0_wo0_cma1_p(2) <= u0_m0_wo0_cma1_l(2) * u0_m0_wo0_cma1_r(2);
    u0_m0_wo0_cma1_p(3) <= u0_m0_wo0_cma1_l(3) * u0_m0_wo0_cma1_r(3);
    u0_m0_wo0_cma1_p(4) <= u0_m0_wo0_cma1_l(4) * u0_m0_wo0_cma1_r(4);
    u0_m0_wo0_cma1_p(5) <= u0_m0_wo0_cma1_l(5) * u0_m0_wo0_cma1_r(5);
    u0_m0_wo0_cma1_p(6) <= u0_m0_wo0_cma1_l(6) * u0_m0_wo0_cma1_r(6);
    u0_m0_wo0_cma1_p(7) <= u0_m0_wo0_cma1_l(7) * u0_m0_wo0_cma1_r(7);
    u0_m0_wo0_cma1_p(8) <= u0_m0_wo0_cma1_l(8) * u0_m0_wo0_cma1_r(8);
    u0_m0_wo0_cma1_p(9) <= u0_m0_wo0_cma1_l(9) * u0_m0_wo0_cma1_r(9);
    u0_m0_wo0_cma1_p(10) <= u0_m0_wo0_cma1_l(10) * u0_m0_wo0_cma1_r(10);
    u0_m0_wo0_cma1_p(11) <= u0_m0_wo0_cma1_l(11) * u0_m0_wo0_cma1_r(11);
    u0_m0_wo0_cma1_p(12) <= u0_m0_wo0_cma1_l(12) * u0_m0_wo0_cma1_r(12);
    u0_m0_wo0_cma1_p(13) <= u0_m0_wo0_cma1_l(13) * u0_m0_wo0_cma1_r(13);
    u0_m0_wo0_cma1_p(14) <= u0_m0_wo0_cma1_l(14) * u0_m0_wo0_cma1_r(14);
    u0_m0_wo0_cma1_p(15) <= u0_m0_wo0_cma1_l(15) * u0_m0_wo0_cma1_r(15);
    u0_m0_wo0_cma1_p(16) <= u0_m0_wo0_cma1_l(16) * u0_m0_wo0_cma1_r(16);
    u0_m0_wo0_cma1_p(17) <= u0_m0_wo0_cma1_l(17) * u0_m0_wo0_cma1_r(17);
    u0_m0_wo0_cma1_p(18) <= u0_m0_wo0_cma1_l(18) * u0_m0_wo0_cma1_r(18);
    u0_m0_wo0_cma1_p(19) <= u0_m0_wo0_cma1_l(19) * u0_m0_wo0_cma1_r(19);
    u0_m0_wo0_cma1_p(20) <= u0_m0_wo0_cma1_l(20) * u0_m0_wo0_cma1_r(20);
    u0_m0_wo0_cma1_p(21) <= u0_m0_wo0_cma1_l(21) * u0_m0_wo0_cma1_r(21);
    u0_m0_wo0_cma1_p(22) <= u0_m0_wo0_cma1_l(22) * u0_m0_wo0_cma1_r(22);
    u0_m0_wo0_cma1_p(23) <= u0_m0_wo0_cma1_l(23) * u0_m0_wo0_cma1_r(23);
    u0_m0_wo0_cma1_p(24) <= u0_m0_wo0_cma1_l(24) * u0_m0_wo0_cma1_r(24);
    u0_m0_wo0_cma1_p(25) <= u0_m0_wo0_cma1_l(25) * u0_m0_wo0_cma1_r(25);
    u0_m0_wo0_cma1_p(26) <= u0_m0_wo0_cma1_l(26) * u0_m0_wo0_cma1_r(26);
    u0_m0_wo0_cma1_p(27) <= u0_m0_wo0_cma1_l(27) * u0_m0_wo0_cma1_r(27);
    u0_m0_wo0_cma1_p(28) <= u0_m0_wo0_cma1_l(28) * u0_m0_wo0_cma1_r(28);
    u0_m0_wo0_cma1_p(29) <= u0_m0_wo0_cma1_l(29) * u0_m0_wo0_cma1_r(29);
    u0_m0_wo0_cma1_p(30) <= u0_m0_wo0_cma1_l(30) * u0_m0_wo0_cma1_r(30);
    u0_m0_wo0_cma1_p(31) <= u0_m0_wo0_cma1_l(31) * u0_m0_wo0_cma1_r(31);
    u0_m0_wo0_cma1_u(0) <= RESIZE(u0_m0_wo0_cma1_p(0),33);
    u0_m0_wo0_cma1_u(1) <= RESIZE(u0_m0_wo0_cma1_p(1),33);
    u0_m0_wo0_cma1_u(2) <= RESIZE(u0_m0_wo0_cma1_p(2),33);
    u0_m0_wo0_cma1_u(3) <= RESIZE(u0_m0_wo0_cma1_p(3),33);
    u0_m0_wo0_cma1_u(4) <= RESIZE(u0_m0_wo0_cma1_p(4),33);
    u0_m0_wo0_cma1_u(5) <= RESIZE(u0_m0_wo0_cma1_p(5),33);
    u0_m0_wo0_cma1_u(6) <= RESIZE(u0_m0_wo0_cma1_p(6),33);
    u0_m0_wo0_cma1_u(7) <= RESIZE(u0_m0_wo0_cma1_p(7),33);
    u0_m0_wo0_cma1_u(8) <= RESIZE(u0_m0_wo0_cma1_p(8),33);
    u0_m0_wo0_cma1_u(9) <= RESIZE(u0_m0_wo0_cma1_p(9),33);
    u0_m0_wo0_cma1_u(10) <= RESIZE(u0_m0_wo0_cma1_p(10),33);
    u0_m0_wo0_cma1_u(11) <= RESIZE(u0_m0_wo0_cma1_p(11),33);
    u0_m0_wo0_cma1_u(12) <= RESIZE(u0_m0_wo0_cma1_p(12),33);
    u0_m0_wo0_cma1_u(13) <= RESIZE(u0_m0_wo0_cma1_p(13),33);
    u0_m0_wo0_cma1_u(14) <= RESIZE(u0_m0_wo0_cma1_p(14),33);
    u0_m0_wo0_cma1_u(15) <= RESIZE(u0_m0_wo0_cma1_p(15),33);
    u0_m0_wo0_cma1_u(16) <= RESIZE(u0_m0_wo0_cma1_p(16),33);
    u0_m0_wo0_cma1_u(17) <= RESIZE(u0_m0_wo0_cma1_p(17),33);
    u0_m0_wo0_cma1_u(18) <= RESIZE(u0_m0_wo0_cma1_p(18),33);
    u0_m0_wo0_cma1_u(19) <= RESIZE(u0_m0_wo0_cma1_p(19),33);
    u0_m0_wo0_cma1_u(20) <= RESIZE(u0_m0_wo0_cma1_p(20),33);
    u0_m0_wo0_cma1_u(21) <= RESIZE(u0_m0_wo0_cma1_p(21),33);
    u0_m0_wo0_cma1_u(22) <= RESIZE(u0_m0_wo0_cma1_p(22),33);
    u0_m0_wo0_cma1_u(23) <= RESIZE(u0_m0_wo0_cma1_p(23),33);
    u0_m0_wo0_cma1_u(24) <= RESIZE(u0_m0_wo0_cma1_p(24),33);
    u0_m0_wo0_cma1_u(25) <= RESIZE(u0_m0_wo0_cma1_p(25),33);
    u0_m0_wo0_cma1_u(26) <= RESIZE(u0_m0_wo0_cma1_p(26),33);
    u0_m0_wo0_cma1_u(27) <= RESIZE(u0_m0_wo0_cma1_p(27),33);
    u0_m0_wo0_cma1_u(28) <= RESIZE(u0_m0_wo0_cma1_p(28),33);
    u0_m0_wo0_cma1_u(29) <= RESIZE(u0_m0_wo0_cma1_p(29),33);
    u0_m0_wo0_cma1_u(30) <= RESIZE(u0_m0_wo0_cma1_p(30),33);
    u0_m0_wo0_cma1_u(31) <= RESIZE(u0_m0_wo0_cma1_p(31),33);
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
    u0_m0_wo0_cma1_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma1_a0 <= (others => (others => '0'));
            u0_m0_wo0_cma1_b0 <= (others => (others => '0'));
            u0_m0_wo0_cma1_c0 <= (others => (others => '0'));
            u0_m0_wo0_cma1_d <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma1_ena0 = '1') THEN
                u0_m0_wo0_cma1_a0(0) <= u0_m0_wo0_cma1_d(1);
                u0_m0_wo0_cma1_a0(1) <= u0_m0_wo0_cma1_d(2);
                u0_m0_wo0_cma1_a0(2) <= u0_m0_wo0_cma1_d(3);
                u0_m0_wo0_cma1_a0(3) <= u0_m0_wo0_cma1_d(4);
                u0_m0_wo0_cma1_a0(4) <= u0_m0_wo0_cma1_d(5);
                u0_m0_wo0_cma1_a0(5) <= u0_m0_wo0_cma1_d(6);
                u0_m0_wo0_cma1_a0(6) <= u0_m0_wo0_cma1_d(7);
                u0_m0_wo0_cma1_a0(7) <= u0_m0_wo0_cma1_d(8);
                u0_m0_wo0_cma1_a0(8) <= u0_m0_wo0_cma1_d(9);
                u0_m0_wo0_cma1_a0(9) <= u0_m0_wo0_cma1_d(10);
                u0_m0_wo0_cma1_a0(10) <= u0_m0_wo0_cma1_d(11);
                u0_m0_wo0_cma1_a0(11) <= u0_m0_wo0_cma1_d(12);
                u0_m0_wo0_cma1_a0(12) <= u0_m0_wo0_cma1_d(13);
                u0_m0_wo0_cma1_a0(13) <= u0_m0_wo0_cma1_d(14);
                u0_m0_wo0_cma1_a0(14) <= u0_m0_wo0_cma1_d(15);
                u0_m0_wo0_cma1_a0(15) <= u0_m0_wo0_cma1_d(16);
                u0_m0_wo0_cma1_a0(16) <= u0_m0_wo0_cma1_d(17);
                u0_m0_wo0_cma1_a0(17) <= u0_m0_wo0_cma1_d(18);
                u0_m0_wo0_cma1_a0(18) <= u0_m0_wo0_cma1_d(19);
                u0_m0_wo0_cma1_a0(19) <= u0_m0_wo0_cma1_d(20);
                u0_m0_wo0_cma1_a0(20) <= u0_m0_wo0_cma1_d(21);
                u0_m0_wo0_cma1_a0(21) <= u0_m0_wo0_cma1_d(22);
                u0_m0_wo0_cma1_a0(22) <= u0_m0_wo0_cma1_d(23);
                u0_m0_wo0_cma1_a0(23) <= u0_m0_wo0_cma1_d(24);
                u0_m0_wo0_cma1_a0(24) <= u0_m0_wo0_cma1_d(25);
                u0_m0_wo0_cma1_a0(25) <= u0_m0_wo0_cma1_d(26);
                u0_m0_wo0_cma1_a0(26) <= u0_m0_wo0_cma1_d(27);
                u0_m0_wo0_cma1_a0(27) <= u0_m0_wo0_cma1_d(28);
                u0_m0_wo0_cma1_a0(28) <= u0_m0_wo0_cma1_d(29);
                u0_m0_wo0_cma1_a0(29) <= u0_m0_wo0_cma1_d(30);
                u0_m0_wo0_cma1_a0(30) <= u0_m0_wo0_cma1_d(31);
                u0_m0_wo0_cma1_a0(31) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr192_q),16);
                u0_m0_wo0_cma1_b0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(4) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(5) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(6) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(7) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(8) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(9) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(10) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(11) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(12) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(13) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(14) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(15) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(16) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(17) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(18) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(19) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(20) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(21) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(22) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(23) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(24) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(25) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(26) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(27) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(28) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(29) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(30) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
                u0_m0_wo0_cma1_b0(31) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split32_b),16);
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
                u0_m0_wo0_cma1_d(0) <= u0_m0_wo0_cma1_a0(0);
                u0_m0_wo0_cma1_d(1) <= u0_m0_wo0_cma1_a0(1);
                u0_m0_wo0_cma1_d(2) <= u0_m0_wo0_cma1_a0(2);
                u0_m0_wo0_cma1_d(3) <= u0_m0_wo0_cma1_a0(3);
                u0_m0_wo0_cma1_d(4) <= u0_m0_wo0_cma1_a0(4);
                u0_m0_wo0_cma1_d(5) <= u0_m0_wo0_cma1_a0(5);
                u0_m0_wo0_cma1_d(6) <= u0_m0_wo0_cma1_a0(6);
                u0_m0_wo0_cma1_d(7) <= u0_m0_wo0_cma1_a0(7);
                u0_m0_wo0_cma1_d(8) <= u0_m0_wo0_cma1_a0(8);
                u0_m0_wo0_cma1_d(9) <= u0_m0_wo0_cma1_a0(9);
                u0_m0_wo0_cma1_d(10) <= u0_m0_wo0_cma1_a0(10);
                u0_m0_wo0_cma1_d(11) <= u0_m0_wo0_cma1_a0(11);
                u0_m0_wo0_cma1_d(12) <= u0_m0_wo0_cma1_a0(12);
                u0_m0_wo0_cma1_d(13) <= u0_m0_wo0_cma1_a0(13);
                u0_m0_wo0_cma1_d(14) <= u0_m0_wo0_cma1_a0(14);
                u0_m0_wo0_cma1_d(15) <= u0_m0_wo0_cma1_a0(15);
                u0_m0_wo0_cma1_d(16) <= u0_m0_wo0_cma1_a0(16);
                u0_m0_wo0_cma1_d(17) <= u0_m0_wo0_cma1_a0(17);
                u0_m0_wo0_cma1_d(18) <= u0_m0_wo0_cma1_a0(18);
                u0_m0_wo0_cma1_d(19) <= u0_m0_wo0_cma1_a0(19);
                u0_m0_wo0_cma1_d(20) <= u0_m0_wo0_cma1_a0(20);
                u0_m0_wo0_cma1_d(21) <= u0_m0_wo0_cma1_a0(21);
                u0_m0_wo0_cma1_d(22) <= u0_m0_wo0_cma1_a0(22);
                u0_m0_wo0_cma1_d(23) <= u0_m0_wo0_cma1_a0(23);
                u0_m0_wo0_cma1_d(24) <= u0_m0_wo0_cma1_a0(24);
                u0_m0_wo0_cma1_d(25) <= u0_m0_wo0_cma1_a0(25);
                u0_m0_wo0_cma1_d(26) <= u0_m0_wo0_cma1_a0(26);
                u0_m0_wo0_cma1_d(27) <= u0_m0_wo0_cma1_a0(27);
                u0_m0_wo0_cma1_d(28) <= u0_m0_wo0_cma1_a0(28);
                u0_m0_wo0_cma1_d(29) <= u0_m0_wo0_cma1_a0(29);
                u0_m0_wo0_cma1_d(30) <= u0_m0_wo0_cma1_a0(30);
                u0_m0_wo0_cma1_d(31) <= u0_m0_wo0_cma1_a0(31);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma1_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma1_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma1_ena1 = '1') THEN
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
    GENERIC MAP ( width => 33, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_cma1_s(0)(32 downto 0)), xout => u0_m0_wo0_cma1_qq, clk => clk, aclr => areset );
    u0_m0_wo0_cma1_q <= STD_LOGIC_VECTOR(u0_m0_wo0_cma1_qq(32 downto 0));

    -- u0_m0_wo0_wi0_r0_delayr193(DELAY,213)@10
    u0_m0_wo0_wi0_r0_delayr193 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr192_q, xout => u0_m0_wo0_wi0_r0_delayr193_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr194(DELAY,214)@10
    u0_m0_wo0_wi0_r0_delayr194 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr193_q, xout => u0_m0_wo0_wi0_r0_delayr194_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr195(DELAY,215)@10
    u0_m0_wo0_wi0_r0_delayr195 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr194_q, xout => u0_m0_wo0_wi0_r0_delayr195_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr196(DELAY,216)@10
    u0_m0_wo0_wi0_r0_delayr196 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr195_q, xout => u0_m0_wo0_wi0_r0_delayr196_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr197(DELAY,217)@10
    u0_m0_wo0_wi0_r0_delayr197 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr196_q, xout => u0_m0_wo0_wi0_r0_delayr197_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr198(DELAY,218)@10
    u0_m0_wo0_wi0_r0_delayr198 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr197_q, xout => u0_m0_wo0_wi0_r0_delayr198_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr199(DELAY,219)@10
    u0_m0_wo0_wi0_r0_delayr199 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr198_q, xout => u0_m0_wo0_wi0_r0_delayr199_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr200(DELAY,220)@10
    u0_m0_wo0_wi0_r0_delayr200 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr199_q, xout => u0_m0_wo0_wi0_r0_delayr200_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr201(DELAY,221)@10
    u0_m0_wo0_wi0_r0_delayr201 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr200_q, xout => u0_m0_wo0_wi0_r0_delayr201_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr202(DELAY,222)@10
    u0_m0_wo0_wi0_r0_delayr202 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr201_q, xout => u0_m0_wo0_wi0_r0_delayr202_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr203(DELAY,223)@10
    u0_m0_wo0_wi0_r0_delayr203 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr202_q, xout => u0_m0_wo0_wi0_r0_delayr203_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr204(DELAY,224)@10
    u0_m0_wo0_wi0_r0_delayr204 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr203_q, xout => u0_m0_wo0_wi0_r0_delayr204_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr205(DELAY,225)@10
    u0_m0_wo0_wi0_r0_delayr205 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr204_q, xout => u0_m0_wo0_wi0_r0_delayr205_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr206(DELAY,226)@10
    u0_m0_wo0_wi0_r0_delayr206 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr205_q, xout => u0_m0_wo0_wi0_r0_delayr206_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr207(DELAY,227)@10
    u0_m0_wo0_wi0_r0_delayr207 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr206_q, xout => u0_m0_wo0_wi0_r0_delayr207_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr208(DELAY,228)@10
    u0_m0_wo0_wi0_r0_delayr208 : dspba_delay
    GENERIC MAP ( width => 16, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr207_q, xout => u0_m0_wo0_wi0_r0_delayr208_q, ena => input_valid_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr224(DELAY,244)@10
    u0_m0_wo0_wi0_r0_delayr224_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr208_q);

    -- u0_m0_wo0_cma0(CHAINMULTADD,535)@10 + 2
    u0_m0_wo0_cma0_reset <= areset;
    u0_m0_wo0_cma0_ena0 <= input_valid_q(0);
    u0_m0_wo0_cma0_ena1 <= d_u0_m0_wo0_compute_q_11_q(0);
    u0_m0_wo0_cma0_l(0) <= RESIZE(u0_m0_wo0_cma0_a0(0),17) + RESIZE(u0_m0_wo0_cma0_b0(0),17);
    u0_m0_wo0_cma0_l(1) <= RESIZE(u0_m0_wo0_cma0_a0(1),17) + RESIZE(u0_m0_wo0_cma0_b0(1),17);
    u0_m0_wo0_cma0_l(2) <= RESIZE(u0_m0_wo0_cma0_a0(2),17) + RESIZE(u0_m0_wo0_cma0_b0(2),17);
    u0_m0_wo0_cma0_l(3) <= RESIZE(u0_m0_wo0_cma0_a0(3),17) + RESIZE(u0_m0_wo0_cma0_b0(3),17);
    u0_m0_wo0_cma0_l(4) <= RESIZE(u0_m0_wo0_cma0_a0(4),17) + RESIZE(u0_m0_wo0_cma0_b0(4),17);
    u0_m0_wo0_cma0_l(5) <= RESIZE(u0_m0_wo0_cma0_a0(5),17) + RESIZE(u0_m0_wo0_cma0_b0(5),17);
    u0_m0_wo0_cma0_l(6) <= RESIZE(u0_m0_wo0_cma0_a0(6),17) + RESIZE(u0_m0_wo0_cma0_b0(6),17);
    u0_m0_wo0_cma0_l(7) <= RESIZE(u0_m0_wo0_cma0_a0(7),17) + RESIZE(u0_m0_wo0_cma0_b0(7),17);
    u0_m0_wo0_cma0_l(8) <= RESIZE(u0_m0_wo0_cma0_a0(8),17) + RESIZE(u0_m0_wo0_cma0_b0(8),17);
    u0_m0_wo0_cma0_l(9) <= RESIZE(u0_m0_wo0_cma0_a0(9),17) + RESIZE(u0_m0_wo0_cma0_b0(9),17);
    u0_m0_wo0_cma0_l(10) <= RESIZE(u0_m0_wo0_cma0_a0(10),17) + RESIZE(u0_m0_wo0_cma0_b0(10),17);
    u0_m0_wo0_cma0_l(11) <= RESIZE(u0_m0_wo0_cma0_a0(11),17) + RESIZE(u0_m0_wo0_cma0_b0(11),17);
    u0_m0_wo0_cma0_l(12) <= RESIZE(u0_m0_wo0_cma0_a0(12),17) + RESIZE(u0_m0_wo0_cma0_b0(12),17);
    u0_m0_wo0_cma0_l(13) <= RESIZE(u0_m0_wo0_cma0_a0(13),17) + RESIZE(u0_m0_wo0_cma0_b0(13),17);
    u0_m0_wo0_cma0_l(14) <= RESIZE(u0_m0_wo0_cma0_a0(14),17) + RESIZE(u0_m0_wo0_cma0_b0(14),17);
    u0_m0_wo0_cma0_l(15) <= RESIZE(u0_m0_wo0_cma0_a0(15),17) + RESIZE(u0_m0_wo0_cma0_b0(15),17);
    u0_m0_wo0_cma0_l(16) <= RESIZE(u0_m0_wo0_cma0_a0(16),17) + RESIZE(u0_m0_wo0_cma0_b0(16),17);
    u0_m0_wo0_cma0_l(17) <= RESIZE(u0_m0_wo0_cma0_a0(17),17) + RESIZE(u0_m0_wo0_cma0_b0(17),17);
    u0_m0_wo0_cma0_l(18) <= RESIZE(u0_m0_wo0_cma0_a0(18),17) + RESIZE(u0_m0_wo0_cma0_b0(18),17);
    u0_m0_wo0_cma0_l(19) <= RESIZE(u0_m0_wo0_cma0_a0(19),17) + RESIZE(u0_m0_wo0_cma0_b0(19),17);
    u0_m0_wo0_cma0_l(20) <= RESIZE(u0_m0_wo0_cma0_a0(20),17) + RESIZE(u0_m0_wo0_cma0_b0(20),17);
    u0_m0_wo0_cma0_l(21) <= RESIZE(u0_m0_wo0_cma0_a0(21),17) + RESIZE(u0_m0_wo0_cma0_b0(21),17);
    u0_m0_wo0_cma0_l(22) <= RESIZE(u0_m0_wo0_cma0_a0(22),17) + RESIZE(u0_m0_wo0_cma0_b0(22),17);
    u0_m0_wo0_cma0_l(23) <= RESIZE(u0_m0_wo0_cma0_a0(23),17) + RESIZE(u0_m0_wo0_cma0_b0(23),17);
    u0_m0_wo0_cma0_l(24) <= RESIZE(u0_m0_wo0_cma0_a0(24),17) + RESIZE(u0_m0_wo0_cma0_b0(24),17);
    u0_m0_wo0_cma0_l(25) <= RESIZE(u0_m0_wo0_cma0_a0(25),17) + RESIZE(u0_m0_wo0_cma0_b0(25),17);
    u0_m0_wo0_cma0_l(26) <= RESIZE(u0_m0_wo0_cma0_a0(26),17) + RESIZE(u0_m0_wo0_cma0_b0(26),17);
    u0_m0_wo0_cma0_l(27) <= RESIZE(u0_m0_wo0_cma0_a0(27),17) + RESIZE(u0_m0_wo0_cma0_b0(27),17);
    u0_m0_wo0_cma0_l(28) <= RESIZE(u0_m0_wo0_cma0_a0(28),17) + RESIZE(u0_m0_wo0_cma0_b0(28),17);
    u0_m0_wo0_cma0_l(29) <= RESIZE(u0_m0_wo0_cma0_a0(29),17) + RESIZE(u0_m0_wo0_cma0_b0(29),17);
    u0_m0_wo0_cma0_l(30) <= RESIZE(u0_m0_wo0_cma0_a0(30),17) + RESIZE(u0_m0_wo0_cma0_b0(30),17);
    u0_m0_wo0_cma0_l(31) <= RESIZE(u0_m0_wo0_cma0_a0(31),17) + RESIZE(u0_m0_wo0_cma0_b0(31),17);
    -- altera synthesis_off
    u0_m0_wo0_cma0_k0 <= (
        0 => TO_SIGNED(13,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k1 <= (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k2 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k3 <= (
        0 => TO_SIGNED(5,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k4 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k5 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k6 <= (
        0 => TO_SIGNED(-5,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k7 <= (
        0 => TO_SIGNED(-4,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k8 <= (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k9 <= (
        0 => TO_SIGNED(-7,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k10 <= (
        0 => TO_SIGNED(-7,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k11 <= (
        0 => TO_SIGNED(-5,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k12 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k13 <= (
        0 => TO_SIGNED(0,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k14 <= (
        0 => TO_SIGNED(4,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k15 <= (
        0 => TO_SIGNED(8,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k16 <= (
        0 => TO_SIGNED(10,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k17 <= (
        0 => TO_SIGNED(12,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k18 <= (
        0 => TO_SIGNED(13,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k19 <= (
        0 => TO_SIGNED(11,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k20 <= (
        0 => TO_SIGNED(8,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k21 <= (
        0 => TO_SIGNED(3,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k22 <= (
        0 => TO_SIGNED(-2,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k23 <= (
        0 => TO_SIGNED(-8,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k24 <= (
        0 => TO_SIGNED(-13,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k25 <= (
        0 => TO_SIGNED(-18,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k26 <= (
        0 => TO_SIGNED(-20,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k27 <= (
        0 => TO_SIGNED(-20,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k28 <= (
        0 => TO_SIGNED(-16,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k29 <= (
        0 => TO_SIGNED(-11,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k30 <= (
        0 => TO_SIGNED(-3,11),
        others => (others => '0'));
    u0_m0_wo0_cma0_k31 <= (
        0 => TO_SIGNED(5,11),
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
    u0_m0_wo0_cma0_p(0) <= u0_m0_wo0_cma0_l(0) * u0_m0_wo0_cma0_r(0);
    u0_m0_wo0_cma0_p(1) <= u0_m0_wo0_cma0_l(1) * u0_m0_wo0_cma0_r(1);
    u0_m0_wo0_cma0_p(2) <= u0_m0_wo0_cma0_l(2) * u0_m0_wo0_cma0_r(2);
    u0_m0_wo0_cma0_p(3) <= u0_m0_wo0_cma0_l(3) * u0_m0_wo0_cma0_r(3);
    u0_m0_wo0_cma0_p(4) <= u0_m0_wo0_cma0_l(4) * u0_m0_wo0_cma0_r(4);
    u0_m0_wo0_cma0_p(5) <= u0_m0_wo0_cma0_l(5) * u0_m0_wo0_cma0_r(5);
    u0_m0_wo0_cma0_p(6) <= u0_m0_wo0_cma0_l(6) * u0_m0_wo0_cma0_r(6);
    u0_m0_wo0_cma0_p(7) <= u0_m0_wo0_cma0_l(7) * u0_m0_wo0_cma0_r(7);
    u0_m0_wo0_cma0_p(8) <= u0_m0_wo0_cma0_l(8) * u0_m0_wo0_cma0_r(8);
    u0_m0_wo0_cma0_p(9) <= u0_m0_wo0_cma0_l(9) * u0_m0_wo0_cma0_r(9);
    u0_m0_wo0_cma0_p(10) <= u0_m0_wo0_cma0_l(10) * u0_m0_wo0_cma0_r(10);
    u0_m0_wo0_cma0_p(11) <= u0_m0_wo0_cma0_l(11) * u0_m0_wo0_cma0_r(11);
    u0_m0_wo0_cma0_p(12) <= u0_m0_wo0_cma0_l(12) * u0_m0_wo0_cma0_r(12);
    u0_m0_wo0_cma0_p(13) <= u0_m0_wo0_cma0_l(13) * u0_m0_wo0_cma0_r(13);
    u0_m0_wo0_cma0_p(14) <= u0_m0_wo0_cma0_l(14) * u0_m0_wo0_cma0_r(14);
    u0_m0_wo0_cma0_p(15) <= u0_m0_wo0_cma0_l(15) * u0_m0_wo0_cma0_r(15);
    u0_m0_wo0_cma0_p(16) <= u0_m0_wo0_cma0_l(16) * u0_m0_wo0_cma0_r(16);
    u0_m0_wo0_cma0_p(17) <= u0_m0_wo0_cma0_l(17) * u0_m0_wo0_cma0_r(17);
    u0_m0_wo0_cma0_p(18) <= u0_m0_wo0_cma0_l(18) * u0_m0_wo0_cma0_r(18);
    u0_m0_wo0_cma0_p(19) <= u0_m0_wo0_cma0_l(19) * u0_m0_wo0_cma0_r(19);
    u0_m0_wo0_cma0_p(20) <= u0_m0_wo0_cma0_l(20) * u0_m0_wo0_cma0_r(20);
    u0_m0_wo0_cma0_p(21) <= u0_m0_wo0_cma0_l(21) * u0_m0_wo0_cma0_r(21);
    u0_m0_wo0_cma0_p(22) <= u0_m0_wo0_cma0_l(22) * u0_m0_wo0_cma0_r(22);
    u0_m0_wo0_cma0_p(23) <= u0_m0_wo0_cma0_l(23) * u0_m0_wo0_cma0_r(23);
    u0_m0_wo0_cma0_p(24) <= u0_m0_wo0_cma0_l(24) * u0_m0_wo0_cma0_r(24);
    u0_m0_wo0_cma0_p(25) <= u0_m0_wo0_cma0_l(25) * u0_m0_wo0_cma0_r(25);
    u0_m0_wo0_cma0_p(26) <= u0_m0_wo0_cma0_l(26) * u0_m0_wo0_cma0_r(26);
    u0_m0_wo0_cma0_p(27) <= u0_m0_wo0_cma0_l(27) * u0_m0_wo0_cma0_r(27);
    u0_m0_wo0_cma0_p(28) <= u0_m0_wo0_cma0_l(28) * u0_m0_wo0_cma0_r(28);
    u0_m0_wo0_cma0_p(29) <= u0_m0_wo0_cma0_l(29) * u0_m0_wo0_cma0_r(29);
    u0_m0_wo0_cma0_p(30) <= u0_m0_wo0_cma0_l(30) * u0_m0_wo0_cma0_r(30);
    u0_m0_wo0_cma0_p(31) <= u0_m0_wo0_cma0_l(31) * u0_m0_wo0_cma0_r(31);
    u0_m0_wo0_cma0_u(0) <= RESIZE(u0_m0_wo0_cma0_p(0),33);
    u0_m0_wo0_cma0_u(1) <= RESIZE(u0_m0_wo0_cma0_p(1),33);
    u0_m0_wo0_cma0_u(2) <= RESIZE(u0_m0_wo0_cma0_p(2),33);
    u0_m0_wo0_cma0_u(3) <= RESIZE(u0_m0_wo0_cma0_p(3),33);
    u0_m0_wo0_cma0_u(4) <= RESIZE(u0_m0_wo0_cma0_p(4),33);
    u0_m0_wo0_cma0_u(5) <= RESIZE(u0_m0_wo0_cma0_p(5),33);
    u0_m0_wo0_cma0_u(6) <= RESIZE(u0_m0_wo0_cma0_p(6),33);
    u0_m0_wo0_cma0_u(7) <= RESIZE(u0_m0_wo0_cma0_p(7),33);
    u0_m0_wo0_cma0_u(8) <= RESIZE(u0_m0_wo0_cma0_p(8),33);
    u0_m0_wo0_cma0_u(9) <= RESIZE(u0_m0_wo0_cma0_p(9),33);
    u0_m0_wo0_cma0_u(10) <= RESIZE(u0_m0_wo0_cma0_p(10),33);
    u0_m0_wo0_cma0_u(11) <= RESIZE(u0_m0_wo0_cma0_p(11),33);
    u0_m0_wo0_cma0_u(12) <= RESIZE(u0_m0_wo0_cma0_p(12),33);
    u0_m0_wo0_cma0_u(13) <= RESIZE(u0_m0_wo0_cma0_p(13),33);
    u0_m0_wo0_cma0_u(14) <= RESIZE(u0_m0_wo0_cma0_p(14),33);
    u0_m0_wo0_cma0_u(15) <= RESIZE(u0_m0_wo0_cma0_p(15),33);
    u0_m0_wo0_cma0_u(16) <= RESIZE(u0_m0_wo0_cma0_p(16),33);
    u0_m0_wo0_cma0_u(17) <= RESIZE(u0_m0_wo0_cma0_p(17),33);
    u0_m0_wo0_cma0_u(18) <= RESIZE(u0_m0_wo0_cma0_p(18),33);
    u0_m0_wo0_cma0_u(19) <= RESIZE(u0_m0_wo0_cma0_p(19),33);
    u0_m0_wo0_cma0_u(20) <= RESIZE(u0_m0_wo0_cma0_p(20),33);
    u0_m0_wo0_cma0_u(21) <= RESIZE(u0_m0_wo0_cma0_p(21),33);
    u0_m0_wo0_cma0_u(22) <= RESIZE(u0_m0_wo0_cma0_p(22),33);
    u0_m0_wo0_cma0_u(23) <= RESIZE(u0_m0_wo0_cma0_p(23),33);
    u0_m0_wo0_cma0_u(24) <= RESIZE(u0_m0_wo0_cma0_p(24),33);
    u0_m0_wo0_cma0_u(25) <= RESIZE(u0_m0_wo0_cma0_p(25),33);
    u0_m0_wo0_cma0_u(26) <= RESIZE(u0_m0_wo0_cma0_p(26),33);
    u0_m0_wo0_cma0_u(27) <= RESIZE(u0_m0_wo0_cma0_p(27),33);
    u0_m0_wo0_cma0_u(28) <= RESIZE(u0_m0_wo0_cma0_p(28),33);
    u0_m0_wo0_cma0_u(29) <= RESIZE(u0_m0_wo0_cma0_p(29),33);
    u0_m0_wo0_cma0_u(30) <= RESIZE(u0_m0_wo0_cma0_p(30),33);
    u0_m0_wo0_cma0_u(31) <= RESIZE(u0_m0_wo0_cma0_p(31),33);
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
    u0_m0_wo0_cma0_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma0_a0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_b0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_c0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_d <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma0_ena0 = '1') THEN
                u0_m0_wo0_cma0_a0(0) <= u0_m0_wo0_cma0_d(1);
                u0_m0_wo0_cma0_a0(1) <= u0_m0_wo0_cma0_d(2);
                u0_m0_wo0_cma0_a0(2) <= u0_m0_wo0_cma0_d(3);
                u0_m0_wo0_cma0_a0(3) <= u0_m0_wo0_cma0_d(4);
                u0_m0_wo0_cma0_a0(4) <= u0_m0_wo0_cma0_d(5);
                u0_m0_wo0_cma0_a0(5) <= u0_m0_wo0_cma0_d(6);
                u0_m0_wo0_cma0_a0(6) <= u0_m0_wo0_cma0_d(7);
                u0_m0_wo0_cma0_a0(7) <= u0_m0_wo0_cma0_d(8);
                u0_m0_wo0_cma0_a0(8) <= u0_m0_wo0_cma0_d(9);
                u0_m0_wo0_cma0_a0(9) <= u0_m0_wo0_cma0_d(10);
                u0_m0_wo0_cma0_a0(10) <= u0_m0_wo0_cma0_d(11);
                u0_m0_wo0_cma0_a0(11) <= u0_m0_wo0_cma0_d(12);
                u0_m0_wo0_cma0_a0(12) <= u0_m0_wo0_cma0_d(13);
                u0_m0_wo0_cma0_a0(13) <= u0_m0_wo0_cma0_d(14);
                u0_m0_wo0_cma0_a0(14) <= u0_m0_wo0_cma0_d(15);
                u0_m0_wo0_cma0_a0(15) <= u0_m0_wo0_cma0_d(16);
                u0_m0_wo0_cma0_a0(16) <= u0_m0_wo0_cma0_d(17);
                u0_m0_wo0_cma0_a0(17) <= u0_m0_wo0_cma0_d(18);
                u0_m0_wo0_cma0_a0(18) <= u0_m0_wo0_cma0_d(19);
                u0_m0_wo0_cma0_a0(19) <= u0_m0_wo0_cma0_d(20);
                u0_m0_wo0_cma0_a0(20) <= u0_m0_wo0_cma0_d(21);
                u0_m0_wo0_cma0_a0(21) <= u0_m0_wo0_cma0_d(22);
                u0_m0_wo0_cma0_a0(22) <= u0_m0_wo0_cma0_d(23);
                u0_m0_wo0_cma0_a0(23) <= u0_m0_wo0_cma0_d(24);
                u0_m0_wo0_cma0_a0(24) <= u0_m0_wo0_cma0_d(25);
                u0_m0_wo0_cma0_a0(25) <= u0_m0_wo0_cma0_d(26);
                u0_m0_wo0_cma0_a0(26) <= u0_m0_wo0_cma0_d(27);
                u0_m0_wo0_cma0_a0(27) <= u0_m0_wo0_cma0_d(28);
                u0_m0_wo0_cma0_a0(28) <= u0_m0_wo0_cma0_d(29);
                u0_m0_wo0_cma0_a0(29) <= u0_m0_wo0_cma0_d(30);
                u0_m0_wo0_cma0_a0(30) <= u0_m0_wo0_cma0_d(31);
                u0_m0_wo0_cma0_a0(31) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr224_q),16);
                u0_m0_wo0_cma0_b0(0) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(1) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(2) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(3) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(4) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(5) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(6) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(7) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(8) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(9) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(10) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(11) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(12) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(13) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(14) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(15) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(16) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(17) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(18) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(19) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(20) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(21) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(22) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(23) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(24) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(25) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(26) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(27) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(28) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(29) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(30) <= RESIZE(SIGNED(xIn_0),16);
                u0_m0_wo0_cma0_b0(31) <= RESIZE(SIGNED(xIn_0),16);
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
                u0_m0_wo0_cma0_d(0) <= u0_m0_wo0_cma0_a0(0);
                u0_m0_wo0_cma0_d(1) <= u0_m0_wo0_cma0_a0(1);
                u0_m0_wo0_cma0_d(2) <= u0_m0_wo0_cma0_a0(2);
                u0_m0_wo0_cma0_d(3) <= u0_m0_wo0_cma0_a0(3);
                u0_m0_wo0_cma0_d(4) <= u0_m0_wo0_cma0_a0(4);
                u0_m0_wo0_cma0_d(5) <= u0_m0_wo0_cma0_a0(5);
                u0_m0_wo0_cma0_d(6) <= u0_m0_wo0_cma0_a0(6);
                u0_m0_wo0_cma0_d(7) <= u0_m0_wo0_cma0_a0(7);
                u0_m0_wo0_cma0_d(8) <= u0_m0_wo0_cma0_a0(8);
                u0_m0_wo0_cma0_d(9) <= u0_m0_wo0_cma0_a0(9);
                u0_m0_wo0_cma0_d(10) <= u0_m0_wo0_cma0_a0(10);
                u0_m0_wo0_cma0_d(11) <= u0_m0_wo0_cma0_a0(11);
                u0_m0_wo0_cma0_d(12) <= u0_m0_wo0_cma0_a0(12);
                u0_m0_wo0_cma0_d(13) <= u0_m0_wo0_cma0_a0(13);
                u0_m0_wo0_cma0_d(14) <= u0_m0_wo0_cma0_a0(14);
                u0_m0_wo0_cma0_d(15) <= u0_m0_wo0_cma0_a0(15);
                u0_m0_wo0_cma0_d(16) <= u0_m0_wo0_cma0_a0(16);
                u0_m0_wo0_cma0_d(17) <= u0_m0_wo0_cma0_a0(17);
                u0_m0_wo0_cma0_d(18) <= u0_m0_wo0_cma0_a0(18);
                u0_m0_wo0_cma0_d(19) <= u0_m0_wo0_cma0_a0(19);
                u0_m0_wo0_cma0_d(20) <= u0_m0_wo0_cma0_a0(20);
                u0_m0_wo0_cma0_d(21) <= u0_m0_wo0_cma0_a0(21);
                u0_m0_wo0_cma0_d(22) <= u0_m0_wo0_cma0_a0(22);
                u0_m0_wo0_cma0_d(23) <= u0_m0_wo0_cma0_a0(23);
                u0_m0_wo0_cma0_d(24) <= u0_m0_wo0_cma0_a0(24);
                u0_m0_wo0_cma0_d(25) <= u0_m0_wo0_cma0_a0(25);
                u0_m0_wo0_cma0_d(26) <= u0_m0_wo0_cma0_a0(26);
                u0_m0_wo0_cma0_d(27) <= u0_m0_wo0_cma0_a0(27);
                u0_m0_wo0_cma0_d(28) <= u0_m0_wo0_cma0_a0(28);
                u0_m0_wo0_cma0_d(29) <= u0_m0_wo0_cma0_a0(29);
                u0_m0_wo0_cma0_d(30) <= u0_m0_wo0_cma0_a0(30);
                u0_m0_wo0_cma0_d(31) <= u0_m0_wo0_cma0_a0(31);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma0_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma0_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma0_ena1 = '1') THEN
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
    GENERIC MAP ( width => 33, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_cma0_s(0)(32 downto 0)), xout => u0_m0_wo0_cma0_qq, clk => clk, aclr => areset );
    u0_m0_wo0_cma0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_cma0_qq(32 downto 0));

    -- u0_m0_wo0_mtree_add0_0(ADD,539)@12 + 1
    u0_m0_wo0_mtree_add0_0_a <= STD_LOGIC_VECTOR(u0_m0_wo0_cma0_q(30 downto 0));
    u0_m0_wo0_mtree_add0_0_b <= STD_LOGIC_VECTOR(u0_m0_wo0_cma1_q(30 downto 0));
    u0_m0_wo0_mtree_add0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_0_a) + SIGNED(u0_m0_wo0_mtree_add0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_0_q <= u0_m0_wo0_mtree_add0_0_o(30 downto 0);

    -- u0_m0_wo0_mtree_add1_0(ADD,541)@13 + 1
    u0_m0_wo0_mtree_add1_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 31 => u0_m0_wo0_mtree_add0_0_q(30)) & u0_m0_wo0_mtree_add0_0_q));
    u0_m0_wo0_mtree_add1_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 36 => u0_m0_wo0_mtree_add0_1_q(35)) & u0_m0_wo0_mtree_add0_1_q));
    u0_m0_wo0_mtree_add1_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_0_a) + SIGNED(u0_m0_wo0_mtree_add1_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_0_q <= u0_m0_wo0_mtree_add1_0_o(36 downto 0);

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- d_u0_m0_wo0_compute_q_13(DELAY,550)@11 + 2
    d_u0_m0_wo0_compute_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_11_q, xout => d_u0_m0_wo0_compute_q_13_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_oseq_gated_reg(REG,542)@13 + 1
    u0_m0_wo0_oseq_gated_reg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(d_u0_m0_wo0_compute_q_13_q);
        END IF;
    END PROCESS;

    -- out0_m0_wo0_lineup_select_delay_0(DELAY,544)@14
    out0_m0_wo0_lineup_select_delay_0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_reg_q);

    -- out0_m0_wo0_assign_id3(DELAY,546)@14
    out0_m0_wo0_assign_id3_q <= STD_LOGIC_VECTOR(out0_m0_wo0_lineup_select_delay_0_q);

    -- xOut(PORTOUT,547)@14 + 1
    xOut_v <= out0_m0_wo0_assign_id3_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= STD_LOGIC_VECTOR((39 downto 37 => u0_m0_wo0_mtree_add1_0_q(36)) & u0_m0_wo0_mtree_add1_0_q);

END normal;
