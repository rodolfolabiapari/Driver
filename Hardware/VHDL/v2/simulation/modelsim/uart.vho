-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.0 Build 156 04/24/2013 SJ Web Edition"

-- DATE "09/21/2015 23:56:32"

-- 
-- Device: Altera EP2C5T144C8 Package TQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEII;
LIBRARY IEEE;
USE CYCLONEII.CYCLONEII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	uart_top_level IS
    PORT (
	clock : IN std_logic;
	botao1 : IN std_logic;
	botao2 : IN std_logic;
	botao3 : IN std_logic;
	botao4 : IN std_logic;
	ledred : OUT std_logic_vector(7 DOWNTO 0);
	pinIn120 : IN std_logic;
	pinIn121 : IN std_logic;
	pinOut118 : OUT std_logic;
	pinOut119 : OUT std_logic;
	pinSound : OUT std_logic;
	display8seg : OUT std_logic_vector(7 DOWNTO 0);
	display8segSelect : OUT std_logic_vector(7 DOWNTO 0)
	);
END uart_top_level;

-- Design Ports Information
-- ledred[0]	=>  Location: PIN_65,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- ledred[1]	=>  Location: PIN_69,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- ledred[2]	=>  Location: PIN_70,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- ledred[3]	=>  Location: PIN_71,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- ledred[4]	=>  Location: PIN_72,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- ledred[5]	=>  Location: PIN_64,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- ledred[6]	=>  Location: PIN_67,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- ledred[7]	=>  Location: PIN_60,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- pinIn120	=>  Location: PIN_120,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pinOut118	=>  Location: PIN_118,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- pinOut119	=>  Location: PIN_119,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- pinSound	=>  Location: PIN_32,	 I/O Standard: 2.5 V,	 Current Strength: 8mA
-- display8seg[0]	=>  Location: PIN_93,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8seg[1]	=>  Location: PIN_92,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8seg[2]	=>  Location: PIN_87,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8seg[3]	=>  Location: PIN_86,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8seg[4]	=>  Location: PIN_55,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- display8seg[5]	=>  Location: PIN_58,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- display8seg[6]	=>  Location: PIN_79,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8seg[7]	=>  Location: PIN_113,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- display8segSelect[0]	=>  Location: PIN_94,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8segSelect[1]	=>  Location: PIN_96,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8segSelect[2]	=>  Location: PIN_97,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8segSelect[3]	=>  Location: PIN_99,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8segSelect[4]	=>  Location: PIN_100,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8segSelect[5]	=>  Location: PIN_101,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8segSelect[6]	=>  Location: PIN_103,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- display8segSelect[7]	=>  Location: PIN_104,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
-- botao4	=>  Location: PIN_45,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- botao1	=>  Location: PIN_43,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- botao3	=>  Location: PIN_40,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- botao2	=>  Location: PIN_48,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pinIn121	=>  Location: PIN_121,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF uart_top_level IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_botao1 : std_logic;
SIGNAL ww_botao2 : std_logic;
SIGNAL ww_botao3 : std_logic;
SIGNAL ww_botao4 : std_logic;
SIGNAL ww_ledred : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_pinIn120 : std_logic;
SIGNAL ww_pinIn121 : std_logic;
SIGNAL ww_pinOut118 : std_logic;
SIGNAL ww_pinOut119 : std_logic;
SIGNAL ww_pinSound : std_logic;
SIGNAL ww_display8seg : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_display8segSelect : std_logic_vector(7 DOWNTO 0);
SIGNAL \uart1|c1|newClock~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \estado.recebeChave~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \Selector2~0clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clock~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \Selector92~2clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \Selector86~4clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \uart1|comando_recebido~0clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \Selector81~0clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \Add0~9_combout\ : std_logic;
SIGNAL \uart1|c1|count[5]~24_combout\ : std_logic;
SIGNAL \Selector13~1_combout\ : std_logic;
SIGNAL \uart1|c1|newClock~0_combout\ : std_logic;
SIGNAL \Add0~11_combout\ : std_logic;
SIGNAL \Selector101~0_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \Mux0~1_combout\ : std_logic;
SIGNAL \Mux0~2_combout\ : std_logic;
SIGNAL \Mux0~3_combout\ : std_logic;
SIGNAL \Selector20~0_combout\ : std_logic;
SIGNAL \Mux2~0_combout\ : std_logic;
SIGNAL \Mux2~1_combout\ : std_logic;
SIGNAL \Mux2~2_combout\ : std_logic;
SIGNAL \Mux2~3_combout\ : std_logic;
SIGNAL \Selector22~0_combout\ : std_logic;
SIGNAL \uart1|rx1|recebido~0_combout\ : std_logic;
SIGNAL \uart1|rx1|index~3_combout\ : std_logic;
SIGNAL \uart1|rx1|Decoder0~4_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll[3]~5_combout\ : std_logic;
SIGNAL \uart1|rx1|Decoder0~9_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll[8]~10_combout\ : std_logic;
SIGNAL \Selector63~0_combout\ : std_logic;
SIGNAL \Selector4~0_combout\ : std_logic;
SIGNAL \Selector40~0_combout\ : std_logic;
SIGNAL \Selector33~0_combout\ : std_logic;
SIGNAL \Selector37~0_combout\ : std_logic;
SIGNAL \Selector6~0_combout\ : std_logic;
SIGNAL \Selector8~0_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_line~8_combout\ : std_logic;
SIGNAL \botao1~combout\ : std_logic;
SIGNAL \clock~combout\ : std_logic;
SIGNAL \clock~clkctrl_outclk\ : std_logic;
SIGNAL \pinIn121~combout\ : std_logic;
SIGNAL \uart1|rx1|recebido~1_combout\ : std_logic;
SIGNAL \uart1|rx1|recebido~regout\ : std_logic;
SIGNAL \uart1|rx1|Decoder0~0_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll[9]~1_combout\ : std_logic;
SIGNAL \uart1|rx1|process_0~0_combout\ : std_logic;
SIGNAL \uart1|rx1|Add0~0_combout\ : std_logic;
SIGNAL \uart1|rx1|index[3]~4_combout\ : std_logic;
SIGNAL \uart1|rx1|index[3]~9_combout\ : std_logic;
SIGNAL \uart1|rx1|index[2]~6_combout\ : std_logic;
SIGNAL \uart1|rx1|index[2]~7_combout\ : std_logic;
SIGNAL \uart1|rx1|index[2]~8_combout\ : std_logic;
SIGNAL \uart1|rx1|Decoder0~2_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll[0]~0_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll~3_combout\ : std_logic;
SIGNAL \uart1|rx1|index[3]~1_combout\ : std_logic;
SIGNAL \uart1|rx1|index[3]~2_combout\ : std_logic;
SIGNAL \uart1|rx1|index[0]~0_combout\ : std_logic;
SIGNAL \uart1|rx1|index[1]~5_combout\ : std_logic;
SIGNAL \uart1|rx1|rx_flg~0_combout\ : std_logic;
SIGNAL \uart1|rx1|data[0]~0_combout\ : std_logic;
SIGNAL \pinIn121~_wirecell_combout\ : std_logic;
SIGNAL \uart1|rx1|rx_flg~regout\ : std_logic;
SIGNAL \uart1|edge~0_combout\ : std_logic;
SIGNAL \uart1|edge~combout\ : std_logic;
SIGNAL \uart1|comando_recebido~0_combout\ : std_logic;
SIGNAL \uart1|comando_recebido~0clkctrl_outclk\ : std_logic;
SIGNAL \uart1|rx1|Decoder0~1_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll[1]~2_combout\ : std_logic;
SIGNAL \uart1|rx1|data~1_combout\ : std_logic;
SIGNAL \uart1|rx1|data[0]~2_combout\ : std_logic;
SIGNAL \Add0~0_combout\ : std_logic;
SIGNAL \Add0~2_combout\ : std_logic;
SIGNAL \Selector14~0_combout\ : std_logic;
SIGNAL \botao3~combout\ : std_logic;
SIGNAL \botao4~combout\ : std_logic;
SIGNAL \process_0~0_combout\ : std_logic;
SIGNAL \estado.retornaChave~regout\ : std_logic;
SIGNAL \Add0~1\ : std_logic;
SIGNAL \Add0~3_combout\ : std_logic;
SIGNAL \Add0~5_combout\ : std_logic;
SIGNAL \uart1|tx1|index~4_combout\ : std_logic;
SIGNAL \uart1|tx1|index~3_combout\ : std_logic;
SIGNAL \uart1|tx1|index~5_combout\ : std_logic;
SIGNAL \uart1|tx1|index~6_combout\ : std_logic;
SIGNAL \uart1|tx1|Add0~0_combout\ : std_logic;
SIGNAL \uart1|tx1|index~2_combout\ : std_logic;
SIGNAL \uart1|tx1|LessThan0~0_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_flg~0_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_flg~1_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_flg~regout\ : std_logic;
SIGNAL \uart1|tx1|busy~0_combout\ : std_logic;
SIGNAL \uart1|comb~0_combout\ : std_logic;
SIGNAL \sig_comm_enviar~1_combout\ : std_logic;
SIGNAL \sig_comm_enviar~0_combout\ : std_logic;
SIGNAL \sig_comm_enviar~combout\ : std_logic;
SIGNAL \uart1|process_1~1_combout\ : std_logic;
SIGNAL \uart1|tx_start~combout\ : std_logic;
SIGNAL \uart1|tx1|busy~regout\ : std_logic;
SIGNAL \process_1~0_combout\ : std_logic;
SIGNAL \Selector13~0_combout\ : std_logic;
SIGNAL \estado.reset~2_combout\ : std_logic;
SIGNAL \estado.reset~regout\ : std_logic;
SIGNAL \Selector83~0_combout\ : std_logic;
SIGNAL \Selector82~0_combout\ : std_logic;
SIGNAL \Selector86~1_combout\ : std_logic;
SIGNAL \Selector86~2_combout\ : std_logic;
SIGNAL \Selector86~0_combout\ : std_logic;
SIGNAL \Selector99~0_combout\ : std_logic;
SIGNAL \botao2~combout\ : std_logic;
SIGNAL \Selector86~3_combout\ : std_logic;
SIGNAL \Selector86~4_combout\ : std_logic;
SIGNAL \Selector86~4clkctrl_outclk\ : std_logic;
SIGNAL \Add0~4\ : std_logic;
SIGNAL \Add0~7\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~12_combout\ : std_logic;
SIGNAL \Add0~14_combout\ : std_logic;
SIGNAL \process_1~1_combout\ : std_logic;
SIGNAL \Selector13~4_combout\ : std_logic;
SIGNAL \Add0~6_combout\ : std_logic;
SIGNAL \Add0~8_combout\ : std_logic;
SIGNAL \Equal2~0_combout\ : std_logic;
SIGNAL \Selector13~2_combout\ : std_logic;
SIGNAL \Selector13~3_combout\ : std_logic;
SIGNAL \estado.recebeChave~regout\ : std_logic;
SIGNAL \estado.recebeChave~clkctrl_outclk\ : std_logic;
SIGNAL \ledred[0]$latch~combout\ : std_logic;
SIGNAL \uart1|rx1|Decoder0~3_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll[2]~4_combout\ : std_logic;
SIGNAL \uart1|rx1|data~3_combout\ : std_logic;
SIGNAL \ledred[1]$latch~combout\ : std_logic;
SIGNAL \uart1|rx1|data~4_combout\ : std_logic;
SIGNAL \ledred[2]$latch~combout\ : std_logic;
SIGNAL \uart1|rx1|Decoder0~5_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll[4]~6_combout\ : std_logic;
SIGNAL \uart1|rx1|data~5_combout\ : std_logic;
SIGNAL \ledred[3]$latch~combout\ : std_logic;
SIGNAL \uart1|rx1|Decoder0~6_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll[5]~7_combout\ : std_logic;
SIGNAL \uart1|rx1|data~6_combout\ : std_logic;
SIGNAL \ledred[4]$latch~combout\ : std_logic;
SIGNAL \uart1|rx1|Decoder0~7_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll[6]~8_combout\ : std_logic;
SIGNAL \uart1|rx1|data~7_combout\ : std_logic;
SIGNAL \ledred[5]$latch~combout\ : std_logic;
SIGNAL \uart1|rx1|Decoder0~8_combout\ : std_logic;
SIGNAL \uart1|rx1|datafll[7]~9_combout\ : std_logic;
SIGNAL \uart1|rx1|data~8_combout\ : std_logic;
SIGNAL \ledred[6]$latch~combout\ : std_logic;
SIGNAL \uart1|rx1|data~9_combout\ : std_logic;
SIGNAL \ledred[7]$latch~combout\ : std_logic;
SIGNAL \uart1|c1|count[0]~14_combout\ : std_logic;
SIGNAL \uart1|c1|count[6]~26_combout\ : std_logic;
SIGNAL \uart1|c1|LessThan0~0_combout\ : std_logic;
SIGNAL \uart1|c1|count[9]~33\ : std_logic;
SIGNAL \uart1|c1|count[10]~35\ : std_logic;
SIGNAL \uart1|c1|count[11]~36_combout\ : std_logic;
SIGNAL \uart1|c1|count[11]~37\ : std_logic;
SIGNAL \uart1|c1|count[12]~39\ : std_logic;
SIGNAL \uart1|c1|count[13]~40_combout\ : std_logic;
SIGNAL \uart1|c1|count[12]~38_combout\ : std_logic;
SIGNAL \uart1|c1|LessThan0~2_combout\ : std_logic;
SIGNAL \uart1|c1|count[10]~34_combout\ : std_logic;
SIGNAL \uart1|c1|count[8]~30_combout\ : std_logic;
SIGNAL \uart1|c1|LessThan0~1_combout\ : std_logic;
SIGNAL \uart1|c1|LessThan0~3_combout\ : std_logic;
SIGNAL \uart1|c1|count[0]~15\ : std_logic;
SIGNAL \uart1|c1|count[1]~16_combout\ : std_logic;
SIGNAL \uart1|c1|count[1]~17\ : std_logic;
SIGNAL \uart1|c1|count[2]~18_combout\ : std_logic;
SIGNAL \uart1|c1|count[2]~19\ : std_logic;
SIGNAL \uart1|c1|count[3]~21\ : std_logic;
SIGNAL \uart1|c1|count[4]~22_combout\ : std_logic;
SIGNAL \uart1|c1|count[4]~23\ : std_logic;
SIGNAL \uart1|c1|count[5]~25\ : std_logic;
SIGNAL \uart1|c1|count[6]~27\ : std_logic;
SIGNAL \uart1|c1|count[7]~28_combout\ : std_logic;
SIGNAL \uart1|c1|count[7]~29\ : std_logic;
SIGNAL \uart1|c1|count[8]~31\ : std_logic;
SIGNAL \uart1|c1|count[9]~32_combout\ : std_logic;
SIGNAL \uart1|c1|newClock~3_combout\ : std_logic;
SIGNAL \uart1|c1|count[3]~20_combout\ : std_logic;
SIGNAL \uart1|c1|newClock~2_combout\ : std_logic;
SIGNAL \uart1|c1|newClock~1_combout\ : std_logic;
SIGNAL \uart1|c1|newClock~4_combout\ : std_logic;
SIGNAL \uart1|c1|newClock~regout\ : std_logic;
SIGNAL \uart1|c1|newClock~clkctrl_outclk\ : std_logic;
SIGNAL \uart1|process_1~0_combout\ : std_logic;
SIGNAL \Selector81~0_combout\ : std_logic;
SIGNAL \Selector81~0clkctrl_outclk\ : std_logic;
SIGNAL \Selector80~0_combout\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \Selector2~0clkctrl_outclk\ : std_logic;
SIGNAL \Selector62~0_combout\ : std_logic;
SIGNAL \Selector54~0_combout\ : std_logic;
SIGNAL \Selector78~0_combout\ : std_logic;
SIGNAL \Selector74~0_combout\ : std_logic;
SIGNAL \Selector70~0_combout\ : std_logic;
SIGNAL \Mux1~0_combout\ : std_logic;
SIGNAL \Mux1~1_combout\ : std_logic;
SIGNAL \Selector46~0_combout\ : std_logic;
SIGNAL \Selector42~0_combout\ : std_logic;
SIGNAL \Selector38~0_combout\ : std_logic;
SIGNAL \Selector34~0_combout\ : std_logic;
SIGNAL \Selector30~0_combout\ : std_logic;
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \Selector5~0_combout\ : std_logic;
SIGNAL \Mux1~2_combout\ : std_logic;
SIGNAL \Mux1~3_combout\ : std_logic;
SIGNAL \Selector21~0_combout\ : std_logic;
SIGNAL \uart1|tx1|process_0~0_combout\ : std_logic;
SIGNAL \Selector80~1_combout\ : std_logic;
SIGNAL \Selector59~0_combout\ : std_logic;
SIGNAL \Selector55~0_combout\ : std_logic;
SIGNAL \Selector51~0_combout\ : std_logic;
SIGNAL \Selector71~0_combout\ : std_logic;
SIGNAL \Selector67~0_combout\ : std_logic;
SIGNAL \Selector79~0_combout\ : std_logic;
SIGNAL \Selector75~0_combout\ : std_logic;
SIGNAL \Mux4~0_combout\ : std_logic;
SIGNAL \Mux4~1_combout\ : std_logic;
SIGNAL \Selector47~0_combout\ : std_logic;
SIGNAL \Selector43~0_combout\ : std_logic;
SIGNAL \Selector39~0_combout\ : std_logic;
SIGNAL \Selector35~0_combout\ : std_logic;
SIGNAL \Selector31~0_combout\ : std_logic;
SIGNAL \Selector27~0_combout\ : std_logic;
SIGNAL \Mux4~2_combout\ : std_logic;
SIGNAL \Mux4~3_combout\ : std_logic;
SIGNAL \Selector24~0_combout\ : std_logic;
SIGNAL \Selector76~0_combout\ : std_logic;
SIGNAL \Selector72~0_combout\ : std_logic;
SIGNAL \Selector68~0_combout\ : std_logic;
SIGNAL \Selector64~0_combout\ : std_logic;
SIGNAL \Selector60~0_combout\ : std_logic;
SIGNAL \Selector56~0_combout\ : std_logic;
SIGNAL \Selector52~0_combout\ : std_logic;
SIGNAL \Mux3~0_combout\ : std_logic;
SIGNAL \Mux3~1_combout\ : std_logic;
SIGNAL \Selector36~0_combout\ : std_logic;
SIGNAL \Selector32~0_combout\ : std_logic;
SIGNAL \Selector28~0_combout\ : std_logic;
SIGNAL \Selector48~0_combout\ : std_logic;
SIGNAL \Selector44~0_combout\ : std_logic;
SIGNAL \Mux3~2_combout\ : std_logic;
SIGNAL \Mux3~3_combout\ : std_logic;
SIGNAL \Selector23~0_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_line~4_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_line~5_combout\ : std_logic;
SIGNAL \Mux7~0_combout\ : std_logic;
SIGNAL \Mux7~1_combout\ : std_logic;
SIGNAL \Selector7~0_combout\ : std_logic;
SIGNAL \Selector11~0_combout\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \Mux7~2_combout\ : std_logic;
SIGNAL \Mux7~3_combout\ : std_logic;
SIGNAL \Selector80~2_combout\ : std_logic;
SIGNAL \Selector10~0_combout\ : std_logic;
SIGNAL \Selector29~0_combout\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \Selector77~0_combout\ : std_logic;
SIGNAL \Selector73~0_combout\ : std_logic;
SIGNAL \Selector69~0_combout\ : std_logic;
SIGNAL \Selector65~0_combout\ : std_logic;
SIGNAL \Selector61~0_combout\ : std_logic;
SIGNAL \Selector57~0_combout\ : std_logic;
SIGNAL \Selector53~0_combout\ : std_logic;
SIGNAL \Selector49~0_combout\ : std_logic;
SIGNAL \Selector45~0_combout\ : std_logic;
SIGNAL \Selector41~0_combout\ : std_logic;
SIGNAL \Mux6~0_combout\ : std_logic;
SIGNAL \Mux6~1_combout\ : std_logic;
SIGNAL \Mux6~2_combout\ : std_logic;
SIGNAL \Mux6~3_combout\ : std_logic;
SIGNAL \Selector26~0_combout\ : std_logic;
SIGNAL \Selector58~0_combout\ : std_logic;
SIGNAL \Selector66~0_combout\ : std_logic;
SIGNAL \Mux5~0_combout\ : std_logic;
SIGNAL \Selector50~0_combout\ : std_logic;
SIGNAL \Mux5~1_combout\ : std_logic;
SIGNAL \Selector9~0_combout\ : std_logic;
SIGNAL \Mux5~2_combout\ : std_logic;
SIGNAL \Mux5~3_combout\ : std_logic;
SIGNAL \Selector25~0_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_line~2_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_line~3_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_line~6_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_line~7_combout\ : std_logic;
SIGNAL \uart1|tx1|tx_line~regout\ : std_logic;
SIGNAL \estado.recebeTexto~0_combout\ : std_logic;
SIGNAL \estado.recebeTexto~regout\ : std_logic;
SIGNAL \Selector100~0_combout\ : std_logic;
SIGNAL \Selector94~0_combout\ : std_logic;
SIGNAL \Selector92~2_combout\ : std_logic;
SIGNAL \Selector92~2clkctrl_outclk\ : std_logic;
SIGNAL \Selector91~0_combout\ : std_logic;
SIGNAL \Selector95~0_combout\ : std_logic;
SIGNAL \Selector93~0_combout\ : std_logic;
SIGNAL \d1|Mux0~0_combout\ : std_logic;
SIGNAL \d1|Mux1~0_combout\ : std_logic;
SIGNAL \d1|Mux2~0_combout\ : std_logic;
SIGNAL \d1|Mux3~0_combout\ : std_logic;
SIGNAL \d1|Mux4~0_combout\ : std_logic;
SIGNAL \d1|Mux5~0_combout\ : std_logic;
SIGNAL \d1|Mux6~0_combout\ : std_logic;
SIGNAL \Selector97~0_combout\ : std_logic;
SIGNAL \Selector97~1_combout\ : std_logic;
SIGNAL \Selector96~0_combout\ : std_logic;
SIGNAL \Selector96~1_combout\ : std_logic;
SIGNAL \display8seg[7]$latch~combout\ : std_logic;
SIGNAL \display8segSelect[0]$latch~combout\ : std_logic;
SIGNAL countEstado : std_logic_vector(3 DOWNTO 0);
SIGNAL sig_des_key : std_logic_vector(0 TO 63);
SIGNAL \uart1|c1|count\ : std_logic_vector(13 DOWNTO 0);
SIGNAL \uart1|dado_recebido\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \uart1|tx1|datafll\ : std_logic_vector(9 DOWNTO 0);
SIGNAL sig_decod_In : std_logic_vector(3 DOWNTO 0);
SIGNAL \uart1|rx1|index\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \uart1|rx1|data\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \uart1|tx1|index\ : std_logic_vector(3 DOWNTO 0);
SIGNAL sig_dado_enviar : std_logic_vector(7 DOWNTO 0);
SIGNAL \uart1|rx1|datafll\ : std_logic_vector(9 DOWNTO 0);
SIGNAL countBytesLidos : std_logic_vector(4 DOWNTO 0);
SIGNAL completado : std_logic_vector(2 DOWNTO 0);
SIGNAL \uart1|ALT_INV_tx_start~combout\ : std_logic;
SIGNAL \d1|ALT_INV_Mux6~0_combout\ : std_logic;
SIGNAL \uart1|tx1|ALT_INV_tx_line~regout\ : std_logic;
SIGNAL \uart1|rx1|ALT_INV_rx_flg~regout\ : std_logic;

