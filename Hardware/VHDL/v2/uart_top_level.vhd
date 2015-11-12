library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use IEEE.math_real.all;
	use ieee.std_logic_1164.all;  
	use ieee.numeric_std.all;  

entity uart_top_level is
	port (
		clock             : in  std_logic; -- Clock FPGA
		botao1            : in  std_logic; -- botao
		botao2            : in  std_logic; -- botao
		botao3            : in  std_logic; -- botao
		botao4            : in  std_logic; -- botao
		ledred            : out std_logic_vector(7 downto 0); -- Leds
		pinIn120          : in  std_logic; 
		pinIn121          : in  std_logic; 
		pinOut118         : out std_logic; 
		pinOut119         : out std_logic; 
		pinSound          : out std_logic;
		display8seg       : out std_logic_vector(7 downto 0);
		display8segSelect : out std_logic_vector(7 downto 0)	
  );
end uart_top_level;

architecture uart_behav of uart_top_level is
	signal sig_uart_tx          : std_logic;
	signal sig_des_reset        : std_logic;
	signal sig_des_text64       : std_logic_vector(0 TO 63);
	signal sig_des_key          : std_logic_vector(0 TO 63);
	signal sig_des_done         : std_logic;
	signal sig_des_textOut64    : std_logic_vector(0 TO 63);

	signal sig_dado_enviar      : std_logic_vector (7 downto 0);
	signal sig_comm_enviar_busy : std_logic; 
	signal sig_comm_enviar      : std_logic := '0';
	signal sig_comm_recebido    : std_logic;
	signal sig_dado_recebido    : std_logic_vector (7 downto 0); 

	signal sig_decod_In         : std_logic_vector (3 downto 0);

	signal sig_uart_display8seg : std_logic_vector (7 downto 0);
	type state_type is (reset, recebeChave, retornaChave, recebeTexto);

	-- Register to hold the current state
	signal estado               : state_type := reset;
	signal countEstado          : std_logic_vector(3 downto 0);
	signal countBytesLidos      : std_logic_vector(4 downto 0);
	signal botaoAvancaByte      : std_logic;

	component uart is
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
	end component uart;
	
	component decodificador7seg
    port (
		dadoEntrada         : in std_logic_vector(3 DOWNTO 0);
		A, B, C, D, E, F, G : out std_logic
    );
	end component decodificador7seg;
	
	component des is
	port(
		clk       : IN  std_logic;
		reset     : In  std_logic;
		text64    : IN  std_logic_vector(0 TO 63);
		key       : IN  std_logic_vector(0 TO 63);
		done      : OUT std_logic;
		textOut64 : OUT std_logic_vector(0 TO 63)
	);
	end component des;
begin 	
	uart1: uart port map (	
		clock            => clock,
		comando_enviar   => sig_comm_enviar,
		comando_recebido => sig_comm_recebido,
		dado_recebido    => sig_dado_recebido,
		dado_enviar      => sig_dado_enviar,
		enviar_busy      => sig_comm_enviar_busy,
		uart_tx          => sig_uart_tx,
		uart_rx          => pinIn121
	);
	
	d1: decodificador7seg port map(
		dadoEntrada => sig_decod_In,
		A           => display8seg(0),
		B           => display8seg(1),
		C           => display8seg(2),
		D           => display8seg(3),
		E           => display8seg(4),
		F           => display8seg(5),
		G           => display8seg(6)
    );
	 
	crito1: des port map(
		clk       => clock,
		reset     => sig_des_reset,
		text64    => sig_des_text64,
		key       => sig_des_key,
		done      => sig_des_done,
		textOut64 => sig_des_textOut64
	);
	
	pinOut119 <= sig_uart_tx;
	pinOut118 <= sig_uart_tx;
	
	pinSound <= '1';
	--ledred <= not sig_dado_recebido;

	-- Logic to advance to the next state
	process (clock, botao4, botao3)
	begin
		if botao4 = '0' and botao3 = '0' then
			estado <= reset;
		elsif (rising_edge(clock)) then
			case estado is
				when reset=>
					--if sig_dado_recebido = "01100001" then
					if (botao1 = '0') then 
						estado <= recebeChave;
					end if;

				when recebeChave=>
					if (botao3 = '0' and countBytesLidos = 16) then 
						estado  <= retornaChave;
					end if;
					
				when retornaChave =>
					if (countBytesLidos = 9 and sig_comm_enviar_busy = '0') then
						if (botao4 = '0') then
							estado         <= recebeTexto;
						end if;
					end if;
					
				when recebeTexto =>
			end case;
		end if;
	end process;
	
	
	
   PROCESS (estado)
	variable completado : std_logic_vector(2 downto 0) := "000";
   BEGIN
      CASE estado IS
         WHEN reset =>
				countEstado       <= "0000";
				display8segSelect <= "01111111";
				botaoAvancaByte   <= '0';
				display8seg(7)    <= '1';
				sig_decod_In      <= "1110";
				countBytesLidos   <= "00000";
				completado        := "000";
				sig_dado_enviar   <= "00000000";
				sig_des_reset     <= '1';
				--sig_des_key     <= x"3031323334353637";
				sig_des_key       <= x"0000000000000000";
				sig_des_text64    <= x"0000000000000000";
				
				if (botao1 = '0') then 
					countBytesLidos <= "00000";
				end if;
			
         WHEN recebeChave =>
				sig_decod_In <= countBytesLidos (3 downto 0);
				ledred       <= not sig_dado_recebido;
				
