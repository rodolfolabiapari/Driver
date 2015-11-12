library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- 
-- uart é 9600 bit/sec
-- 
-- 50e6/9600=5208
-- 
-- serao intervalos de 5208 para envio
-- 
-- 
entity UART is
	port(
		clock: in std_logic;
		sw : in std_logic_vector(9 downto 0);
		key : in std_logic_vector(3 downto 0);
		ledr :out std_logic_vector(9 downto 0);
		ledg :out std_logic_vector(7 downto 0);
		uart_txd: out std_logic;
		uart_rxd: in std_logic
		);
end UART;

architecture uart_behiv of UART is
signal tx_data : std_logic_vector(7 downto 0);
signal tx_start : std_logic := '0';
signal tx_busy : std_logic;

signal rx_data: std_logic_vector(7 downto 0);
signal rx_busy: std_logic;


component TX
port(
	clk: in std_logic;
	start: in std_logic;
	busy: out std_logic;
	data: in std_logic_vector (7 downto 0);
	tx_line: out std_logic
	);
end component TX;


component RX
port(
	clk: in std_logic;
	rx_line: in std_logic;
	data: out std_logic_vector(7 downto 0);
	busy: out std_logic
	);
end component RX;

begin
	c1: TX port map (
		clk=>clock, 
		start=>tx_start, 
		busy=>tx_busy, 
		data=>tx_data, 
		tx_line=>uart_txd);
	c2: RX port map (clk=>clock, 
		rx_line=>uart_rxd, 
		data=>rx_data, 
		busy=>rx_busy);

	process(rx_busy)
	begin
		if (rx_busy'event and rx_busy='0') then
			ledr(7 downto 0) <= rx_data;
		end if;
	end process;

	process (clock)
	begin
		if (clock'event and clock='1') then
			if (key(0)='0' and tx_busy='0') then
				tx_data <= sw(7 downto 0);
				tx_start<= '1';
				ledg<= tx_data;
			else
				tx_start<= '0';
			end if;
		end if;
	end process;
end uart_behiv;