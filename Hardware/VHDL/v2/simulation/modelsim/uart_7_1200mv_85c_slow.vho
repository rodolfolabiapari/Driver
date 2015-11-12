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

-- DATE "09/14/2015 18:17:48"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	uart IS
    PORT (
	clock : IN std_logic;
	botao : IN std_logic;
	ledr : OUT std_logic_vector(9 DOWNTO 0);
	uart_tx : OUT std_logic;
	uart_rx : IN std_logic
	);
END uart;

-- Design Ports Information
-- ledr[0]	=>  Location: PIN_G19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ledr[1]	=>  Location: PIN_F19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ledr[2]	=>  Location: PIN_E19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ledr[3]	=>  Location: PIN_F21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ledr[4]	=>  Location: PIN_F18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ledr[5]	=>  Location: PIN_E18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ledr[6]	=>  Location: PIN_J19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ledr[7]	=>  Location: PIN_H19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ledr[8]	=>  Location: PIN_J17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ledr[9]	=>  Location: PIN_G17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- uart_tx	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- botao	=>  Location: PIN_M23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- uart_rx	=>  Location: PIN_H14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_AG14,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF uart IS
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
SIGNAL ww_botao : std_logic;
SIGNAL ww_ledr : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_uart_tx : std_logic;
SIGNAL ww_uart_rx : std_logic;
SIGNAL \rx1|busy~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \c1|newClock~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clock~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \c1|count[1]~9_combout\ : std_logic;
SIGNAL \tx1|tx_line~0_combout\ : std_logic;
SIGNAL \rx1|Decoder0~1_combout\ : std_logic;
SIGNAL \rx1|datafll[1]~2_combout\ : std_logic;
SIGNAL \rx1|Add0~1_combout\ : std_logic;
SIGNAL \rx1|Decoder0~7_combout\ : std_logic;
SIGNAL \rx1|datafll[6]~8_combout\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputclkctrl_outclk\ : std_logic;
SIGNAL \ledr[0]~output_o\ : std_logic;
SIGNAL \ledr[1]~output_o\ : std_logic;
SIGNAL \ledr[2]~output_o\ : std_logic;
SIGNAL \ledr[3]~output_o\ : std_logic;
SIGNAL \ledr[4]~output_o\ : std_logic;
SIGNAL \ledr[5]~output_o\ : std_logic;
SIGNAL \ledr[6]~output_o\ : std_logic;
SIGNAL \ledr[7]~output_o\ : std_logic;
SIGNAL \ledr[8]~output_o\ : std_logic;
SIGNAL \ledr[9]~output_o\ : std_logic;
SIGNAL \uart_tx~output_o\ : std_logic;
SIGNAL \uart_rx~input_o\ : std_logic;
SIGNAL \rx1|index[0]~4_combout\ : std_logic;
SIGNAL \rx1|index[1]~6_combout\ : std_logic;
SIGNAL \rx1|LessThan0~0_combout\ : std_logic;
SIGNAL \rx1|index[1]~5_combout\ : std_logic;
SIGNAL \rx1|index[3]~9_combout\ : std_logic;
SIGNAL \rx1|Add0~0_combout\ : std_logic;
SIGNAL \rx1|index[2]~7_combout\ : std_logic;
SIGNAL \rx1|index[2]~8_combout\ : std_logic;
SIGNAL \rx1|Decoder0~0_combout\ : std_logic;
SIGNAL \rx1|datafll[9]~1_combout\ : std_logic;
SIGNAL \rx1|Decoder0~2_combout\ : std_logic;
SIGNAL \rx1|datafll[0]~0_combout\ : std_logic;
SIGNAL \rx1|datafll~3_combout\ : std_logic;
SIGNAL \rx1|index[0]~1_combout\ : std_logic;
SIGNAL \rx1|index[0]~2_combout\ : std_logic;
SIGNAL \rx1|index[0]~0_combout\ : std_logic;
SIGNAL \rx1|index[0]~3_combout\ : std_logic;
SIGNAL \rx1|recebido~0_combout\ : std_logic;
SIGNAL \rx1|recebido~1_combout\ : std_logic;
SIGNAL \rx1|recebido~q\ : std_logic;
SIGNAL \rx1|data[0]~9_combout\ : std_logic;
SIGNAL \uart_rx~_wirecell_combout\ : std_logic;
SIGNAL \rx1|rx_flg~q\ : std_logic;
SIGNAL \rx1|data[0]~1_combout\ : std_logic;
SIGNAL \rx1|busy~2_combout\ : std_logic;
SIGNAL \rx1|busy~feeder_combout\ : std_logic;
SIGNAL \rx1|busy~q\ : std_logic;
SIGNAL \rx1|busy~clkctrl_outclk\ : std_logic;
SIGNAL \rx1|data~0_combout\ : std_logic;
SIGNAL \ledr[0]~0_combout\ : std_logic;
SIGNAL \ledr[0]~reg0_q\ : std_logic;
SIGNAL \rx1|Decoder0~3_combout\ : std_logic;
SIGNAL \rx1|datafll[2]~4_combout\ : std_logic;
SIGNAL \rx1|data~2_combout\ : std_logic;
SIGNAL \ledr[1]~1_combout\ : std_logic;
SIGNAL \ledr[1]~reg0_q\ : std_logic;
SIGNAL \rx1|Decoder0~4_combout\ : std_logic;
SIGNAL \rx1|datafll[3]~5_combout\ : std_logic;
SIGNAL \rx1|data~3_combout\ : std_logic;
SIGNAL \ledr[2]~2_combout\ : std_logic;
SIGNAL \ledr[2]~reg0_q\ : std_logic;
SIGNAL \rx1|Decoder0~5_combout\ : std_logic;
SIGNAL \rx1|datafll[4]~6_combout\ : std_logic;
SIGNAL \rx1|data~4_combout\ : std_logic;
SIGNAL \ledr[3]~3_combout\ : std_logic;
SIGNAL \ledr[3]~reg0_q\ : std_logic;
SIGNAL \rx1|Decoder0~6_combout\ : std_logic;
SIGNAL \rx1|datafll[5]~7_combout\ : std_logic;
SIGNAL \rx1|data~5_combout\ : std_logic;
SIGNAL \ledr[4]~4_combout\ : std_logic;
SIGNAL \ledr[4]~reg0_q\ : std_logic;
SIGNAL \rx1|data~6_combout\ : std_logic;
SIGNAL \ledr[5]~5_combout\ : std_logic;
SIGNAL \ledr[5]~reg0_q\ : std_logic;
SIGNAL \rx1|Decoder0~8_combout\ : std_logic;
SIGNAL \rx1|datafll[7]~9_combout\ : std_logic;
SIGNAL \rx1|data~7_combout\ : std_logic;
SIGNAL \ledr[6]~6_combout\ : std_logic;
SIGNAL \ledr[6]~reg0_q\ : std_logic;
SIGNAL \rx1|Decoder0~9_combout\ : std_logic;
SIGNAL \rx1|datafll[8]~10_combout\ : std_logic;
SIGNAL \rx1|data~8_combout\ : std_logic;
SIGNAL \ledr[7]~7_combout\ : std_logic;
SIGNAL \ledr[7]~reg0_q\ : std_logic;
SIGNAL \c1|count[0]~7_combout\ : std_logic;
SIGNAL \c1|count[2]~11_combout\ : std_logic;
SIGNAL \c1|LessThan0~0_combout\ : std_logic;
SIGNAL \c1|LessThan0~1_combout\ : std_logic;
SIGNAL \c1|count[0]~8\ : std_logic;
SIGNAL \c1|count[1]~10\ : std_logic;
SIGNAL \c1|count[2]~12\ : std_logic;
SIGNAL \c1|count[3]~13_combout\ : std_logic;
SIGNAL \c1|count[3]~14\ : std_logic;
SIGNAL \c1|count[4]~15_combout\ : std_logic;
SIGNAL \c1|count[4]~16\ : std_logic;
SIGNAL \c1|count[5]~17_combout\ : std_logic;
SIGNAL \c1|count[5]~18\ : std_logic;
SIGNAL \c1|count[6]~19_combout\ : std_logic;
SIGNAL \c1|newClock~0_combout\ : std_logic;
SIGNAL \c1|newClock~1_combout\ : std_logic;
SIGNAL \c1|newClock~2_combout\ : std_logic;
SIGNAL \c1|newClock~q\ : std_logic;
SIGNAL \c1|newClock~clkctrl_outclk\ : std_logic;
SIGNAL \tx1|index~0_combout\ : std_logic;
SIGNAL \tx1|index~1_combout\ : std_logic;
SIGNAL \tx1|index~3_combout\ : std_logic;
SIGNAL \tx1|Add0~0_combout\ : std_logic;
SIGNAL \tx1|index~2_combout\ : std_logic;
SIGNAL \tx1|Add0~1_combout\ : std_logic;
SIGNAL \tx1|index~4_combout\ : std_logic;
SIGNAL \tx1|LessThan0~0_combout\ : std_logic;
SIGNAL \tx1|busy~0_combout\ : std_logic;
SIGNAL \botao~input_o\ : std_logic;
SIGNAL \tx_start~combout\ : std_logic;
SIGNAL \tx1|busy~q\ : std_logic;
SIGNAL \tx1|tx_flg~0_combout\ : std_logic;
SIGNAL \tx1|tx_flg~q\ : std_logic;
SIGNAL \tx1|tx_line~1_combout\ : std_logic;
SIGNAL \tx1|tx_line~q\ : std_logic;
SIGNAL \c1|count\ : std_logic_vector(6 DOWNTO 0);
SIGNAL \tx1|index\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \rx1|index\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \rx1|datafll\ : std_logic_vector(9 DOWNTO 0);
SIGNAL \rx1|data\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \rx1|ALT_INV_busy~clkctrl_outclk\ : std_logic;
SIGNAL \ALT_INV_tx_start~combout\ : std_logic;
SIGNAL \tx1|ALT_INV_tx_line~q\ : std_logic;
SIGNAL \rx1|ALT_INV_rx_flg~q\ : std_logic;

