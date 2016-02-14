library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use ieee.numeric_std.all;  

-- PPPPPP                                    bb              lll        
-- PP   PP rr rr    eee    aa aa mm mm mmmm  bb      uu   uu lll  oooo  
-- PPPPPP  rrr  r ee   e  aa aaa mmm  mm  mm bbbbbb  uu   uu lll oo  oo 
-- PP      rr     eeeee  aa  aaa mmm  mm  mm bb   bb uu   uu lll oo  oo 
-- PP      rr      eeeee  aaa aa mmm  mm  mm bbbbbb   uuuu u lll  oooo  	

entity TDES_Project is
	port (
		clock              : in  std_logic; -- Clock FPGA

		botao_0            : in  std_logic; -- botao
		botao_1            : in  std_logic; -- botao
		botao_2            : in  std_logic; -- botao
		botao_3            : in  std_logic; -- botao

		leds_green         : out std_logic_vector(7 downto 0); -- leds_green
		led_reset          : out std_logic; -- Informa reset
		--ledr               : out std_logic_vector(3 downto 0); -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! inutilizadoo

		pin_1_in           : in  std_logic; 
		pin_5_out          : out std_logic; 

		bus_displays_out   : out std_logic_vector(55 downto 0)
  );
end TDES_Project;







architecture TDES_Project_behav of TDES_Project is
	
	-- variaveis internas
	constant const_bits_endereco : integer := 10;



	type st_type is (st_reset, st_menuPrincipal, 
					st_menuChave, st_feedbackChave, st_retornaChave, 
					st_recebeChave_espera_hexa, st_recebeChave_recebe_hexa, st_recebeChave_decodifica_hexa,
					st_menuTexto, st_recebeTexto, st_feedbackTexto, st_retornaTexto, st_inicializa_envio_texto,
					st_retorna_texto_recebe_ram, st_retorna_texto_envia, st_retorna_texto_seleciona_bloco,

					st_menuOperacoes, st_opEncripta, st_opDecripta,

					st_carregando_quantidade_blocos,
					st_carregando_texto,

					st_encripta_recebe_ram, st_encripta_opera, st_encripta_recebe_resultado, st_encripta_seleciona_bloco,
					st_decripta_recebe_ram, st_decripta_opera, st_decripta_recebe_resultado, st_decripta_seleciona_bloco,
					
					st_resultado_recebe_ram, st_resultado_envia, st_resultado_seleciona_bloco);
	signal estado                          : st_type := st_reset;
	


	component uart is
	port (
		clock                        : in  std_logic; -- Clock FPGA
		reset                        : in  std_logic;
		comando_enviar               : in  std_logic; 
		comando_recebido             : out std_logic;
		dado_recebido                : out std_logic_vector(7 downto 0); -- leds_green
		dado_enviar                  : in  std_logic_vector(7 downto 0); -- leds_green
		enviar_busy                  : out std_logic;
		uart_tx                      : out std_logic; -- Saida Tx
		uart_rx                      : in  std_logic
	);
	end component uart;
		signal s_dado_enviar         : std_logic_vector (7 downto 0)   := (others => '0');
		signal s_comm_enviar_busy    : std_logic                       := '0'; 
		signal s_comm_enviar         : std_logic                       := '0';
		signal s_comm_recebido       : std_logic                       := '0';
		signal s_dado_recebido       : std_logic_vector (7 downto 0)   := (others => '0'); 
		signal s_reset_comunicacao   : std_logic                       := '0';
	

	component decodificador7seg
	port (
		clock                             : in std_logic;
		reset                             : in std_logic;
		dadoEntrada                       : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		displays                          : out std_logic_vector(55 downto 0)
	);
	end component decodificador7seg;
		signal s_tdecodificador_displays  : std_logic_vector (31 downto 0) := (others => '0');
		signal s_posicao_display          : std_logic_vector (2 downto 0)  := (others => '0');
		signal s_bus_displays_outSelect   : std_logic_vector (3 downto 0)  := (others => '0');
		signal s_uart_bus_displays_out    : std_logic_vector (7 downto 0)  := (others => '0');
	

	-- Triple DES
	component t_des 
		port(
			clock                : IN std_logic;
			reset                : In std_logic;
			text64               : IN std_logic_vector(0 TO 63);
			key192               : IN std_logic_vector(0 TO 191);
			done                 : OUT std_logic;
			textOut64            : OUT std_logic_vector(0 TO 63)
		);
	end component;
		signal s_tdes_reset      : std_logic                 := '0';
		signal s_tdes_text64     : std_logic_vector(0 TO 63) := (others => '0');
		signal s_tdes_done       : std_logic                 := '0';
		signal s_tdes_textOut64  : std_logic_vector(0 TO 63) := (others => '0');


	-- Triple UnDES
	component t_un_des 
		port(
			clock                  : IN std_logic;
			reset                  : In std_logic;
			text64                 : IN std_logic_vector(0 TO 63);
			key192                 : IN std_logic_vector(0 TO 191);
			done                   : OUT std_logic;
			textOut64              : OUT std_logic_vector(0 TO 63)
		);
	end component;
		signal s_tundes_reset      : std_logic                 := '0';
		signal s_tundes_text64     : std_logic_vector(0 TO 63) := (others => '0');
		signal s_tundes_done       : std_logic                 := '0';
		signal s_tundes_textOut64  : std_logic_vector(0 TO 63) := (others => '0');


	-- Ram para armazenamento do texto e seu resultado
	component ramTexto
		generic(
			bits_endereco	  : integer := const_bits_endereco; 
			bits_dado		  : integer := 64
		);
		port (
			clock             : in  std_logic;
			escrita	          : in  std_logic;
			endereco          : in  std_logic_vector(const_bits_endereco - 1 DOWNTO 0);
			datain            : in  std_logic_vector(bits_dado - 1 DOWNTO 0);
			dataout           : out std_logic_vector(bits_dado - 1 DOWNTO 0)
		);
	end component;
		signal s_ram_escrita  : std_logic                                          := '0';
		signal s_ram_endereco : std_logic_vector(const_bits_endereco - 1 downto 0) := (others => '0');
		signal s_ram_datain   : std_logic_vector(63 downto 0)                      := (others => '0');
		signal s_ram_dataout  : std_logic_vector(63 downto 0)                      := (others => '0');



	signal quantidade_blocos     : unsigned (const_bits_endereco - 1 downto 0) := (others => '0'); 
	signal i                     : unsigned (const_bits_endereco - 1 downto 0) := (others => '0');
	signal reg_key_192           : std_logic_vector(0 TO 191)                  := x"0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF";
	signal contador              : std_logic_vector(5 downto 0)                := (others => '0');
	signal nibbleBuffer          : std_logic_vector(3 downto 0)                := (others => '0');
	signal edge                  : std_logic_vector(1 downto 0)                := (others => '0');
	signal s_reset_all_modules   : std_logic                                   := '0';
	signal encripta              : std_logic                                   := '0';

