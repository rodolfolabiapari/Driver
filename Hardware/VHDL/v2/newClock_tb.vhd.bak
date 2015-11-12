LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;

ENTITY sbox1_tb IS
END sbox1_tb;

ARCHITECTURE sinais OF sbox1_tb IS
    	signal sig_clock_fpga : std_logic := '0';                         -- clock
	signal sig_newClock  : std_logic;
	signal sig_choice  : std_logic_vector(2 downto 0);
   	constant half_period 	: time := 1 ns;

	-- Importação de componente

	COMPONENT newClock port (
	    clock_fpga : in std_logic;                         -- clock
		choice     : in std_logic_vector(2 downto 0);
		newClock  : out std_logic
		);
	END COMPONENT;

BEGIN
	-- Mapeamento de portas
	UUT_entity_rom1: newClock PORT MAP(
	    clock_fpga => sig_clock_fpga,
		choice  => sig_choice,
		newClock => sig_newClock
	);
	
	sig_choice <= "000";
	sig_clock_fpga <= not sig_clock_fpga after half_period;

END ARCHITECTURE sinais;