BEGIN

ww_clock <= clock;
ww_botao1 <= botao1;
ww_botao2 <= botao2;
ww_botao3 <= botao3;
ww_botao4 <= botao4;
ledred <= ww_ledred;
ww_pinIn120 <= pinIn120;
ww_pinIn121 <= pinIn121;
pinOut118 <= ww_pinOut118;
pinOut119 <= ww_pinOut119;
pinSound <= ww_pinSound;
display8seg <= ww_display8seg;
display8segSelect <= ww_display8segSelect;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\uart1|c1|newClock~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \uart1|c1|newClock~regout\);

\estado.recebeChave~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \estado.recebeChave~regout\);

\Selector2~0clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \Selector2~0_combout\);

\clock~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \clock~combout\);

\Selector92~2clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \Selector92~2_combout\);

\Selector86~4clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \Selector86~4_combout\);

\uart1|comando_recebido~0clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \uart1|comando_recebido~0_combout\);

\Selector81~0clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \Selector81~0_combout\);
\uart1|ALT_INV_tx_start~combout\ <= NOT \uart1|tx_start~combout\;
\d1|ALT_INV_Mux6~0_combout\ <= NOT \d1|Mux6~0_combout\;
\uart1|tx1|ALT_INV_tx_line~regout\ <= NOT \uart1|tx1|tx_line~regout\;
\uart1|rx1|ALT_INV_rx_flg~regout\ <= NOT \uart1|rx1|rx_flg~regout\;

-- Location: LCFF_X19_Y12_N11
\uart1|c1|count[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[5]~24_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(5));

-- Location: LCCOMB_X18_Y5_N12
\Add0~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \Add0~9_combout\ = (countBytesLidos(3) & (!\Add0~7\)) # (!countBytesLidos(3) & ((\Add0~7\) # (GND)))
-- \Add0~10\ = CARRY((!\Add0~7\) # (!countBytesLidos(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(3),
	datad => VCC,
	cin => \Add0~7\,
	combout => \Add0~9_combout\,
	cout => \Add0~10\);

-- Location: LCCOMB_X19_Y12_N10
\uart1|c1|count[5]~24\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[5]~24_combout\ = (\uart1|c1|count\(5) & (!\uart1|c1|count[4]~23\)) # (!\uart1|c1|count\(5) & ((\uart1|c1|count[4]~23\) # (GND)))
-- \uart1|c1|count[5]~25\ = CARRY((!\uart1|c1|count[4]~23\) # (!\uart1|c1|count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(5),
	datad => VCC,
	cin => \uart1|c1|count[4]~23\,
	combout => \uart1|c1|count[5]~24_combout\,
	cout => \uart1|c1|count[5]~25\);

-- Location: LCFF_X18_Y4_N13
\uart1|tx1|datafll[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => sig_dado_enviar(7),
	ena => \uart1|tx1|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|datafll\(8));

-- Location: LCFF_X18_Y4_N23
\uart1|tx1|datafll[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => sig_dado_enviar(5),
	ena => \uart1|tx1|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|datafll\(6));

-- Location: LCCOMB_X19_Y5_N16
\Selector13~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector13~1_combout\ = (!\botao1~combout\ & !\estado.reset~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \botao1~combout\,
	datad => \estado.reset~regout\,
	combout => \Selector13~1_combout\);

-- Location: LCCOMB_X20_Y12_N16
\uart1|c1|newClock~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|newClock~0_combout\ = (!\uart1|c1|count\(13) & (((!\uart1|c1|count\(10) & !\uart1|c1|count\(11))) # (!\uart1|c1|count\(12))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(10),
	datab => \uart1|c1|count\(12),
	datac => \uart1|c1|count\(13),
	datad => \uart1|c1|count\(11),
	combout => \uart1|c1|newClock~0_combout\);

-- Location: LCCOMB_X18_Y5_N20
\Add0~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \Add0~11_combout\ = (\estado.reset~regout\ & (!\Selector13~4_combout\ & \Add0~9_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \estado.reset~regout\,
	datac => \Selector13~4_combout\,
	datad => \Add0~9_combout\,
	combout => \Add0~11_combout\);

-- Location: LCCOMB_X20_Y8_N26
\Selector101~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector101~0_combout\ = (!\estado.recebeChave~regout\ & ((\uart1|process_1~0_combout\) # ((\sig_comm_enviar~combout\) # (!\estado.retornaChave~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|process_1~0_combout\,
	datab => \sig_comm_enviar~combout\,
	datac => \estado.recebeChave~regout\,
	datad => \estado.retornaChave~regout\,
	combout => \Selector101~0_combout\);

-- Location: LCFF_X22_Y4_N17
\uart1|rx1|datafll[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|datafll[3]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|datafll\(3));

-- Location: LCFF_X21_Y6_N25
\uart1|rx1|datafll[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|datafll[8]~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|datafll\(8));

-- Location: LCCOMB_X18_Y4_N26
\Mux0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = (countBytesLidos(1) & (((countBytesLidos(0))))) # (!countBytesLidos(1) & ((countBytesLidos(0) & ((sig_des_key(8)))) # (!countBytesLidos(0) & (sig_des_key(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(1),
	datab => sig_des_key(0),
	datac => sig_des_key(8),
	datad => countBytesLidos(0),
	combout => \Mux0~0_combout\);

-- Location: LCCOMB_X18_Y4_N20
\Mux0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux0~1_combout\ = (countBytesLidos(1) & ((\Mux0~0_combout\ & (sig_des_key(24))) # (!\Mux0~0_combout\ & ((sig_des_key(16)))))) # (!countBytesLidos(1) & (((\Mux0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(1),
	datab => sig_des_key(24),
	datac => sig_des_key(16),
	datad => \Mux0~0_combout\,
	combout => \Mux0~1_combout\);

-- Location: LCCOMB_X19_Y4_N16
\Mux0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux0~2_combout\ = (countBytesLidos(0) & (((countBytesLidos(1))))) # (!countBytesLidos(0) & ((countBytesLidos(1) & (sig_des_key(48))) # (!countBytesLidos(1) & ((sig_des_key(32))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => sig_des_key(48),
	datac => countBytesLidos(1),
	datad => sig_des_key(32),
	combout => \Mux0~2_combout\);

-- Location: LCCOMB_X19_Y4_N18
\Mux0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux0~3_combout\ = (\Mux0~2_combout\ & (((sig_des_key(56)) # (!countBytesLidos(0))))) # (!\Mux0~2_combout\ & (sig_des_key(40) & ((countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(40),
	datab => sig_des_key(56),
	datac => \Mux0~2_combout\,
	datad => countBytesLidos(0),
	combout => \Mux0~3_combout\);

-- Location: LCCOMB_X18_Y4_N18
\Selector20~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector20~0_combout\ = (\Selector80~0_combout\ & ((\Mux0~3_combout\) # ((\Selector80~1_combout\ & \Mux0~1_combout\)))) # (!\Selector80~0_combout\ & (\Selector80~1_combout\ & (\Mux0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector80~0_combout\,
	datab => \Selector80~1_combout\,
	datac => \Mux0~1_combout\,
	datad => \Mux0~3_combout\,
	combout => \Selector20~0_combout\);

-- Location: LCCOMB_X19_Y7_N8
\Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux2~0_combout\ = (countBytesLidos(0) & ((sig_des_key(10)) # ((countBytesLidos(1))))) # (!countBytesLidos(0) & (((!countBytesLidos(1) & sig_des_key(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(10),
	datab => countBytesLidos(0),
	datac => countBytesLidos(1),
	datad => sig_des_key(2),
	combout => \Mux2~0_combout\);

-- Location: LCCOMB_X19_Y7_N6
\Mux2~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux2~1_combout\ = (\Mux2~0_combout\ & (((sig_des_key(26)) # (!countBytesLidos(1))))) # (!\Mux2~0_combout\ & (sig_des_key(18) & ((countBytesLidos(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(18),
	datab => sig_des_key(26),
	datac => \Mux2~0_combout\,
	datad => countBytesLidos(1),
	combout => \Mux2~1_combout\);

-- Location: LCCOMB_X18_Y7_N16
\Mux2~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux2~2_combout\ = (countBytesLidos(0) & (countBytesLidos(1))) # (!countBytesLidos(0) & ((countBytesLidos(1) & (sig_des_key(50))) # (!countBytesLidos(1) & ((sig_des_key(34))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => countBytesLidos(1),
	datac => sig_des_key(50),
	datad => sig_des_key(34),
	combout => \Mux2~2_combout\);

-- Location: LCCOMB_X18_Y7_N2
\Mux2~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux2~3_combout\ = (countBytesLidos(0) & ((\Mux2~2_combout\ & ((sig_des_key(58)))) # (!\Mux2~2_combout\ & (sig_des_key(42))))) # (!countBytesLidos(0) & (((\Mux2~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(42),
	datab => countBytesLidos(0),
	datac => \Mux2~2_combout\,
	datad => sig_des_key(58),
	combout => \Mux2~3_combout\);

-- Location: LCCOMB_X18_Y4_N0
\Selector22~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector22~0_combout\ = (\Selector80~0_combout\ & ((\Mux2~3_combout\) # ((\Selector80~1_combout\ & \Mux2~1_combout\)))) # (!\Selector80~0_combout\ & (\Selector80~1_combout\ & ((\Mux2~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector80~0_combout\,
	datab => \Selector80~1_combout\,
	datac => \Mux2~3_combout\,
	datad => \Mux2~1_combout\,
	combout => \Selector22~0_combout\);

-- Location: LCCOMB_X22_Y4_N24
\uart1|rx1|recebido~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|recebido~0_combout\ = (\uart1|rx1|index\(3) & (\uart1|rx1|index\(0) & (!\uart1|rx1|index\(2) & !\uart1|rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(3),
	datab => \uart1|rx1|index\(0),
	datac => \uart1|rx1|index\(2),
	datad => \uart1|rx1|index\(1),
	combout => \uart1|rx1|recebido~0_combout\);

-- Location: LCCOMB_X22_Y5_N24
\uart1|rx1|index~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|index~3_combout\ = (\uart1|rx1|rx_flg~regout\ & \uart1|rx1|rx_flg~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|rx_flg~regout\,
	datac => \uart1|rx1|rx_flg~0_combout\,
	combout => \uart1|rx1|index~3_combout\);

-- Location: LCCOMB_X22_Y4_N12
\uart1|rx1|Decoder0~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Decoder0~4_combout\ = (!\uart1|rx1|index\(3) & (\uart1|rx1|index\(0) & (!\uart1|rx1|index\(2) & \uart1|rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(3),
	datab => \uart1|rx1|index\(0),
	datac => \uart1|rx1|index\(2),
	datad => \uart1|rx1|index\(1),
	combout => \uart1|rx1|Decoder0~4_combout\);

-- Location: LCCOMB_X22_Y4_N16
\uart1|rx1|datafll[3]~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll[3]~5_combout\ = (\uart1|rx1|rx_flg~regout\ & ((\uart1|rx1|Decoder0~4_combout\ & (\pinIn121~combout\)) # (!\uart1|rx1|Decoder0~4_combout\ & ((\uart1|rx1|datafll\(3)))))) # (!\uart1|rx1|rx_flg~regout\ & (((\uart1|rx1|datafll\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|rx_flg~regout\,
	datab => \pinIn121~combout\,
	datac => \uart1|rx1|datafll\(3),
	datad => \uart1|rx1|Decoder0~4_combout\,
	combout => \uart1|rx1|datafll[3]~5_combout\);

-- Location: LCCOMB_X21_Y6_N12
\uart1|rx1|Decoder0~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Decoder0~9_combout\ = (\uart1|rx1|index\(3) & (!\uart1|rx1|index\(0) & (!\uart1|rx1|index\(1) & !\uart1|rx1|index\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(3),
	datab => \uart1|rx1|index\(0),
	datac => \uart1|rx1|index\(1),
	datad => \uart1|rx1|index\(2),
	combout => \uart1|rx1|Decoder0~9_combout\);

-- Location: LCCOMB_X21_Y6_N24
\uart1|rx1|datafll[8]~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll[8]~10_combout\ = (\uart1|rx1|rx_flg~regout\ & ((\uart1|rx1|Decoder0~9_combout\ & (\pinIn121~combout\)) # (!\uart1|rx1|Decoder0~9_combout\ & ((\uart1|rx1|datafll\(8)))))) # (!\uart1|rx1|rx_flg~regout\ & (((\uart1|rx1|datafll\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pinIn121~combout\,
	datab => \uart1|rx1|rx_flg~regout\,
	datac => \uart1|rx1|datafll\(8),
	datad => \uart1|rx1|Decoder0~9_combout\,
	combout => \uart1|rx1|datafll[8]~10_combout\);

-- Location: LCCOMB_X18_Y8_N30
\Selector63~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector63~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(12) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => \Equal2~0_combout\,
	datad => sig_des_key(12),
	combout => \Selector63~0_combout\);

-- Location: LCCOMB_X19_Y4_N12
\Selector4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector4~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(52) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => sig_des_key(52),
	datad => \Equal2~0_combout\,
	combout => \Selector4~0_combout\);

-- Location: LCCOMB_X18_Y6_N4
\Selector40~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector40~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(35) & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => \Equal2~0_combout\,
	datac => countBytesLidos(0),
	datad => sig_des_key(35),
	combout => \Selector40~0_combout\);

-- Location: LCCOMB_X18_Y7_N28
\Selector33~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector33~0_combout\ = (sig_des_key(42) & (\estado.recebeChave~regout\ & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(42),
	datab => \estado.recebeChave~regout\,
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector33~0_combout\);

-- Location: LCCOMB_X18_Y7_N30
\Selector37~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector37~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(38) & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(38),
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector37~0_combout\);

-- Location: LCCOMB_X17_Y5_N28
\Selector6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector6~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(54) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => \Equal2~0_combout\,
	datad => sig_des_key(54),
	combout => \Selector6~0_combout\);

-- Location: LCCOMB_X19_Y4_N6
\Selector8~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector8~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(56) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(56),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector8~0_combout\);

-- Location: LCCOMB_X18_Y8_N20
\uart1|tx1|tx_line~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|tx_line~8_combout\ = (\uart1|tx1|index\(3) & ((\uart1|tx1|index\(1)) # ((\uart1|tx1|index\(0)) # (\uart1|tx1|datafll\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx1|index\(1),
	datab => \uart1|tx1|index\(0),
	datac => \uart1|tx1|index\(3),
	datad => \uart1|tx1|datafll\(8),
	combout => \uart1|tx1|tx_line~8_combout\);

-- Location: LCCOMB_X20_Y5_N4
\countEstado[0]\ : cycloneii_lcell_comb
-- Equation(s):
-- countEstado(0) = (\Selector100~0_combout\ & ((\Selector99~0_combout\))) # (!\Selector100~0_combout\ & (countEstado(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector100~0_combout\,
	datac => countEstado(0),
	datad => \Selector99~0_combout\,
	combout => countEstado(0));

-- Location: LCCOMB_X18_Y4_N12
\sig_dado_enviar[7]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_dado_enviar(7) = (GLOBAL(\Selector81~0clkctrl_outclk\) & ((\Selector20~0_combout\))) # (!GLOBAL(\Selector81~0clkctrl_outclk\) & (sig_dado_enviar(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_dado_enviar(7),
	datac => \Selector81~0clkctrl_outclk\,
	datad => \Selector20~0_combout\,
	combout => sig_dado_enviar(7));

-- Location: LCCOMB_X18_Y4_N22
\sig_dado_enviar[5]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_dado_enviar(5) = (GLOBAL(\Selector81~0clkctrl_outclk\) & ((\Selector22~0_combout\))) # (!GLOBAL(\Selector81~0clkctrl_outclk\) & (sig_dado_enviar(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_dado_enviar(5),
	datac => \Selector81~0clkctrl_outclk\,
	datad => \Selector22~0_combout\,
	combout => sig_dado_enviar(5));

-- Location: LCCOMB_X18_Y8_N10
\sig_des_key[16]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(16) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector63~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(16),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector63~0_combout\,
	combout => sig_des_key(16));

-- Location: LCCOMB_X19_Y4_N4
\sig_des_key[56]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(56) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector4~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(56)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(56),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector4~0_combout\,
	combout => sig_des_key(56));

-- Location: LCCOMB_X18_Y6_N12
\sig_des_key[39]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(39) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector40~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(39)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(39),
	datac => \Selector40~0_combout\,
	datad => \Selector2~0clkctrl_outclk\,
	combout => sig_des_key(39));

-- Location: LCCOMB_X18_Y7_N6
\sig_des_key[46]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(46) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector33~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(46)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(46),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector33~0_combout\,
	combout => sig_des_key(46));

-- Location: LCCOMB_X18_Y7_N20
\sig_des_key[42]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(42) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector37~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(42)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(42),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector37~0_combout\,
	combout => sig_des_key(42));

-- Location: LCCOMB_X17_Y5_N10
\sig_des_key[58]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(58) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector6~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(58)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(58),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector6~0_combout\,
	combout => sig_des_key(58));

-- Location: LCCOMB_X19_Y4_N10
\sig_des_key[60]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(60) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector8~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(60)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(60),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector8~0_combout\,
	combout => sig_des_key(60));

-- Location: PIN_43,	 I/O Standard: 2.5 V,	 Current Strength: Default
\botao1~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_botao1,
	combout => \botao1~combout\);

-- Location: PIN_17,	 I/O Standard: 2.5 V,	 Current Strength: Default
\clock~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_clock,
	combout => \clock~combout\);

-- Location: CLKCTRL_G2
\clock~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clock~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clock~clkctrl_outclk\);

-- Location: PIN_121,	 I/O Standard: 2.5 V,	 Current Strength: Default
\pinIn121~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_pinIn121,
	combout => \pinIn121~combout\);

