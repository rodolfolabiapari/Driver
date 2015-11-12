LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;

ENTITY tx_tb IS
END tx_tb;

ARCHITECTURE sinais OF tx_tb IS
	signal sig_clock   : std_logic := '0';
	signal sig_start   : std_logic := '1';
	signal sig_busy    : std_logic;
	signal sig_data    : std_logic_vector (7 downto 0) := "01100001";
	signal sig_tx_line : std_logic;


	COMPONENT tx port (
		clock   : in std_logic;
		start   : in std_logic;
		busy    : out std_logic;
		data    : in std_logic_vector (7 downto 0);
		tx_line : out std_logic
		);
	END COMPONENT;

BEGIN
	UUT_entity_rom1: tx PORT MAP(
		clock   => sig_clock,
		start   => sig_start,
		busy    => sig_busy,
		data    => sig_data,
		tx_line => sig_tx_line
	);
	
	sig_clock <= not sig_clock after 1 ns;

END ARCHITECTURE sinais;
