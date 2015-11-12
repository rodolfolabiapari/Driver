library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use IEEE.math_real.all;
	use ieee.std_logic_1164.all;  
	use ieee.numeric_std.all;  
	
entity interfaceDES is
	port (
		clock             : in  std_logic; -- Clock FPGA
		botao0            : in  std_logic; -- botao
		botao1            : in  std_logic; -- botao
		botao2            : in  std_logic; -- botao
		botao3            : in  std_logic; -- botao
		leds              : out std_logic_vector(7 downto 0); -- Leds
		led               : out std_logic;
		ledr              : out std_LOGIC_VECTOR(3 downto 0);
		pinIn1            : in  std_logic; 
		pinIn3            : in  std_logic; 
		pinOut5           : out std_logic; 
		pinOut7           : out std_logic; 
		display8seg       : out std_logic_vector(55 downto 0)
  );
end interfaceDES;

architecture interfaceDES_behav of interfaceDES is
	signal sig_reset            : std_logic := '0';
	signal sig_reset_comm       : std_logic := '0';

	signal sig_des_reset        : std_logic;
	signal sig_des_text64       : std_logic_vector(0 TO 63);
	signal sig_des_key192          : std_logic_vector(0 TO 191);
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
	
	type state_type is (reset, menuPrincipal, 
					menuChave, recebeChave, feedbackRecebeChave, retornaChave, 
					menuTexto, recebeTexto, feedbackRecebeTexto, retornaTexto, 
					menuOperacoes, operacaoEncripta, operacaoDecrifra,
					retornaResultado);
	
	signal estado               : state_type := reset;
	
	signal countBytesLidos      : std_logic_vector(5 downto 0);
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
		displays        : out std_logic_vector(55 downto 0)
	);
	end component decodificador7seg;
	
	component tdes is
	port(
		clock          : IN std_logic;
		reset          : In std_logic;
		text64         : IN std_logic_vector(0 TO 63);
		key192         : IN std_logic_vector(0 TO 191);
		done           : OUT std_logic;
		textOut64      : OUT std_logic_vector(0 TO 63)
	);
	end component tdes;