-- Location: LCCOMB_X22_Y4_N28
\uart1|rx1|recebido~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|recebido~1_combout\ = (\uart1|rx1|recebido~regout\ & (((\pinIn121~combout\) # (\uart1|rx1|rx_flg~regout\)))) # (!\uart1|rx1|recebido~regout\ & (\uart1|rx1|recebido~0_combout\ & ((\uart1|rx1|rx_flg~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|recebido~0_combout\,
	datab => \pinIn121~combout\,
	datac => \uart1|rx1|recebido~regout\,
	datad => \uart1|rx1|rx_flg~regout\,
	combout => \uart1|rx1|recebido~1_combout\);

-- Location: LCFF_X22_Y4_N29
\uart1|rx1|recebido\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|recebido~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|recebido~regout\);

-- Location: LCCOMB_X22_Y4_N6
\uart1|rx1|Decoder0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Decoder0~0_combout\ = (\uart1|rx1|index\(3) & (\uart1|rx1|index\(0) & (!\uart1|rx1|index\(2) & !\uart1|rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(3),
	datab => \uart1|rx1|index\(0),
	datac => \uart1|rx1|index\(2),
	datad => \uart1|rx1|index\(1),
	combout => \uart1|rx1|Decoder0~0_combout\);

-- Location: LCCOMB_X22_Y4_N18
\uart1|rx1|datafll[9]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll[9]~1_combout\ = (\uart1|rx1|rx_flg~regout\ & ((\uart1|rx1|Decoder0~0_combout\ & (\pinIn121~combout\)) # (!\uart1|rx1|Decoder0~0_combout\ & ((\uart1|rx1|datafll\(9)))))) # (!\uart1|rx1|rx_flg~regout\ & (((\uart1|rx1|datafll\(9)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|rx_flg~regout\,
	datab => \pinIn121~combout\,
	datac => \uart1|rx1|datafll\(9),
	datad => \uart1|rx1|Decoder0~0_combout\,
	combout => \uart1|rx1|datafll[9]~1_combout\);

-- Location: LCFF_X22_Y4_N19
\uart1|rx1|datafll[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|datafll[9]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|datafll\(9));

-- Location: LCCOMB_X22_Y4_N0
\uart1|rx1|process_0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|process_0~0_combout\ = (\uart1|rx1|datafll\(0)) # (!\uart1|rx1|datafll\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \uart1|rx1|datafll\(0),
	datad => \uart1|rx1|datafll\(9),
	combout => \uart1|rx1|process_0~0_combout\);

-- Location: LCCOMB_X22_Y5_N4
\uart1|rx1|Add0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Add0~0_combout\ = \uart1|rx1|index\(3) $ (((\uart1|rx1|index\(1) & (\uart1|rx1|index\(0) & \uart1|rx1|index\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(1),
	datab => \uart1|rx1|index\(3),
	datac => \uart1|rx1|index\(0),
	datad => \uart1|rx1|index\(2),
	combout => \uart1|rx1|Add0~0_combout\);

-- Location: LCCOMB_X22_Y5_N30
\uart1|rx1|index[3]~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|index[3]~4_combout\ = (\uart1|rx1|rx_flg~regout\ & (((!\uart1|rx1|rx_flg~0_combout\ & \uart1|rx1|index[3]~1_combout\)))) # (!\uart1|rx1|rx_flg~regout\ & (\pinIn121~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pinIn121~combout\,
	datab => \uart1|rx1|rx_flg~0_combout\,
	datac => \uart1|rx1|rx_flg~regout\,
	datad => \uart1|rx1|index[3]~1_combout\,
	combout => \uart1|rx1|index[3]~4_combout\);

-- Location: LCCOMB_X22_Y5_N6
\uart1|rx1|index[3]~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|index[3]~9_combout\ = (\uart1|rx1|index[3]~4_combout\ & (((\uart1|rx1|index\(3))))) # (!\uart1|rx1|index[3]~4_combout\ & (\uart1|rx1|index~3_combout\ & (\uart1|rx1|Add0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index~3_combout\,
	datab => \uart1|rx1|Add0~0_combout\,
	datac => \uart1|rx1|index\(3),
	datad => \uart1|rx1|index[3]~4_combout\,
	combout => \uart1|rx1|index[3]~9_combout\);

-- Location: LCFF_X22_Y5_N7
\uart1|rx1|index[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|index[3]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|index\(3));

-- Location: LCCOMB_X22_Y5_N28
\uart1|rx1|index[2]~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|index[2]~6_combout\ = (!\uart1|rx1|index\(3) & (\uart1|rx1|index\(2) $ (((\uart1|rx1|index\(1) & \uart1|rx1|index\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(1),
	datab => \uart1|rx1|index\(3),
	datac => \uart1|rx1|index\(0),
	datad => \uart1|rx1|index\(2),
	combout => \uart1|rx1|index[2]~6_combout\);

-- Location: LCCOMB_X22_Y5_N26
\uart1|rx1|index[2]~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|index[2]~7_combout\ = (\uart1|rx1|index[2]~6_combout\) # ((\uart1|rx1|recebido~regout\ & (!\uart1|rx1|process_0~0_combout\ & !\uart1|rx1|rx_flg~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|recebido~regout\,
	datab => \uart1|rx1|process_0~0_combout\,
	datac => \uart1|rx1|rx_flg~0_combout\,
	datad => \uart1|rx1|index[2]~6_combout\,
	combout => \uart1|rx1|index[2]~7_combout\);

-- Location: LCCOMB_X22_Y5_N0
\uart1|rx1|index[2]~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|index[2]~8_combout\ = (\uart1|rx1|index[3]~4_combout\ & (((\uart1|rx1|index\(2))))) # (!\uart1|rx1|index[3]~4_combout\ & (\uart1|rx1|rx_flg~regout\ & (\uart1|rx1|index[2]~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|rx_flg~regout\,
	datab => \uart1|rx1|index[2]~7_combout\,
	datac => \uart1|rx1|index\(2),
	datad => \uart1|rx1|index[3]~4_combout\,
	combout => \uart1|rx1|index[2]~8_combout\);

-- Location: LCFF_X22_Y5_N1
\uart1|rx1|index[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|index[2]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|index\(2));

-- Location: LCCOMB_X22_Y4_N4
\uart1|rx1|Decoder0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Decoder0~2_combout\ = (!\uart1|rx1|index\(3) & (!\uart1|rx1|index\(0) & (!\uart1|rx1|index\(2) & !\uart1|rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(3),
	datab => \uart1|rx1|index\(0),
	datac => \uart1|rx1|index\(2),
	datad => \uart1|rx1|index\(1),
	combout => \uart1|rx1|Decoder0~2_combout\);

-- Location: LCCOMB_X22_Y4_N8
\uart1|rx1|datafll[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll[0]~0_combout\ = (\uart1|rx1|Decoder0~2_combout\ & (\pinIn121~combout\)) # (!\uart1|rx1|Decoder0~2_combout\ & ((\uart1|rx1|datafll\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \pinIn121~combout\,
	datac => \uart1|rx1|datafll\(0),
	datad => \uart1|rx1|Decoder0~2_combout\,
	combout => \uart1|rx1|datafll[0]~0_combout\);

-- Location: LCCOMB_X22_Y4_N14
\uart1|rx1|datafll~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll~3_combout\ = (\pinIn121~combout\ & \uart1|rx1|datafll\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \pinIn121~combout\,
	datac => \uart1|rx1|datafll\(0),
	combout => \uart1|rx1|datafll~3_combout\);

-- Location: LCFF_X22_Y4_N9
\uart1|rx1|datafll[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|datafll[0]~0_combout\,
	sdata => \uart1|rx1|datafll~3_combout\,
	sload => \uart1|rx1|ALT_INV_rx_flg~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|datafll\(0));

-- Location: LCCOMB_X22_Y4_N2
\uart1|rx1|index[3]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|index[3]~1_combout\ = ((\uart1|rx1|datafll\(0)) # (!\uart1|rx1|datafll\(9))) # (!\uart1|rx1|recebido~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|rx1|recebido~regout\,
	datac => \uart1|rx1|datafll\(0),
	datad => \uart1|rx1|datafll\(9),
	combout => \uart1|rx1|index[3]~1_combout\);

-- Location: LCCOMB_X22_Y5_N10
\uart1|rx1|index[3]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|index[3]~2_combout\ = ((!\uart1|rx1|rx_flg~0_combout\ & \uart1|rx1|index[3]~1_combout\)) # (!\uart1|rx1|rx_flg~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|rx_flg~regout\,
	datac => \uart1|rx1|rx_flg~0_combout\,
	datad => \uart1|rx1|index[3]~1_combout\,
	combout => \uart1|rx1|index[3]~2_combout\);

-- Location: LCCOMB_X22_Y5_N16
\uart1|rx1|index[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|index[0]~0_combout\ = (\uart1|rx1|index~3_combout\ & (!\uart1|rx1|index\(0))) # (!\uart1|rx1|index~3_combout\ & ((\uart1|rx1|index[3]~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index~3_combout\,
	datac => \uart1|rx1|index\(0),
	datad => \uart1|rx1|index[3]~2_combout\,
	combout => \uart1|rx1|index[0]~0_combout\);

-- Location: LCFF_X22_Y5_N17
\uart1|rx1|index[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|index[0]~0_combout\,
	sdata => \uart1|rx1|index\(0),
	sload => \uart1|rx1|index[3]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|index\(0));

-- Location: LCCOMB_X22_Y5_N14
\uart1|rx1|index[1]~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|index[1]~5_combout\ = (\uart1|rx1|index[3]~4_combout\ & (((\uart1|rx1|index\(1))))) # (!\uart1|rx1|index[3]~4_combout\ & (\uart1|rx1|index~3_combout\ & (\uart1|rx1|index\(0) $ (\uart1|rx1|index\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index~3_combout\,
	datab => \uart1|rx1|index\(0),
	datac => \uart1|rx1|index\(1),
	datad => \uart1|rx1|index[3]~4_combout\,
	combout => \uart1|rx1|index[1]~5_combout\);

-- Location: LCFF_X22_Y5_N15
\uart1|rx1|index[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|index[1]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|index\(1));

-- Location: LCCOMB_X22_Y5_N12
\uart1|rx1|rx_flg~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|rx_flg~0_combout\ = ((!\uart1|rx1|index\(1) & (!\uart1|rx1|index\(0) & !\uart1|rx1|index\(2)))) # (!\uart1|rx1|index\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(3),
	datab => \uart1|rx1|index\(1),
	datac => \uart1|rx1|index\(0),
	datad => \uart1|rx1|index\(2),
	combout => \uart1|rx1|rx_flg~0_combout\);

-- Location: LCCOMB_X21_Y5_N30
\uart1|rx1|data[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|data[0]~0_combout\ = (\uart1|rx1|rx_flg~0_combout\) # (!\uart1|rx1|recebido~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|rx1|recebido~regout\,
	datad => \uart1|rx1|rx_flg~0_combout\,
	combout => \uart1|rx1|data[0]~0_combout\);

-- Location: LCCOMB_X21_Y5_N20
\pinIn121~_wirecell\ : cycloneii_lcell_comb
-- Equation(s):
-- \pinIn121~_wirecell_combout\ = !\pinIn121~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \pinIn121~combout\,
	combout => \pinIn121~_wirecell_combout\);

-- Location: LCFF_X21_Y5_N31
\uart1|rx1|rx_flg\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~regout\,
	datain => \uart1|rx1|data[0]~0_combout\,
	sdata => \pinIn121~_wirecell_combout\,
	sload => \uart1|rx1|ALT_INV_rx_flg~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|rx_flg~regout\);

-- Location: LCCOMB_X21_Y5_N6
\uart1|edge~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|edge~0_combout\ = (\uart1|edge~combout\) # (\uart1|rx1|rx_flg~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \uart1|edge~combout\,
	datad => \uart1|rx1|rx_flg~regout\,
	combout => \uart1|edge~0_combout\);

-- Location: LCCOMB_X21_Y5_N24
\uart1|edge\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|edge~combout\ = (\uart1|edge~0_combout\ & (\uart1|rx1|rx_flg~regout\)) # (!\uart1|edge~0_combout\ & ((\uart1|edge~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|rx1|rx_flg~regout\,
	datac => \uart1|edge~combout\,
	datad => \uart1|edge~0_combout\,
	combout => \uart1|edge~combout\);

-- Location: LCCOMB_X21_Y5_N26
\uart1|comando_recebido~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|comando_recebido~0_combout\ = (\uart1|edge~combout\ & !\uart1|rx1|rx_flg~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \uart1|edge~combout\,
	datad => \uart1|rx1|rx_flg~regout\,
	combout => \uart1|comando_recebido~0_combout\);

-- Location: CLKCTRL_G7
\uart1|comando_recebido~0clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \uart1|comando_recebido~0clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \uart1|comando_recebido~0clkctrl_outclk\);

