library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.math_real.all;

entity uart is
	port (
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
end uart;

architecture uart_behav of uart is
	signal sig_choice              : std_logic_vector(2 downto 0);
	signal sig_newClock            : std_logic := '0';

	signal tx_start                : std_logic := '0';
	signal tx_busy                 : std_logic := '0';
	signal tx_data                 : std_logic_vector(7 downto 0);

	signal rx_busy                 : std_logic;
	signal rx_data                 : std_logic_vector(7 downto 0); 
	signal comando_recebido_buffer : std_logic := '0';
	
	signal nova_informacao         : std_logic := '0';

	type state_typeTX is (esperaComandoEnviar, processandoEnvio, enviandoInformacao);
	signal estadoTX               : state_typeTX := esperaComandoEnviar;
	
	type state_typeRX is (semInformacao, recebendoInformacao, estabilizandoInformacao, informacaoRecebida);
	signal estadoRX               : state_typeRX := semInformacao;
	
	component newClock
	port(
		clock_fpga : in std_logic;
		choice     : in std_logic_vector(2 downto 0);
		newClock   : out std_logic
		);
	end component newClock;

	component tx
	port(
		clockFast : in std_logic;
		clockSlow : in std_logic;
		start     : in std_logic;
		busy      : out std_logic;
		data      : in std_logic_vector (7 downto 0);
		tx_line   : out std_logic
		);
	end component tx;

	component rx
	port(
		clock   : in  std_logic;
		reset   : in  std_logic;
		busy    : out std_logic;
		data    : out std_logic_vector(7 downto 0);
		rx_line : in  std_logic
		);
	end component rx;

begin 
	c1: newClock port map (
		clock_fpga => clock,
		choice     => sig_choice,
		newClock   => sig_newClock
	);
	
	tx1: tx port map (
		clockFast => clock,
		clockSlow => sig_newClock, 
		start     => tx_start, 
		busy      => tx_busy, 
		data      => tx_data, 
		tx_line   => uart_tx
	);

	rx1: rx port map (
		clock   => sig_newClock,
		reset   => reset,
		busy    => rx_busy,
		data    => rx_data,

		rx_line => uart_rx
	);

	sig_choice <= "000";

	--tx_data <= dado_enviar(0) & dado_enviar(1) & dado_enviar(2) & dado_enviar(3) 
	--& dado_enviar(4) & dado_enviar(5) & dado_enviar(6) & dado_enviar(7);
	--tx_data <= "01100010";
	
	
	
--	process(clock)
--	begin
--		if (rx_busy = '0' and nova_informacao = '1') then
--				comando_recebido_buffer <= '1';
--				nova_informacao  <= '0';
--		elsif (rx_busy = '0' and nova_informacao = '0') then
--				comando_recebido_buffer <= '0';			
--		elsif (rx_busy = '1') then
--		end if;
	
--		if (nova_informacao = '1') then
--			comando_recebido_buffer <= '1';
--		else 
--			comando_recebido_buffer <= '0';
--		end if;
--	end process;
	
	
	
	process(rx_busy, clock, nova_informacao)
	begin
--		if (rx_busy = '0') then
--			if (nova_informacao = '1') then
--				dado_recebido   <= rx_data;
--				comando_recebido_buffer <= '1';
--				nova_informacao <= '0';
--			elsif (nova_informacao = '0') then
--			
--				comando_recebido_buffer <= '0';
--				nova_informacao <= '0';	
--			end if;
--			
--		else	
--		
--			comando_recebido_buffer <= '0';
--			nova_informacao <= '1';
--		end if;
		if (clock'event and clock = '1') then
		
			case estadoRX is 
				when semInformacao =>
					dado_recebido <= x"00";
					comando_recebido_buffer <= '0';
					
					if (rx_busy = '1') then
						estadoRX <= recebendoInformacao;
					end if;
					
					
				when recebendoInformacao =>
					comando_recebido_buffer <= '0';
					
					if (rx_busy = '0') then
						estadoRX <= estabilizandoInformacao;
					end if;
					
					
				when estabilizandoInformacao =>
					dado_recebido   <= rx_data;
					comando_recebido_buffer <= '1';
					
					if (comando_recebido_buffer = '1') then
						estadoRX <= informacaoRecebida;
					end if;
				
				
				when informacaoRecebida=>
					comando_recebido_buffer <= '0';
					
					if (comando_recebido_buffer = '0') then
						estadoRX <= semInformacao;
					end if;
					
					
	--					if (rx_busy = '1') then	
	--						estadoRX <= recebendoInformacao;
	--						comando_recebido_buffer <= '0';
	--					else--if (rx_busy = '0') then
	--						estadoRX <= semInformacao;
	--					end if;
			end case;
			
			comando_recebido <= comando_recebido_buffer;
		end if;
	end process;
	

	
	process (clock)
	begin
		if (clock'event and clock = '1') then
			case estadoTX is 
				when esperaComandoEnviar =>
					enviar_busy <= '0';
					
					if (comando_enviar = '1' and tx_busy = '0') then
						estadoTX <= enviandoInformacao;
						tx_data <= dado_enviar;
						tx_start <= '1';
						enviar_busy <= '1';
					end if;
				
				when processandoEnvio =>
					if (tx_busy = '1') then
						estadoTX <= enviandoInformacao;
					end if;

				when enviandoInformacao =>
					tx_start <= '0';
					
					if (tx_busy = '0') then
						estadoTX <= esperaComandoEnviar;
						enviar_busy <= '0';
					end if;
				end case;
		end if;
--			
--			if (comando_enviar='1' and tx_busy='0' and tx_start='0') then
--				--tx_data <= "01100010";
--				tx_start <= '1';
--				tx_data <= dado_enviar;
--				--ledg<= tx_data;
--			elsif (tx_start = '1' and tx_busy='1') then
--				tx_start<= '0';
--			end if;
--			
--			enviar_busy <= tx_busy or tx_start;
	end process;
end uart_behav;