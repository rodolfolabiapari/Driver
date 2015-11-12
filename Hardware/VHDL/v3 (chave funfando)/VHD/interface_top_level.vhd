library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use IEEE.math_real.all;
	use ieee.std_logic_1164.all;  
	use ieee.numeric_std.all;  
	
entity interfaceDES is
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
end interfaceDES;

architecture interfaceDES_behav of interfaceDES is
	signal sig_reset            : std_logic := '0';
	signal sig_reset_comm       : std_logic := '0';

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

	signal sig_decod_In         : std_logic_vector (31 downto 0);
	signal sig_posicao_display  : std_logic_vector (2 downto 0);
	signal sig_display8segSelect: std_logic_vector (3 downto 0);

	signal sig_uart_display8seg : std_logic_vector (7 downto 0);
	
	type state_type is (reset, menuPrincipal, menuChave, recebeChave, feedbackRecebeChave, retornaChave, recebeTexto);
	signal estado               : state_type := reset;
	
	signal countBytesLidos      : std_logic_vector(4 downto 0);
	signal nibbleBuffer           : std_logic_vector(3 downto 0) := x"0";
	signal flag      : std_logic  := '0';
	signal edge                 : std_logic_vector(1 downto 0) := "00";

	component uart is
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
	end component uart;
	
	component decodificador7seg
    port (
		clock           : in std_logic;
		reset           : in std_logic;
		dadoEntrada     : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		A, B, C, D, E, F, G : out STD_LOGIC;
		displays        : out std_logic_vector (7 downto 0)
    );
	end component decodificador7seg;
	
--	component des is
--	port(
--		clk       : IN  std_logic;
--		reset     : In  std_logic;
--		text64    : IN  std_logic_vector(0 TO 63);
--		key       : IN  std_logic_vector(0 TO 63);
--		done      : OUT std_logic;
--		textOut64 : OUT std_logic_vector(0 TO 63)
--	);
--	end component des;
begin 	
	uart1: uart port map (	
		clock            => clock,
		reset            => sig_reset_comm,
		comando_enviar   => sig_comm_enviar,
		comando_recebido => sig_comm_recebido,
		dado_recebido    => sig_dado_recebido,
		dado_enviar      => sig_dado_enviar,
		enviar_busy      => sig_comm_enviar_busy,
		uart_tx          => sig_uart_tx,
		uart_rx          => pinIn121
	);
	
	d1: decodificador7seg port map(	
		clock           => clock,
		reset           => sig_reset,
		dadoEntrada     => sig_decod_In,
		A               => display8seg(0),
		B               => display8seg(1),
		C               => display8seg(2),
		D               => display8seg(3),
		E               => display8seg(4),
		F               => display8seg(5),
		G               => display8seg(6),
		--displays    => sig_display8segSelect
		displays        => display8segSelect
    );
	 
--	crito1: des port map(
--		clk       => clock,
--		reset     => sig_des_reset,
--		text64    => sig_des_text64,
--		key       => sig_des_key,
--		done      => sig_des_done,
--		textOut64 => sig_des_textOut64
--	);
	
	--display8segSelect <= sig_display8segSelect;
	pinOut119 <= sig_uart_tx;
	pinOut118 <= sig_uart_tx;
	--pinSound <= not sig_comm_recebido;
	--pinSound <= botao1 and botao2 and botao3 and botao4 and not sig_comm_recebido;
	
	--ledred <= not sig_dado_recebido;

	-- Logic to advance to the next state
	process (clock)
	begin
		if botao4 = '0' and botao3 = '0' then
			estado <= reset;
		elsif (rising_edge(clock)) then
			case estado is
				when reset=>
					case sig_dado_recebido is 
						when x"73" => -- s
							estado <= menuPrincipal;
						when others =>
					end case;
					