-- Location: LCCOMB_X21_Y6_N26
\uart1|rx1|Decoder0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Decoder0~1_combout\ = (!\uart1|rx1|index\(3) & (\uart1|rx1|index\(0) & (!\uart1|rx1|index\(1) & !\uart1|rx1|index\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(3),
	datab => \uart1|rx1|index\(0),
	datac => \uart1|rx1|index\(1),
	datad => \uart1|rx1|index\(2),
	combout => \uart1|rx1|Decoder0~1_combout\);

-- Location: LCCOMB_X21_Y6_N20
\uart1|rx1|datafll[1]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll[1]~2_combout\ = (\uart1|rx1|rx_flg~regout\ & ((\uart1|rx1|Decoder0~1_combout\ & (\pinIn121~combout\)) # (!\uart1|rx1|Decoder0~1_combout\ & ((\uart1|rx1|datafll\(1)))))) # (!\uart1|rx1|rx_flg~regout\ & (((\uart1|rx1|datafll\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pinIn121~combout\,
	datab => \uart1|rx1|rx_flg~regout\,
	datac => \uart1|rx1|datafll\(1),
	datad => \uart1|rx1|Decoder0~1_combout\,
	combout => \uart1|rx1|datafll[1]~2_combout\);

-- Location: LCFF_X21_Y6_N21
\uart1|rx1|datafll[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|datafll[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|datafll\(1));

-- Location: LCCOMB_X21_Y4_N12
\uart1|rx1|data~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|data~1_combout\ = (\uart1|rx1|datafll\(9) & (!\uart1|rx1|datafll\(0) & \uart1|rx1|datafll\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|rx1|datafll\(9),
	datac => \uart1|rx1|datafll\(0),
	datad => \uart1|rx1|datafll\(1),
	combout => \uart1|rx1|data~1_combout\);

-- Location: LCCOMB_X21_Y4_N10
\uart1|rx1|data[0]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|data[0]~2_combout\ = (\uart1|rx1|recebido~regout\ & (\uart1|rx1|rx_flg~regout\ & !\uart1|rx1|rx_flg~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|rx1|recebido~regout\,
	datac => \uart1|rx1|rx_flg~regout\,
	datad => \uart1|rx1|rx_flg~0_combout\,
	combout => \uart1|rx1|data[0]~2_combout\);

-- Location: LCFF_X21_Y4_N13
\uart1|rx1|data[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|data~1_combout\,
	ena => \uart1|rx1|data[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|data\(0));

-- Location: LCCOMB_X21_Y4_N24
\uart1|dado_recebido[0]\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|dado_recebido\(0) = (GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & ((\uart1|rx1|data\(0)))) # (!GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & (\uart1|dado_recebido\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|dado_recebido\(0),
	datac => \uart1|comando_recebido~0clkctrl_outclk\,
	datad => \uart1|rx1|data\(0),
	combout => \uart1|dado_recebido\(0));

-- Location: LCCOMB_X18_Y5_N6
\Add0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Add0~0_combout\ = countBytesLidos(0) $ (VCC)
-- \Add0~1\ = CARRY(countBytesLidos(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => countBytesLidos(0),
	datad => VCC,
	combout => \Add0~0_combout\,
	cout => \Add0~1\);

-- Location: LCCOMB_X19_Y5_N18
\Add0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Add0~2_combout\ = (\estado.reset~regout\ & (\Add0~0_combout\ & !\Selector13~4_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.reset~regout\,
	datac => \Add0~0_combout\,
	datad => \Selector13~4_combout\,
	combout => \Add0~2_combout\);

-- Location: LCCOMB_X19_Y5_N14
\Selector14~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector14~0_combout\ = (!\Selector13~0_combout\ & ((\Selector13~2_combout\) # ((!\Selector13~1_combout\ & \estado.retornaChave~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector13~1_combout\,
	datab => \Selector13~2_combout\,
	datac => \estado.retornaChave~regout\,
	datad => \Selector13~0_combout\,
	combout => \Selector14~0_combout\);

-- Location: PIN_40,	 I/O Standard: 2.5 V,	 Current Strength: Default
\botao3~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_botao3,
	combout => \botao3~combout\);

-- Location: PIN_45,	 I/O Standard: 2.5 V,	 Current Strength: Default
\botao4~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_botao4,
	combout => \botao4~combout\);

-- Location: LCCOMB_X19_Y5_N20
\process_0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \process_0~0_combout\ = (!\botao3~combout\ & !\botao4~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \botao3~combout\,
	datad => \botao4~combout\,
	combout => \process_0~0_combout\);

-- Location: LCFF_X19_Y5_N15
\estado.retornaChave\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \Selector14~0_combout\,
	aclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \estado.retornaChave~regout\);

-- Location: LCCOMB_X18_Y5_N8
\Add0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Add0~3_combout\ = (countBytesLidos(1) & (!\Add0~1\)) # (!countBytesLidos(1) & ((\Add0~1\) # (GND)))
-- \Add0~4\ = CARRY((!\Add0~1\) # (!countBytesLidos(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => countBytesLidos(1),
	datad => VCC,
	cin => \Add0~1\,
	combout => \Add0~3_combout\,
	cout => \Add0~4\);

-- Location: LCCOMB_X19_Y5_N24
\Add0~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \Add0~5_combout\ = (\estado.reset~regout\ & (!\Selector13~4_combout\ & \Add0~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.reset~regout\,
	datab => \Selector13~4_combout\,
	datad => \Add0~3_combout\,
	combout => \Add0~5_combout\);

-- Location: LCCOMB_X18_Y5_N22
\countBytesLidos[1]\ : cycloneii_lcell_comb
-- Equation(s):
-- countBytesLidos(1) = (GLOBAL(\Selector86~4clkctrl_outclk\) & (\Add0~5_combout\)) # (!GLOBAL(\Selector86~4clkctrl_outclk\) & ((countBytesLidos(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Add0~5_combout\,
	datac => countBytesLidos(1),
	datad => \Selector86~4clkctrl_outclk\,
	combout => countBytesLidos(1));

-- Location: LCCOMB_X19_Y8_N24
\uart1|tx1|index~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|index~4_combout\ = (!\uart1|tx1|index\(0) & \uart1|tx1|tx_flg~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \uart1|tx1|index\(0),
	datad => \uart1|tx1|tx_flg~0_combout\,
	combout => \uart1|tx1|index~4_combout\);

-- Location: LCCOMB_X19_Y8_N28
\uart1|tx1|index~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|index~3_combout\ = (\uart1|tx_start~combout\) # (\uart1|tx1|tx_flg~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx_start~combout\,
	datac => \uart1|tx1|tx_flg~regout\,
	combout => \uart1|tx1|index~3_combout\);

-- Location: LCFF_X19_Y8_N25
\uart1|tx1|index[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|tx1|index~4_combout\,
	ena => \uart1|tx1|index~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|index\(0));

-- Location: LCCOMB_X19_Y8_N26
\uart1|tx1|index~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|index~5_combout\ = (\uart1|tx1|tx_flg~0_combout\ & (\uart1|tx1|index\(0) $ (\uart1|tx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|tx1|index\(0),
	datac => \uart1|tx1|index\(1),
	datad => \uart1|tx1|tx_flg~0_combout\,
	combout => \uart1|tx1|index~5_combout\);

-- Location: LCFF_X19_Y8_N27
\uart1|tx1|index[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|tx1|index~5_combout\,
	ena => \uart1|tx1|index~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|index\(1));

-- Location: LCCOMB_X19_Y8_N14
\uart1|tx1|index~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|index~6_combout\ = (\uart1|tx1|tx_flg~0_combout\ & (\uart1|tx1|index\(2) $ (((\uart1|tx1|index\(0) & \uart1|tx1|index\(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx1|index\(0),
	datab => \uart1|tx1|tx_flg~0_combout\,
	datac => \uart1|tx1|index\(2),
	datad => \uart1|tx1|index\(1),
	combout => \uart1|tx1|index~6_combout\);

-- Location: LCFF_X19_Y8_N15
\uart1|tx1|index[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|tx1|index~6_combout\,
	ena => \uart1|tx1|index~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|index\(2));

-- Location: LCCOMB_X19_Y8_N30
\uart1|tx1|Add0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|Add0~0_combout\ = (\uart1|tx1|index\(0) & \uart1|tx1|index\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|tx1|index\(0),
	datad => \uart1|tx1|index\(1),
	combout => \uart1|tx1|Add0~0_combout\);

-- Location: LCCOMB_X19_Y8_N22
\uart1|tx1|index~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|index~2_combout\ = (\uart1|tx1|tx_flg~0_combout\ & (\uart1|tx1|index\(3) $ (((\uart1|tx1|index\(2) & \uart1|tx1|Add0~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx1|tx_flg~0_combout\,
	datab => \uart1|tx1|index\(2),
	datac => \uart1|tx1|index\(3),
	datad => \uart1|tx1|Add0~0_combout\,
	combout => \uart1|tx1|index~2_combout\);

-- Location: LCFF_X19_Y8_N23
\uart1|tx1|index[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|tx1|index~2_combout\,
	ena => \uart1|tx1|index~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|index\(3));

-- Location: LCCOMB_X19_Y8_N12
\uart1|tx1|LessThan0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|LessThan0~0_combout\ = (!\uart1|tx1|index\(0) & !\uart1|tx1|index\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \uart1|tx1|index\(0),
	datad => \uart1|tx1|index\(1),
	combout => \uart1|tx1|LessThan0~0_combout\);

-- Location: LCCOMB_X19_Y8_N16
\uart1|tx1|tx_flg~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|tx_flg~0_combout\ = (\uart1|tx1|tx_flg~regout\ & (((!\uart1|tx1|index\(2) & \uart1|tx1|LessThan0~0_combout\)) # (!\uart1|tx1|index\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx1|tx_flg~regout\,
	datab => \uart1|tx1|index\(3),
	datac => \uart1|tx1|index\(2),
	datad => \uart1|tx1|LessThan0~0_combout\,
	combout => \uart1|tx1|tx_flg~0_combout\);

-- Location: LCCOMB_X19_Y8_N20
\uart1|tx1|tx_flg~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|tx_flg~1_combout\ = (\uart1|tx1|tx_flg~0_combout\) # ((\uart1|tx_start~combout\ & !\uart1|tx1|tx_flg~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx_start~combout\,
	datac => \uart1|tx1|tx_flg~regout\,
	datad => \uart1|tx1|tx_flg~0_combout\,
	combout => \uart1|tx1|tx_flg~1_combout\);

-- Location: LCFF_X19_Y8_N21
\uart1|tx1|tx_flg\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|tx1|tx_flg~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|tx_flg~regout\);

-- Location: LCCOMB_X20_Y8_N20
\uart1|tx1|busy~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|busy~0_combout\ = ((\uart1|tx1|busy~regout\ & \uart1|tx1|tx_flg~0_combout\)) # (!\uart1|tx1|tx_flg~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|tx1|tx_flg~regout\,
	datac => \uart1|tx1|busy~regout\,
	datad => \uart1|tx1|tx_flg~0_combout\,
	combout => \uart1|tx1|busy~0_combout\);

-- Location: LCCOMB_X20_Y8_N28
\uart1|comb~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|comb~0_combout\ = (\uart1|tx1|busy~regout\ & \uart1|tx_start~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \uart1|tx1|busy~regout\,
	datad => \uart1|tx_start~combout\,
	combout => \uart1|comb~0_combout\);

-- Location: LCCOMB_X20_Y5_N24
\sig_comm_enviar~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \sig_comm_enviar~1_combout\ = (\estado.retornaChave~regout\ & ((\sig_comm_enviar~combout\) # ((!\uart1|tx_start~combout\ & !\uart1|tx1|busy~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.retornaChave~regout\,
	datab => \sig_comm_enviar~combout\,
	datac => \uart1|tx_start~combout\,
	datad => \uart1|tx1|busy~regout\,
	combout => \sig_comm_enviar~1_combout\);

-- Location: LCCOMB_X20_Y5_N10
\sig_comm_enviar~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \sig_comm_enviar~0_combout\ = (!\sig_comm_enviar~combout\ & ((!\process_1~0_combout\) # (!\process_1~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \process_1~1_combout\,
	datac => \sig_comm_enviar~combout\,
	datad => \process_1~0_combout\,
	combout => \sig_comm_enviar~0_combout\);

-- Location: LCCOMB_X20_Y5_N20
sig_comm_enviar : cycloneii_lcell_comb
-- Equation(s):
-- \sig_comm_enviar~combout\ = (\sig_comm_enviar~1_combout\ & ((\sig_comm_enviar~0_combout\))) # (!\sig_comm_enviar~1_combout\ & (\sig_comm_enviar~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sig_comm_enviar~combout\,
	datac => \sig_comm_enviar~1_combout\,
	datad => \sig_comm_enviar~0_combout\,
	combout => \sig_comm_enviar~combout\);

-- Location: LCCOMB_X20_Y8_N30
\uart1|process_1~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|process_1~1_combout\ = (\sig_comm_enviar~combout\ & (!\uart1|tx1|busy~regout\ & !\uart1|tx_start~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \sig_comm_enviar~combout\,
	datac => \uart1|tx1|busy~regout\,
	datad => \uart1|tx_start~combout\,
	combout => \uart1|process_1~1_combout\);

-- Location: LCCOMB_X20_Y8_N22
\uart1|tx_start\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx_start~combout\ = (!\uart1|comb~0_combout\ & ((\uart1|process_1~1_combout\) # (\uart1|tx_start~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|comb~0_combout\,
	datac => \uart1|process_1~1_combout\,
	datad => \uart1|tx_start~combout\,
	combout => \uart1|tx_start~combout\);

-- Location: LCFF_X20_Y8_N21
\uart1|tx1|busy\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~regout\,
	datain => \uart1|tx1|busy~0_combout\,
	aclr => \uart1|ALT_INV_tx_start~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|busy~regout\);

-- Location: LCCOMB_X20_Y5_N0
\process_1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \process_1~0_combout\ = (!\uart1|tx_start~combout\ & (!countBytesLidos(2) & (!countBytesLidos(1) & !\uart1|tx1|busy~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx_start~combout\,
	datab => countBytesLidos(2),
	datac => countBytesLidos(1),
	datad => \uart1|tx1|busy~regout\,
	combout => \process_1~0_combout\);

-- Location: LCCOMB_X20_Y5_N2
\Selector13~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector13~0_combout\ = (!\botao4~combout\ & (\estado.retornaChave~regout\ & (\process_1~1_combout\ & \process_1~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \botao4~combout\,
	datab => \estado.retornaChave~regout\,
	datac => \process_1~1_combout\,
	datad => \process_1~0_combout\,
	combout => \Selector13~0_combout\);

-- Location: LCCOMB_X19_Y5_N12
\estado.reset~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \estado.reset~2_combout\ = ((\Selector13~2_combout\) # ((\estado.reset~regout\) # (\Selector13~0_combout\))) # (!\botao1~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \botao1~combout\,
	datab => \Selector13~2_combout\,
	datac => \estado.reset~regout\,
	datad => \Selector13~0_combout\,
	combout => \estado.reset~2_combout\);

-- Location: LCFF_X19_Y5_N13
\estado.reset\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~combout\,
	datain => \estado.reset~2_combout\,
	aclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \estado.reset~regout\);

-- Location: LCCOMB_X21_Y5_N16
\Selector83~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector83~0_combout\ = ((\estado.recebeChave~regout\ & (completado(0) $ (\uart1|comando_recebido~0_combout\)))) # (!\estado.reset~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => completado(0),
	datab => \uart1|comando_recebido~0_combout\,
	datac => \estado.reset~regout\,
	datad => \estado.recebeChave~regout\,
	combout => \Selector83~0_combout\);

-- Location: LCCOMB_X21_Y5_N18
\Selector82~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector82~0_combout\ = (\estado.recebeChave~regout\ & (!completado(0) & (\uart1|edge~combout\ & !\uart1|rx1|rx_flg~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => completado(0),
	datac => \uart1|edge~combout\,
	datad => \uart1|rx1|rx_flg~regout\,
	combout => \Selector82~0_combout\);

-- Location: LCCOMB_X21_Y5_N14
\completado[0]\ : cycloneii_lcell_comb
-- Equation(s):
-- completado(0) = (\Selector83~0_combout\ & ((\Selector82~0_combout\))) # (!\Selector83~0_combout\ & (completado(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => completado(0),
	datac => \Selector83~0_combout\,
	datad => \Selector82~0_combout\,
	combout => completado(0));

-- Location: LCCOMB_X21_Y5_N8
\Selector86~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector86~1_combout\ = (!\uart1|rx1|rx_flg~regout\ & (!completado(0) & (!\estado.retornaChave~regout\ & \uart1|edge~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|rx_flg~regout\,
	datab => completado(0),
	datac => \estado.retornaChave~regout\,
	datad => \uart1|edge~combout\,
	combout => \Selector86~1_combout\);

-- Location: LCCOMB_X21_Y5_N22
\Selector86~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector86~2_combout\ = (\Selector86~1_combout\ & ((!countBytesLidos(0)) # (!\Equal2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal2~0_combout\,
	datac => countBytesLidos(0),
	datad => \Selector86~1_combout\,
	combout => \Selector86~2_combout\);

-- Location: LCCOMB_X21_Y5_N28
\Selector86~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector86~0_combout\ = (!\estado.retornaChave~regout\ & !\estado.recebeChave~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \estado.retornaChave~regout\,
	datad => \estado.recebeChave~regout\,
	combout => \Selector86~0_combout\);

-- Location: LCCOMB_X20_Y5_N30
\Selector99~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector99~0_combout\ = (\estado.retornaChave~regout\ & (\sig_comm_enviar~combout\ & ((!\process_1~1_combout\) # (!\process_1~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \process_1~0_combout\,
	datab => \estado.retornaChave~regout\,
	datac => \process_1~1_combout\,
	datad => \sig_comm_enviar~combout\,
	combout => \Selector99~0_combout\);

-- Location: PIN_48,	 I/O Standard: 2.5 V,	 Current Strength: Default
\botao2~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_botao2,
	combout => \botao2~combout\);

-- Location: LCCOMB_X20_Y5_N16
\Selector86~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector86~3_combout\ = (\Selector99~0_combout\) # ((\botao4~combout\ & (!\botao2~combout\ & \Selector13~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \botao4~combout\,
	datab => \Selector99~0_combout\,
	datac => \botao2~combout\,
	datad => \Selector13~4_combout\,
	combout => \Selector86~3_combout\);

-- Location: LCCOMB_X21_Y5_N2
\Selector86~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector86~4_combout\ = (!\estado.recebeTexto~regout\ & ((\Selector86~2_combout\) # ((\Selector86~0_combout\) # (\Selector86~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeTexto~regout\,
	datab => \Selector86~2_combout\,
	datac => \Selector86~0_combout\,
	datad => \Selector86~3_combout\,
	combout => \Selector86~4_combout\);

-- Location: CLKCTRL_G6
\Selector86~4clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \Selector86~4clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \Selector86~4clkctrl_outclk\);

-- Location: LCCOMB_X19_Y5_N22
\countBytesLidos[0]\ : cycloneii_lcell_comb
-- Equation(s):
-- countBytesLidos(0) = (GLOBAL(\Selector86~4clkctrl_outclk\) & ((\Add0~2_combout\))) # (!GLOBAL(\Selector86~4clkctrl_outclk\) & (countBytesLidos(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datac => \Add0~2_combout\,
	datad => \Selector86~4clkctrl_outclk\,
	combout => countBytesLidos(0));

-- Location: LCCOMB_X18_Y5_N10
\Add0~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \Add0~6_combout\ = (countBytesLidos(2) & (\Add0~4\ $ (GND))) # (!countBytesLidos(2) & (!\Add0~4\ & VCC))
-- \Add0~7\ = CARRY((countBytesLidos(2) & !\Add0~4\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => countBytesLidos(2),
	datad => VCC,
	cin => \Add0~4\,
	combout => \Add0~6_combout\,
	cout => \Add0~7\);

-- Location: LCCOMB_X18_Y5_N14
\Add0~12\ : cycloneii_lcell_comb
-- Equation(s):
-- \Add0~12_combout\ = \Add0~10\ $ (!countBytesLidos(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => countBytesLidos(4),
	cin => \Add0~10\,
	combout => \Add0~12_combout\);

-- Location: LCCOMB_X18_Y5_N0
\Add0~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \Add0~14_combout\ = (\Add0~12_combout\ & (\estado.reset~regout\ & !\Selector13~4_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Add0~12_combout\,
	datac => \estado.reset~regout\,
	datad => \Selector13~4_combout\,
	combout => \Add0~14_combout\);

-- Location: LCCOMB_X18_Y5_N2
\countBytesLidos[4]\ : cycloneii_lcell_comb
-- Equation(s):
-- countBytesLidos(4) = (\Selector86~4_combout\ & ((\Add0~14_combout\))) # (!\Selector86~4_combout\ & (countBytesLidos(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => countBytesLidos(4),
	datac => \Selector86~4_combout\,
	datad => \Add0~14_combout\,
	combout => countBytesLidos(4));

-- Location: LCCOMB_X18_Y5_N16
\countBytesLidos[3]\ : cycloneii_lcell_comb
-- Equation(s):
-- countBytesLidos(3) = (GLOBAL(\Selector86~4clkctrl_outclk\) & (\Add0~11_combout\)) # (!GLOBAL(\Selector86~4clkctrl_outclk\) & ((countBytesLidos(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Add0~11_combout\,
	datac => countBytesLidos(3),
	datad => \Selector86~4clkctrl_outclk\,
	combout => countBytesLidos(3));

-- Location: LCCOMB_X20_Y5_N8
\process_1~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \process_1~1_combout\ = (countBytesLidos(0) & (!countBytesLidos(4) & countBytesLidos(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => countBytesLidos(0),
	datac => countBytesLidos(4),
	datad => countBytesLidos(3),
	combout => \process_1~1_combout\);

-- Location: LCCOMB_X20_Y5_N22
\Selector13~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector13~4_combout\ = (\estado.retornaChave~regout\ & (\process_1~1_combout\ & \process_1~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.retornaChave~regout\,
	datac => \process_1~1_combout\,
	datad => \process_1~0_combout\,
	combout => \Selector13~4_combout\);

-- Location: LCCOMB_X19_Y5_N28
\Add0~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \Add0~8_combout\ = (\estado.reset~regout\ & (!\Selector13~4_combout\ & \Add0~6_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.reset~regout\,
	datab => \Selector13~4_combout\,
	datad => \Add0~6_combout\,
	combout => \Add0~8_combout\);

-- Location: LCCOMB_X18_Y5_N30
\countBytesLidos[2]\ : cycloneii_lcell_comb
-- Equation(s):
-- countBytesLidos(2) = (GLOBAL(\Selector86~4clkctrl_outclk\) & (\Add0~8_combout\)) # (!GLOBAL(\Selector86~4clkctrl_outclk\) & ((countBytesLidos(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Add0~8_combout\,
	datac => countBytesLidos(2),
	datad => \Selector86~4clkctrl_outclk\,
	combout => countBytesLidos(2));

-- Location: LCCOMB_X18_Y5_N18
\Equal2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Equal2~0_combout\ = (countBytesLidos(4) & (!countBytesLidos(2) & (!countBytesLidos(3) & !countBytesLidos(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(4),
	datab => countBytesLidos(2),
	datac => countBytesLidos(3),
	datad => countBytesLidos(1),
	combout => \Equal2~0_combout\);

-- Location: LCCOMB_X19_Y5_N0
\Selector13~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector13~2_combout\ = (!countBytesLidos(0) & (\estado.recebeChave~regout\ & (\Equal2~0_combout\ & !\botao3~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => \Equal2~0_combout\,
	datad => \botao3~combout\,
	combout => \Selector13~2_combout\);

-- Location: LCCOMB_X19_Y5_N4
\Selector13~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector13~3_combout\ = (!\Selector13~2_combout\ & (!\Selector13~0_combout\ & ((\Selector13~1_combout\) # (\estado.recebeChave~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector13~1_combout\,
	datab => \Selector13~2_combout\,
	datac => \estado.recebeChave~regout\,
	datad => \Selector13~0_combout\,
	combout => \Selector13~3_combout\);

-- Location: LCFF_X19_Y5_N5
\estado.recebeChave\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \Selector13~3_combout\,
	aclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \estado.recebeChave~regout\);

-- Location: CLKCTRL_G1
\estado.recebeChave~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \estado.recebeChave~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \estado.recebeChave~clkctrl_outclk\);

-- Location: LCCOMB_X21_Y4_N22
\ledred[0]$latch\ : cycloneii_lcell_comb
-- Equation(s):
-- \ledred[0]$latch~combout\ = (GLOBAL(\estado.recebeChave~clkctrl_outclk\) & ((!\uart1|dado_recebido\(0)))) # (!GLOBAL(\estado.recebeChave~clkctrl_outclk\) & (\ledred[0]$latch~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ledred[0]$latch~combout\,
	datac => \uart1|dado_recebido\(0),
	datad => \estado.recebeChave~clkctrl_outclk\,
	combout => \ledred[0]$latch~combout\);

-- Location: LCCOMB_X22_Y5_N18
\uart1|rx1|Decoder0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Decoder0~3_combout\ = (\uart1|rx1|index\(1) & (!\uart1|rx1|index\(3) & (!\uart1|rx1|index\(0) & !\uart1|rx1|index\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(1),
	datab => \uart1|rx1|index\(3),
	datac => \uart1|rx1|index\(0),
	datad => \uart1|rx1|index\(2),
	combout => \uart1|rx1|Decoder0~3_combout\);

-- Location: LCCOMB_X22_Y5_N22
\uart1|rx1|datafll[2]~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll[2]~4_combout\ = (\uart1|rx1|rx_flg~regout\ & ((\uart1|rx1|Decoder0~3_combout\ & ((\pinIn121~combout\))) # (!\uart1|rx1|Decoder0~3_combout\ & (\uart1|rx1|datafll\(2))))) # (!\uart1|rx1|rx_flg~regout\ & (((\uart1|rx1|datafll\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|rx_flg~regout\,
	datab => \uart1|rx1|Decoder0~3_combout\,
	datac => \uart1|rx1|datafll\(2),
	datad => \pinIn121~combout\,
	combout => \uart1|rx1|datafll[2]~4_combout\);

-- Location: LCFF_X22_Y5_N23
\uart1|rx1|datafll[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|datafll[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|datafll\(2));

-- Location: LCCOMB_X21_Y4_N30
\uart1|rx1|data~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|data~3_combout\ = (\uart1|rx1|datafll\(9) & (!\uart1|rx1|datafll\(0) & \uart1|rx1|datafll\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|rx1|datafll\(9),
	datac => \uart1|rx1|datafll\(0),
	datad => \uart1|rx1|datafll\(2),
	combout => \uart1|rx1|data~3_combout\);

-- Location: LCFF_X21_Y4_N31
\uart1|rx1|data[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|data~3_combout\,
	ena => \uart1|rx1|data[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|data\(1));

-- Location: LCCOMB_X21_Y4_N14
\uart1|dado_recebido[1]\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|dado_recebido\(1) = (GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & ((\uart1|rx1|data\(1)))) # (!GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & (\uart1|dado_recebido\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|dado_recebido\(1),
	datac => \uart1|comando_recebido~0clkctrl_outclk\,
	datad => \uart1|rx1|data\(1),
	combout => \uart1|dado_recebido\(1));

-- Location: LCCOMB_X21_Y4_N4
\ledred[1]$latch\ : cycloneii_lcell_comb
-- Equation(s):
-- \ledred[1]$latch~combout\ = (GLOBAL(\estado.recebeChave~clkctrl_outclk\) & (!\uart1|dado_recebido\(1))) # (!GLOBAL(\estado.recebeChave~clkctrl_outclk\) & ((\ledred[1]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|dado_recebido\(1),
	datac => \ledred[1]$latch~combout\,
	datad => \estado.recebeChave~clkctrl_outclk\,
	combout => \ledred[1]$latch~combout\);

-- Location: LCCOMB_X22_Y4_N30
\uart1|rx1|data~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|data~4_combout\ = (\uart1|rx1|datafll\(3) & (\uart1|rx1|datafll\(9) & !\uart1|rx1|datafll\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|datafll\(3),
	datab => \uart1|rx1|datafll\(9),
	datac => \uart1|rx1|datafll\(0),
	combout => \uart1|rx1|data~4_combout\);

-- Location: LCFF_X22_Y4_N31
\uart1|rx1|data[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|data~4_combout\,
	ena => \uart1|rx1|data[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|data\(2));

-- Location: LCCOMB_X22_Y4_N22
\uart1|dado_recebido[2]\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|dado_recebido\(2) = (GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & ((\uart1|rx1|data\(2)))) # (!GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & (\uart1|dado_recebido\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|dado_recebido\(2),
	datac => \uart1|comando_recebido~0clkctrl_outclk\,
	datad => \uart1|rx1|data\(2),
	combout => \uart1|dado_recebido\(2));

-- Location: LCCOMB_X22_Y4_N20
\ledred[2]$latch\ : cycloneii_lcell_comb
-- Equation(s):
-- \ledred[2]$latch~combout\ = (GLOBAL(\estado.recebeChave~clkctrl_outclk\) & (!\uart1|dado_recebido\(2))) # (!GLOBAL(\estado.recebeChave~clkctrl_outclk\) & ((\ledred[2]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|dado_recebido\(2),
	datac => \ledred[2]$latch~combout\,
	datad => \estado.recebeChave~clkctrl_outclk\,
	combout => \ledred[2]$latch~combout\);

-- Location: LCCOMB_X21_Y5_N0
\uart1|rx1|Decoder0~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Decoder0~5_combout\ = (!\uart1|rx1|index\(0) & (!\uart1|rx1|index\(1) & (\uart1|rx1|index\(2) & !\uart1|rx1|index\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(0),
	datab => \uart1|rx1|index\(1),
	datac => \uart1|rx1|index\(2),
	datad => \uart1|rx1|index\(3),
	combout => \uart1|rx1|Decoder0~5_combout\);

-- Location: LCCOMB_X21_Y5_N12
\uart1|rx1|datafll[4]~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll[4]~6_combout\ = (\uart1|rx1|rx_flg~regout\ & ((\uart1|rx1|Decoder0~5_combout\ & (\pinIn121~combout\)) # (!\uart1|rx1|Decoder0~5_combout\ & ((\uart1|rx1|datafll\(4)))))) # (!\uart1|rx1|rx_flg~regout\ & (((\uart1|rx1|datafll\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|rx_flg~regout\,
	datab => \pinIn121~combout\,
	datac => \uart1|rx1|datafll\(4),
	datad => \uart1|rx1|Decoder0~5_combout\,
	combout => \uart1|rx1|datafll[4]~6_combout\);

-- Location: LCFF_X21_Y5_N13
\uart1|rx1|datafll[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|datafll[4]~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|datafll\(4));

-- Location: LCCOMB_X21_Y4_N28
\uart1|rx1|data~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|data~5_combout\ = (\uart1|rx1|datafll\(9) & (!\uart1|rx1|datafll\(0) & \uart1|rx1|datafll\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|rx1|datafll\(9),
	datac => \uart1|rx1|datafll\(0),
	datad => \uart1|rx1|datafll\(4),
	combout => \uart1|rx1|data~5_combout\);

-- Location: LCFF_X21_Y4_N29
\uart1|rx1|data[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|data~5_combout\,
	ena => \uart1|rx1|data[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|data\(3));

-- Location: LCCOMB_X21_Y4_N8
\uart1|dado_recebido[3]\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|dado_recebido\(3) = (GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & ((\uart1|rx1|data\(3)))) # (!GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & (\uart1|dado_recebido\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|dado_recebido\(3),
	datac => \uart1|comando_recebido~0clkctrl_outclk\,
	datad => \uart1|rx1|data\(3),
	combout => \uart1|dado_recebido\(3));

-- Location: LCCOMB_X21_Y4_N18
\ledred[3]$latch\ : cycloneii_lcell_comb
-- Equation(s):
-- \ledred[3]$latch~combout\ = (GLOBAL(\estado.recebeChave~clkctrl_outclk\) & ((!\uart1|dado_recebido\(3)))) # (!GLOBAL(\estado.recebeChave~clkctrl_outclk\) & (\ledred[3]$latch~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ledred[3]$latch~combout\,
	datac => \uart1|dado_recebido\(3),
	datad => \estado.recebeChave~clkctrl_outclk\,
	combout => \ledred[3]$latch~combout\);

-- Location: LCCOMB_X22_Y6_N4
\uart1|rx1|Decoder0~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Decoder0~6_combout\ = (!\uart1|rx1|index\(1) & (\uart1|rx1|index\(2) & (\uart1|rx1|index\(0) & !\uart1|rx1|index\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(1),
	datab => \uart1|rx1|index\(2),
	datac => \uart1|rx1|index\(0),
	datad => \uart1|rx1|index\(3),
	combout => \uart1|rx1|Decoder0~6_combout\);

-- Location: LCCOMB_X21_Y6_N30
\uart1|rx1|datafll[5]~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll[5]~7_combout\ = (\uart1|rx1|rx_flg~regout\ & ((\uart1|rx1|Decoder0~6_combout\ & (\pinIn121~combout\)) # (!\uart1|rx1|Decoder0~6_combout\ & ((\uart1|rx1|datafll\(5)))))) # (!\uart1|rx1|rx_flg~regout\ & (((\uart1|rx1|datafll\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pinIn121~combout\,
	datab => \uart1|rx1|rx_flg~regout\,
	datac => \uart1|rx1|datafll\(5),
	datad => \uart1|rx1|Decoder0~6_combout\,
	combout => \uart1|rx1|datafll[5]~7_combout\);

-- Location: LCFF_X21_Y6_N31
\uart1|rx1|datafll[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|datafll[5]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|datafll\(5));

-- Location: LCCOMB_X21_Y6_N28
\uart1|rx1|data~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|data~6_combout\ = (\uart1|rx1|datafll\(5) & (!\uart1|rx1|datafll\(0) & \uart1|rx1|datafll\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|rx1|datafll\(5),
	datac => \uart1|rx1|datafll\(0),
	datad => \uart1|rx1|datafll\(9),
	combout => \uart1|rx1|data~6_combout\);

-- Location: LCFF_X21_Y6_N29
\uart1|rx1|data[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|data~6_combout\,
	ena => \uart1|rx1|data[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|data\(4));

-- Location: LCCOMB_X21_Y6_N22
\uart1|dado_recebido[4]\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|dado_recebido\(4) = (GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & ((\uart1|rx1|data\(4)))) # (!GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & (\uart1|dado_recebido\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|dado_recebido\(4),
	datac => \uart1|comando_recebido~0clkctrl_outclk\,
	datad => \uart1|rx1|data\(4),
	combout => \uart1|dado_recebido\(4));

-- Location: LCCOMB_X21_Y6_N14
\ledred[4]$latch\ : cycloneii_lcell_comb
-- Equation(s):
-- \ledred[4]$latch~combout\ = (GLOBAL(\estado.recebeChave~clkctrl_outclk\) & ((!\uart1|dado_recebido\(4)))) # (!GLOBAL(\estado.recebeChave~clkctrl_outclk\) & (\ledred[4]$latch~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ledred[4]$latch~combout\,
	datac => \estado.recebeChave~clkctrl_outclk\,
	datad => \uart1|dado_recebido\(4),
	combout => \ledred[4]$latch~combout\);

-- Location: LCCOMB_X22_Y5_N8
\uart1|rx1|Decoder0~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Decoder0~7_combout\ = (\uart1|rx1|index\(1) & (!\uart1|rx1|index\(3) & (!\uart1|rx1|index\(0) & \uart1|rx1|index\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(1),
	datab => \uart1|rx1|index\(3),
	datac => \uart1|rx1|index\(0),
	datad => \uart1|rx1|index\(2),
	combout => \uart1|rx1|Decoder0~7_combout\);

-- Location: LCCOMB_X22_Y5_N20
\uart1|rx1|datafll[6]~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll[6]~8_combout\ = (\uart1|rx1|rx_flg~regout\ & ((\uart1|rx1|Decoder0~7_combout\ & ((\pinIn121~combout\))) # (!\uart1|rx1|Decoder0~7_combout\ & (\uart1|rx1|datafll\(6))))) # (!\uart1|rx1|rx_flg~regout\ & (((\uart1|rx1|datafll\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|rx_flg~regout\,
	datab => \uart1|rx1|Decoder0~7_combout\,
	datac => \uart1|rx1|datafll\(6),
	datad => \pinIn121~combout\,
	combout => \uart1|rx1|datafll[6]~8_combout\);

-- Location: LCFF_X22_Y5_N21
\uart1|rx1|datafll[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|datafll[6]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|datafll\(6));

-- Location: LCCOMB_X21_Y4_N20
\uart1|rx1|data~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|data~7_combout\ = (\uart1|rx1|datafll\(9) & (!\uart1|rx1|datafll\(0) & \uart1|rx1|datafll\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|rx1|datafll\(9),
	datac => \uart1|rx1|datafll\(0),
	datad => \uart1|rx1|datafll\(6),
	combout => \uart1|rx1|data~7_combout\);

-- Location: LCFF_X21_Y4_N3
\uart1|rx1|data[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	sdata => \uart1|rx1|data~7_combout\,
	sload => VCC,
	ena => \uart1|rx1|data[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|data\(5));

-- Location: LCCOMB_X21_Y4_N2
\uart1|dado_recebido[5]\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|dado_recebido\(5) = (GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & ((\uart1|rx1|data\(5)))) # (!GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & (\uart1|dado_recebido\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|dado_recebido\(5),
	datac => \uart1|rx1|data\(5),
	datad => \uart1|comando_recebido~0clkctrl_outclk\,
	combout => \uart1|dado_recebido\(5));

-- Location: LCCOMB_X21_Y4_N16
\ledred[5]$latch\ : cycloneii_lcell_comb
-- Equation(s):
-- \ledred[5]$latch~combout\ = (GLOBAL(\estado.recebeChave~clkctrl_outclk\) & ((!\uart1|dado_recebido\(5)))) # (!GLOBAL(\estado.recebeChave~clkctrl_outclk\) & (\ledred[5]$latch~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ledred[5]$latch~combout\,
	datac => \estado.recebeChave~clkctrl_outclk\,
	datad => \uart1|dado_recebido\(5),
	combout => \ledred[5]$latch~combout\);

-- Location: LCCOMB_X22_Y4_N26
\uart1|rx1|Decoder0~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|Decoder0~8_combout\ = (!\uart1|rx1|index\(3) & (\uart1|rx1|index\(0) & (\uart1|rx1|index\(2) & \uart1|rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|index\(3),
	datab => \uart1|rx1|index\(0),
	datac => \uart1|rx1|index\(2),
	datad => \uart1|rx1|index\(1),
	combout => \uart1|rx1|Decoder0~8_combout\);

-- Location: LCCOMB_X22_Y4_N10
\uart1|rx1|datafll[7]~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|datafll[7]~9_combout\ = (\uart1|rx1|rx_flg~regout\ & ((\uart1|rx1|Decoder0~8_combout\ & (\pinIn121~combout\)) # (!\uart1|rx1|Decoder0~8_combout\ & ((\uart1|rx1|datafll\(7)))))) # (!\uart1|rx1|rx_flg~regout\ & (((\uart1|rx1|datafll\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|rx_flg~regout\,
	datab => \pinIn121~combout\,
	datac => \uart1|rx1|datafll\(7),
	datad => \uart1|rx1|Decoder0~8_combout\,
	combout => \uart1|rx1|datafll[7]~9_combout\);

-- Location: LCFF_X22_Y4_N11
\uart1|rx1|datafll[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|datafll[7]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|datafll\(7));

-- Location: LCCOMB_X21_Y4_N0
\uart1|rx1|data~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|data~8_combout\ = (!\uart1|rx1|datafll\(0) & (\uart1|rx1|datafll\(7) & \uart1|rx1|datafll\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|rx1|datafll\(0),
	datac => \uart1|rx1|datafll\(7),
	datad => \uart1|rx1|datafll\(9),
	combout => \uart1|rx1|data~8_combout\);

-- Location: LCFF_X21_Y4_N1
\uart1|rx1|data[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|data~8_combout\,
	ena => \uart1|rx1|data[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|data\(6));

-- Location: LCCOMB_X21_Y4_N26
\uart1|dado_recebido[6]\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|dado_recebido\(6) = (GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & ((\uart1|rx1|data\(6)))) # (!GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & (\uart1|dado_recebido\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|dado_recebido\(6),
	datac => \uart1|comando_recebido~0clkctrl_outclk\,
	datad => \uart1|rx1|data\(6),
	combout => \uart1|dado_recebido\(6));

-- Location: LCCOMB_X21_Y4_N6
\ledred[6]$latch\ : cycloneii_lcell_comb
-- Equation(s):
-- \ledred[6]$latch~combout\ = (GLOBAL(\estado.recebeChave~clkctrl_outclk\) & ((!\uart1|dado_recebido\(6)))) # (!GLOBAL(\estado.recebeChave~clkctrl_outclk\) & (\ledred[6]$latch~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ledred[6]$latch~combout\,
	datac => \estado.recebeChave~clkctrl_outclk\,
	datad => \uart1|dado_recebido\(6),
	combout => \ledred[6]$latch~combout\);

-- Location: LCCOMB_X21_Y6_N2
\uart1|rx1|data~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|rx1|data~9_combout\ = (\uart1|rx1|datafll\(8) & (!\uart1|rx1|datafll\(0) & \uart1|rx1|datafll\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|rx1|datafll\(8),
	datac => \uart1|rx1|datafll\(0),
	datad => \uart1|rx1|datafll\(9),
	combout => \uart1|rx1|data~9_combout\);

-- Location: LCFF_X21_Y6_N3
\uart1|rx1|data[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|rx1|data~9_combout\,
	ena => \uart1|rx1|data[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|rx1|data\(7));

-- Location: LCCOMB_X21_Y6_N0
\uart1|dado_recebido[7]\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|dado_recebido\(7) = (GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & ((\uart1|rx1|data\(7)))) # (!GLOBAL(\uart1|comando_recebido~0clkctrl_outclk\) & (\uart1|dado_recebido\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|dado_recebido\(7),
	datac => \uart1|comando_recebido~0clkctrl_outclk\,
	datad => \uart1|rx1|data\(7),
	combout => \uart1|dado_recebido\(7));

-- Location: LCCOMB_X21_Y6_N16
\ledred[7]$latch\ : cycloneii_lcell_comb
-- Equation(s):
-- \ledred[7]$latch~combout\ = (GLOBAL(\estado.recebeChave~clkctrl_outclk\) & ((!\uart1|dado_recebido\(7)))) # (!GLOBAL(\estado.recebeChave~clkctrl_outclk\) & (\ledred[7]$latch~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ledred[7]$latch~combout\,
	datac => \estado.recebeChave~clkctrl_outclk\,
	datad => \uart1|dado_recebido\(7),
	combout => \ledred[7]$latch~combout\);

-- Location: LCCOMB_X19_Y12_N0
\uart1|c1|count[0]~14\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[0]~14_combout\ = \uart1|c1|count\(0) $ (VCC)
-- \uart1|c1|count[0]~15\ = CARRY(\uart1|c1|count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|c1|count\(0),
	datad => VCC,
	combout => \uart1|c1|count[0]~14_combout\,
	cout => \uart1|c1|count[0]~15\);

-- Location: LCCOMB_X19_Y12_N12
\uart1|c1|count[6]~26\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[6]~26_combout\ = (\uart1|c1|count\(6) & (\uart1|c1|count[5]~25\ $ (GND))) # (!\uart1|c1|count\(6) & (!\uart1|c1|count[5]~25\ & VCC))
-- \uart1|c1|count[6]~27\ = CARRY((\uart1|c1|count\(6) & !\uart1|c1|count[5]~25\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(6),
	datad => VCC,
	cin => \uart1|c1|count[5]~25\,
	combout => \uart1|c1|count[6]~26_combout\,
	cout => \uart1|c1|count[6]~27\);

-- Location: LCFF_X19_Y12_N13
\uart1|c1|count[6]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[6]~26_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(6));

-- Location: LCCOMB_X19_Y12_N28
\uart1|c1|LessThan0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|LessThan0~0_combout\ = ((!\uart1|c1|count\(6) & ((!\uart1|c1|count\(4)) # (!\uart1|c1|count\(5))))) # (!\uart1|c1|count\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(5),
	datab => \uart1|c1|count\(4),
	datac => \uart1|c1|count\(7),
	datad => \uart1|c1|count\(6),
	combout => \uart1|c1|LessThan0~0_combout\);

-- Location: LCCOMB_X19_Y12_N18
\uart1|c1|count[9]~32\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[9]~32_combout\ = (\uart1|c1|count\(9) & (!\uart1|c1|count[8]~31\)) # (!\uart1|c1|count\(9) & ((\uart1|c1|count[8]~31\) # (GND)))
-- \uart1|c1|count[9]~33\ = CARRY((!\uart1|c1|count[8]~31\) # (!\uart1|c1|count\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \uart1|c1|count\(9),
	datad => VCC,
	cin => \uart1|c1|count[8]~31\,
	combout => \uart1|c1|count[9]~32_combout\,
	cout => \uart1|c1|count[9]~33\);

-- Location: LCCOMB_X19_Y12_N20
\uart1|c1|count[10]~34\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[10]~34_combout\ = (\uart1|c1|count\(10) & (\uart1|c1|count[9]~33\ $ (GND))) # (!\uart1|c1|count\(10) & (!\uart1|c1|count[9]~33\ & VCC))
-- \uart1|c1|count[10]~35\ = CARRY((\uart1|c1|count\(10) & !\uart1|c1|count[9]~33\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(10),
	datad => VCC,
	cin => \uart1|c1|count[9]~33\,
	combout => \uart1|c1|count[10]~34_combout\,
	cout => \uart1|c1|count[10]~35\);

-- Location: LCCOMB_X19_Y12_N22
\uart1|c1|count[11]~36\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[11]~36_combout\ = (\uart1|c1|count\(11) & (!\uart1|c1|count[10]~35\)) # (!\uart1|c1|count\(11) & ((\uart1|c1|count[10]~35\) # (GND)))
-- \uart1|c1|count[11]~37\ = CARRY((!\uart1|c1|count[10]~35\) # (!\uart1|c1|count\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \uart1|c1|count\(11),
	datad => VCC,
	cin => \uart1|c1|count[10]~35\,
	combout => \uart1|c1|count[11]~36_combout\,
	cout => \uart1|c1|count[11]~37\);

-- Location: LCFF_X19_Y12_N23
\uart1|c1|count[11]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[11]~36_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(11));

-- Location: LCCOMB_X19_Y12_N24
\uart1|c1|count[12]~38\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[12]~38_combout\ = (\uart1|c1|count\(12) & (\uart1|c1|count[11]~37\ $ (GND))) # (!\uart1|c1|count\(12) & (!\uart1|c1|count[11]~37\ & VCC))
-- \uart1|c1|count[12]~39\ = CARRY((\uart1|c1|count\(12) & !\uart1|c1|count[11]~37\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(12),
	datad => VCC,
	cin => \uart1|c1|count[11]~37\,
	combout => \uart1|c1|count[12]~38_combout\,
	cout => \uart1|c1|count[12]~39\);

-- Location: LCCOMB_X19_Y12_N26
\uart1|c1|count[13]~40\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[13]~40_combout\ = \uart1|c1|count[12]~39\ $ (\uart1|c1|count\(13))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \uart1|c1|count\(13),
	cin => \uart1|c1|count[12]~39\,
	combout => \uart1|c1|count[13]~40_combout\);

-- Location: LCFF_X19_Y12_N27
\uart1|c1|count[13]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[13]~40_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(13));

-- Location: LCFF_X19_Y12_N25
\uart1|c1|count[12]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[12]~38_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(12));

-- Location: LCCOMB_X20_Y12_N14
\uart1|c1|LessThan0~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|LessThan0~2_combout\ = ((!\uart1|c1|count\(12) & !\uart1|c1|count\(11))) # (!\uart1|c1|count\(13))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|c1|count\(13),
	datac => \uart1|c1|count\(12),
	datad => \uart1|c1|count\(11),
	combout => \uart1|c1|LessThan0~2_combout\);

-- Location: LCFF_X19_Y12_N21
\uart1|c1|count[10]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[10]~34_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(10));

-- Location: LCCOMB_X19_Y12_N16
\uart1|c1|count[8]~30\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[8]~30_combout\ = (\uart1|c1|count\(8) & (\uart1|c1|count[7]~29\ $ (GND))) # (!\uart1|c1|count\(8) & (!\uart1|c1|count[7]~29\ & VCC))
-- \uart1|c1|count[8]~31\ = CARRY((\uart1|c1|count\(8) & !\uart1|c1|count[7]~29\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(8),
	datad => VCC,
	cin => \uart1|c1|count[7]~29\,
	combout => \uart1|c1|count[8]~30_combout\,
	cout => \uart1|c1|count[8]~31\);

-- Location: LCFF_X19_Y12_N17
\uart1|c1|count[8]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[8]~30_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(8));

-- Location: LCCOMB_X20_Y12_N30
\uart1|c1|LessThan0~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|LessThan0~1_combout\ = (!\uart1|c1|count\(12) & (!\uart1|c1|count\(9) & (!\uart1|c1|count\(10) & !\uart1|c1|count\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(12),
	datab => \uart1|c1|count\(9),
	datac => \uart1|c1|count\(10),
	datad => \uart1|c1|count\(8),
	combout => \uart1|c1|LessThan0~1_combout\);

-- Location: LCCOMB_X19_Y12_N30
\uart1|c1|LessThan0~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|LessThan0~3_combout\ = (!\uart1|c1|LessThan0~2_combout\ & ((!\uart1|c1|LessThan0~1_combout\) # (!\uart1|c1|LessThan0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|c1|LessThan0~0_combout\,
	datac => \uart1|c1|LessThan0~2_combout\,
	datad => \uart1|c1|LessThan0~1_combout\,
	combout => \uart1|c1|LessThan0~3_combout\);

-- Location: LCFF_X19_Y12_N1
\uart1|c1|count[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[0]~14_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(0));

-- Location: LCCOMB_X19_Y12_N2
\uart1|c1|count[1]~16\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[1]~16_combout\ = (\uart1|c1|count\(1) & (!\uart1|c1|count[0]~15\)) # (!\uart1|c1|count\(1) & ((\uart1|c1|count[0]~15\) # (GND)))
-- \uart1|c1|count[1]~17\ = CARRY((!\uart1|c1|count[0]~15\) # (!\uart1|c1|count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \uart1|c1|count\(1),
	datad => VCC,
	cin => \uart1|c1|count[0]~15\,
	combout => \uart1|c1|count[1]~16_combout\,
	cout => \uart1|c1|count[1]~17\);

-- Location: LCFF_X19_Y12_N3
\uart1|c1|count[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[1]~16_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(1));

-- Location: LCCOMB_X19_Y12_N4
\uart1|c1|count[2]~18\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[2]~18_combout\ = (\uart1|c1|count\(2) & (\uart1|c1|count[1]~17\ $ (GND))) # (!\uart1|c1|count\(2) & (!\uart1|c1|count[1]~17\ & VCC))
-- \uart1|c1|count[2]~19\ = CARRY((\uart1|c1|count\(2) & !\uart1|c1|count[1]~17\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \uart1|c1|count\(2),
	datad => VCC,
	cin => \uart1|c1|count[1]~17\,
	combout => \uart1|c1|count[2]~18_combout\,
	cout => \uart1|c1|count[2]~19\);

-- Location: LCFF_X19_Y12_N5
\uart1|c1|count[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[2]~18_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(2));

-- Location: LCCOMB_X19_Y12_N6
\uart1|c1|count[3]~20\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[3]~20_combout\ = (\uart1|c1|count\(3) & (!\uart1|c1|count[2]~19\)) # (!\uart1|c1|count\(3) & ((\uart1|c1|count[2]~19\) # (GND)))
-- \uart1|c1|count[3]~21\ = CARRY((!\uart1|c1|count[2]~19\) # (!\uart1|c1|count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(3),
	datad => VCC,
	cin => \uart1|c1|count[2]~19\,
	combout => \uart1|c1|count[3]~20_combout\,
	cout => \uart1|c1|count[3]~21\);

-- Location: LCCOMB_X19_Y12_N8
\uart1|c1|count[4]~22\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[4]~22_combout\ = (\uart1|c1|count\(4) & (\uart1|c1|count[3]~21\ $ (GND))) # (!\uart1|c1|count\(4) & (!\uart1|c1|count[3]~21\ & VCC))
-- \uart1|c1|count[4]~23\ = CARRY((\uart1|c1|count\(4) & !\uart1|c1|count[3]~21\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \uart1|c1|count\(4),
	datad => VCC,
	cin => \uart1|c1|count[3]~21\,
	combout => \uart1|c1|count[4]~22_combout\,
	cout => \uart1|c1|count[4]~23\);

-- Location: LCFF_X19_Y12_N9
\uart1|c1|count[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[4]~22_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(4));

-- Location: LCCOMB_X19_Y12_N14
\uart1|c1|count[7]~28\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|count[7]~28_combout\ = (\uart1|c1|count\(7) & (!\uart1|c1|count[6]~27\)) # (!\uart1|c1|count\(7) & ((\uart1|c1|count[6]~27\) # (GND)))
-- \uart1|c1|count[7]~29\ = CARRY((!\uart1|c1|count[6]~27\) # (!\uart1|c1|count\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \uart1|c1|count\(7),
	datad => VCC,
	cin => \uart1|c1|count[6]~27\,
	combout => \uart1|c1|count[7]~28_combout\,
	cout => \uart1|c1|count[7]~29\);

-- Location: LCFF_X19_Y12_N15
\uart1|c1|count[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[7]~28_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(7));

-- Location: LCFF_X19_Y12_N19
\uart1|c1|count[9]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[9]~32_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(9));

-- Location: LCCOMB_X20_Y12_N28
\uart1|c1|newClock~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|newClock~3_combout\ = (!\uart1|c1|count\(13) & (!\uart1|c1|count\(9) & (!\uart1|c1|count\(11) & !\uart1|c1|count\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(13),
	datab => \uart1|c1|count\(9),
	datac => \uart1|c1|count\(11),
	datad => \uart1|c1|count\(8),
	combout => \uart1|c1|newClock~3_combout\);

-- Location: LCFF_X19_Y12_N7
\uart1|c1|count[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|count[3]~20_combout\,
	sclr => \uart1|c1|LessThan0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|count\(3));

-- Location: LCCOMB_X20_Y12_N24
\uart1|c1|newClock~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|newClock~2_combout\ = ((!\uart1|c1|count\(5) & ((!\uart1|c1|count\(4)) # (!\uart1|c1|count\(3))))) # (!\uart1|c1|count\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(5),
	datab => \uart1|c1|count\(3),
	datac => \uart1|c1|count\(4),
	datad => \uart1|c1|count\(6),
	combout => \uart1|c1|newClock~2_combout\);

-- Location: LCCOMB_X20_Y12_N10
\uart1|c1|newClock~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|newClock~1_combout\ = (\uart1|c1|newClock~0_combout\) # ((!\uart1|c1|LessThan0~2_combout\ & ((!\uart1|c1|LessThan0~0_combout\) # (!\uart1|c1|LessThan0~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101110101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|newClock~0_combout\,
	datab => \uart1|c1|LessThan0~1_combout\,
	datac => \uart1|c1|LessThan0~2_combout\,
	datad => \uart1|c1|LessThan0~0_combout\,
	combout => \uart1|c1|newClock~1_combout\);

-- Location: LCCOMB_X20_Y12_N18
\uart1|c1|newClock~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|c1|newClock~4_combout\ = (!\uart1|c1|newClock~1_combout\ & ((\uart1|c1|count\(7)) # ((!\uart1|c1|newClock~2_combout\) # (!\uart1|c1|newClock~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|c1|count\(7),
	datab => \uart1|c1|newClock~3_combout\,
	datac => \uart1|c1|newClock~2_combout\,
	datad => \uart1|c1|newClock~1_combout\,
	combout => \uart1|c1|newClock~4_combout\);

-- Location: LCFF_X20_Y12_N19
\uart1|c1|newClock\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~clkctrl_outclk\,
	datain => \uart1|c1|newClock~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|c1|newClock~regout\);

-- Location: CLKCTRL_G0
\uart1|c1|newClock~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \uart1|c1|newClock~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \uart1|c1|newClock~clkctrl_outclk\);

-- Location: LCCOMB_X20_Y8_N14
\uart1|process_1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|process_1~0_combout\ = (!\uart1|tx1|busy~regout\ & !\uart1|tx_start~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \uart1|tx1|busy~regout\,
	datad => \uart1|tx_start~combout\,
	combout => \uart1|process_1~0_combout\);

-- Location: LCCOMB_X19_Y5_N2
\Selector81~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector81~0_combout\ = ((\estado.retornaChave~regout\ & (\uart1|process_1~0_combout\ & \sig_comm_enviar~0_combout\))) # (!\estado.reset~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.retornaChave~regout\,
	datab => \uart1|process_1~0_combout\,
	datac => \sig_comm_enviar~0_combout\,
	datad => \estado.reset~regout\,
	combout => \Selector81~0_combout\);

-- Location: CLKCTRL_G3
\Selector81~0clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \Selector81~0clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \Selector81~0clkctrl_outclk\);

-- Location: LCCOMB_X18_Y5_N28
\Selector80~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector80~0_combout\ = (!countBytesLidos(4) & (\estado.retornaChave~regout\ & (!countBytesLidos(3) & countBytesLidos(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(4),
	datab => \estado.retornaChave~regout\,
	datac => countBytesLidos(3),
	datad => countBytesLidos(2),
	combout => \Selector80~0_combout\);

-- Location: LCCOMB_X21_Y5_N4
\Selector2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = ((\estado.recebeChave~regout\ & (!completado(0) & \uart1|comando_recebido~0_combout\))) # (!\estado.reset~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => completado(0),
	datac => \estado.reset~regout\,
	datad => \uart1|comando_recebido~0_combout\,
	combout => \Selector2~0_combout\);

-- Location: CLKCTRL_G4
\Selector2~0clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \Selector2~0clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \Selector2~0clkctrl_outclk\);

-- Location: LCCOMB_X14_Y5_N0
\Selector62~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector62~0_combout\ = (sig_des_key(13) & (\estado.recebeChave~regout\ & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(13),
	datab => \estado.recebeChave~regout\,
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector62~0_combout\);

-- Location: LCCOMB_X14_Y5_N8
\sig_des_key[17]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(17) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector62~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(17),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector62~0_combout\,
	combout => sig_des_key(17));

-- Location: LCCOMB_X17_Y5_N26
\Selector54~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector54~0_combout\ = (sig_des_key(21) & (\estado.recebeChave~regout\ & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(21),
	datab => \estado.recebeChave~regout\,
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector54~0_combout\);

-- Location: LCCOMB_X17_Y5_N8
\sig_des_key[25]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(25) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector54~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(25)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(25),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector54~0_combout\,
	combout => sig_des_key(25));

-- Location: LCCOMB_X18_Y5_N4
\Selector78~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector78~0_combout\ = (\uart1|dado_recebido\(2) & (\estado.recebeChave~regout\ & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|dado_recebido\(2),
	datab => \estado.recebeChave~regout\,
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector78~0_combout\);

-- Location: LCCOMB_X18_Y5_N26
\sig_des_key[1]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(1) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector78~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(1),
	datac => \Selector78~0_combout\,
	datad => \Selector2~0clkctrl_outclk\,
	combout => sig_des_key(1));

-- Location: LCCOMB_X14_Y5_N18
\Selector74~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector74~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(1) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => sig_des_key(1),
	datad => \Equal2~0_combout\,
	combout => \Selector74~0_combout\);

-- Location: LCCOMB_X14_Y5_N26
\sig_des_key[5]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(5) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector74~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(5),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector74~0_combout\,
	combout => sig_des_key(5));

-- Location: LCCOMB_X14_Y5_N30
\Selector70~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector70~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(5) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(5),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector70~0_combout\);

-- Location: LCCOMB_X14_Y5_N2
\sig_des_key[9]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(9) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector70~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(9),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector70~0_combout\,
	combout => sig_des_key(9));

-- Location: LCCOMB_X14_Y5_N6
\Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux1~0_combout\ = (countBytesLidos(1) & (((countBytesLidos(0))))) # (!countBytesLidos(1) & ((countBytesLidos(0) & (sig_des_key(9))) # (!countBytesLidos(0) & ((sig_des_key(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(1),
	datab => sig_des_key(9),
	datac => sig_des_key(1),
	datad => countBytesLidos(0),
	combout => \Mux1~0_combout\);

-- Location: LCCOMB_X14_Y5_N20
\Mux1~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux1~1_combout\ = (countBytesLidos(1) & ((\Mux1~0_combout\ & ((sig_des_key(25)))) # (!\Mux1~0_combout\ & (sig_des_key(17))))) # (!countBytesLidos(1) & (((\Mux1~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(1),
	datab => sig_des_key(17),
	datac => sig_des_key(25),
	datad => \Mux1~0_combout\,
	combout => \Mux1~1_combout\);

-- Location: LCCOMB_X17_Y5_N4
\Selector46~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector46~0_combout\ = (sig_des_key(29) & (\estado.recebeChave~regout\ & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(29),
	datab => \Equal2~0_combout\,
	datac => \estado.recebeChave~regout\,
	datad => countBytesLidos(0),
	combout => \Selector46~0_combout\);

-- Location: LCCOMB_X17_Y5_N30
\sig_des_key[33]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(33) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector46~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(33)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(33),
	datac => \Selector46~0_combout\,
	datad => \Selector2~0clkctrl_outclk\,
	combout => sig_des_key(33));

-- Location: LCCOMB_X15_Y5_N20
\Selector42~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector42~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(33) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => sig_des_key(33),
	datad => \Equal2~0_combout\,
	combout => \Selector42~0_combout\);

-- Location: LCCOMB_X15_Y5_N16
\sig_des_key[37]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(37) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector42~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(37)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(37),
	datac => \Selector42~0_combout\,
	datad => \Selector2~0clkctrl_outclk\,
	combout => sig_des_key(37));

-- Location: LCCOMB_X19_Y5_N26
\Selector38~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector38~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(37) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => \Equal2~0_combout\,
	datad => sig_des_key(37),
	combout => \Selector38~0_combout\);

-- Location: LCCOMB_X19_Y5_N6
\sig_des_key[41]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(41) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector38~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(41)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(41),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector38~0_combout\,
	combout => sig_des_key(41));

-- Location: LCCOMB_X15_Y5_N12
\Selector34~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector34~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(41) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => sig_des_key(41),
	datad => \Equal2~0_combout\,
	combout => \Selector34~0_combout\);

-- Location: LCCOMB_X15_Y5_N4
\sig_des_key[45]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(45) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector34~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(45)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(45),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector34~0_combout\,
	combout => sig_des_key(45));

-- Location: LCCOMB_X15_Y5_N24
\Selector30~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector30~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(45) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(45),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector30~0_combout\);

-- Location: LCCOMB_X15_Y5_N8
\sig_des_key[49]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(49) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector30~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(49)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(49),
	datac => \Selector30~0_combout\,
	datad => \Selector2~0clkctrl_outclk\,
	combout => sig_des_key(49));

-- Location: LCCOMB_X15_Y5_N6
\Selector0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector0~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(49) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(49),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector0~0_combout\);

-- Location: LCCOMB_X15_Y5_N26
\sig_des_key[53]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(53) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector0~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(53)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(53),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector0~0_combout\,
	combout => sig_des_key(53));

-- Location: LCCOMB_X15_Y5_N22
\Selector5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector5~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(53) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(53),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector5~0_combout\);

-- Location: LCCOMB_X15_Y5_N14
\sig_des_key[57]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(57) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector5~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(57)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(57),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector5~0_combout\,
	combout => sig_des_key(57));

-- Location: LCCOMB_X15_Y5_N28
\Mux1~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux1~2_combout\ = (countBytesLidos(0) & (countBytesLidos(1))) # (!countBytesLidos(0) & ((countBytesLidos(1) & (sig_des_key(49))) # (!countBytesLidos(1) & ((sig_des_key(33))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => countBytesLidos(1),
	datac => sig_des_key(49),
	datad => sig_des_key(33),
	combout => \Mux1~2_combout\);

-- Location: LCCOMB_X15_Y5_N2
\Mux1~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux1~3_combout\ = (countBytesLidos(0) & ((\Mux1~2_combout\ & (sig_des_key(57))) # (!\Mux1~2_combout\ & ((sig_des_key(41)))))) # (!countBytesLidos(0) & (((\Mux1~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => sig_des_key(57),
	datac => sig_des_key(41),
	datad => \Mux1~2_combout\,
	combout => \Mux1~3_combout\);

-- Location: LCCOMB_X14_Y5_N10
\Selector21~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector21~0_combout\ = (\Selector80~1_combout\ & ((\Mux1~1_combout\) # ((\Selector80~0_combout\ & \Mux1~3_combout\)))) # (!\Selector80~1_combout\ & (\Selector80~0_combout\ & ((\Mux1~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector80~1_combout\,
	datab => \Selector80~0_combout\,
	datac => \Mux1~1_combout\,
	datad => \Mux1~3_combout\,
	combout => \Selector21~0_combout\);

-- Location: LCCOMB_X14_Y5_N22
\sig_dado_enviar[6]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_dado_enviar(6) = (GLOBAL(\Selector81~0clkctrl_outclk\) & ((\Selector21~0_combout\))) # (!GLOBAL(\Selector81~0clkctrl_outclk\) & (sig_dado_enviar(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_dado_enviar(6),
	datac => \Selector81~0clkctrl_outclk\,
	datad => \Selector21~0_combout\,
	combout => sig_dado_enviar(6));

-- Location: LCCOMB_X17_Y8_N22
\uart1|tx1|process_0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|process_0~0_combout\ = (\uart1|tx_start~combout\ & !\uart1|tx1|tx_flg~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|tx_start~combout\,
	datad => \uart1|tx1|tx_flg~regout\,
	combout => \uart1|tx1|process_0~0_combout\);

-- Location: LCFF_X14_Y5_N23
\uart1|tx1|datafll[7]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => sig_dado_enviar(6),
	ena => \uart1|tx1|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|datafll\(7));

-- Location: LCCOMB_X18_Y5_N24
\Selector80~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector80~1_combout\ = (!countBytesLidos(4) & (\estado.retornaChave~regout\ & (!countBytesLidos(3) & !countBytesLidos(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(4),
	datab => \estado.retornaChave~regout\,
	datac => countBytesLidos(3),
	datad => countBytesLidos(2),
	combout => \Selector80~1_combout\);

-- Location: LCCOMB_X18_Y8_N26
\Selector59~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector59~0_combout\ = (sig_des_key(16) & (\estado.recebeChave~regout\ & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(16),
	datab => \estado.recebeChave~regout\,
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector59~0_combout\);

-- Location: LCCOMB_X18_Y8_N14
\sig_des_key[20]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(20) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector59~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(20)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(20),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector59~0_combout\,
	combout => sig_des_key(20));

-- Location: LCCOMB_X18_Y8_N12
\Selector55~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector55~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(20) & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(20),
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector55~0_combout\);

-- Location: LCCOMB_X18_Y8_N8
\sig_des_key[24]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(24) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector55~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(24),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector55~0_combout\,
	combout => sig_des_key(24));

-- Location: LCCOMB_X18_Y8_N28
\Selector51~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector51~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(24) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => sig_des_key(24),
	datad => \Equal2~0_combout\,
	combout => \Selector51~0_combout\);

-- Location: LCCOMB_X18_Y8_N24
\sig_des_key[28]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(28) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector51~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(28)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(28),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector51~0_combout\,
	combout => sig_des_key(28));

-- Location: LCCOMB_X18_Y4_N4
\Selector71~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector71~0_combout\ = (sig_des_key(4) & (\estado.recebeChave~regout\ & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(4),
	datab => \estado.recebeChave~regout\,
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector71~0_combout\);

-- Location: LCCOMB_X18_Y4_N14
\sig_des_key[8]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(8) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector71~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(8),
	datac => \Selector71~0_combout\,
	datad => \Selector2~0clkctrl_outclk\,
	combout => sig_des_key(8));

-- Location: LCCOMB_X18_Y4_N28
\Selector67~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector67~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(8) & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(8),
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector67~0_combout\);

-- Location: LCCOMB_X18_Y4_N2
\sig_des_key[12]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(12) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector67~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(12),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector67~0_combout\,
	combout => sig_des_key(12));

-- Location: LCCOMB_X18_Y4_N10
\Selector79~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector79~0_combout\ = (\estado.recebeChave~regout\ & (\uart1|dado_recebido\(3) & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => \uart1|dado_recebido\(3),
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector79~0_combout\);

-- Location: LCCOMB_X18_Y4_N8
\sig_des_key[0]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(0) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector79~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(0),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector79~0_combout\,
	combout => sig_des_key(0));

-- Location: LCCOMB_X17_Y4_N28
\Selector75~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector75~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(0) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(0),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector75~0_combout\);

-- Location: LCCOMB_X17_Y4_N14
\sig_des_key[4]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(4) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector75~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(4),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector75~0_combout\,
	combout => sig_des_key(4));

-- Location: LCCOMB_X18_Y4_N6
\Mux4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux4~0_combout\ = (countBytesLidos(0) & ((sig_des_key(12)) # ((countBytesLidos(1))))) # (!countBytesLidos(0) & (((!countBytesLidos(1) & sig_des_key(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => sig_des_key(12),
	datac => countBytesLidos(1),
	datad => sig_des_key(4),
	combout => \Mux4~0_combout\);

-- Location: LCCOMB_X18_Y4_N24
\Mux4~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux4~1_combout\ = (countBytesLidos(1) & ((\Mux4~0_combout\ & (sig_des_key(28))) # (!\Mux4~0_combout\ & ((sig_des_key(20)))))) # (!countBytesLidos(1) & (((\Mux4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(1),
	datab => sig_des_key(28),
	datac => sig_des_key(20),
	datad => \Mux4~0_combout\,
	combout => \Mux4~1_combout\);

-- Location: LCCOMB_X18_Y8_N6
\Selector47~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector47~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(28) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(28),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector47~0_combout\);

-- Location: LCCOMB_X18_Y8_N22
\sig_des_key[32]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(32) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector47~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(32)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(32),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector47~0_combout\,
	combout => sig_des_key(32));

-- Location: LCCOMB_X18_Y8_N2
\Selector43~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector43~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(32) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(32),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector43~0_combout\);

-- Location: LCCOMB_X18_Y8_N18
\sig_des_key[36]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(36) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector43~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(36)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(36),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector43~0_combout\,
	combout => sig_des_key(36));

-- Location: LCCOMB_X19_Y4_N28
\Selector39~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector39~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(36) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => \Equal2~0_combout\,
	datad => sig_des_key(36),
	combout => \Selector39~0_combout\);

-- Location: LCCOMB_X19_Y4_N20
\sig_des_key[40]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(40) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector39~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(40)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(40),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector39~0_combout\,
	combout => sig_des_key(40));

-- Location: LCCOMB_X19_Y4_N30
\Selector35~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector35~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(40) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => sig_des_key(40),
	datad => \Equal2~0_combout\,
	combout => \Selector35~0_combout\);

-- Location: LCCOMB_X19_Y4_N14
\sig_des_key[44]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(44) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector35~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(44)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(44),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector35~0_combout\,
	combout => sig_des_key(44));

-- Location: LCCOMB_X19_Y4_N22
\Selector31~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector31~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(44) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => sig_des_key(44),
	datad => \Equal2~0_combout\,
	combout => \Selector31~0_combout\);

-- Location: LCCOMB_X19_Y4_N26
\sig_des_key[48]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(48) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector31~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(48)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(48),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector31~0_combout\,
	combout => sig_des_key(48));

-- Location: LCCOMB_X19_Y4_N0
\Selector27~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector27~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(48) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(48),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector27~0_combout\);

-- Location: LCCOMB_X19_Y4_N24
\sig_des_key[52]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(52) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector27~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(52)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(52),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector27~0_combout\,
	combout => sig_des_key(52));

-- Location: LCCOMB_X19_Y4_N8
\Mux4~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux4~2_combout\ = (countBytesLidos(0) & (countBytesLidos(1))) # (!countBytesLidos(0) & ((countBytesLidos(1) & (sig_des_key(52))) # (!countBytesLidos(1) & ((sig_des_key(36))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => countBytesLidos(1),
	datac => sig_des_key(52),
	datad => sig_des_key(36),
	combout => \Mux4~2_combout\);

-- Location: LCCOMB_X19_Y4_N2
\Mux4~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux4~3_combout\ = (\Mux4~2_combout\ & ((sig_des_key(60)) # ((!countBytesLidos(0))))) # (!\Mux4~2_combout\ & (((sig_des_key(44) & countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(60),
	datab => sig_des_key(44),
	datac => \Mux4~2_combout\,
	datad => countBytesLidos(0),
	combout => \Mux4~3_combout\);

-- Location: LCCOMB_X18_Y4_N30
\Selector24~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector24~0_combout\ = (\Selector80~0_combout\ & ((\Mux4~3_combout\) # ((\Selector80~1_combout\ & \Mux4~1_combout\)))) # (!\Selector80~0_combout\ & (\Selector80~1_combout\ & (\Mux4~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector80~0_combout\,
	datab => \Selector80~1_combout\,
	datac => \Mux4~1_combout\,
	datad => \Mux4~3_combout\,
	combout => \Selector24~0_combout\);

-- Location: LCCOMB_X18_Y4_N16
\sig_dado_enviar[3]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_dado_enviar(3) = (GLOBAL(\Selector81~0clkctrl_outclk\) & ((\Selector24~0_combout\))) # (!GLOBAL(\Selector81~0clkctrl_outclk\) & (sig_dado_enviar(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_dado_enviar(3),
	datac => \Selector81~0clkctrl_outclk\,
	datad => \Selector24~0_combout\,
	combout => sig_dado_enviar(3));

-- Location: LCFF_X18_Y4_N17
\uart1|tx1|datafll[4]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => sig_dado_enviar(3),
	ena => \uart1|tx1|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|datafll\(4));

-- Location: LCCOMB_X17_Y5_N14
\Selector76~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector76~0_combout\ = (\uart1|dado_recebido\(0) & (\estado.recebeChave~regout\ & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|dado_recebido\(0),
	datab => \Equal2~0_combout\,
	datac => \estado.recebeChave~regout\,
	datad => countBytesLidos(0),
	combout => \Selector76~0_combout\);

-- Location: LCCOMB_X17_Y5_N0
\sig_des_key[3]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(3) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector76~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(3),
	datac => \Selector76~0_combout\,
	datad => \Selector2~0clkctrl_outclk\,
	combout => sig_des_key(3));

-- Location: LCCOMB_X17_Y6_N18
\Selector72~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector72~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(3) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(3),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector72~0_combout\);

-- Location: LCCOMB_X17_Y6_N22
\sig_des_key[7]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(7) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector72~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(7),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector72~0_combout\,
	combout => sig_des_key(7));

-- Location: LCCOMB_X17_Y6_N2
\Selector68~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector68~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(7) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(7),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector68~0_combout\);

-- Location: LCCOMB_X17_Y6_N26
\sig_des_key[11]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(11) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector68~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(11),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector68~0_combout\,
	combout => sig_des_key(11));

-- Location: LCCOMB_X17_Y6_N12
\Selector64~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector64~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(11) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(11),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector64~0_combout\);

-- Location: LCCOMB_X17_Y6_N4
\sig_des_key[15]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(15) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector64~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(15),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector64~0_combout\,
	combout => sig_des_key(15));

-- Location: LCCOMB_X17_Y6_N0
\Selector60~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector60~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(15) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(15),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector60~0_combout\);

-- Location: LCCOMB_X17_Y6_N16
\sig_des_key[19]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(19) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector60~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(19),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector60~0_combout\,
	combout => sig_des_key(19));

-- Location: LCCOMB_X19_Y6_N0
\Selector56~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector56~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(19) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => sig_des_key(19),
	datad => \Equal2~0_combout\,
	combout => \Selector56~0_combout\);

-- Location: LCCOMB_X19_Y6_N20
\sig_des_key[23]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(23) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector56~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(23)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(23),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector56~0_combout\,
	combout => sig_des_key(23));

-- Location: LCCOMB_X19_Y6_N28
\Selector52~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector52~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(23) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => sig_des_key(23),
	datad => \Equal2~0_combout\,
	combout => \Selector52~0_combout\);

-- Location: LCCOMB_X19_Y6_N24
\sig_des_key[27]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(27) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector52~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(27)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(27),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector52~0_combout\,
	combout => sig_des_key(27));

-- Location: LCCOMB_X17_Y6_N6
\Mux3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux3~0_combout\ = (countBytesLidos(0) & (((countBytesLidos(1)) # (sig_des_key(11))))) # (!countBytesLidos(0) & (sig_des_key(3) & (!countBytesLidos(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => sig_des_key(3),
	datac => countBytesLidos(1),
	datad => sig_des_key(11),
	combout => \Mux3~0_combout\);

-- Location: LCCOMB_X17_Y6_N20
\Mux3~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux3~1_combout\ = (countBytesLidos(1) & ((\Mux3~0_combout\ & ((sig_des_key(27)))) # (!\Mux3~0_combout\ & (sig_des_key(19))))) # (!countBytesLidos(1) & (((\Mux3~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(19),
	datab => countBytesLidos(1),
	datac => sig_des_key(27),
	datad => \Mux3~0_combout\,
	combout => \Mux3~1_combout\);

-- Location: LCCOMB_X18_Y6_N18
\Selector36~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector36~0_combout\ = (sig_des_key(39) & (\estado.recebeChave~regout\ & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(39),
	datab => \estado.recebeChave~regout\,
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector36~0_combout\);

-- Location: LCCOMB_X18_Y6_N14
\sig_des_key[43]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(43) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector36~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(43)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(43),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector36~0_combout\,
	combout => sig_des_key(43));

-- Location: LCCOMB_X18_Y6_N20
\Selector32~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector32~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(43) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(43),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector32~0_combout\);

-- Location: LCCOMB_X18_Y6_N8
\sig_des_key[47]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(47) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector32~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(47)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(47),
	datac => \Selector32~0_combout\,
	datad => \Selector2~0clkctrl_outclk\,
	combout => sig_des_key(47));

-- Location: LCCOMB_X18_Y6_N24
\Selector28~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector28~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(47) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(47),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector28~0_combout\);

-- Location: LCCOMB_X18_Y6_N16
\sig_des_key[51]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(51) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector28~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(51)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(51),
	datac => \Selector28~0_combout\,
	datad => \Selector2~0clkctrl_outclk\,
	combout => sig_des_key(51));

-- Location: LCCOMB_X19_Y6_N26
\Selector48~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector48~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(27) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => sig_des_key(27),
	datad => \Equal2~0_combout\,
	combout => \Selector48~0_combout\);

-- Location: LCCOMB_X19_Y6_N14
\sig_des_key[31]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(31) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector48~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(31)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(31),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector48~0_combout\,
	combout => sig_des_key(31));