BEGIN

ww_clock <= clock;
ww_botao <= botao;
ledr <= ww_ledr;
uart_tx <= ww_uart_tx;
ww_uart_rx <= uart_rx;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\rx1|busy~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \rx1|busy~q\);

\c1|newClock~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \c1|newClock~q\);

\clock~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clock~input_o\);
\rx1|ALT_INV_busy~clkctrl_outclk\ <= NOT \rx1|busy~clkctrl_outclk\;
\ALT_INV_tx_start~combout\ <= NOT \tx_start~combout\;
\tx1|ALT_INV_tx_line~q\ <= NOT \tx1|tx_line~q\;
\rx1|ALT_INV_rx_flg~q\ <= NOT \rx1|rx_flg~q\;

-- Location: FF_X56_Y71_N11
\c1|count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \c1|count[1]~9_combout\,
	sclr => \c1|LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c1|count\(1));

-- Location: LCCOMB_X56_Y71_N10
\c1|count[1]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|count[1]~9_combout\ = (\c1|count\(1) & (!\c1|count[0]~8\)) # (!\c1|count\(1) & ((\c1|count[0]~8\) # (GND)))
-- \c1|count[1]~10\ = CARRY((!\c1|count[0]~8\) # (!\c1|count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c1|count\(1),
	datad => VCC,
	cin => \c1|count[0]~8\,
	combout => \c1|count[1]~9_combout\,
	cout => \c1|count[1]~10\);