--				if (countBytesLidos = 17) then
--					countBytesLidos <= "00000";
--					display8segSelect <= "00000000";
--				elsif (countBytesLidos = 16) then
--					display8segSelect <= "11111100";
--					display8seg(7) <= '0';
--				else 
--					display8segSelect    <= "11111110";
--					display8seg(7) <= '1';
--				end if;
					
				--if (sig_comm_recebido'event and sig_comm_recebido = '1') then
				if (sig_comm_recebido = '1' and completado = "000") then
					if (countBytesLidos = 17) then
						sig_des_key       <= std_logic_vector(shift_right(unsigned(sig_des_key), 64));
						display8seg(7) <= '0';
					else 							
						sig_des_key          <= std_logic_vector(shift_right(unsigned(sig_des_key), 4));
						sig_des_key (0 to 3) <= sig_dado_recebido (3 downto 0);
						display8seg(7) <= '1';
						
						countBytesLidos   <= countBytesLidos + 1;
					end if;
					
					completado := "001";
						
				elsif (sig_comm_recebido = '0' and completado = "001") then
					completado := "000";
				end if;
						
--					-- realiza os shifts de 15 dados
--					elsif (botao2 = '0' and botaoAvancaByte = '0' and countBytesLidos < 16) then
--						botaoAvancaByte      <= '1';
--						sig_des_key (0 to 3) <= sig_dado_recebido(3 downto 0);
--						--sig_des_key(0 to 4) <= sig_dado_recebido(0) & sig_dado_recebido(1) & sig_dado_recebido(2) & sig_dado_recebido(3) & sig_dado_recebido(4);
--						countEstado          <= countBytesLidos (3 downto 0);
--						countBytesLidos      <= countBytesLidos + 1;
--						display8segSelect <= "11111110";
--
--					elsif (botao3 = '0' and botaoAvancaByte = '1') then
--						if (countBytesLidos < 16) then
--							sig_des_key     <= std_logic_vector(shift_right(unsigned(sig_des_key), 4));
--
--						elsif (countBytesLidos = 16) then
--							display8seg(7)  <= '0';
--
--						end if;
--							
--						botaoAvancaByte <= '0';
--						--countEstado     <= "0000";
--						display8segSelect <= "11111100";
--
--					end if;


					
			
         WHEN retornaChave =>
				if (countBytesLidos = 9 and sig_comm_enviar_busy = '0') then
					sig_comm_enviar  <= '0';
					countEstado <= "0110";
					
					if (botao4 = '0') then
						display8seg(7) <= '0';
					elsif (botao2 = '0') then
						countBytesLidos <= "00000";
					end if;
				
				elsif (sig_comm_enviar = '1') then
					sig_comm_enviar      <= '0';
					countBytesLidos <= countBytesLidos + 1;
					display8seg(7)  <= sig_comm_enviar_busy;
					countEstado     <= "0101";
					
				elsif (sig_comm_enviar_busy = '0' and sig_comm_enviar = '0') then

					sig_comm_enviar   <= '1';
					sig_decod_In <= countEstado;
					countEstado  <= "0100";
					
					case countBytesLidos is
						when "00000" => sig_dado_enviar <= sig_des_key(0 to 7);
						when "00001" => sig_dado_enviar <= sig_des_key(8 to 15);
						when "00010" => sig_dado_enviar <= sig_des_key(16 to 23);
						when "00011" => sig_dado_enviar <= sig_des_key(24 to 31);
						when "00100" => sig_dado_enviar <= sig_des_key(32 to 39);
						when "00101" => sig_dado_enviar <= sig_des_key(40 to 47);
						when "00110" => sig_dado_enviar <= sig_des_key(48 to 55);
						when "00111" => sig_dado_enviar <= sig_des_key(56 to 63);
						when others =>
							sig_dado_enviar <= "00000000";
					end case;
				end if;
			
			
         WHEN recebeTexto =>
					display8seg(7) <= '0';
					display8segSelect <= "01111110";
					countEstado <= "1000";
					sig_decod_In <= countEstado;
			
			
			When others => 
      END CASE;
   END PROCESS;

end uart_behav;