begin 	
	uart1: uart port map (	
		clock            => clock,
		reset            => sig_reset_comm,
		comando_enviar   => sig_comm_enviar,
		comando_recebido => sig_comm_recebido,
		dado_recebido    => sig_dado_recebido,
		dado_enviar      => sig_dado_enviar,
		enviar_busy      => sig_comm_enviar_busy,
		uart_tx          => pinOut5,
		uart_rx          => pinIn3
	);
	
	d1: decodificador7seg port map(	
		clock           => clock,
		reset           => sig_reset,
		dadoEntrada     => sig_decod_In,
		displays        => display8seg
    );
	 
	crito1: tdes port map(
		clock           => clock     ,
		reset           => sig_des_reset     ,
		text64          => sig_des_text64    ,
		key192          => sig_des_key192    ,
		done            => sig_des_done      ,
		textOut64       => sig_des_textOut64 
	);
	
	--display8segSelect <= sig_display8segSelect;
	--pinSound <= not sig_comm_recebido;
	--pinSound <= botao0 and botao1 and botao2 and botao3 and not sig_comm_recebido;
	
	--leds <= not sig_dado_recebido;

	-- Logic to advance to the next state
	process (clock)
	begin
		if botao3 = '0' and botao2 = '0' then
			estado <= reset;
		elsif (rising_edge(clock)) then
			case estado is
				when reset=>
					if (sig_comm_recebido = '1') then
						case sig_dado_recebido is 
							when x"73" => -- s
								estado <= menuPrincipal;
							when others =>
						end case;
					end if;
					
					
				when menuPrincipal =>
					if (sig_comm_recebido = '1') then
						case sig_dado_recebido is 
							when x"6b" => -- k
								estado <= menuChave;
							when x"74" => -- t
								estado <= menuTexto;
							when x"72" => -- r
								estado <= retornaResultado;
							when x"6f" => -- o
								estado <= menuOperacoes;
							when others =>
						end case;
					end if;

					
				when retornaResultado=>
					if (edge = "11") then
						estado <= menuPrincipal;
					end if;

				when menuOperacoes=>
					if (sig_comm_recebido = '1') then
						case sig_dado_recebido is 
							when x"66" => -- f
								estado <= menuPrincipal;
							when x"65" => -- e
								estado <= operacaoEncripta;
							when x"64" => -- d
								estado <= operacaoDecrifra;
							when others =>
						end case;
					end if;
					

				when operacaoEncripta =>
					if (sig_des_done = '1') then
						estado <= retornaResultado;
					end if;

				when recebeChave=>
					if (countBytesLidos(5 downto 0) = "110000") then 
						estado  <= feedbackRecebeChave;
					end if;
				when feedbackRecebeChave =>
					if edge = "10" then
						estado <= menuChave;
					end if;
				when retornaChave =>
					if (edge = "11") then
						estado <= menuChave;
					end if;
					
				when menuChave =>
					if (sig_comm_recebido = '1') then
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
					end if;
					
				
				when recebeTexto=>
					if (countBytesLidos(5 downto 0) = "001000") then 
						estado  <= feedbackRecebeTexto;
					end if;
				when feedbackRecebeTexto =>
					if edge = "10" then
						estado <= menuTexto;
					end if;
				when retornaTexto =>
					if (edge = "11") then
						estado <= menuTexto;
					end if;
					
				when menuTexto =>
						if (sig_comm_recebido = '1') then
							case sig_dado_recebido is 
								when x"66" => -- f
									estado <= menuPrincipal;
								when x"61" => -- a
									estado <= recebeTexto;
								when x"62" => -- b
									estado <= retornaTexto;
								when x"63" => -- c
									estado <= feedbackRecebeTexto;
								when others =>
							end case;
						end if;
				
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
					flag              <= '0';
					led <= '1';
					countBytesLidos   <= "000000";
					edge              <= "00";
					sig_dado_enviar   <= "00000000";
					--leds             <= "00000000";
					sig_des_reset     <= '1';
					sig_des_key192    <= x"000000000000000000000000000000000000000000000000";
					--sig_des_key192    <= x"133457799BBCDFF1133457799BBCDFF1133457799BBCDFF1";
					sig_des_text64    <= x"0000000000000000";
					sig_des_text64    <= x"0123456789ABCDEF";
	
					case sig_dado_recebido is 
						when x"73" => -- s
							sig_reset <= '0';
						when others =>
					end case;
					
					
				when menuPrincipal => 	
					leds <= sig_dado_recebido;

					sig_decod_In(3 downto 0) <= x"f";
					led <= '0';
					
					
					
				when retornaResultado=>
					
					sig_decod_In(3 downto 0) <=  x"2";
					
					case edge is
						when "00" =>
							if (sig_comm_enviar_busy = '0') then
								case countBytesLidos is
									when "000000" => sig_dado_enviar <= sig_des_textOut64(0 to 7);   countBytesLidos <= "000001";
									when "000001" => sig_dado_enviar <= sig_des_textOut64(8 to 15);  countBytesLidos <= "000010";
									when "000010" => sig_dado_enviar <= sig_des_textOut64(16 to 23); countBytesLidos <= "000011";
									when "000011" => sig_dado_enviar <= sig_des_textOut64(24 to 31); countBytesLidos <= "000100";
									when "000100" => sig_dado_enviar <= sig_des_textOut64(32 to 39); countBytesLidos <= "000101";
									when "000101" => sig_dado_enviar <= sig_des_textOut64(40 to 47); countBytesLidos <= "000110";
									when "000110" => sig_dado_enviar <= sig_des_textOut64(48 to 55); countBytesLidos <= "000111";
									when "000111" => sig_dado_enviar <= sig_des_textOut64(56 to 63); countBytesLidos <= "010111";
									when others  => sig_dado_enviar <= "00000000";
								end case;

								sig_comm_enviar <= '1';
								edge <= "10";
							end if;
							
							
						when "10" => 
							sig_comm_enviar <= '0';

							if countBytesLidos >= "001000" then
								edge <= "11";
								countBytesLidos <= "011110";		
							else
								edge <= "00";
							end if;
							
							
						when "11" =>
							sig_comm_enviar <= '0';
							countBytesLidos <= "011110";
							edge <= "11";
							
						when others =>
					end case;
					
				when menuOperacoes=>
					sig_decod_In(3 downto 0) <=  x"a";
					leds <= sig_dado_recebido;

					sig_des_reset <= '1';
					edge <= "00";
					countBytesLidos <= "000000";

					case sig_dado_recebido is 
						when x"66" => -- f
						when x"65" => -- e
							sig_des_reset <= '0';
						when x"64" => -- d
							sig_des_reset <= '0';
						when others =>
					end case;
					

				when operacaoEncripta =>
					if (sig_des_done = '1') then
						sig_des_reset <= '1';
					end if;
					
					
				when recebeChave =>
					leds       <= "00" & countBytesLidos(5 downto 0);
					
					sig_decod_In(3 downto 0) <=  x"1";
					sig_decod_In(23 downto 20) <= sig_dado_recebido(3 downto 0);
					
					if (countBytesLidos < 48) then		
						sig_decod_In(11 downto 8) <= countBytesLidos(3 downto 0);
						sig_decod_In(15 downto 12) <= "00" & countBytesLidos(5 downto 4);
						
						if (sig_comm_recebido = '1' and edge = "01") then
							sig_des_key192 <= std_logic_vector(shift_left(unsigned(sig_des_key192), 4));
							sig_des_key192(188 to 191) <= sig_dado_recebido(3 downto 0);
							countBytesLidos <= countBytesLidos + 1; 
							edge <= "00";
							
						elsif (sig_comm_recebido = '0' and edge = "00") then
							edge <= "01";
						end if;
					end if;
					
				
				when feedbackRecebeChave =>
					case edge is
						when "00" =>
							sig_decod_In(3 downto 0) <=  x"3";
							
							if (sig_comm_enviar_busy = '0') then
								sig_comm_enviar <= '1';
								sig_dado_enviar <= x"6b"; -- k
								edge <= "01";
							else 
								sig_comm_enviar <= '0';
							end if;
						
						
						when "01" =>
							sig_comm_enviar <= '0';
							
							if (sig_comm_enviar_busy = '1') then
								edge <= "10";
							end if;
							
								
						when "10" => 
							sig_comm_enviar <= '0';
						when others =>
					end case;
					
				
				when menuChave=>
					leds <= sig_dado_recebido;

					sig_decod_In(3 downto 0) <=  x"4";
					sig_decod_In(31 downto 4) <=  x"0000000";
					countBytesLidos <= "000000";
					edge <= "00";
					flag <= '0';
			
				
				WHEN retornaChave =>
					sig_decod_In(3 downto 0) <=  x"2";
					
					case edge is
						when "00" =>

							if (sig_comm_enviar_busy = '0') then
								case countBytesLidos is
									when "000000" => sig_dado_enviar <= sig_des_key192(  0 to 7);   countBytesLidos <= "000001";
									when "000001" => sig_dado_enviar <= sig_des_key192(  8 to 15);  countBytesLidos <= "000010";
									when "000010" => sig_dado_enviar <= sig_des_key192( 16 to 23);  countBytesLidos <= "000011";
									when "000011" => sig_dado_enviar <= sig_des_key192( 24 to 31);  countBytesLidos <= "000100";
									when "000100" => sig_dado_enviar <= sig_des_key192( 32 to 39);  countBytesLidos <= "000101";
									when "000101" => sig_dado_enviar <= sig_des_key192( 40 to 47);  countBytesLidos <= "000110";
									when "000110" => sig_dado_enviar <= sig_des_key192( 48 to 55);  countBytesLidos <= "000111";
									when "000111" => sig_dado_enviar <= sig_des_key192( 56 to 63);  countBytesLidos <= "001000";
									when "001000" => sig_dado_enviar <= sig_des_key192( 64 to  71); countBytesLidos <= "001001";
									when "001001" => sig_dado_enviar <= sig_des_key192( 72 to  79); countBytesLidos <= "001010";
									when "001010" => sig_dado_enviar <= sig_des_key192( 80 to  87); countBytesLidos <= "001011";
									when "001011" => sig_dado_enviar <= sig_des_key192( 88 to  95); countBytesLidos <= "001100";
									when "001100" => sig_dado_enviar <= sig_des_key192( 96 to 103); countBytesLidos <= "001101";
									when "001101" => sig_dado_enviar <= sig_des_key192(104 to 111); countBytesLidos <= "001110";
									when "001110" => sig_dado_enviar <= sig_des_key192(112 to 119); countBytesLidos <= "001111";
									when "001111" => sig_dado_enviar <= sig_des_key192(120 to 127); countBytesLidos <= "010000";
									when "010000" => sig_dado_enviar <= sig_des_key192(128 to 135); countBytesLidos <= "010001";
									when "010001" => sig_dado_enviar <= sig_des_key192(136 to 143); countBytesLidos <= "010010";
									when "010010" => sig_dado_enviar <= sig_des_key192(144 to 151); countBytesLidos <= "010011";
									when "010011" => sig_dado_enviar <= sig_des_key192(152 to 159); countBytesLidos <= "010100";
									when "010100" => sig_dado_enviar <= sig_des_key192(160 to 167); countBytesLidos <= "010101";
									when "010101" => sig_dado_enviar <= sig_des_key192(168 to 175); countBytesLidos <= "010110";
									when "010110" => sig_dado_enviar <= sig_des_key192(176 to 183); countBytesLidos <= "010111";
									when "010111" => sig_dado_enviar <= sig_des_key192(184 to 191); countBytesLidos <= "011000";
									when others  => sig_dado_enviar <= "00000000";
								end case;

								sig_comm_enviar <= '1';
								edge <= "10";
							end if;
							
							
						when "10" => 
							sig_comm_enviar <= '0';

							if countBytesLidos >= "011000" then
								edge <= "11";
								countBytesLidos <= "111111";
							else
								edge <= "00";
							end if;
							
							
						when "11" =>
							sig_comm_enviar <= '0';
							countBytesLidos <= "111111";
							edge <= "11";
							
						when others =>
					end case;
					
				
				
				----------------------------------------------------------------------------------------------------------------------------
				

			
				when recebeTexto =>
					leds       <= "00" & countBytesLidos(5 downto 0);
					sig_decod_In(3 downto 0) <=  x"1";
					
					if (countBytesLidos < 8) then
						sig_decod_In(11 downto 8) <= countBytesLidos(3 downto 0);
						sig_decod_In(19 downto 16) <= sig_dado_recebido(3 downto 0);
						sig_decod_In(23 downto 20) <= sig_dado_recebido(7 downto 4);
						
						if (sig_comm_recebido = '1' and edge = "01") then
							sig_des_text64           <= std_logic_vector(shift_left(unsigned(sig_des_text64), 8));
							sig_des_text64(56 to 63) <= sig_dado_recebido;
							countBytesLidos       <= countBytesLidos + 1; 
							edge                  <= "00";
							
						elsif (sig_comm_recebido = '0' and edge = "00") then
							edge <= "01";
						end if;
					end if;
					
				
				when feedbackRecebeTexto =>
					case edge is
						when "00" =>
							sig_decod_In(3 downto 0) <=  x"3";
							
							if (sig_comm_enviar_busy = '0') then
								sig_comm_enviar <= '1';
								sig_dado_enviar <= x"74"; -- t
								edge <= "01";
							else 
								sig_comm_enviar <= '0';
							end if;
						
						
						when "01" =>
							sig_comm_enviar <= '0';
							
							if (sig_comm_enviar_busy = '1') then
								edge <= "10";
							end if;
							
								
						when "10" => 
							sig_comm_enviar <= '0';
						when others =>
					end case;
					
				
				when menuTexto=>
					leds <= sig_dado_recebido;
					sig_decod_In(3 downto 0) <=  x"5";
					sig_decod_In(31 downto 4) <=  x"0000000";
					countBytesLidos <= "000000";
					edge <= "00";
					flag <= '0';
			
				
				WHEN retornaTexto =>
					sig_decod_In(3 downto 0) <=  x"6";
					
					case edge is
						when "00" =>
							if (sig_comm_enviar_busy = '0') then
								case countBytesLidos is
									when "000000" => sig_dado_enviar <= sig_des_text64(0 to 7);   countBytesLidos <= "000001";
									when "000001" => sig_dado_enviar <= sig_des_text64(8 to 15);  countBytesLidos <= "000010";
									when "000010" => sig_dado_enviar <= sig_des_text64(16 to 23); countBytesLidos <= "000011";
									when "000011" => sig_dado_enviar <= sig_des_text64(24 to 31); countBytesLidos <= "000100";
									when "000100" => sig_dado_enviar <= sig_des_text64(32 to 39); countBytesLidos <= "000101";
									when "000101" => sig_dado_enviar <= sig_des_text64(40 to 47); countBytesLidos <= "000110";
									when "000110" => sig_dado_enviar <= sig_des_text64(48 to 55); countBytesLidos <= "000111";
									when "000111" => sig_dado_enviar <= sig_des_text64(56 to 63); countBytesLidos <= "010111";
									when others  => sig_dado_enviar <= "00000000";
								end case;

								sig_comm_enviar <= '1';
								edge <= "10";
							end if;
							
							
						when "10" => 
							sig_comm_enviar <= '0';

							if countBytesLidos >= "001000" then
								edge <= "11";
								countBytesLidos <= "011110";
								
							else
								edge <= "00";
							end if;
							
							
						when "11" =>
							sig_comm_enviar <= '0';
							countBytesLidos <= "011110";
							edge <= "11";
							
						when others =>
					end case;
				
				When others => 
			END CASE;
		end if;
	END PROCESS;

end interfaceDES_behav;