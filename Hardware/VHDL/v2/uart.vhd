library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.math_real.all;

entity uart is
	port (
		clock            : in  std_logic; -- Clock FPGA
		comando_enviar   : in  std_logic; 
		comando_recebido : out std_logic;
		dado_recebido    : out std_logic_vector(7 downto 0); -- Leds
		dado_enviar      : in  std_logic_vector(7 downto 0); -- Leds
		enviar_busy      : out std_logic;
		uart_tx          : out std_logic; -- Saida Tx
		uart_rx          : in  std_logic
  );
end uart;

architecture uart_behav of uart is
	signal sig_choice     : std_logic_vector(2 downto 0);
	signal sig_newClock   : std_logic;

	signal tx_start       : std_logic;
	signal tx_busy        : std_logic;
	signal tx_data        : std_logic_vector(7 downto 0);

	signal rx_busy        : std_logic;
	signal rx_data        : std_logic_vector(7 downto 0);

	component newClock
	port(
		clock_fpga : in std_logic;
		choice     : in std_logic_vector(2 downto 0);
		newClock   : out std_logic
		);
	end component newClock;

	component tx
	port(
		clock   : in std_logic;
		start   : in std_logic;
		busy    : out std_logic;
		data    : in std_logic_vector (7 downto 0);
		tx_line : out std_logic
		);
	end component tx;

	component rx
	port(
		clock   : in std_logic;
		busy    : out std_logic;
		data    : out std_logic_vector(7 downto 0);
		rx_line : in std_logic
		);
	end component rx;

begin 
	c1: newClock port map (
		clock_fpga => clock,
		choice     => sig_choice,
		newClock   => sig_newClock
	);
	
	tx1: tx port map (
		clock   => sig_newClock, 
		start   => tx_start, 
		busy    => tx_busy, 
		data    => tx_data, 
		tx_line => uart_tx
	);

	rx1: rx port map (
		clock   => sig_newClock,
		busy    => rx_busy,
		data    => rx_data,
		rx_line => uart_rx
	);

	sig_choice <= "000";
	--tx_data <= dado_enviar(0) & dado_enviar(1) & dado_enviar(2) & dado_enviar(3) 
	--& dado_enviar(4) & dado_enviar(5) & dado_enviar(6) & dado_enviar(7);
	tx_data <= dado_enviar;
	--tx_data <= "01100010";
	
	process(rx_busy, clock)
	variable edge : std_logic := '0';
	begin
		if (rx_busy='0') then
			if (edge = '1') then
				dado_recebido    <= rx_data;
				comando_recebido <= '1';
				edge             := '0';
			else
				comando_recebido <= '0';
			end if;
			
		elsif (rx_busy = '1') then
			edge := '1';
			comando_recebido <= '0';
		end if;
	end process;
	

	process (clock, comando_enviar)
	begin
		if (comando_enviar='1' and tx_busy='0' and tx_start='0') then
			--tx_data <= "01100010";
			tx_start <= '1';
			--ledg<= tx_data;
		elsif (tx_start = '1' and tx_busy='1') then
			tx_start<= '0';
		end if;
		
		enviar_busy <= tx_busy or tx_start;
	end process;
end uart_behav;