-- Location: LCCOMB_X19_Y6_N18
\Selector44~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector44~0_combout\ = (sig_des_key(31) & (\estado.recebeChave~regout\ & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => sig_des_key(31),
	datac => \estado.recebeChave~regout\,
	datad => \Equal2~0_combout\,
	combout => \Selector44~0_combout\);

-- Location: LCCOMB_X19_Y6_N30
\sig_des_key[35]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(35) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector44~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(35)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(35),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector44~0_combout\,
	combout => sig_des_key(35));

-- Location: LCCOMB_X18_Y6_N28
\Mux3~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux3~2_combout\ = (countBytesLidos(0) & (countBytesLidos(1))) # (!countBytesLidos(0) & ((countBytesLidos(1) & (sig_des_key(51))) # (!countBytesLidos(1) & ((sig_des_key(35))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => countBytesLidos(1),
	datac => sig_des_key(51),
	datad => sig_des_key(35),
	combout => \Mux3~2_combout\);

-- Location: LCCOMB_X18_Y6_N22
\Mux3~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux3~3_combout\ = (countBytesLidos(0) & ((\Mux3~2_combout\ & (sig_des_key(59))) # (!\Mux3~2_combout\ & ((sig_des_key(43)))))) # (!countBytesLidos(0) & (((\Mux3~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(59),
	datab => sig_des_key(43),
	datac => countBytesLidos(0),
	datad => \Mux3~2_combout\,
	combout => \Mux3~3_combout\);

-- Location: LCCOMB_X17_Y6_N10
\Selector23~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector23~0_combout\ = (\Selector80~0_combout\ & ((\Mux3~3_combout\) # ((\Selector80~1_combout\ & \Mux3~1_combout\)))) # (!\Selector80~0_combout\ & (\Selector80~1_combout\ & (\Mux3~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector80~0_combout\,
	datab => \Selector80~1_combout\,
	datac => \Mux3~1_combout\,
	datad => \Mux3~3_combout\,
	combout => \Selector23~0_combout\);

-- Location: LCCOMB_X17_Y6_N30
\sig_dado_enviar[4]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_dado_enviar(4) = (GLOBAL(\Selector81~0clkctrl_outclk\) & ((\Selector23~0_combout\))) # (!GLOBAL(\Selector81~0clkctrl_outclk\) & (sig_dado_enviar(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_dado_enviar(4),
	datac => \Selector81~0clkctrl_outclk\,
	datad => \Selector23~0_combout\,
	combout => sig_dado_enviar(4));

-- Location: LCFF_X17_Y6_N31
\uart1|tx1|datafll[5]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => sig_dado_enviar(4),
	ena => \uart1|tx1|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|datafll\(5));