--					if (botao1 = '0') then
--						estado <=feedbackRecebeChave;
--					end if;
					
				when menuPrincipal =>
					case sig_dado_recebido is 
						when x"6b" => -- k
							estado <= menuChave;
						when others =>
						
					end case;

				when recebeChave=>
					if (countBytesLidos(4 downto 0) = "10000") then 
						estado  <= feedbackRecebeChave;
					end if;
					
				when feedbackRecebeChave =>
					if edge = "10" then
						estado <= menuChave;
					end if;
					
				when menuChave =>
					case sig_dado_recebido is 
						when x"66" => -- f
							estado <= menuPrincipal;
						
						when x"61" => -- a
							estado <= recebeChave;
							
						when x"62" => -- b
							estado <= retornaChave;
							
						when x"63" => -- c
							estado <= feedbackRecebeChave;
							
						when others =>
					end case;
					
				when retornaChave =>
					if (edge = "11") then
						estado <= menuChave;
					end if;
					
				when recebeTexto =>
				
				when others =>
			end case;
		end if;
	end process;
	
	
	
   PROCESS (clock)
   BEGIN
		if (clock'event and clock = '1') then
			
			CASE estado IS
				WHEN reset =>
					sig_reset         <= '1';
					sig_reset_comm    <= '0';
					sig_decod_In      <= x"0000_0000";
					sig_comm_enviar   <= '0';
					sig_dado_enviar   <= x"30";
					--sig_posicao_display <= "110";
					flag   <= '0';
					display8seg(7)    <= '1';
					countBytesLidos   <= "00000";
					edge              <= "00";
					sig_dado_enviar   <= "00000000";
					ledred  	         <= not "00000000";
					sig_des_reset     <= '1';
					--sig_des_key     <= x"3031323334353637";
					sig_des_key       <= x"3031323334353637";
					sig_des_text64    <= x"0000000000000000";
					pinSound          <= '1';
	
					case sig_dado_recebido is 
						when x"73" => -- s
							sig_reset <= '0';
						when others =>
					end case;
					
					
				when menuPrincipal => 
					pinSound <= '1';
					sig_decod_In(3 downto 0)        <= x"f";
					--sig_posicao_display <= "111";
					
					
				WHEN recebeChave =>
					--ledred       <= not sig_dado_recebido;
					ledred       <= "111" & not countBytesLidos(4 downto 0);
					--pinSound <= '0';
					
					sig_decod_In(3 downto 0) <=  x"1";
					--sig_posicao_display <= "001";
					
					if (countBytesLidos < 16) then		
						sig_decod_In (11 downto 8) <= countBytesLidos(3 downto 0);
						sig_decod_In(19 downto 16) <= sig_dado_recebido(3 downto 0);
						display8seg(7) <= countBytesLidos(0);
						
						if (sig_comm_recebido = '1' and edge = "01") then
							sig_des_key           <= std_logic_vector(shift_left(unsigned(sig_des_key), 4));
							sig_des_key(60 to 63) <= sig_dado_recebido(3 downto 0);
							
							countBytesLidos      <= countBytesLidos + 1; 
							edge                 <= "00";
							pinSound             <= '0';
							
						elsif (sig_comm_recebido = '0' and edge = "00") then
							pinSound <= '1';
							edge <= "01";
						end if;
						
					elsif (countBytesLidos >= 16) then 
						sig_decod_In (11 downto 8) <= "0000";
						sig_decod_In(19 downto 16) <= "0000";
						edge <= "00";
					end if;
					
				
				when feedbackRecebeChave =>
					case edge is
						when "00" =>
							pinSound <= '1';
							sig_decod_In(3 downto 0) <=  x"2";
							--sig_decod_In(3 downto 0) <=  x"0";
						
							if (sig_comm_enviar_busy = '0') then
								--display8seg(7) <= '0';
								sig_comm_enviar <= '1';
								sig_dado_enviar <= x"6b"; -- m
								edge <= "10";
							else 
								sig_comm_enviar <= '0';
							end if;
						
						
						when "01" =>
							sig_comm_enviar <= '0';
							sig_decod_In(3 downto 0) <=  x"3";
								
							if (sig_comm_enviar_busy = '1') then
								edge <= "10";
							end if;
							
								
						when "10" => 
							sig_comm_enviar <= '0';
							sig_decod_In(3 downto 0) <=  x"5";
						when others =>
					end case;
					
				
				when menuChave=>
					sig_decod_In(3 downto 0) <=  x"4";
					countBytesLidos <= "00000";
					edge <= "00";
					flag <= '0';
					
					case sig_dado_recebido is 
						when x"31" => -- 1
							
						when x"32" => -- 2
							
						when x"33" => -- 3
							
						when others =>
					end case;
						
				
				WHEN retornaChave =>
					sig_decod_In(31 downto 28) <= '0' & edge & '0';
					
					case edge is
						when "00" =>
							sig_decod_In(19 downto 16) <= countBytesLidos(3 downto 0);
							sig_decod_In(3 downto 0) <=  x"1";
						
							case countBytesLidos is
								when "00000" => sig_dado_enviar <= sig_des_key(0 to 7);  
								when "00001" => sig_dado_enviar <= sig_des_key(8 to 15); 
								when "00010" => sig_dado_enviar <= sig_des_key(16 to 23);
								when "00011" => sig_dado_enviar <= sig_des_key(24 to 31);
								when "00100" => sig_dado_enviar <= sig_des_key(32 to 39);
								when "00101" => sig_dado_enviar <= sig_des_key(40 to 47);
								when "00110" => sig_dado_enviar <= sig_des_key(48 to 55);
								when "00111" => sig_dado_enviar <= sig_des_key(56 to 63);
								when others  => sig_dado_enviar <= "00000000";
							end case;

							if (sig_comm_enviar_busy = '0') then
								sig_comm_enviar <= '1';
								--display8seg(7) <= '0';
								
								--sig_decod_In(31 downto 28) <= sig_dado_enviar()
								edge <= "10";
							end if;
--						when "01" =>
--							sig_comm_enviar <= '0';
--							sig_decod_In(3 downto 0) <=  x"7";
--								
--							if (sig_comm_enviar_busy = '1') then
--								edge <= "10";
--							end if;
						when "10" => 
							sig_comm_enviar <= '0';
							sig_decod_In(3 downto 0) <=  x"c";

							--if ( countBytesLidos < "01000") then 
							if countBytesLidos >= 8 then
								edge <= "11";
								countBytesLidos <= "11111";
								--display8seg(7) <= '1';
								
							else
								countBytesLidos <= std_logic_vector(unsigned(countBytesLidos(4 downto 0)) + 1);
								edge <= "00";
							end if;
							
							
						when "11" =>
							sig_decod_In(31 downto 0) <=  x"00000000";
							countBytesLidos <= "11111";
							edge <= "11";
							
						when others =>
					end case;
					
				
				
				WHEN recebeTexto =>
						display8seg(7) <= '0';
						--display8segSelect <= "01111110";
						--sig_decod_In <= countEstado;
				
				
				When others => 
			END CASE;
		end if;
	END PROCESS;

end interfaceDES_behav;