-- Location: LCCOMB_X31_Y70_N26
\tx1|tx_line~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|tx_line~0_combout\ = (\tx1|tx_flg~q\ & ((\tx1|index\(2) & (\tx1|index\(1))) # (!\tx1|index\(2) & (!\tx1|index\(1) & \tx1|index\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tx1|index\(2),
	datab => \tx1|index\(1),
	datac => \tx1|tx_flg~q\,
	datad => \tx1|index\(0),
	combout => \tx1|tx_line~0_combout\);

-- Location: FF_X54_Y72_N9
\rx1|datafll[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|datafll[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|datafll\(1));

-- Location: FF_X57_Y72_N31
\rx1|datafll[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|datafll[6]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|datafll\(6));

-- Location: LCCOMB_X54_Y72_N12
\rx1|Decoder0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Decoder0~1_combout\ = (\rx1|index\(0) & (!\rx1|index\(3) & (!\rx1|index\(2) & !\rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(0),
	datab => \rx1|index\(3),
	datac => \rx1|index\(2),
	datad => \rx1|index\(1),
	combout => \rx1|Decoder0~1_combout\);

-- Location: LCCOMB_X54_Y72_N8
\rx1|datafll[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll[1]~2_combout\ = (\rx1|rx_flg~q\ & ((\rx1|Decoder0~1_combout\ & (\uart_rx~input_o\)) # (!\rx1|Decoder0~1_combout\ & ((\rx1|datafll\(1)))))) # (!\rx1|rx_flg~q\ & (((\rx1|datafll\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|rx_flg~q\,
	datab => \uart_rx~input_o\,
	datac => \rx1|datafll\(1),
	datad => \rx1|Decoder0~1_combout\,
	combout => \rx1|datafll[1]~2_combout\);

-- Location: LCCOMB_X55_Y72_N4
\rx1|Add0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Add0~1_combout\ = \rx1|index\(3) $ (((\rx1|index\(2) & (\rx1|index\(0) & \rx1|index\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(2),
	datab => \rx1|index\(0),
	datac => \rx1|index\(1),
	datad => \rx1|index\(3),
	combout => \rx1|Add0~1_combout\);

-- Location: LCCOMB_X57_Y72_N0
\rx1|Decoder0~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Decoder0~7_combout\ = (!\rx1|index\(0) & (!\rx1|index\(3) & (\rx1|index\(2) & \rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(0),
	datab => \rx1|index\(3),
	datac => \rx1|index\(2),
	datad => \rx1|index\(1),
	combout => \rx1|Decoder0~7_combout\);

-- Location: LCCOMB_X57_Y72_N30
\rx1|datafll[6]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll[6]~8_combout\ = (\rx1|rx_flg~q\ & ((\rx1|Decoder0~7_combout\ & (\uart_rx~input_o\)) # (!\rx1|Decoder0~7_combout\ & ((\rx1|datafll\(6)))))) # (!\rx1|rx_flg~q\ & (((\rx1|datafll\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart_rx~input_o\,
	datab => \rx1|rx_flg~q\,
	datac => \rx1|datafll\(6),
	datad => \rx1|Decoder0~7_combout\,
	combout => \rx1|datafll[6]~8_combout\);

-- Location: IOIBUF_X58_Y0_N22
\clock~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

-- Location: CLKCTRL_G18
\clock~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clock~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clock~inputclkctrl_outclk\);

-- Location: IOOBUF_X69_Y73_N16
\ledr[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ledr[0]~reg0_q\,
	devoe => ww_devoe,
	o => \ledr[0]~output_o\);

-- Location: IOOBUF_X94_Y73_N2
\ledr[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ledr[1]~reg0_q\,
	devoe => ww_devoe,
	o => \ledr[1]~output_o\);

-- Location: IOOBUF_X94_Y73_N9
\ledr[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ledr[2]~reg0_q\,
	devoe => ww_devoe,
	o => \ledr[2]~output_o\);

-- Location: IOOBUF_X107_Y73_N16
\ledr[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ledr[3]~reg0_q\,
	devoe => ww_devoe,
	o => \ledr[3]~output_o\);

-- Location: IOOBUF_X87_Y73_N16
\ledr[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ledr[4]~reg0_q\,
	devoe => ww_devoe,
	o => \ledr[4]~output_o\);

-- Location: IOOBUF_X87_Y73_N9
\ledr[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ledr[5]~reg0_q\,
	devoe => ww_devoe,
	o => \ledr[5]~output_o\);

-- Location: IOOBUF_X72_Y73_N9
\ledr[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ledr[6]~reg0_q\,
	devoe => ww_devoe,
	o => \ledr[6]~output_o\);

-- Location: IOOBUF_X72_Y73_N2
\ledr[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ledr[7]~reg0_q\,
	devoe => ww_devoe,
	o => \ledr[7]~output_o\);

-- Location: IOOBUF_X69_Y73_N2
\ledr[8]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ledr[8]~output_o\);

-- Location: IOOBUF_X83_Y73_N23
\ledr[9]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ledr[9]~output_o\);

-- Location: IOOBUF_X23_Y73_N23
\uart_tx~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \tx1|ALT_INV_tx_line~q\,
	devoe => ww_devoe,
	o => \uart_tx~output_o\);

-- Location: IOIBUF_X49_Y73_N15
\uart_rx~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_uart_rx,
	o => \uart_rx~input_o\);

-- Location: LCCOMB_X54_Y72_N2
\rx1|index[0]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|index[0]~4_combout\ = (\rx1|rx_flg~q\ & (!\rx1|index[0]~1_combout\ & (!\rx1|LessThan0~0_combout\))) # (!\rx1|rx_flg~q\ & (((\uart_rx~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011011100000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index[0]~1_combout\,
	datab => \rx1|rx_flg~q\,
	datac => \rx1|LessThan0~0_combout\,
	datad => \uart_rx~input_o\,
	combout => \rx1|index[0]~4_combout\);

-- Location: LCCOMB_X54_Y72_N16
\rx1|index[1]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|index[1]~6_combout\ = (\rx1|index\(1) & ((\rx1|index[0]~4_combout\) # ((!\rx1|index\(0) & \rx1|index[1]~5_combout\)))) # (!\rx1|index\(1) & (\rx1|index\(0) & (\rx1|index[1]~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(0),
	datab => \rx1|index[1]~5_combout\,
	datac => \rx1|index\(1),
	datad => \rx1|index[0]~4_combout\,
	combout => \rx1|index[1]~6_combout\);

-- Location: FF_X54_Y72_N17
\rx1|index[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|index[1]~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|index\(1));

-- Location: LCCOMB_X55_Y72_N20
\rx1|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|LessThan0~0_combout\ = ((!\rx1|index\(2) & (!\rx1|index\(0) & !\rx1|index\(1)))) # (!\rx1|index\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(2),
	datab => \rx1|index\(0),
	datac => \rx1|index\(1),
	datad => \rx1|index\(3),
	combout => \rx1|LessThan0~0_combout\);

-- Location: LCCOMB_X54_Y72_N0
\rx1|index[1]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|index[1]~5_combout\ = (\rx1|rx_flg~q\ & \rx1|LessThan0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|rx_flg~q\,
	datac => \rx1|LessThan0~0_combout\,
	combout => \rx1|index[1]~5_combout\);

-- Location: LCCOMB_X54_Y72_N20
\rx1|index[3]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|index[3]~9_combout\ = (\rx1|Add0~1_combout\ & ((\rx1|index[1]~5_combout\) # ((\rx1|index\(3) & \rx1|index[0]~4_combout\)))) # (!\rx1|Add0~1_combout\ & (((\rx1|index\(3) & \rx1|index[0]~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|Add0~1_combout\,
	datab => \rx1|index[1]~5_combout\,
	datac => \rx1|index\(3),
	datad => \rx1|index[0]~4_combout\,
	combout => \rx1|index[3]~9_combout\);

-- Location: FF_X54_Y72_N21
\rx1|index[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|index[3]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|index\(3));

-- Location: LCCOMB_X55_Y72_N22
\rx1|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Add0~0_combout\ = \rx1|index\(2) $ (((\rx1|index\(0) & \rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \rx1|index\(0),
	datac => \rx1|index\(1),
	datad => \rx1|index\(2),
	combout => \rx1|Add0~0_combout\);

-- Location: LCCOMB_X54_Y72_N18
\rx1|index[2]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|index[2]~7_combout\ = (\rx1|LessThan0~0_combout\ & ((\rx1|Add0~0_combout\))) # (!\rx1|LessThan0~0_combout\ & (\rx1|index[0]~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index[0]~1_combout\,
	datac => \rx1|LessThan0~0_combout\,
	datad => \rx1|Add0~0_combout\,
	combout => \rx1|index[2]~7_combout\);

-- Location: LCCOMB_X54_Y72_N14
\rx1|index[2]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|index[2]~8_combout\ = (\rx1|index[0]~4_combout\ & (((\rx1|index\(2))))) # (!\rx1|index[0]~4_combout\ & (\rx1|rx_flg~q\ & ((\rx1|index[2]~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|rx_flg~q\,
	datab => \rx1|index[0]~4_combout\,
	datac => \rx1|index\(2),
	datad => \rx1|index[2]~7_combout\,
	combout => \rx1|index[2]~8_combout\);

-- Location: FF_X54_Y72_N15
\rx1|index[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|index[2]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|index\(2));

-- Location: LCCOMB_X54_Y72_N10
\rx1|Decoder0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Decoder0~0_combout\ = (\rx1|index\(0) & (\rx1|index\(3) & (!\rx1|index\(2) & !\rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(0),
	datab => \rx1|index\(3),
	datac => \rx1|index\(2),
	datad => \rx1|index\(1),
	combout => \rx1|Decoder0~0_combout\);

-- Location: LCCOMB_X54_Y72_N22
\rx1|datafll[9]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll[9]~1_combout\ = (\rx1|rx_flg~q\ & ((\rx1|Decoder0~0_combout\ & (\uart_rx~input_o\)) # (!\rx1|Decoder0~0_combout\ & ((\rx1|datafll\(9)))))) # (!\rx1|rx_flg~q\ & (((\rx1|datafll\(9)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|rx_flg~q\,
	datab => \uart_rx~input_o\,
	datac => \rx1|datafll\(9),
	datad => \rx1|Decoder0~0_combout\,
	combout => \rx1|datafll[9]~1_combout\);

-- Location: FF_X54_Y72_N23
\rx1|datafll[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|datafll[9]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|datafll\(9));

-- Location: LCCOMB_X55_Y72_N16
\rx1|Decoder0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Decoder0~2_combout\ = (!\rx1|index\(3) & (!\rx1|index\(0) & (!\rx1|index\(1) & !\rx1|index\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(3),
	datab => \rx1|index\(0),
	datac => \rx1|index\(1),
	datad => \rx1|index\(2),
	combout => \rx1|Decoder0~2_combout\);

-- Location: LCCOMB_X54_Y72_N24
\rx1|datafll[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll[0]~0_combout\ = (\rx1|Decoder0~2_combout\ & (\uart_rx~input_o\)) # (!\rx1|Decoder0~2_combout\ & ((\rx1|datafll\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \uart_rx~input_o\,
	datac => \rx1|datafll\(0),
	datad => \rx1|Decoder0~2_combout\,
	combout => \rx1|datafll[0]~0_combout\);

-- Location: LCCOMB_X55_Y72_N30
\rx1|datafll~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll~3_combout\ = (\uart_rx~input_o\ & \rx1|datafll\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \uart_rx~input_o\,
	datad => \rx1|datafll\(0),
	combout => \rx1|datafll~3_combout\);

-- Location: FF_X54_Y72_N25
\rx1|datafll[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|datafll[0]~0_combout\,
	asdata => \rx1|datafll~3_combout\,
	sload => \rx1|ALT_INV_rx_flg~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|datafll\(0));

-- Location: LCCOMB_X54_Y72_N30
\rx1|index[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|index[0]~1_combout\ = (\rx1|recebido~q\ & (\rx1|datafll\(9) & !\rx1|datafll\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|recebido~q\,
	datac => \rx1|datafll\(9),
	datad => \rx1|datafll\(0),
	combout => \rx1|index[0]~1_combout\);

-- Location: LCCOMB_X54_Y72_N28
\rx1|index[0]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|index[0]~2_combout\ = (\rx1|index\(0) & (!\rx1|index[0]~1_combout\ & ((\rx1|rx_flg~q\) # (\uart_rx~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|rx_flg~q\,
	datab => \rx1|index\(0),
	datac => \rx1|index[0]~1_combout\,
	datad => \uart_rx~input_o\,
	combout => \rx1|index[0]~2_combout\);

-- Location: LCCOMB_X54_Y72_N4
\rx1|index[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|index[0]~0_combout\ = (\rx1|LessThan0~0_combout\ & (!\rx1|index\(0))) # (!\rx1|LessThan0~0_combout\ & ((\rx1|index[0]~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|LessThan0~0_combout\,
	datac => \rx1|index\(0),
	datad => \rx1|index[0]~2_combout\,
	combout => \rx1|index[0]~0_combout\);

-- Location: LCCOMB_X55_Y72_N8
\rx1|index[0]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|index[0]~3_combout\ = (\rx1|index\(0)) # (!\uart_rx~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010111110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart_rx~input_o\,
	datac => \rx1|index\(0),
	combout => \rx1|index[0]~3_combout\);

-- Location: FF_X54_Y72_N5
\rx1|index[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|index[0]~0_combout\,
	asdata => \rx1|index[0]~3_combout\,
	sload => \rx1|ALT_INV_rx_flg~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|index\(0));

-- Location: LCCOMB_X55_Y72_N26
\rx1|recebido~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|recebido~0_combout\ = (!\rx1|index\(2) & (\rx1|index\(0) & (!\rx1|index\(1) & \rx1|index\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(2),
	datab => \rx1|index\(0),
	datac => \rx1|index\(1),
	datad => \rx1|index\(3),
	combout => \rx1|recebido~0_combout\);

-- Location: LCCOMB_X54_Y72_N6
\rx1|recebido~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|recebido~1_combout\ = (\rx1|rx_flg~q\ & (((\rx1|recebido~q\) # (\rx1|recebido~0_combout\)))) # (!\rx1|rx_flg~q\ & (\uart_rx~input_o\ & (\rx1|recebido~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|rx_flg~q\,
	datab => \uart_rx~input_o\,
	datac => \rx1|recebido~q\,
	datad => \rx1|recebido~0_combout\,
	combout => \rx1|recebido~1_combout\);

-- Location: FF_X54_Y72_N7
\rx1|recebido\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|recebido~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|recebido~q\);

-- Location: LCCOMB_X54_Y72_N26
\rx1|data[0]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|data[0]~9_combout\ = (\rx1|LessThan0~0_combout\) # (!\rx1|recebido~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|LessThan0~0_combout\,
	datad => \rx1|recebido~q\,
	combout => \rx1|data[0]~9_combout\);

-- Location: LCCOMB_X53_Y72_N16
\uart_rx~_wirecell\ : cycloneive_lcell_comb
-- Equation(s):
-- \uart_rx~_wirecell_combout\ = !\uart_rx~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \uart_rx~input_o\,
	combout => \uart_rx~_wirecell_combout\);

-- Location: FF_X54_Y72_N27
\rx1|rx_flg\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|data[0]~9_combout\,
	asdata => \uart_rx~_wirecell_combout\,
	sload => \rx1|ALT_INV_rx_flg~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|rx_flg~q\);

-- Location: LCCOMB_X55_Y72_N6
\rx1|data[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|data[0]~1_combout\ = (\rx1|recebido~q\ & (\rx1|rx_flg~q\ & !\rx1|LessThan0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \rx1|recebido~q\,
	datac => \rx1|rx_flg~q\,
	datad => \rx1|LessThan0~0_combout\,
	combout => \rx1|data[0]~1_combout\);

-- Location: LCCOMB_X57_Y72_N2
\rx1|busy~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|busy~2_combout\ = (!\rx1|data[0]~1_combout\ & ((\rx1|busy~q\) # ((!\uart_rx~input_o\ & !\rx1|rx_flg~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart_rx~input_o\,
	datab => \rx1|rx_flg~q\,
	datac => \rx1|busy~q\,
	datad => \rx1|data[0]~1_combout\,
	combout => \rx1|busy~2_combout\);

-- Location: LCCOMB_X57_Y72_N22
\rx1|busy~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|busy~feeder_combout\ = \rx1|busy~2_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \rx1|busy~2_combout\,
	combout => \rx1|busy~feeder_combout\);

-- Location: FF_X57_Y72_N23
\rx1|busy\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|busy~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|busy~q\);

-- Location: CLKCTRL_G12
\rx1|busy~clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \rx1|busy~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \rx1|busy~clkctrl_outclk\);

-- Location: LCCOMB_X55_Y72_N28
\rx1|data~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|data~0_combout\ = (\rx1|datafll\(1) & (\rx1|datafll\(9) & !\rx1|datafll\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|datafll\(1),
	datab => \rx1|datafll\(9),
	datad => \rx1|datafll\(0),
	combout => \rx1|data~0_combout\);

-- Location: FF_X55_Y72_N29
\rx1|data[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|data~0_combout\,
	ena => \rx1|data[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|data\(0));

-- Location: LCCOMB_X55_Y72_N24
\ledr[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ledr[0]~0_combout\ = !\rx1|data\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \rx1|data\(0),
	combout => \ledr[0]~0_combout\);

-- Location: FF_X55_Y72_N25
\ledr[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rx1|ALT_INV_busy~clkctrl_outclk\,
	d => \ledr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ledr[0]~reg0_q\);

-- Location: LCCOMB_X57_Y72_N16
\rx1|Decoder0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Decoder0~3_combout\ = (!\rx1|index\(0) & (!\rx1|index\(3) & (!\rx1|index\(2) & \rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(0),
	datab => \rx1|index\(3),
	datac => \rx1|index\(2),
	datad => \rx1|index\(1),
	combout => \rx1|Decoder0~3_combout\);

-- Location: LCCOMB_X57_Y72_N6
\rx1|datafll[2]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll[2]~4_combout\ = (\rx1|rx_flg~q\ & ((\rx1|Decoder0~3_combout\ & (\uart_rx~input_o\)) # (!\rx1|Decoder0~3_combout\ & ((\rx1|datafll\(2)))))) # (!\rx1|rx_flg~q\ & (((\rx1|datafll\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart_rx~input_o\,
	datab => \rx1|rx_flg~q\,
	datac => \rx1|datafll\(2),
	datad => \rx1|Decoder0~3_combout\,
	combout => \rx1|datafll[2]~4_combout\);

-- Location: FF_X57_Y72_N7
\rx1|datafll[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|datafll[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|datafll\(2));

-- Location: LCCOMB_X55_Y72_N18
\rx1|data~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|data~2_combout\ = (!\rx1|datafll\(0) & (\rx1|datafll\(2) & \rx1|datafll\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \rx1|datafll\(0),
	datac => \rx1|datafll\(2),
	datad => \rx1|datafll\(9),
	combout => \rx1|data~2_combout\);

-- Location: FF_X55_Y72_N19
\rx1|data[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|data~2_combout\,
	ena => \rx1|data[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|data\(1));

-- Location: LCCOMB_X55_Y72_N2
\ledr[1]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ledr[1]~1_combout\ = !\rx1|data\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \rx1|data\(1),
	combout => \ledr[1]~1_combout\);

-- Location: FF_X55_Y72_N3
\ledr[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rx1|ALT_INV_busy~clkctrl_outclk\,
	d => \ledr[1]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ledr[1]~reg0_q\);

-- Location: LCCOMB_X57_Y72_N20
\rx1|Decoder0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Decoder0~4_combout\ = (\rx1|index\(0) & (!\rx1|index\(3) & (!\rx1|index\(2) & \rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(0),
	datab => \rx1|index\(3),
	datac => \rx1|index\(2),
	datad => \rx1|index\(1),
	combout => \rx1|Decoder0~4_combout\);

-- Location: LCCOMB_X57_Y72_N8
\rx1|datafll[3]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll[3]~5_combout\ = (\rx1|rx_flg~q\ & ((\rx1|Decoder0~4_combout\ & (\uart_rx~input_o\)) # (!\rx1|Decoder0~4_combout\ & ((\rx1|datafll\(3)))))) # (!\rx1|rx_flg~q\ & (((\rx1|datafll\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart_rx~input_o\,
	datab => \rx1|rx_flg~q\,
	datac => \rx1|datafll\(3),
	datad => \rx1|Decoder0~4_combout\,
	combout => \rx1|datafll[3]~5_combout\);

-- Location: FF_X57_Y72_N9
\rx1|datafll[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|datafll[3]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|datafll\(3));

-- Location: LCCOMB_X55_Y72_N12
\rx1|data~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|data~3_combout\ = (\rx1|datafll\(9) & (\rx1|datafll\(3) & !\rx1|datafll\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \rx1|datafll\(9),
	datac => \rx1|datafll\(3),
	datad => \rx1|datafll\(0),
	combout => \rx1|data~3_combout\);

-- Location: FF_X55_Y72_N13
\rx1|data[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|data~3_combout\,
	ena => \rx1|data[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|data\(2));

-- Location: LCCOMB_X55_Y72_N0
\ledr[2]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \ledr[2]~2_combout\ = !\rx1|data\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \rx1|data\(2),
	combout => \ledr[2]~2_combout\);

-- Location: FF_X55_Y72_N1
\ledr[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rx1|ALT_INV_busy~clkctrl_outclk\,
	d => \ledr[2]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ledr[2]~reg0_q\);

-- Location: LCCOMB_X57_Y72_N12
\rx1|Decoder0~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Decoder0~5_combout\ = (!\rx1|index\(0) & (!\rx1|index\(3) & (\rx1|index\(2) & !\rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(0),
	datab => \rx1|index\(3),
	datac => \rx1|index\(2),
	datad => \rx1|index\(1),
	combout => \rx1|Decoder0~5_combout\);

-- Location: LCCOMB_X57_Y72_N14
\rx1|datafll[4]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll[4]~6_combout\ = (\rx1|rx_flg~q\ & ((\rx1|Decoder0~5_combout\ & (\uart_rx~input_o\)) # (!\rx1|Decoder0~5_combout\ & ((\rx1|datafll\(4)))))) # (!\rx1|rx_flg~q\ & (((\rx1|datafll\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart_rx~input_o\,
	datab => \rx1|rx_flg~q\,
	datac => \rx1|datafll\(4),
	datad => \rx1|Decoder0~5_combout\,
	combout => \rx1|datafll[4]~6_combout\);

-- Location: FF_X57_Y72_N15
\rx1|datafll[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|datafll[4]~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|datafll\(4));

-- Location: LCCOMB_X55_Y72_N10
\rx1|data~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|data~4_combout\ = (\rx1|datafll\(9) & (\rx1|datafll\(4) & !\rx1|datafll\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \rx1|datafll\(9),
	datac => \rx1|datafll\(4),
	datad => \rx1|datafll\(0),
	combout => \rx1|data~4_combout\);

-- Location: FF_X55_Y72_N11
\rx1|data[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|data~4_combout\,
	ena => \rx1|data[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|data\(3));

-- Location: LCCOMB_X55_Y72_N14
\ledr[3]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \ledr[3]~3_combout\ = !\rx1|data\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \rx1|data\(3),
	combout => \ledr[3]~3_combout\);

-- Location: FF_X55_Y72_N15
\ledr[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rx1|ALT_INV_busy~clkctrl_outclk\,
	d => \ledr[3]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ledr[3]~reg0_q\);

-- Location: LCCOMB_X57_Y72_N28
\rx1|Decoder0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Decoder0~6_combout\ = (\rx1|index\(0) & (!\rx1|index\(3) & (\rx1|index\(2) & !\rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(0),
	datab => \rx1|index\(3),
	datac => \rx1|index\(2),
	datad => \rx1|index\(1),
	combout => \rx1|Decoder0~6_combout\);

-- Location: LCCOMB_X57_Y72_N18
\rx1|datafll[5]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll[5]~7_combout\ = (\rx1|rx_flg~q\ & ((\rx1|Decoder0~6_combout\ & (\uart_rx~input_o\)) # (!\rx1|Decoder0~6_combout\ & ((\rx1|datafll\(5)))))) # (!\rx1|rx_flg~q\ & (((\rx1|datafll\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart_rx~input_o\,
	datab => \rx1|rx_flg~q\,
	datac => \rx1|datafll\(5),
	datad => \rx1|Decoder0~6_combout\,
	combout => \rx1|datafll[5]~7_combout\);

-- Location: FF_X57_Y72_N19
\rx1|datafll[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|datafll[5]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|datafll\(5));

-- Location: LCCOMB_X56_Y72_N12
\rx1|data~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|data~5_combout\ = (!\rx1|datafll\(0) & (\rx1|datafll\(9) & \rx1|datafll\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \rx1|datafll\(0),
	datac => \rx1|datafll\(9),
	datad => \rx1|datafll\(5),
	combout => \rx1|data~5_combout\);

-- Location: FF_X56_Y72_N13
\rx1|data[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|data~5_combout\,
	ena => \rx1|data[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|data\(4));

-- Location: LCCOMB_X56_Y72_N20
\ledr[4]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \ledr[4]~4_combout\ = !\rx1|data\(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \rx1|data\(4),
	combout => \ledr[4]~4_combout\);

-- Location: FF_X56_Y72_N21
\ledr[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rx1|ALT_INV_busy~clkctrl_outclk\,
	d => \ledr[4]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ledr[4]~reg0_q\);

-- Location: LCCOMB_X56_Y72_N18
\rx1|data~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|data~6_combout\ = (\rx1|datafll\(6) & (\rx1|datafll\(9) & !\rx1|datafll\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|datafll\(6),
	datac => \rx1|datafll\(9),
	datad => \rx1|datafll\(0),
	combout => \rx1|data~6_combout\);

-- Location: FF_X56_Y72_N19
\rx1|data[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|data~6_combout\,
	ena => \rx1|data[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|data\(5));

-- Location: LCCOMB_X56_Y72_N2
\ledr[5]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \ledr[5]~5_combout\ = !\rx1|data\(5)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \rx1|data\(5),
	combout => \ledr[5]~5_combout\);

-- Location: FF_X56_Y72_N3
\ledr[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rx1|ALT_INV_busy~clkctrl_outclk\,
	d => \ledr[5]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ledr[5]~reg0_q\);

-- Location: LCCOMB_X57_Y72_N24
\rx1|Decoder0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Decoder0~8_combout\ = (\rx1|index\(0) & (!\rx1|index\(3) & (\rx1|index\(2) & \rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(0),
	datab => \rx1|index\(3),
	datac => \rx1|index\(2),
	datad => \rx1|index\(1),
	combout => \rx1|Decoder0~8_combout\);

-- Location: LCCOMB_X57_Y72_N26
\rx1|datafll[7]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll[7]~9_combout\ = (\rx1|rx_flg~q\ & ((\rx1|Decoder0~8_combout\ & (\uart_rx~input_o\)) # (!\rx1|Decoder0~8_combout\ & ((\rx1|datafll\(7)))))) # (!\rx1|rx_flg~q\ & (((\rx1|datafll\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart_rx~input_o\,
	datab => \rx1|rx_flg~q\,
	datac => \rx1|datafll\(7),
	datad => \rx1|Decoder0~8_combout\,
	combout => \rx1|datafll[7]~9_combout\);

-- Location: FF_X57_Y72_N27
\rx1|datafll[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|datafll[7]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|datafll\(7));

-- Location: LCCOMB_X56_Y72_N0
\rx1|data~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|data~7_combout\ = (!\rx1|datafll\(0) & (\rx1|datafll\(9) & \rx1|datafll\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \rx1|datafll\(0),
	datac => \rx1|datafll\(9),
	datad => \rx1|datafll\(7),
	combout => \rx1|data~7_combout\);

-- Location: FF_X56_Y72_N1
\rx1|data[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|data~7_combout\,
	ena => \rx1|data[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|data\(6));

-- Location: LCCOMB_X56_Y72_N24
\ledr[6]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \ledr[6]~6_combout\ = !\rx1|data\(6)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \rx1|data\(6),
	combout => \ledr[6]~6_combout\);

-- Location: FF_X56_Y72_N25
\ledr[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rx1|ALT_INV_busy~clkctrl_outclk\,
	d => \ledr[6]~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ledr[6]~reg0_q\);

-- Location: LCCOMB_X57_Y72_N10
\rx1|Decoder0~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|Decoder0~9_combout\ = (!\rx1|index\(0) & (\rx1|index\(3) & (!\rx1|index\(2) & !\rx1|index\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rx1|index\(0),
	datab => \rx1|index\(3),
	datac => \rx1|index\(2),
	datad => \rx1|index\(1),
	combout => \rx1|Decoder0~9_combout\);

-- Location: LCCOMB_X57_Y72_N4
\rx1|datafll[8]~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|datafll[8]~10_combout\ = (\rx1|rx_flg~q\ & ((\rx1|Decoder0~9_combout\ & (\uart_rx~input_o\)) # (!\rx1|Decoder0~9_combout\ & ((\rx1|datafll\(8)))))) # (!\rx1|rx_flg~q\ & (((\rx1|datafll\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \uart_rx~input_o\,
	datab => \rx1|rx_flg~q\,
	datac => \rx1|datafll\(8),
	datad => \rx1|Decoder0~9_combout\,
	combout => \rx1|datafll[8]~10_combout\);

-- Location: FF_X57_Y72_N5
\rx1|datafll[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|datafll[8]~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|datafll\(8));

-- Location: LCCOMB_X56_Y72_N10
\rx1|data~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \rx1|data~8_combout\ = (!\rx1|datafll\(0) & (\rx1|datafll\(9) & \rx1|datafll\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \rx1|datafll\(0),
	datac => \rx1|datafll\(9),
	datad => \rx1|datafll\(8),
	combout => \rx1|data~8_combout\);

-- Location: FF_X56_Y72_N11
\rx1|data[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \rx1|data~8_combout\,
	ena => \rx1|data[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rx1|data\(7));

-- Location: LCCOMB_X56_Y72_N22
\ledr[7]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \ledr[7]~7_combout\ = !\rx1|data\(7)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \rx1|data\(7),
	combout => \ledr[7]~7_combout\);

-- Location: FF_X56_Y72_N23
\ledr[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rx1|ALT_INV_busy~clkctrl_outclk\,
	d => \ledr[7]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ledr[7]~reg0_q\);

-- Location: LCCOMB_X56_Y71_N8
\c1|count[0]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|count[0]~7_combout\ = \c1|count\(0) $ (VCC)
-- \c1|count[0]~8\ = CARRY(\c1|count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \c1|count\(0),
	datad => VCC,
	combout => \c1|count[0]~7_combout\,
	cout => \c1|count[0]~8\);

-- Location: LCCOMB_X56_Y71_N12
\c1|count[2]~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|count[2]~11_combout\ = (\c1|count\(2) & (\c1|count[1]~10\ $ (GND))) # (!\c1|count\(2) & (!\c1|count[1]~10\ & VCC))
-- \c1|count[2]~12\ = CARRY((\c1|count\(2) & !\c1|count[1]~10\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c1|count\(2),
	datad => VCC,
	cin => \c1|count[1]~10\,
	combout => \c1|count[2]~11_combout\,
	cout => \c1|count[2]~12\);

-- Location: FF_X56_Y71_N13
\c1|count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \c1|count[2]~11_combout\,
	sclr => \c1|LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c1|count\(2));

-- Location: LCCOMB_X56_Y71_N24
\c1|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|LessThan0~0_combout\ = (!\c1|count\(5) & (!\c1|count\(3) & ((!\c1|count\(2)) # (!\c1|count\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c1|count\(1),
	datab => \c1|count\(5),
	datac => \c1|count\(3),
	datad => \c1|count\(2),
	combout => \c1|LessThan0~0_combout\);

-- Location: LCCOMB_X56_Y71_N30
\c1|LessThan0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|LessThan0~1_combout\ = (\c1|count\(6) & (!\c1|LessThan0~0_combout\ & ((\c1|count\(5)) # (\c1|count\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c1|count\(5),
	datab => \c1|count\(4),
	datac => \c1|count\(6),
	datad => \c1|LessThan0~0_combout\,
	combout => \c1|LessThan0~1_combout\);

-- Location: FF_X56_Y71_N9
\c1|count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \c1|count[0]~7_combout\,
	sclr => \c1|LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c1|count\(0));

-- Location: LCCOMB_X56_Y71_N14
\c1|count[3]~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|count[3]~13_combout\ = (\c1|count\(3) & (!\c1|count[2]~12\)) # (!\c1|count\(3) & ((\c1|count[2]~12\) # (GND)))
-- \c1|count[3]~14\ = CARRY((!\c1|count[2]~12\) # (!\c1|count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c1|count\(3),
	datad => VCC,
	cin => \c1|count[2]~12\,
	combout => \c1|count[3]~13_combout\,
	cout => \c1|count[3]~14\);

-- Location: FF_X56_Y71_N15
\c1|count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \c1|count[3]~13_combout\,
	sclr => \c1|LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c1|count\(3));

-- Location: LCCOMB_X56_Y71_N16
\c1|count[4]~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|count[4]~15_combout\ = (\c1|count\(4) & (\c1|count[3]~14\ $ (GND))) # (!\c1|count\(4) & (!\c1|count[3]~14\ & VCC))
-- \c1|count[4]~16\ = CARRY((\c1|count\(4) & !\c1|count[3]~14\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c1|count\(4),
	datad => VCC,
	cin => \c1|count[3]~14\,
	combout => \c1|count[4]~15_combout\,
	cout => \c1|count[4]~16\);

-- Location: FF_X56_Y71_N17
\c1|count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \c1|count[4]~15_combout\,
	sclr => \c1|LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c1|count\(4));

-- Location: LCCOMB_X56_Y71_N18
\c1|count[5]~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|count[5]~17_combout\ = (\c1|count\(5) & (!\c1|count[4]~16\)) # (!\c1|count\(5) & ((\c1|count[4]~16\) # (GND)))
-- \c1|count[5]~18\ = CARRY((!\c1|count[4]~16\) # (!\c1|count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c1|count\(5),
	datad => VCC,
	cin => \c1|count[4]~16\,
	combout => \c1|count[5]~17_combout\,
	cout => \c1|count[5]~18\);

-- Location: FF_X56_Y71_N19
\c1|count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \c1|count[5]~17_combout\,
	sclr => \c1|LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c1|count\(5));

-- Location: LCCOMB_X56_Y71_N20
\c1|count[6]~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|count[6]~19_combout\ = \c1|count\(6) $ (!\c1|count[5]~18\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c1|count\(6),
	cin => \c1|count[5]~18\,
	combout => \c1|count[6]~19_combout\);

-- Location: FF_X56_Y71_N21
\c1|count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \c1|count[6]~19_combout\,
	sclr => \c1|LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c1|count\(6));

-- Location: LCCOMB_X56_Y71_N26
\c1|newClock~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|newClock~0_combout\ = ((!\c1|count\(2) & ((!\c1|count\(0)) # (!\c1|count\(1))))) # (!\c1|count\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c1|count\(1),
	datab => \c1|count\(0),
	datac => \c1|count\(3),
	datad => \c1|count\(2),
	combout => \c1|newClock~0_combout\);

-- Location: LCCOMB_X56_Y71_N28
\c1|newClock~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|newClock~1_combout\ = (!\c1|count\(6) & (\c1|newClock~0_combout\ & !\c1|count\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c1|count\(6),
	datac => \c1|newClock~0_combout\,
	datad => \c1|count\(4),
	combout => \c1|newClock~1_combout\);

-- Location: LCCOMB_X56_Y71_N2
\c1|newClock~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \c1|newClock~2_combout\ = (!\c1|LessThan0~1_combout\ & (!\c1|newClock~1_combout\ & ((\c1|count\(5)) # (\c1|count\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c1|count\(5),
	datab => \c1|count\(6),
	datac => \c1|LessThan0~1_combout\,
	datad => \c1|newClock~1_combout\,
	combout => \c1|newClock~2_combout\);

-- Location: FF_X56_Y71_N3
\c1|newClock\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \c1|newClock~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c1|newClock~q\);

-- Location: CLKCTRL_G13
\c1|newClock~clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \c1|newClock~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \c1|newClock~clkctrl_outclk\);

-- Location: LCCOMB_X31_Y70_N20
\tx1|index~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|index~0_combout\ = (\tx1|tx_flg~q\ & (\tx1|LessThan0~0_combout\ & (\tx1|index\(0) $ (\tx1|index\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tx1|index\(0),
	datab => \tx1|tx_flg~q\,
	datac => \tx1|index\(1),
	datad => \tx1|LessThan0~0_combout\,
	combout => \tx1|index~0_combout\);

-- Location: LCCOMB_X31_Y70_N8
\tx1|index~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|index~1_combout\ = (\tx1|tx_flg~q\) # ((!\botao~input_o\ & !\tx1|busy~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \botao~input_o\,
	datac => \tx1|tx_flg~q\,
	datad => \tx1|busy~q\,
	combout => \tx1|index~1_combout\);

-- Location: FF_X31_Y70_N21
\tx1|index[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \tx1|index~0_combout\,
	ena => \tx1|index~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tx1|index\(1));

-- Location: LCCOMB_X31_Y70_N12
\tx1|index~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|index~3_combout\ = (\tx1|tx_flg~q\ & (!\tx1|index\(0) & \tx1|LessThan0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tx1|tx_flg~q\,
	datac => \tx1|index\(0),
	datad => \tx1|LessThan0~0_combout\,
	combout => \tx1|index~3_combout\);

-- Location: FF_X31_Y70_N13
\tx1|index[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \tx1|index~3_combout\,
	ena => \tx1|index~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tx1|index\(0));

-- Location: LCCOMB_X31_Y70_N22
\tx1|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|Add0~0_combout\ = \tx1|index\(2) $ (((\tx1|index\(1) & \tx1|index\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tx1|index\(1),
	datac => \tx1|index\(2),
	datad => \tx1|index\(0),
	combout => \tx1|Add0~0_combout\);

-- Location: LCCOMB_X31_Y70_N30
\tx1|index~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|index~2_combout\ = (\tx1|tx_flg~q\ & (\tx1|Add0~0_combout\ & \tx1|LessThan0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tx1|tx_flg~q\,
	datac => \tx1|Add0~0_combout\,
	datad => \tx1|LessThan0~0_combout\,
	combout => \tx1|index~2_combout\);

-- Location: FF_X31_Y70_N31
\tx1|index[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \tx1|index~2_combout\,
	ena => \tx1|index~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tx1|index\(2));

-- Location: LCCOMB_X31_Y70_N24
\tx1|Add0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|Add0~1_combout\ = \tx1|index\(3) $ (((\tx1|index\(0) & (\tx1|index\(1) & \tx1|index\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tx1|index\(0),
	datab => \tx1|index\(1),
	datac => \tx1|index\(2),
	datad => \tx1|index\(3),
	combout => \tx1|Add0~1_combout\);

-- Location: LCCOMB_X31_Y70_N16
\tx1|index~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|index~4_combout\ = (\tx1|tx_flg~q\ & (\tx1|Add0~1_combout\ & \tx1|LessThan0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tx1|tx_flg~q\,
	datac => \tx1|Add0~1_combout\,
	datad => \tx1|LessThan0~0_combout\,
	combout => \tx1|index~4_combout\);

-- Location: FF_X31_Y70_N17
\tx1|index[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \tx1|index~4_combout\,
	ena => \tx1|index~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tx1|index\(3));

-- Location: LCCOMB_X31_Y70_N18
\tx1|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|LessThan0~0_combout\ = ((!\tx1|index\(0) & (!\tx1|index\(1) & !\tx1|index\(2)))) # (!\tx1|index\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tx1|index\(0),
	datab => \tx1|index\(1),
	datac => \tx1|index\(2),
	datad => \tx1|index\(3),
	combout => \tx1|LessThan0~0_combout\);

-- Location: LCCOMB_X31_Y70_N28
\tx1|busy~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|busy~0_combout\ = ((\tx1|busy~q\ & \tx1|LessThan0~0_combout\)) # (!\tx1|tx_flg~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001100110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tx1|tx_flg~q\,
	datac => \tx1|busy~q\,
	datad => \tx1|LessThan0~0_combout\,
	combout => \tx1|busy~0_combout\);

-- Location: IOIBUF_X115_Y40_N8
\botao~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_botao,
	o => \botao~input_o\);

-- Location: LCCOMB_X31_Y70_N14
tx_start : cycloneive_lcell_comb
-- Equation(s):
-- \tx_start~combout\ = (\botao~input_o\) # (\tx1|busy~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \botao~input_o\,
	datad => \tx1|busy~q\,
	combout => \tx_start~combout\);

-- Location: FF_X31_Y70_N29
\tx1|busy\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \tx1|busy~0_combout\,
	clrn => \ALT_INV_tx_start~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tx1|busy~q\);

-- Location: LCCOMB_X31_Y70_N6
\tx1|tx_flg~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|tx_flg~0_combout\ = (\tx1|tx_flg~q\ & (((\tx1|LessThan0~0_combout\)))) # (!\tx1|tx_flg~q\ & (!\botao~input_o\ & (!\tx1|busy~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000100000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \botao~input_o\,
	datab => \tx1|busy~q\,
	datac => \tx1|tx_flg~q\,
	datad => \tx1|LessThan0~0_combout\,
	combout => \tx1|tx_flg~0_combout\);

-- Location: FF_X31_Y70_N7
\tx1|tx_flg\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \tx1|tx_flg~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tx1|tx_flg~q\);

-- Location: LCCOMB_X31_Y70_N0
\tx1|tx_line~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \tx1|tx_line~1_combout\ = (!\tx1|tx_line~0_combout\ & ((\tx1|tx_flg~q\ & ((\tx1|LessThan0~0_combout\))) # (!\tx1|tx_flg~q\ & (\tx1|tx_line~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tx1|tx_line~0_combout\,
	datab => \tx1|tx_flg~q\,
	datac => \tx1|tx_line~q\,
	datad => \tx1|LessThan0~0_combout\,
	combout => \tx1|tx_line~1_combout\);

-- Location: FF_X31_Y70_N1
\tx1|tx_line\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c1|newClock~clkctrl_outclk\,
	d => \tx1|tx_line~1_combout\,
	clrn => \ALT_INV_tx_start~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \tx1|tx_line~q\);

ww_ledr(0) <= \ledr[0]~output_o\;

ww_ledr(1) <= \ledr[1]~output_o\;

ww_ledr(2) <= \ledr[2]~output_o\;

ww_ledr(3) <= \ledr[3]~output_o\;

ww_ledr(4) <= \ledr[4]~output_o\;

ww_ledr(5) <= \ledr[5]~output_o\;

ww_ledr(6) <= \ledr[6]~output_o\;

ww_ledr(7) <= \ledr[7]~output_o\;

ww_ledr(8) <= \ledr[8]~output_o\;

ww_ledr(9) <= \ledr[9]~output_o\;

ww_uart_tx <= \uart_tx~output_o\;
END structure;