begin 	
	uart1: uart port map (	
		clock            => clock,
		reset            => '0',
		comando_enviar   => s_comm_enviar,
		comando_recebido => s_comm_recebido,
		dado_recebido    => s_dado_recebido,
		dado_enviar      => s_dado_enviar,
		enviar_busy      => s_comm_enviar_busy,
		uart_tx          => pin_5_out,
		uart_rx          => pin_1_in
	);
	
	d1: decodificador7seg port map(	
		clock           => clock,
		reset           => s_reset_all_modules,
		dadoEntrada     => s_tdecodificador_displays,
		displays        => bus_displays_out
    );
	 
	crito1: t_des port map(
		clock           => clock     ,
		reset           => s_tdes_reset     ,
		text64          => s_tdes_text64    ,
		key192          => reg_key_192    ,
		done            => s_tdes_done      ,
		textOut64       => s_tdes_textOut64 
	);

	decrito1: t_un_des port map(
		clock           => clock     ,
		reset           => s_tundes_reset     ,
		text64          => s_tundes_text64    ,
		key192          => reg_key_192    ,
		done            => s_tundes_done      ,
		textOut64       => s_tundes_textOut64 
	);

	mapram: ramTexto port map(
		clock     => clock ,
		escrita   => s_ram_escrita ,
		endereco  => s_ram_endereco ,
		datain    => s_ram_datain ,
		dataout   => s_ram_dataout 
	);
	