-- Location: LCCOMB_X18_Y8_N4
\uart1|tx1|tx_line~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|tx_line~4_combout\ = (\uart1|tx1|index\(1) & (!\uart1|tx1|index\(0))) # (!\uart1|tx1|index\(1) & ((\uart1|tx1|index\(0) & ((\uart1|tx1|datafll\(5)))) # (!\uart1|tx1|index\(0) & (\uart1|tx1|datafll\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011000110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx1|index\(1),
	datab => \uart1|tx1|index\(0),
	datac => \uart1|tx1|datafll\(4),
	datad => \uart1|tx1|datafll\(5),
	combout => \uart1|tx1|tx_line~4_combout\);

-- Location: LCCOMB_X17_Y8_N14
\uart1|tx1|tx_line~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|tx_line~5_combout\ = (\uart1|tx1|index\(1) & ((\uart1|tx1|tx_line~4_combout\ & (\uart1|tx1|datafll\(6))) # (!\uart1|tx1|tx_line~4_combout\ & ((\uart1|tx1|datafll\(7)))))) # (!\uart1|tx1|index\(1) & (((\uart1|tx1|tx_line~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx1|datafll\(6),
	datab => \uart1|tx1|index\(1),
	datac => \uart1|tx1|datafll\(7),
	datad => \uart1|tx1|tx_line~4_combout\,
	combout => \uart1|tx1|tx_line~5_combout\);

-- Location: LCCOMB_X17_Y6_N24
\Mux7~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux7~0_combout\ = (countBytesLidos(0) & ((countBytesLidos(1)) # ((sig_des_key(15))))) # (!countBytesLidos(0) & (!countBytesLidos(1) & ((sig_des_key(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => countBytesLidos(1),
	datac => sig_des_key(15),
	datad => sig_des_key(7),
	combout => \Mux7~0_combout\);

-- Location: LCCOMB_X17_Y6_N14
\Mux7~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux7~1_combout\ = (countBytesLidos(1) & ((\Mux7~0_combout\ & ((sig_des_key(31)))) # (!\Mux7~0_combout\ & (sig_des_key(23))))) # (!countBytesLidos(1) & (((\Mux7~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(23),
	datab => countBytesLidos(1),
	datac => \Mux7~0_combout\,
	datad => sig_des_key(31),
	combout => \Mux7~1_combout\);

-- Location: LCCOMB_X18_Y6_N2
\Selector7~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector7~0_combout\ = (sig_des_key(55) & (\estado.recebeChave~regout\ & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(55),
	datab => \estado.recebeChave~regout\,
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector7~0_combout\);

-- Location: LCCOMB_X18_Y6_N6
\sig_des_key[59]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(59) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector7~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(59)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(59),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector7~0_combout\,
	combout => sig_des_key(59));

-- Location: LCCOMB_X19_Y6_N12
\Selector11~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector11~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(59) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(59),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector11~0_combout\);

-- Location: LCCOMB_X19_Y6_N16
\sig_des_key[63]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(63) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector11~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(63)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(63),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector11~0_combout\,
	combout => sig_des_key(63));

-- Location: LCCOMB_X18_Y6_N26
\Selector3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = (sig_des_key(51) & (\estado.recebeChave~regout\ & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(51),
	datab => \estado.recebeChave~regout\,
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector3~0_combout\);

-- Location: LCCOMB_X18_Y6_N10
\sig_des_key[55]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(55) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector3~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(55)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(55),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector3~0_combout\,
	combout => sig_des_key(55));

-- Location: LCCOMB_X18_Y6_N0
\Mux7~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux7~2_combout\ = (countBytesLidos(1) & (((countBytesLidos(0)) # (sig_des_key(55))))) # (!countBytesLidos(1) & (sig_des_key(39) & (!countBytesLidos(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(39),
	datab => countBytesLidos(1),
	datac => countBytesLidos(0),
	datad => sig_des_key(55),
	combout => \Mux7~2_combout\);

-- Location: LCCOMB_X18_Y6_N30
\Mux7~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux7~3_combout\ = (countBytesLidos(0) & ((\Mux7~2_combout\ & ((sig_des_key(63)))) # (!\Mux7~2_combout\ & (sig_des_key(47))))) # (!countBytesLidos(0) & (((\Mux7~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => sig_des_key(47),
	datac => sig_des_key(63),
	datad => \Mux7~2_combout\,
	combout => \Mux7~3_combout\);

-- Location: LCCOMB_X17_Y6_N28
\Selector80~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector80~2_combout\ = (\Selector80~0_combout\ & ((\Mux7~3_combout\) # ((\Selector80~1_combout\ & \Mux7~1_combout\)))) # (!\Selector80~0_combout\ & (\Selector80~1_combout\ & (\Mux7~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector80~0_combout\,
	datab => \Selector80~1_combout\,
	datac => \Mux7~1_combout\,
	datad => \Mux7~3_combout\,
	combout => \Selector80~2_combout\);

-- Location: LCCOMB_X17_Y6_N8
\sig_dado_enviar[0]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_dado_enviar(0) = (GLOBAL(\Selector81~0clkctrl_outclk\) & ((\Selector80~2_combout\))) # (!GLOBAL(\Selector81~0clkctrl_outclk\) & (sig_dado_enviar(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_dado_enviar(0),
	datac => \Selector81~0clkctrl_outclk\,
	datad => \Selector80~2_combout\,
	combout => sig_dado_enviar(0));

-- Location: LCFF_X17_Y6_N9
\uart1|tx1|datafll[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => sig_dado_enviar(0),
	ena => \uart1|tx1|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|datafll\(1));

-- Location: LCCOMB_X17_Y5_N18
\Selector10~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector10~0_combout\ = (sig_des_key(58) & (\estado.recebeChave~regout\ & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(58),
	datab => \estado.recebeChave~regout\,
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector10~0_combout\);

-- Location: LCCOMB_X17_Y5_N24
\sig_des_key[62]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(62) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector10~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(62)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(62),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector10~0_combout\,
	combout => sig_des_key(62));

-- Location: LCCOMB_X18_Y7_N12
\Selector29~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector29~0_combout\ = (sig_des_key(46) & (\estado.recebeChave~regout\ & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(46),
	datab => \estado.recebeChave~regout\,
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector29~0_combout\);

-- Location: LCCOMB_X18_Y7_N14
\sig_des_key[50]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(50) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector29~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(50)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(50),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector29~0_combout\,
	combout => sig_des_key(50));

-- Location: LCCOMB_X18_Y7_N10
\Selector1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(50) & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(50),
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector1~0_combout\);

-- Location: LCCOMB_X18_Y7_N8
\sig_des_key[54]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(54) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector1~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(54)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(54),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector1~0_combout\,
	combout => sig_des_key(54));

-- Location: LCCOMB_X19_Y6_N22
\Selector77~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector77~0_combout\ = (\estado.recebeChave~regout\ & (\uart1|dado_recebido\(1) & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => \uart1|dado_recebido\(1),
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector77~0_combout\);

-- Location: LCCOMB_X19_Y6_N6
\sig_des_key[2]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(2) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector77~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(2),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector77~0_combout\,
	combout => sig_des_key(2));

-- Location: LCCOMB_X19_Y7_N26
\Selector73~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector73~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(2) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => sig_des_key(2),
	datad => \Equal2~0_combout\,
	combout => \Selector73~0_combout\);

-- Location: LCCOMB_X19_Y7_N2
\sig_des_key[6]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(6) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector73~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(6),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector73~0_combout\,
	combout => sig_des_key(6));

