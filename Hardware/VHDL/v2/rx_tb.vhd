LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;

ENTITY rx_tb IS
END rx_tb;

ARCHITECTURE sinais OF rx_tb IS
	signal sig_clock   : std_logic := '0';
	signal sig_busy    : std_logic;
	signal sig_data    : std_logic_vector (7 downto 0);
	signal sig_rx_line : std_logic;


	COMPONENT rx port (
		clock   : in std_logic;
		busy    : out std_logic;
		data    : out std_logic_vector(7 downto 0);
		rx_line : in std_logic
		);
	END COMPONENT;

BEGIN
	UUT_entity_rom1: rx PORT MAP(
		clock   => sig_clock,
		busy    => sig_busy,
		data    => sig_data,
		rx_line => sig_rx_line
	);
	
	sig_clock <= not sig_clock after 1 ns;
	
	process 
	begin
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '0';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '0';  wait until sig_clock = '0';
		sig_rx_line <= '0';  wait until sig_clock = '0';
		sig_rx_line <= '0';  wait until sig_clock = '0';
		sig_rx_line <= '0';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '0';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '1';  wait until sig_clock = '0';
		sig_rx_line <= '1';
	end process;
END ARCHITECTURE sinais;