--MM    MM                         iii                       dd                      tt                 dd              
--MMM  MMM   aa aa   qqqqq uu   uu     nn nnn    aa aa       dd   eee     eee   sss  tt      aa aa      dd  oooo   sss  
--MM MM MM  aa aaa qq   qq uu   uu iii nnn  nn  aa aaa   dddddd ee   e  ee   e s     tttt   aa aaa  dddddd oo  oo s     
--MM    MM aa  aaa  qqqqqq uu   uu iii nn   nn aa  aaa  dd   dd eeeee   eeeee   sss  tt    aa  aaa dd   dd oo  oo  sss  
--MM    MM  aaa aa      qq  uuuu u iii nn   nn  aaa aa   dddddd  eeeee   eeeee     s  tttt  aaa aa  dddddd  oooo      s 
--                      qq                                                      sss                                sss 

	-- Processo de gereneciamento da maquina de estados da interface
	process (clock)
		variable controle_recebido : std_logic := '0';
	begin
		-- Quando os botoes 3 e 2 estao pressionados, o sistema e' resetado
		if botao_3 = '0' and botao_2 = '0' then
			estado <= st_reset;

		elsif (rising_edge(clock)) then
			case estado is

				-- O sistema so reinicia quando recebe o comando 's'
				when st_reset=>
					controle_recebido := '0';

					if (s_comm_recebido = '1') then
						case s_dado_recebido is 
							when x"73" => -- s
								estado <= st_menuPrincipal;
							when others =>
						end case;

					elsif botao_0 = '0' then
						estado <= st_menuPrincipal;
					end if;


				when st_menuPrincipal =>
					if (s_comm_recebido = '1') then
						controle_recebido := '1';

					elsif (s_comm_recebido = '0' and controle_recebido = '1') then 
						controle_recebido := '0';

						case s_dado_recebido is 
							when x"6b" => -- k
								estado <= st_menuChave;
							when x"74" => -- t
								estado <= st_menuTexto;
							when x"66" => -- f
								estado <= st_resultado_seleciona_bloco;
							when x"6f" => -- o
								estado <= st_menuOperacoes;
							when x"52" => -- R
								estado <= st_reset;
							when others =>
						end case;
					end if;



				-- Seleciona, na RAM qual o proximo bloco a ser operado
				when st_resultado_seleciona_bloco =>
					if (i >= quantidade_blocos ) then
						estado <= st_menuPrincipal;
					else 
						estado <= st_resultado_recebe_ram;
					end if;

				-- Recebe o bloco escolhido
				when st_resultado_recebe_ram =>
					estado <= st_resultado_envia;

				-- Opera o bloco
				when st_resultado_envia =>
					if contador >= "001000" then
						estado <= st_resultado_seleciona_bloco;
					end if;




				when st_menuOperacoes=>
					if (s_comm_recebido = '1') then
						controle_recebido := '1';

					elsif (s_comm_recebido = '0' and controle_recebido = '1') then 
						controle_recebido := '0';

						case s_dado_recebido is 
							when x"46" => -- f
								estado <= st_menuPrincipal;
							when x"61" => -- a
								estado <= st_encripta_seleciona_bloco;
								encripta <= '1';
							when x"62" => -- b
								estado <= st_decripta_seleciona_bloco;
								encripta <= '0';
							when others =>
						end case;
					end if;


					-- Seleciona o bloco a ser usado
				when st_encripta_seleciona_bloco =>
					if (i >= quantidade_blocos ) then
						estado <= st_menuOperacoes;
					else 
						estado <= st_encripta_recebe_ram;
					end if;

				-- recebe-o da ram
				when st_encripta_recebe_ram =>
					estado <= st_encripta_opera;

				-- opera
				when st_encripta_opera =>
					if (s_tdes_done = '1') then
						estado <= st_encripta_recebe_resultado;
					end if;

				-- recebe o resultado
				when st_encripta_recebe_resultado =>
					estado <= st_encripta_seleciona_bloco;



				-- Seleciona, na RAM qual o proximo bloco a ser operado
				when st_decripta_seleciona_bloco =>
					if (i >= quantidade_blocos ) then
						estado <= st_menuOperacoes;
					else
						estado <= st_decripta_recebe_ram;
					end if;

				-- Recebe o bloco escolhido
				when st_decripta_recebe_ram =>
					estado <= st_decripta_opera;

				-- Opera o bloco
				when st_decripta_opera =>
					if (s_tundes_done = '1') then
						estado <= st_decripta_recebe_resultado;
					end if;

				-- Salva o bloco operado
				when st_decripta_recebe_resultado =>
					estado <= st_decripta_seleciona_bloco;



--				when st_recebeChave=>
--					-- Verifica se a quantidade de dados lida e' um numero grande
--					if (contador(5 downto 0) = "110000") then 
--						estado  <= st_feedbackChave;
--					end if;


				when st_recebeChave_espera_hexa => 
					if(s_comm_recebido = '1' and contador < 48) then
						estado <= st_recebeChave_recebe_hexa;
					end if;

					if(contador >= 48) then
						estado <= st_feedbackChave;
					end if;

				when st_recebeChave_recebe_hexa =>
					estado <= st_recebeChave_decodifica_hexa;

				when st_recebeChave_decodifica_hexa =>
					if(s_comm_recebido = '0') then
						estado <= st_recebeChave_espera_hexa;
					end if;


				when st_feedbackChave =>
					if edge = "10" then
						estado <= st_menuChave;
					end if;

				when st_retornaChave =>
					if (edge = "11") then
						estado <= st_menuChave;
					end if;

				when st_menuChave =>
					if (s_comm_recebido = '1') then
						controle_recebido := '1';

					elsif (s_comm_recebido = '0' and controle_recebido = '1') then 
						controle_recebido := '0';

						case s_dado_recebido is 
							when x"46" => -- F
								estado <= st_menuPrincipal;
							when x"61" => -- a
								estado <= st_recebeChave_espera_hexa;
							when x"62" => -- b
								estado <= st_retornaChave;
							when x"63" => -- c
								estado <= st_feedbackChave;
							when others =>
						end case;
					end if;

					
				when st_menuTexto =>
					if (s_comm_recebido = '1') then
						controle_recebido := '1';

					elsif (s_comm_recebido = '0' and controle_recebido = '1') then 
						controle_recebido := '0';

						case s_dado_recebido is 
							when x"46" => -- F
								estado <= st_menuPrincipal;
							when x"61" => -- a
								estado <= st_carregando_texto;
							when x"62" => -- b
								estado <= st_inicializa_envio_texto;
							when x"63" => -- c
								estado <= st_feedbackTexto;
							when x"64" => -- d
								estado <= st_carregando_quantidade_blocos;
							when others =>
						end case;
					end if;


				when st_feedbackTexto =>
					if edge = "10" then
						estado <= st_menuTexto;
					end if;

				-- recebe quantidade de blocos de texto
				when st_carregando_quantidade_blocos =>
					if (contador > "0010") then
						estado <= st_menuTexto;
					end if;


				-- recebe o texto em blocos de 64 bits
				when st_carregando_texto =>
					if ((i >= quantidade_blocos)
							or 
						(i >= (2 ** (const_bits_endereco - 1)))) then
						estado <= st_feedbackTexto;
					end if;



				when st_inicializa_envio_texto =>
					estado <= st_retorna_texto_seleciona_bloco;


				-- Seleciona, na RAM qual o proximo bloco a ser operado
				when st_retorna_texto_seleciona_bloco =>
					if (i >= quantidade_blocos ) then
						estado <= st_menuTexto;
					else
						estado <= st_retorna_texto_recebe_ram;
					end if;

				-- Recebe o bloco escolhido
				when st_retorna_texto_recebe_ram =>
					estado <= st_retorna_texto_envia;

				-- Opera o bloco
				when st_retorna_texto_envia =>
					if contador >= "001000" then
						estado <= st_retorna_texto_seleciona_bloco;
					end if;

				when others =>
			end case;
		end if;
	end process;
		