-- Location: LCCOMB_X19_Y7_N12
\Selector69~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector69~0_combout\ = (sig_des_key(6) & (\estado.recebeChave~regout\ & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => sig_des_key(6),
	datac => \estado.recebeChave~regout\,
	datad => \Equal2~0_combout\,
	combout => \Selector69~0_combout\);

-- Location: LCCOMB_X19_Y7_N20
\sig_des_key[10]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(10) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector69~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(10),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector69~0_combout\,
	combout => sig_des_key(10));

-- Location: LCCOMB_X19_Y7_N0
\Selector65~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector65~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(10) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => sig_des_key(10),
	datad => \Equal2~0_combout\,
	combout => \Selector65~0_combout\);

-- Location: LCCOMB_X19_Y7_N16
\sig_des_key[14]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(14) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector65~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(14),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector65~0_combout\,
	combout => sig_des_key(14));

-- Location: LCCOMB_X19_Y7_N10
\Selector61~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector61~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(14) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => sig_des_key(14),
	datad => \Equal2~0_combout\,
	combout => \Selector61~0_combout\);

-- Location: LCCOMB_X19_Y7_N18
\sig_des_key[18]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(18) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector61~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(18),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector61~0_combout\,
	combout => sig_des_key(18));

-- Location: LCCOMB_X18_Y8_N0
\Selector57~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector57~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(18) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => sig_des_key(18),
	datad => \Equal2~0_combout\,
	combout => \Selector57~0_combout\);

-- Location: LCCOMB_X18_Y8_N16
\sig_des_key[22]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(22) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector57~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(22),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector57~0_combout\,
	combout => sig_des_key(22));

-- Location: LCCOMB_X19_Y7_N22
\Selector53~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector53~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(22) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => sig_des_key(22),
	datad => \Equal2~0_combout\,
	combout => \Selector53~0_combout\);

-- Location: LCCOMB_X19_Y7_N14
\sig_des_key[26]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(26) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector53~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(26)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(26),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector53~0_combout\,
	combout => sig_des_key(26));

-- Location: LCCOMB_X19_Y7_N28
\Selector49~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector49~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(26) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => sig_des_key(26),
	datad => \Equal2~0_combout\,
	combout => \Selector49~0_combout\);

-- Location: LCCOMB_X19_Y7_N4
\sig_des_key[30]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(30) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector49~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(30)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(30),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector49~0_combout\,
	combout => sig_des_key(30));

-- Location: LCCOMB_X17_Y7_N12
\Selector45~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector45~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(30) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => sig_des_key(30),
	datad => \Equal2~0_combout\,
	combout => \Selector45~0_combout\);

-- Location: LCCOMB_X17_Y7_N18
\sig_des_key[34]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(34) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector45~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(34)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(34),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector45~0_combout\,
	combout => sig_des_key(34));

-- Location: LCCOMB_X18_Y7_N0
\Selector41~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector41~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(34) & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(34),
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector41~0_combout\);

-- Location: LCCOMB_X18_Y7_N18
\sig_des_key[38]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(38) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector41~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(38)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(38),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector41~0_combout\,
	combout => sig_des_key(38));

-- Location: LCCOMB_X18_Y7_N26
\Mux6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux6~0_combout\ = (countBytesLidos(0) & (countBytesLidos(1))) # (!countBytesLidos(0) & ((countBytesLidos(1) & (sig_des_key(54))) # (!countBytesLidos(1) & ((sig_des_key(38))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => countBytesLidos(1),
	datac => sig_des_key(54),
	datad => sig_des_key(38),
	combout => \Mux6~0_combout\);

-- Location: LCCOMB_X18_Y7_N4
\Mux6~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux6~1_combout\ = (countBytesLidos(0) & ((\Mux6~0_combout\ & ((sig_des_key(62)))) # (!\Mux6~0_combout\ & (sig_des_key(46))))) # (!countBytesLidos(0) & (((\Mux6~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(46),
	datab => countBytesLidos(0),
	datac => sig_des_key(62),
	datad => \Mux6~0_combout\,
	combout => \Mux6~1_combout\);

-- Location: LCCOMB_X19_Y7_N24
\Mux6~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux6~2_combout\ = (countBytesLidos(0) & ((countBytesLidos(1)) # ((sig_des_key(14))))) # (!countBytesLidos(0) & (!countBytesLidos(1) & ((sig_des_key(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => countBytesLidos(1),
	datac => sig_des_key(14),
	datad => sig_des_key(6),
	combout => \Mux6~2_combout\);

-- Location: LCCOMB_X19_Y7_N30
\Mux6~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux6~3_combout\ = (countBytesLidos(1) & ((\Mux6~2_combout\ & (sig_des_key(30))) # (!\Mux6~2_combout\ & ((sig_des_key(22)))))) # (!countBytesLidos(1) & (((\Mux6~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(1),
	datab => sig_des_key(30),
	datac => sig_des_key(22),
	datad => \Mux6~2_combout\,
	combout => \Mux6~3_combout\);

-- Location: LCCOMB_X18_Y7_N22
\Selector26~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector26~0_combout\ = (\Selector80~0_combout\ & ((\Mux6~1_combout\) # ((\Selector80~1_combout\ & \Mux6~3_combout\)))) # (!\Selector80~0_combout\ & (\Selector80~1_combout\ & ((\Mux6~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector80~0_combout\,
	datab => \Selector80~1_combout\,
	datac => \Mux6~1_combout\,
	datad => \Mux6~3_combout\,
	combout => \Selector26~0_combout\);

-- Location: LCCOMB_X18_Y7_N24
\sig_dado_enviar[1]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_dado_enviar(1) = (GLOBAL(\Selector81~0clkctrl_outclk\) & ((\Selector26~0_combout\))) # (!GLOBAL(\Selector81~0clkctrl_outclk\) & (sig_dado_enviar(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_dado_enviar(1),
	datac => \Selector81~0clkctrl_outclk\,
	datad => \Selector26~0_combout\,
	combout => sig_dado_enviar(1));

-- Location: LCFF_X18_Y7_N25
\uart1|tx1|datafll[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => sig_dado_enviar(1),
	ena => \uart1|tx1|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|datafll\(2));

-- Location: LCCOMB_X17_Y5_N12
\Selector58~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector58~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(17) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => countBytesLidos(0),
	datac => \Equal2~0_combout\,
	datad => sig_des_key(17),
	combout => \Selector58~0_combout\);

-- Location: LCCOMB_X17_Y5_N6
\sig_des_key[21]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(21) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector58~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(21),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector58~0_combout\,
	combout => sig_des_key(21));

-- Location: LCCOMB_X14_Y5_N12
\Selector66~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector66~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(9) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(9),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector66~0_combout\);

-- Location: LCCOMB_X14_Y5_N24
\sig_des_key[13]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(13) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector66~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(13),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector66~0_combout\,
	combout => sig_des_key(13));

-- Location: LCCOMB_X14_Y5_N4
\Mux5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux5~0_combout\ = (countBytesLidos(0) & ((countBytesLidos(1)) # ((sig_des_key(13))))) # (!countBytesLidos(0) & (!countBytesLidos(1) & ((sig_des_key(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => countBytesLidos(1),
	datac => sig_des_key(13),
	datad => sig_des_key(5),
	combout => \Mux5~0_combout\);

-- Location: LCCOMB_X17_Y5_N22
\Selector50~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector50~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(25) & ((!countBytesLidos(0)) # (!\Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(25),
	datac => \Equal2~0_combout\,
	datad => countBytesLidos(0),
	combout => \Selector50~0_combout\);

-- Location: LCCOMB_X17_Y5_N16
\sig_des_key[29]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(29) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector50~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(29)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_des_key(29),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector50~0_combout\,
	combout => sig_des_key(29));

