LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;

ENTITY uart_tb IS
END uart_tb;

ARCHITECTURE sinais OF uart_tb IS
	signal sig_clock            : std_logic := '0';
	signal sig_comando_enviar   : std_logic := '0';
	signal sig_reset            : std_logic := '0';
	signal sig_comando_recebido : std_logic;
	signal sig_dado_recebido    : std_logic_vector(7 downto 0); -- Leds
	signal sig_dado_enviar      : std_logic_vector(7 downto 0) := "00000000"; -- Leds
	signal sig_enviar_busy      : std_logic;
	signal sig_uart_tx          : std_logic;
	signal sig_uart_rx          : std_logic;

	signal sig_newClock         : std_logic;

	signal count                : std_logic_vector(5 downto 0) := "000000";
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
		reset            => sig_reset            ,
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
	
	-- RX
	process (sig_newClock) is
	begin
		if (sig_newClock'event and sig_newClock = '1') then
			case count IS
				when "000000"=> sig_uart_rx <= '0'; count <= "000001";
				when "000001"=> sig_uart_rx <= '1'; count <= "000010";
				when "000010"=> sig_uart_rx <= '0'; count <= "000011";
				when "000011"=> sig_uart_rx <= '1'; count <= "000100";
				when "000100"=> sig_uart_rx <= '0'; count <= "000101";
				when "000101"=> sig_uart_rx <= '1'; count <= "000110";
				when "000110"=> sig_uart_rx <= '0'; count <= "000111";
				when "000111"=> sig_uart_rx <= '1'; count <= "001000";
				when "001000"=> sig_uart_rx <= '0'; count <= "001001";
				when "001001"=> sig_uart_rx <= '1'; count <= "001010";
				when "001010"=> sig_uart_rx <= '0'; count <= "001011";
				when "001011"=> sig_uart_rx <= '1'; count <= "001100";
				when "001100"=> sig_uart_rx <= '0'; count <= "001101";
				when "001101"=> sig_uart_rx <= '1'; count <= "001110";
				when "001110"=> sig_uart_rx <= '0'; count <= "001111";
				when "001111"=> sig_uart_rx <= '0'; count <= "000000";
				when others=>  count <= "000000";
			end case;
		end if;
	end process;
END ARCHITECTURE sinais;
