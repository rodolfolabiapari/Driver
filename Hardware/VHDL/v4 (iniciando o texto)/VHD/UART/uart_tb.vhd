LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;

ENTITY uart_tb IS
END uart_tb;

ARCHITECTURE sinais OF uart_tb IS
	signal sig_clock            : std_logic := '0';
	signal sig_comando_enviar   : std_logic := '0';
	signal sig_comando_recebido : std_logic;
	signal sig_dado_recebido    : std_logic_vector(7 downto 0); -- Leds
	signal sig_dado_enviar      : std_logic_vector(7 downto 0) := "00000000"; -- Leds
	signal sig_enviar_busy      : std_logic;
	signal sig_uart_tx          : std_logic;
	signal sig_uart_rx          : std_logic;

	signal sig_newClock         : std_logic;

	COMPONENT uart port (
		clock            : in  std_logic; -- Clock FPGA
		reset            : in  std_logic;
		comando_enviar   : in  std_logic; 
		comando_recebido : out std_logic;
		dado_recebido    : out std_logic_vector(7 downto 0); -- Leds
		dado_enviar      : in  std_logic_vector(7 downto 0); -- Leds
		enviar_busy      : out std_logic;
		uart_tx          : out std_logic; -- Saida Tx
		uart_rx          : in  std_logic
		);
	END COMPONENT;

	component newClock
	port(
		clock_fpga : in std_logic;
		choice     : in std_logic_vector(2 downto 0);
		newClock   : out std_logic
		);
	end component newClock;


BEGIN
	UUT_entity_rom1: uart PORT MAP(
		clock            => sig_clock            ,
		reset            => '0',
		comando_enviar   => sig_comando_enviar   ,
		comando_recebido => sig_comando_recebido ,
		dado_recebido    => sig_dado_recebido    ,
		dado_enviar      => sig_dado_enviar      ,
		enviar_busy      => sig_enviar_busy      ,
		uart_tx          => sig_uart_tx          ,
		uart_rx          => sig_uart_rx          
	);

	c1: newClock port map (
		clock_fpga => sig_clock,
		choice     => "000",
		newClock   => sig_newClock
	);
	

	
	sig_clock <= not sig_clock after 1 ns;
	
	process 
	begin

		sig_dado_enviar <= x"6a";  wait until sig_clock = '1'; 
		sig_comando_enviar <= '1'; wait until sig_clock = '1'; 
		sig_comando_enviar <= '0'; wait until sig_clock = '1'; 
		wait until sig_enviar_busy = '0';
		--sig_dado_enviar <= x"6b"; sig_comando_enviar <= '1'; wait until sig_clock = '1'; sig_comando_enviar <= '0';  wait until sig_clock = '1'; wait until sig_enviar_busy = '0';
		--sig_dado_enviar <= x"6c"; sig_comando_enviar <= '1'; wait until sig_clock = '1'; sig_comando_enviar <= '0';  wait until sig_clock = '1'; wait until sig_enviar_busy = '0';
		--sig_dado_enviar <= x"6d"; sig_comando_enviar <= '1'; wait until sig_clock = '1'; sig_comando_enviar <= '0';  wait until sig_clock = '1'; wait until sig_enviar_busy = '0';
	end process;
END ARCHITECTURE sinais;