-- Location: LCCOMB_X14_Y5_N14
\Mux5~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux5~1_combout\ = (countBytesLidos(1) & ((\Mux5~0_combout\ & ((sig_des_key(29)))) # (!\Mux5~0_combout\ & (sig_des_key(21))))) # (!countBytesLidos(1) & (((\Mux5~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(1),
	datab => sig_des_key(21),
	datac => \Mux5~0_combout\,
	datad => sig_des_key(29),
	combout => \Mux5~1_combout\);

-- Location: LCCOMB_X15_Y5_N10
\Selector9~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector9~0_combout\ = (\estado.recebeChave~regout\ & (sig_des_key(57) & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => sig_des_key(57),
	datac => countBytesLidos(0),
	datad => \Equal2~0_combout\,
	combout => \Selector9~0_combout\);

-- Location: LCCOMB_X15_Y5_N18
\sig_des_key[61]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_des_key(61) = (GLOBAL(\Selector2~0clkctrl_outclk\) & ((\Selector9~0_combout\))) # (!GLOBAL(\Selector2~0clkctrl_outclk\) & (sig_des_key(61)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_des_key(61),
	datac => \Selector2~0clkctrl_outclk\,
	datad => \Selector9~0_combout\,
	combout => sig_des_key(61));

-- Location: LCCOMB_X15_Y5_N0
\Mux5~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux5~2_combout\ = (countBytesLidos(0) & (countBytesLidos(1))) # (!countBytesLidos(0) & ((countBytesLidos(1) & ((sig_des_key(53)))) # (!countBytesLidos(1) & (sig_des_key(37)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => countBytesLidos(1),
	datac => sig_des_key(37),
	datad => sig_des_key(53),
	combout => \Mux5~2_combout\);

-- Location: LCCOMB_X15_Y5_N30
\Mux5~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \Mux5~3_combout\ = (countBytesLidos(0) & ((\Mux5~2_combout\ & (sig_des_key(61))) # (!\Mux5~2_combout\ & ((sig_des_key(45)))))) # (!countBytesLidos(0) & (((\Mux5~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => sig_des_key(61),
	datac => sig_des_key(45),
	datad => \Mux5~2_combout\,
	combout => \Mux5~3_combout\);

-- Location: LCCOMB_X14_Y5_N28
\Selector25~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector25~0_combout\ = (\Selector80~1_combout\ & ((\Mux5~1_combout\) # ((\Selector80~0_combout\ & \Mux5~3_combout\)))) # (!\Selector80~1_combout\ & (\Selector80~0_combout\ & ((\Mux5~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector80~1_combout\,
	datab => \Selector80~0_combout\,
	datac => \Mux5~1_combout\,
	datad => \Mux5~3_combout\,
	combout => \Selector25~0_combout\);

-- Location: LCCOMB_X14_Y5_N16
\sig_dado_enviar[2]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_dado_enviar(2) = (GLOBAL(\Selector81~0clkctrl_outclk\) & ((\Selector25~0_combout\))) # (!GLOBAL(\Selector81~0clkctrl_outclk\) & (sig_dado_enviar(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_dado_enviar(2),
	datac => \Selector81~0clkctrl_outclk\,
	datad => \Selector25~0_combout\,
	combout => sig_dado_enviar(2));

-- Location: LCFF_X14_Y5_N17
\uart1|tx1|datafll[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => sig_dado_enviar(2),
	ena => \uart1|tx1|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|datafll\(3));

-- Location: LCCOMB_X17_Y8_N26
\uart1|tx1|tx_line~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|tx_line~2_combout\ = (\uart1|tx1|index\(0) & ((\uart1|tx1|datafll\(3)))) # (!\uart1|tx1|index\(0) & (\uart1|tx1|datafll\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart1|tx1|index\(0),
	datac => \uart1|tx1|datafll\(2),
	datad => \uart1|tx1|datafll\(3),
	combout => \uart1|tx1|tx_line~2_combout\);

-- Location: LCCOMB_X17_Y8_N12
\uart1|tx1|tx_line~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|tx_line~3_combout\ = (\uart1|tx1|index\(1) & (((\uart1|tx1|tx_line~2_combout\)))) # (!\uart1|tx1|index\(1) & (\uart1|tx1|index\(0) & (\uart1|tx1|datafll\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx1|index\(0),
	datab => \uart1|tx1|index\(1),
	datac => \uart1|tx1|datafll\(1),
	datad => \uart1|tx1|tx_line~2_combout\,
	combout => \uart1|tx1|tx_line~3_combout\);

-- Location: LCCOMB_X17_Y8_N0
\uart1|tx1|tx_line~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|tx_line~6_combout\ = (\uart1|tx1|index\(2) & ((\uart1|tx1|index\(3)) # ((\uart1|tx1|tx_line~5_combout\)))) # (!\uart1|tx1|index\(2) & (((\uart1|tx1|tx_line~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx1|index\(3),
	datab => \uart1|tx1|index\(2),
	datac => \uart1|tx1|tx_line~5_combout\,
	datad => \uart1|tx1|tx_line~3_combout\,
	combout => \uart1|tx1|tx_line~6_combout\);

-- Location: LCCOMB_X17_Y8_N16
\uart1|tx1|tx_line~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \uart1|tx1|tx_line~7_combout\ = (\uart1|tx1|tx_flg~regout\ & (!\uart1|tx1|tx_line~8_combout\ & ((!\uart1|tx1|tx_line~6_combout\)))) # (!\uart1|tx1|tx_flg~regout\ & (((\uart1|tx1|tx_line~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000001110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx1|tx_line~8_combout\,
	datab => \uart1|tx1|tx_flg~regout\,
	datac => \uart1|tx1|tx_line~regout\,
	datad => \uart1|tx1|tx_line~6_combout\,
	combout => \uart1|tx1|tx_line~7_combout\);

-- Location: LCFF_X17_Y8_N17
\uart1|tx1|tx_line\ : cycloneii_lcell_ff
PORT MAP (
	clk => \uart1|c1|newClock~clkctrl_outclk\,
	datain => \uart1|tx1|tx_line~7_combout\,
	aclr => \uart1|ALT_INV_tx_start~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \uart1|tx1|tx_line~regout\);

-- Location: LCCOMB_X20_Y5_N14
\estado.recebeTexto~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \estado.recebeTexto~0_combout\ = (\estado.recebeTexto~regout\) # (\Selector13~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \estado.recebeTexto~regout\,
	datad => \Selector13~0_combout\,
	combout => \estado.recebeTexto~0_combout\);

-- Location: LCFF_X20_Y5_N15
\estado.recebeTexto\ : cycloneii_lcell_ff
PORT MAP (
	clk => \clock~combout\,
	datain => \estado.recebeTexto~0_combout\,
	aclr => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \estado.recebeTexto~regout\);

-- Location: LCCOMB_X20_Y5_N28
\Selector100~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector100~0_combout\ = (\estado.recebeTexto~regout\) # ((\sig_comm_enviar~1_combout\) # (!\estado.reset~regout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \estado.recebeTexto~regout\,
	datac => \sig_comm_enviar~1_combout\,
	datad => \estado.reset~regout\,
	combout => \Selector100~0_combout\);

-- Location: LCCOMB_X20_Y5_N6
\countEstado[2]\ : cycloneii_lcell_comb
-- Equation(s):
-- countEstado(2) = (\Selector100~0_combout\ & (\estado.retornaChave~regout\)) # (!\Selector100~0_combout\ & ((countEstado(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.retornaChave~regout\,
	datab => \Selector100~0_combout\,
	datad => countEstado(2),
	combout => countEstado(2));

-- Location: LCCOMB_X17_Y5_N20
\Selector94~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector94~0_combout\ = (\estado.recebeChave~regout\ & (countBytesLidos(2))) # (!\estado.recebeChave~regout\ & (((countEstado(2)) # (!\estado.reset~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100010111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(2),
	datab => \estado.recebeChave~regout\,
	datac => countEstado(2),
	datad => \estado.reset~regout\,
	combout => \Selector94~0_combout\);

-- Location: LCCOMB_X20_Y8_N16
\Selector92~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector92~2_combout\ = ((!\uart1|tx_start~combout\ & (\sig_comm_enviar~0_combout\ & !\uart1|tx1|busy~regout\))) # (!\estado.retornaChave~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.retornaChave~regout\,
	datab => \uart1|tx_start~combout\,
	datac => \sig_comm_enviar~0_combout\,
	datad => \uart1|tx1|busy~regout\,
	combout => \Selector92~2_combout\);

-- Location: CLKCTRL_G5
\Selector92~2clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \Selector92~2clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \Selector92~2clkctrl_outclk\);

-- Location: LCCOMB_X17_Y7_N22
\sig_decod_In[2]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_decod_In(2) = (GLOBAL(\Selector92~2clkctrl_outclk\) & ((\Selector94~0_combout\))) # (!GLOBAL(\Selector92~2clkctrl_outclk\) & (sig_decod_In(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_decod_In(2),
	datac => \Selector94~0_combout\,
	datad => \Selector92~2clkctrl_outclk\,
	combout => sig_decod_In(2));

-- Location: LCCOMB_X17_Y7_N14
\Selector91~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector91~0_combout\ = (\estado.recebeChave~regout\ & (((countBytesLidos(0))))) # (!\estado.recebeChave~regout\ & (countEstado(0) & (\estado.reset~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countEstado(0),
	datab => \estado.recebeChave~regout\,
	datac => \estado.reset~regout\,
	datad => countBytesLidos(0),
	combout => \Selector91~0_combout\);

-- Location: LCCOMB_X17_Y7_N2
\sig_decod_In[0]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_decod_In(0) = (GLOBAL(\Selector92~2clkctrl_outclk\) & ((\Selector91~0_combout\))) # (!GLOBAL(\Selector92~2clkctrl_outclk\) & (sig_decod_In(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_decod_In(0),
	datac => \Selector91~0_combout\,
	datad => \Selector92~2clkctrl_outclk\,
	combout => sig_decod_In(0));

-- Location: LCCOMB_X20_Y8_N24
\countEstado[3]\ : cycloneii_lcell_comb
-- Equation(s):
-- countEstado(3) = (\Selector101~0_combout\ & ((\estado.recebeTexto~regout\))) # (!\Selector101~0_combout\ & (countEstado(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector101~0_combout\,
	datac => countEstado(3),
	datad => \estado.recebeTexto~regout\,
	combout => countEstado(3));

-- Location: LCCOMB_X17_Y7_N26
\Selector95~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector95~0_combout\ = (\estado.recebeChave~regout\ & (countBytesLidos(3))) # (!\estado.recebeChave~regout\ & (((countEstado(3)) # (!\estado.reset~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100010111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(3),
	datab => \estado.recebeChave~regout\,
	datac => countEstado(3),
	datad => \estado.reset~regout\,
	combout => \Selector95~0_combout\);

-- Location: LCCOMB_X17_Y7_N20
\sig_decod_In[3]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_decod_In(3) = (GLOBAL(\Selector92~2clkctrl_outclk\) & ((\Selector95~0_combout\))) # (!GLOBAL(\Selector92~2clkctrl_outclk\) & (sig_decod_In(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector92~2clkctrl_outclk\,
	datac => sig_decod_In(3),
	datad => \Selector95~0_combout\,
	combout => sig_decod_In(3));

-- Location: LCCOMB_X20_Y5_N26
\countEstado[1]\ : cycloneii_lcell_comb
-- Equation(s):
-- countEstado(1) = (\Selector100~0_combout\ & (\Selector13~4_combout\)) # (!\Selector100~0_combout\ & ((countEstado(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector100~0_combout\,
	datab => \Selector13~4_combout\,
	datad => countEstado(1),
	combout => countEstado(1));

-- Location: LCCOMB_X17_Y7_N4
\Selector93~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector93~0_combout\ = (\estado.recebeChave~regout\ & (countBytesLidos(1))) # (!\estado.recebeChave~regout\ & (((countEstado(1)) # (!\estado.reset~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(1),
	datab => \estado.recebeChave~regout\,
	datac => \estado.reset~regout\,
	datad => countEstado(1),
	combout => \Selector93~0_combout\);

-- Location: LCCOMB_X17_Y7_N28
\sig_decod_In[1]\ : cycloneii_lcell_comb
-- Equation(s):
-- sig_decod_In(1) = (GLOBAL(\Selector92~2clkctrl_outclk\) & ((\Selector93~0_combout\))) # (!GLOBAL(\Selector92~2clkctrl_outclk\) & (sig_decod_In(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => sig_decod_In(1),
	datac => \Selector93~0_combout\,
	datad => \Selector92~2clkctrl_outclk\,
	combout => sig_decod_In(1));

-- Location: LCCOMB_X17_Y7_N0
\d1|Mux0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \d1|Mux0~0_combout\ = (sig_decod_In(2) & (!sig_decod_In(1) & (sig_decod_In(0) $ (!sig_decod_In(3))))) # (!sig_decod_In(2) & (sig_decod_In(0) & (sig_decod_In(3) $ (!sig_decod_In(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000010000110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_decod_In(2),
	datab => sig_decod_In(0),
	datac => sig_decod_In(3),
	datad => sig_decod_In(1),
	combout => \d1|Mux0~0_combout\);

-- Location: LCCOMB_X17_Y7_N6
\d1|Mux1~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \d1|Mux1~0_combout\ = (sig_decod_In(3) & ((sig_decod_In(0) & ((sig_decod_In(1)))) # (!sig_decod_In(0) & (sig_decod_In(2))))) # (!sig_decod_In(3) & (sig_decod_In(2) & (sig_decod_In(0) $ (sig_decod_In(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_decod_In(2),
	datab => sig_decod_In(0),
	datac => sig_decod_In(3),
	datad => sig_decod_In(1),
	combout => \d1|Mux1~0_combout\);

-- Location: LCCOMB_X17_Y7_N8
\d1|Mux2~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \d1|Mux2~0_combout\ = (sig_decod_In(2) & (sig_decod_In(3) & ((sig_decod_In(1)) # (!sig_decod_In(0))))) # (!sig_decod_In(2) & (!sig_decod_In(0) & (!sig_decod_In(3) & sig_decod_In(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_decod_In(2),
	datab => sig_decod_In(0),
	datac => sig_decod_In(3),
	datad => sig_decod_In(1),
	combout => \d1|Mux2~0_combout\);

-- Location: LCCOMB_X17_Y7_N10
\d1|Mux3~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \d1|Mux3~0_combout\ = (sig_decod_In(1) & ((sig_decod_In(2) & (sig_decod_In(0))) # (!sig_decod_In(2) & (!sig_decod_In(0) & sig_decod_In(3))))) # (!sig_decod_In(1) & (!sig_decod_In(3) & (sig_decod_In(2) $ (sig_decod_In(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100000000110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_decod_In(2),
	datab => sig_decod_In(0),
	datac => sig_decod_In(3),
	datad => sig_decod_In(1),
	combout => \d1|Mux3~0_combout\);

-- Location: LCCOMB_X17_Y7_N16
\d1|Mux4~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \d1|Mux4~0_combout\ = (sig_decod_In(1) & (((sig_decod_In(0) & !sig_decod_In(3))))) # (!sig_decod_In(1) & ((sig_decod_In(2) & ((!sig_decod_In(3)))) # (!sig_decod_In(2) & (sig_decod_In(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110001001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_decod_In(2),
	datab => sig_decod_In(0),
	datac => sig_decod_In(3),
	datad => sig_decod_In(1),
	combout => \d1|Mux4~0_combout\);

-- Location: LCCOMB_X17_Y7_N30
\d1|Mux5~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \d1|Mux5~0_combout\ = (sig_decod_In(2) & (sig_decod_In(0) & (sig_decod_In(3) $ (sig_decod_In(1))))) # (!sig_decod_In(2) & (!sig_decod_In(3) & ((sig_decod_In(0)) # (sig_decod_In(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110110000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_decod_In(2),
	datab => sig_decod_In(0),
	datac => sig_decod_In(3),
	datad => sig_decod_In(1),
	combout => \d1|Mux5~0_combout\);

-- Location: LCCOMB_X17_Y7_N24
\d1|Mux6~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \d1|Mux6~0_combout\ = (sig_decod_In(0) & ((sig_decod_In(3)) # (sig_decod_In(2) $ (sig_decod_In(1))))) # (!sig_decod_In(0) & ((sig_decod_In(1)) # (sig_decod_In(2) $ (sig_decod_In(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011111011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => sig_decod_In(2),
	datab => sig_decod_In(0),
	datac => sig_decod_In(3),
	datad => sig_decod_In(1),
	combout => \d1|Mux6~0_combout\);

-- Location: LCCOMB_X21_Y5_N10
\Selector97~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector97~0_combout\ = ((\uart1|edge~combout\ & (!completado(0) & !\uart1|rx1|rx_flg~regout\))) # (!\estado.recebeChave~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \estado.recebeChave~regout\,
	datab => \uart1|edge~combout\,
	datac => completado(0),
	datad => \uart1|rx1|rx_flg~regout\,
	combout => \Selector97~0_combout\);

-- Location: LCCOMB_X20_Y5_N12
\Selector97~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector97~1_combout\ = (\Selector13~0_combout\) # ((\Selector99~0_combout\) # ((\Selector97~0_combout\ & !\estado.retornaChave~regout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector13~0_combout\,
	datab => \Selector97~0_combout\,
	datac => \Selector99~0_combout\,
	datad => \estado.retornaChave~regout\,
	combout => \Selector97~1_combout\);

-- Location: LCCOMB_X19_Y5_N30
\Selector96~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector96~0_combout\ = ((\estado.retornaChave~regout\ & ((\uart1|tx_start~combout\) # (\uart1|tx1|busy~regout\)))) # (!\estado.reset~regout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart1|tx_start~combout\,
	datab => \uart1|tx1|busy~regout\,
	datac => \estado.retornaChave~regout\,
	datad => \estado.reset~regout\,
	combout => \Selector96~0_combout\);

-- Location: LCCOMB_X19_Y5_N10
\Selector96~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \Selector96~1_combout\ = (\Selector96~0_combout\) # ((\estado.recebeChave~regout\ & ((!\Equal2~0_combout\) # (!countBytesLidos(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => countBytesLidos(0),
	datab => \estado.recebeChave~regout\,
	datac => \Equal2~0_combout\,
	datad => \Selector96~0_combout\,
	combout => \Selector96~1_combout\);

-- Location: LCCOMB_X19_Y5_N8
\display8seg[7]$latch\ : cycloneii_lcell_comb
-- Equation(s):
-- \display8seg[7]$latch~combout\ = (\Selector97~1_combout\ & ((\Selector96~1_combout\))) # (!\Selector97~1_combout\ & (\display8seg[7]$latch~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \display8seg[7]$latch~combout\,
	datab => \Selector97~1_combout\,
	datad => \Selector96~1_combout\,
	combout => \display8seg[7]$latch~combout\);

-- Location: LCCOMB_X20_Y5_N18
\display8segSelect[0]$latch\ : cycloneii_lcell_comb
-- Equation(s):
-- \display8segSelect[0]$latch~combout\ = (\Selector86~0_combout\ & ((!\estado.recebeTexto~regout\))) # (!\Selector86~0_combout\ & (\display8segSelect[0]$latch~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \display8segSelect[0]$latch~combout\,
	datac => \estado.recebeTexto~regout\,
	datad => \Selector86~0_combout\,
	combout => \display8segSelect[0]$latch~combout\);

-- Location: PIN_65,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\ledred[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ledred[0]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_ledred(0));

-- Location: PIN_69,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\ledred[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ledred[1]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_ledred(1));

-- Location: PIN_70,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\ledred[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ledred[2]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_ledred(2));

-- Location: PIN_71,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\ledred[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ledred[3]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_ledred(3));

-- Location: PIN_72,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\ledred[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ledred[4]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_ledred(4));

-- Location: PIN_64,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\ledred[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ledred[5]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_ledred(5));

-- Location: PIN_67,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\ledred[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ledred[6]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_ledred(6));

-- Location: PIN_60,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\ledred[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \ledred[7]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_ledred(7));

-- Location: PIN_120,	 I/O Standard: 2.5 V,	 Current Strength: Default
\pinIn120~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_pinIn120);

-- Location: PIN_118,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\pinOut118~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \uart1|tx1|ALT_INV_tx_line~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_pinOut118);

-- Location: PIN_119,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\pinOut119~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \uart1|tx1|ALT_INV_tx_line~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_pinOut119);

-- Location: PIN_32,	 I/O Standard: 2.5 V,	 Current Strength: 8mA
\pinSound~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_pinSound);

-- Location: PIN_93,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8seg[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \d1|Mux0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8seg(0));

-- Location: PIN_92,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8seg[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \d1|Mux1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8seg(1));

-- Location: PIN_87,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8seg[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \d1|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8seg(2));

-- Location: PIN_86,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8seg[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \d1|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8seg(3));

-- Location: PIN_55,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\display8seg[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \d1|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8seg(4));

-- Location: PIN_58,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\display8seg[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \d1|Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8seg(5));

-- Location: PIN_79,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8seg[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \d1|ALT_INV_Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8seg(6));

-- Location: PIN_113,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
\display8seg[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \display8seg[7]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8seg(7));

-- Location: PIN_94,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8segSelect[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \display8segSelect[0]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8segSelect(0));

-- Location: PIN_96,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8segSelect[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8segSelect(1));

-- Location: PIN_97,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8segSelect[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8segSelect(2));

-- Location: PIN_99,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8segSelect[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8segSelect(3));

-- Location: PIN_100,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8segSelect[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8segSelect(4));

-- Location: PIN_101,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8segSelect[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8segSelect(5));

-- Location: PIN_103,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8segSelect[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8segSelect(6));

-- Location: PIN_104,	 I/O Standard: 1.5 V,	 Current Strength: 6mA
\display8segSelect[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_display8segSelect(7));
END structure;