-- EEEEEEE                                                    
-- EE      xx  xx   eee    cccc uu   uu   cccc   aa aa  oooo  
-- EEEEE     xx   ee   e cc     uu   uu cc      aa aaa oo  oo 
-- EE        xx   eeeee  cc     uu   uu cc     aa  aaa oo  oo 
-- EEEEEEE xx  xx  eeeee  ccccc  uuuu u  ccccc  aaa aa  oooo  

	-- Maquina de estados que realiza o processo de interface entre o hardware criptografico e a comunicacao
	PROCESS (clock)
		       variable flag : std_logic := '0';
		       variable bloco : std_logic_vector (63 downto 0);
	BEGIN
		if (clock'event and clock = '1') then
			
			CASE estado IS
				WHEN st_reset =>
					s_reset_all_modules       <= '1';
					s_reset_comunicacao       <= '0';

					s_tdecodificador_displays <= x"0000_0000";
					led_reset                 <= '1';
					leds_green                <= s_dado_recebido;

					s_comm_enviar             <= '0';
					s_dado_enviar             <= x"52"; -- 0
					s_dado_enviar             <= "00000000";

					flag                      := '0';
					contador                  <= (others => '0');
					edge                      <= "00";

					s_tdes_reset              <= '1';
					reg_key_192               <= (others => '0');
					--reg_key_192               <= x"133457799BBCDFF1133457799BBCDFF1133457799BBCDFF1";
					s_tdes_text64             <= (others => '0');
					--s_tdes_text64             <= x"0123456789ABCDEF";
					
					
				when st_menuPrincipal => 	
					leds_green                            <= s_dado_recebido;
					s_reset_all_modules                   <= '0';
					s_tdecodificador_displays(3 downto 0) <= x"1";
					led_reset                             <= '0';
					i                                     <= (others => '0');
					
				
				--  CCCCC  hh                             
				-- CC    C hh        aa aa vv   vv   eee  
				-- CC      hhhhhh   aa aaa  vv vv  ee   e 
				-- CC    C hh   hh aa  aaa   vvv   eeeee  
				--  CCCCC  hh   hh  aaa aa    v     eeeee 
				when st_menuChave=>
					leds_green                             <= s_dado_recebido;

					s_tdecodificador_displays(3 downto 0)  <=  x"C";
					s_tdecodificador_displays(31 downto 4) <=  x"0000000";
					contador                               <= "000000";
					edge                                   <= "00";
					flag                                   := '0';


				when st_recebeChave_espera_hexa =>
					leds_green                              <= "00" & contador(5 downto 0);
					s_tdecodificador_displays(3 downto 0)   <=  x"d";
					s_tdecodificador_displays(23 downto 20) <= s_dado_recebido(3 downto 0);
					s_tdecodificador_displays(11 downto 8)  <= contador(3 downto 0);
					s_tdecodificador_displays(15 downto 12) <= "00" & contador(5 downto 4);


				when st_recebeChave_recebe_hexa =>
					reg_key_192       <= std_logic_vector(shift_left(unsigned(reg_key_192), 4));
					bloco(7 downto 0) := s_dado_recebido(7 downto 0);
					contador          <= contador + 1; 


				when st_recebeChave_decodifica_hexa =>

					case bloco(7 downto 0) is
						when x"30" => reg_key_192(188 to 191) <= x"0";
						when x"31" => reg_key_192(188 to 191) <= x"1"; 
						when x"32" => reg_key_192(188 to 191) <= x"2";
						when x"33" => reg_key_192(188 to 191) <= x"3";
						when x"34" => reg_key_192(188 to 191) <= x"4"; 
						when x"35" => reg_key_192(188 to 191) <= x"5";
						when x"36" => reg_key_192(188 to 191) <= x"6";
						when x"37" => reg_key_192(188 to 191) <= x"7"; 
						when x"38" => reg_key_192(188 to 191) <= x"8";
						when x"39" => reg_key_192(188 to 191) <= x"9";
						when x"41" => reg_key_192(188 to 191) <= x"a"; 
						when x"42" => reg_key_192(188 to 191) <= x"b";
						when x"43" => reg_key_192(188 to 191) <= x"c";
						when x"44" => reg_key_192(188 to 191) <= x"d"; 
						when x"45" => reg_key_192(188 to 191) <= x"e";
						when x"46" => reg_key_192(188 to 191) <= x"f";
						when x"61" => reg_key_192(188 to 191) <= x"a"; 
						when x"62" => reg_key_192(188 to 191) <= x"b";
						when x"63" => reg_key_192(188 to 191) <= x"c";
						when x"64" => reg_key_192(188 to 191) <= x"d"; 
						when x"65" => reg_key_192(188 to 191) <= x"e";
						when x"66" => reg_key_192(188 to 191) <= x"f"; 
						when others => reg_key_192(188 to 191)<= x"0";
					end case;


			
				
				WHEN st_retornaChave =>
					s_tdecodificador_displays(3 downto 0) <=  x"2";
					
					case edge is
						when "00" =>

							if (s_comm_enviar_busy = '0') then
								case contador is
									when "000000" => 
										s_dado_enviar <= reg_key_192(  0 to 7 );   
										contador <= "000001";
									when "000001" => 
										s_dado_enviar <= reg_key_192(  8 to 15);  
										contador <= "000010";
									when "000010" => 
										s_dado_enviar <= reg_key_192( 16 to 23);  
										contador <= "000011";
									when "000011" => 
										s_dado_enviar <= reg_key_192( 24 to 31);  
										contador <= "000100";
									when "000100" => 
										s_dado_enviar <= reg_key_192( 32 to 39);  
										contador <= "000101";
									when "000101" => 
										s_dado_enviar <= reg_key_192( 40 to 47);  
										contador <= "000110";
									when "000110" => 
										s_dado_enviar <= reg_key_192( 48 to 55);  
										contador <= "000111";
									when "000111" => 
										s_dado_enviar <= reg_key_192( 56 to 63);  
										contador <= "001000";
									when "001000" => 
										s_dado_enviar <= reg_key_192( 64 to  71); 
										contador <= "001001";
									when "001001" => 
										s_dado_enviar <= reg_key_192( 72 to  79); 
										contador <= "001010";
									when "001010" => 
										s_dado_enviar <= reg_key_192( 80 to  87); 
										contador <= "001011";
									when "001011" => 
										s_dado_enviar <= reg_key_192( 88 to  95); 
										contador <= "001100";
									when "001100" => 
										s_dado_enviar <= reg_key_192( 96 to 103); 
										contador <= "001101";
									when "001101" => 
										s_dado_enviar <= reg_key_192(104 to 111); 
										contador <= "001110";
									when "001110" => 
										s_dado_enviar <= reg_key_192(112 to 119); 
										contador <= "001111";
									when "001111" => 
										s_dado_enviar <= reg_key_192(120 to 127); 
										contador <= "010000";
									when "010000" => 
										s_dado_enviar <= reg_key_192(128 to 135); 
										contador <= "010001";
									when "010001" => 
										s_dado_enviar <= reg_key_192(136 to 143); 
										contador <= "010010";
									when "010010" => 
										s_dado_enviar <= reg_key_192(144 to 151); 
										contador <= "010011";
									when "010011" => 
										s_dado_enviar <= reg_key_192(152 to 159); 
										contador <= "010100";
									when "010100" => 
										s_dado_enviar <= reg_key_192(160 to 167); 
										contador <= "010101";
									when "010101" => 
										s_dado_enviar <= reg_key_192(168 to 175); 
										contador <= "010110";
									when "010110" => 
										s_dado_enviar <= reg_key_192(176 to 183); 
										contador <= "010111";
									when "010111" => 
										s_dado_enviar <= reg_key_192(184 to 191); 
										contador <= "011000";
									when others  => s_dado_enviar <= "00000000";
								end case;

								s_comm_enviar <= '1';
								edge            <= "10";
							end if;
							
						when "10" => 
							s_comm_enviar <= '0';

							if contador >= "011000" then
								edge            <= "11";
								contador <= "111111";
							else
								edge            <= "00";
							end if;
							
						when "11" =>
							s_comm_enviar <= '0';
							contador <= "111111";
							edge            <= "11";
							
						when others =>
					end case;
					
				
				when st_feedbackChave =>
					case edge is
						when "00" =>
							--s_tdecodificador_displays(3 downto 0) <=  x"3";
							
							if (s_comm_enviar_busy = '0') then
								s_comm_enviar <= '1';
								s_dado_enviar <= x"6b"; -- k
								edge            <= "01";

							else 
								s_comm_enviar <= '0';
							end if;
						
						when "01" =>
							s_comm_enviar <= '0';
							
							if (s_comm_enviar_busy = '1') then
								edge <= "10";
							end if;
								
						when "10" => 
							s_comm_enviar <= '0';
						when others =>
					end case;
					
				
				
				
				-- TTTTTTT               tt           
				--   TTT     eee  xx  xx tt     oooo  
				--   TTT   ee   e   xx   tttt  oo  oo 
				--   TTT   eeeee    xx   tt    oo  oo 
				--   TTT    eeeee xx  xx  tttt  oooo

				when st_menuTexto=>
					leds_green                             <= s_dado_recebido;
					s_tdecodificador_displays(3 downto 0)  <=  x"a";
					s_tdecodificador_displays(19 downto 4)  <=  (others => '0');
					s_tdecodificador_displays(31 downto 20)<=  "00" & std_logic_vector(quantidade_blocos(const_bits_endereco - 1 downto 0));
					contador                               <= "000000";
					i                                      <= "0000000000";
					bloco                                  := (others => '0');
					edge                                   <= "00";
					flag                                   := '0';
					s_ram_escrita                          <= '0';


				-- Recebe a quantidade de blocos
				when st_carregando_quantidade_blocos =>
					s_tdecodificador_displays(3 downto 0)   <=  x"e";
					s_tdecodificador_displays(23 downto 20) <= s_dado_recebido(3 downto 0);

					if (contador < 3) then
						s_tdecodificador_displays(11 downto 8)  <= contador(3 downto 0);
						s_tdecodificador_displays(15 downto 12) <= "00" & contador(5 downto 4);
						
						if (s_comm_recebido = '1' and edge = "01") then
							bloco               := std_logic_vector(shift_left(unsigned(bloco), 4));
							bloco(3 downto 0) := s_dado_recebido(3 downto 0);
							contador     <= contador + 1; 
							edge                <= "00";
							
						elsif (s_comm_recebido = '0' and edge = "00") then
							edge                <= "01";
						end if;
					else 
						if (bloco < (2 ** (const_bits_endereco - 1))) then
							quantidade_blocos <= unsigned(bloco(const_bits_endereco - 1 downto 0));
						else 
							quantidade_blocos <= to_unsigned(2 ** (const_bits_endereco - 1), const_bits_endereco);
						end if;

					end if;


				-- Recebe o texto salvando na RAM
				when st_carregando_texto =>
					-- imprime nos displays
					s_tdecodificador_displays(3 downto 0)   <= x"b";
					s_tdecodificador_displays(11 downto 4)  <= "00" & contador;
					s_tdecodificador_displays(19 downto 12) <= s_dado_recebido;
					s_tdecodificador_displays(31 downto 20) <= "00" & std_logic_vector( i (const_bits_endereco - 1 downto 0));

					-- 00
					if (s_comm_recebido = '1' and edge = "00") then
						-- Preenche o bloco
						bloco             := std_logic_vector(shift_left(unsigned(bloco), 8));
						bloco(7 downto 0) := s_dado_recebido;
						--bloco(7 downto 0) := x"3" & std_logic_vector( s_dado_recebido(3 downto 0));
						contador          <= contador + 1; 
						edge              <= "01";

					elsif s_comm_recebido = '0' and edge = "01" then 
						if contador = "001000" then
							edge <= "10";
						else 
							edge <= "00";
						end if;

					elsif edge = "10" then 
						s_ram_escrita  <= '1';
						s_ram_endereco <= std_logic_vector(i);
						s_ram_datain   <= bloco;
						edge           <= "11";

					elsif edge = "11" then 
						s_ram_escrita  <= '0';
						contador      <= (others => '0');
						edge          <= "00";
						i             <= i + 1;

					end if;


				when st_inicializa_envio_texto =>
					i <= (others => '0');


				-- Seleciona qual bloco da ram sera operado
				when st_retorna_texto_seleciona_bloco =>
					s_ram_escrita  <= '0';
					edge           <= "00";
					contador       <= "000111";

					if (i < quantidade_blocos ) then
						s_ram_endereco <= std_logic_vector(i);
					end if;

				-- Recebe o bloco da ram
				when st_retorna_texto_recebe_ram =>

				-- Opera o bloco recebido pela ram
				when st_retorna_texto_envia =>
					case edge is
						when "00" =>
							if (s_comm_enviar_busy = '0') then
								case contador is
									--when "000111" =>  s_dado_enviar <= s_ram_dataout(7  downto 0 );  contador <= "000110";
									--when "000110" =>  s_dado_enviar <= s_ram_dataout(15 downto 8 );  contador <= "000101";
									--when "000101" =>  s_dado_enviar <= s_ram_dataout(23 downto 16);  contador <= "000100";
									--when "000100" =>  s_dado_enviar <= s_ram_dataout(31 downto 24);  contador <= "000011";
									--when "000011" =>  s_dado_enviar <= s_ram_dataout(39 downto 32);  contador <= "000010";
									--when "000010" =>  s_dado_enviar <= s_ram_dataout(47 downto 40);  contador <= "000001";
									--when "000001" =>  s_dado_enviar <= s_ram_dataout(55 downto 48);  contador <= "000000";
									--when "000000" =>  s_dado_enviar <= s_ram_dataout(63 downto 56);  contador <= "001000"; i <= i + 1;

									when "000111" =>  s_dado_enviar <= s_ram_dataout(63 downto 56);  contador <= "000110";
									when "000110" =>  s_dado_enviar <= s_ram_dataout(55 downto 48);  contador <= "000101";
									when "000101" =>  s_dado_enviar <= s_ram_dataout(47 downto 40);  contador <= "000100";
									when "000100" =>  s_dado_enviar <= s_ram_dataout(39 downto 32);  contador <= "000011";
									when "000011" =>  s_dado_enviar <= s_ram_dataout(31 downto 24);  contador <= "000010";
									when "000010" =>  s_dado_enviar <= s_ram_dataout(23 downto 16);  contador <= "000001";
									when "000001" =>  s_dado_enviar <= s_ram_dataout(15 downto 8 );  contador <= "000000";
									when "000000" =>  s_dado_enviar <= s_ram_dataout(7  downto 0 );  contador <= "001000"; i <= i + 1;
									when others  => s_dado_enviar <= "00000000";
								end case;

								s_comm_enviar <= '1';
								edge            <= "10";
							end if;
							
							
						when "10" => 
							s_comm_enviar <= '0';

							if (contador < "001000") then
								edge            <= "00";
							end if;
							
						when others =>
					end case;

				when st_feedbackTexto =>
					case edge is
						when "00" =>
							--s_tdecodificador_displays(3 downto 0) <=  x"3";
							
							if (s_comm_enviar_busy = '0') then
								s_comm_enviar <= '1';
								s_dado_enviar <= x"74"; -- k
								edge            <= "01";

							else 
								s_comm_enviar <= '0';
							end if;
						
						when "01" =>
							s_comm_enviar <= '0';
							
							if (s_comm_enviar_busy = '1') then
								edge <= "10";
							end if;
								
						when "10" => 
							s_comm_enviar <= '0';
						when others =>
					end case;






				--  OOOOO                                                      
				-- OO   OO pp pp     eee  rr rr    aa aa   cccc   aa aa  oooo  
				-- OO   OO ppp  pp ee   e rrr  r  aa aaa cc      aa aaa oo  oo 
				-- OO   OO pppppp  eeeee  rr     aa  aaa cc     aa  aaa oo  oo 
				--  OOOO0  pp       eeeee rr      aaa aa  ccccc  aaa aa  oooo  
				--         pp                                                  

				when st_menuOperacoes=>
					s_tdecodificador_displays(3 downto 0)  <= x"3";
					s_tdecodificador_displays(31 downto 4) <= (others => '0');
					leds_green                 	           <= s_dado_recebido;
					s_tdes_reset               	           <= '1';
					s_tundes_reset             	           <= '1';
					contador                   	           <= (others => '0');
					i                          	           <= (others => '0');
					edge                       	           <= (others => '0');
					flag                       	           := '0';
					bloco                                  := (others => '0');



				-- Seleciona qual bloco da ram sera operado
				when st_encripta_seleciona_bloco =>
					s_ram_escrita  <= '0';
					s_tdes_reset   <= '1';
					s_ram_endereco <= std_logic_vector(i);
					if (i >= quantidade_blocos ) then
						i <= (others => '0');
					end if;

				-- Recebe o bloco da ram
				when st_encripta_recebe_ram =>

				-- Opera o bloco recebido pela ram
				when st_encripta_opera =>
					s_tdes_reset  <= '0';
					s_tdes_text64 <= s_ram_dataout;
					

				-- Salva o resultado na ram
				when st_encripta_recebe_resultado =>
					s_ram_escrita  <= '1';	
					s_tdes_reset   <= '0'; 
					s_ram_datain   <= s_tdes_textOut64;
					s_ram_endereco <= std_logic_vector(i +  -- unsigned to std
											to_unsigned( -- offset
												2 ** (const_bits_endereco - 1)
												, const_bits_endereco)
											);
					i              <= i + 1;



				-- Seleciona qual bloco da ram sera operado
				when st_decripta_seleciona_bloco =>
					s_ram_escrita  <= '0';
					s_tundes_reset <= '1';
					s_ram_endereco <= std_logic_vector(i);
					if (i >= quantidade_blocos ) then
						i <= (others => '0');
					end if;

				-- Recebe o bloco da ram
				when st_decripta_recebe_ram =>

				-- Opera o bloco recebido pela ram
				when st_decripta_opera =>
					s_tundes_reset  <= '0';
					s_tundes_text64 <= s_ram_dataout;

				-- Salva o resultado na ram
				when st_decripta_recebe_resultado =>
					s_ram_escrita  <= '1';	
					s_tundes_reset <= '0'; 
					s_ram_datain   <= s_tdes_textOut64;
					s_ram_endereco <= std_logic_vector(i +  -- unsigned to std
											to_unsigned( -- offset
												2 ** (const_bits_endereco - 1)
												, const_bits_endereco)
											);
					i              <= i + 1;



--				when st_retornaResultado=>
--					s_tdecodificador_displays(3 downto 0) <=  x"7";
--					
--
--					if (contador >= 8) then
--						s_ram_escrita <= '0';
--						s_ram_endereco <= std_logic_vector(i);
--						contador <= "000111";
--					else
--
--						case edge is
--							when "00" =>
--								if (s_comm_enviar_busy = '0') then
--									case contador is
--										when "000111" =>  s_dado_enviar <= s_ram_dataout(63 downto 56);  contador <= "000110";
--										when "000110" =>  s_dado_enviar <= s_ram_dataout(55 downto 48);  contador <= "000101";
--										when "000101" =>  s_dado_enviar <= s_ram_dataout(47 downto 40);  contador <= "000100";
--										when "000100" =>  s_dado_enviar <= s_ram_dataout(39 downto 32);  contador <= "000011";
--										when "000011" =>  s_dado_enviar <= s_ram_dataout(31 downto 24);  contador <= "000010";
--										when "000010" =>  s_dado_enviar <= s_ram_dataout(23 downto 16);  contador <= "000001";
--										when "000001" =>  s_dado_enviar <= s_ram_dataout(15 downto 8 );  contador <= "000000";
--										when "000000" =>  s_dado_enviar <= s_ram_dataout(7  downto 0 );  contador <= "001000"; i <= i + 1;
--										when others  => s_dado_enviar <= "00000000";
--									end case;
--
--									s_comm_enviar <= '1';
--									edge            <= "10";
--								end if;
--								
--								
--							when "10" => 
--								s_comm_enviar <= '0';
--
--								if contador >= "001000" then
--									edge            <= "11";
--									contador <= "011110";		
--
--								else
--									edge            <= "00";
--								end if;
--								
--								
--							when "11" =>
--								s_comm_enviar <= '0';
--								contador <= "011110";
--								edge <= "11";
--								
--							when others =>
--						end case;
--					end if;






				-- Seleciona qual bloco da ram sera operado
				when st_resultado_seleciona_bloco =>
					s_ram_escrita  <= '0';
					edge           <= "00";
					contador       <= "000111";
					s_ram_endereco <= std_logic_vector(i +  -- unsigned to std
											to_unsigned( -- offset
												2 ** (const_bits_endereco - 1)
												, const_bits_endereco)
											);

					if (i >= quantidade_blocos ) then
						i <= (others => '0');
					end if;

				-- Recebe o bloco da ram
				when st_resultado_recebe_ram =>

				-- Opera o bloco recebido pela ram
				when st_resultado_envia =>
					case edge is
						when "00" =>
							if (s_comm_enviar_busy = '0') then
								case contador is
									when "000111" =>  s_dado_enviar <= s_ram_dataout(63 downto 56);  contador <= "000110";
									when "000110" =>  s_dado_enviar <= s_ram_dataout(55 downto 48);  contador <= "000101";
									when "000101" =>  s_dado_enviar <= s_ram_dataout(47 downto 40);  contador <= "000100";
									when "000100" =>  s_dado_enviar <= s_ram_dataout(39 downto 32);  contador <= "000011";
									when "000011" =>  s_dado_enviar <= s_ram_dataout(31 downto 24);  contador <= "000010";
									when "000010" =>  s_dado_enviar <= s_ram_dataout(23 downto 16);  contador <= "000001";
									when "000001" =>  s_dado_enviar <= s_ram_dataout(15 downto 8 );  contador <= "000000";
									when "000000" =>  s_dado_enviar <= s_ram_dataout(7  downto 0 );  contador <= "001000"; i <= i + 1;

									-- when "000111" =>  s_dado_enviar <= s_ram_dataout(7  downto 0 );  contador <= "000110";
									-- when "000110" =>  s_dado_enviar <= s_ram_dataout(15 downto 8 );  contador <= "000101";
									-- when "000101" =>  s_dado_enviar <= s_ram_dataout(23 downto 16);  contador <= "000100";
									-- when "000100" =>  s_dado_enviar <= s_ram_dataout(31 downto 24);  contador <= "000011";
									-- when "000011" =>  s_dado_enviar <= s_ram_dataout(39 downto 32);  contador <= "000010";
									-- when "000010" =>  s_dado_enviar <= s_ram_dataout(47 downto 40);  contador <= "000001";
									-- when "000001" =>  s_dado_enviar <= s_ram_dataout(55 downto 48);  contador <= "000000";
									-- when "000000" =>  s_dado_enviar <= s_ram_dataout(63 downto 56);  contador <= "001000"; i <= i + 1;

									when others  => s_dado_enviar <= "00000000";
								end case;

								s_comm_enviar <= '1';
								edge            <= "10";
							end if;
							
							
						when "10" => 
							s_comm_enviar <= '0';

							if (contador < "001000") then
								edge            <= "00";
							end if;
							
						when others =>
					end case;



				When others => 
			END CASE;
		end if;
	END PROCESS;

end TDES_Project_behav;