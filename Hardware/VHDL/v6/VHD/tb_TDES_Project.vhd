LIBRARY IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use ieee.numeric_std.all;  

ENTITY tb_TDES_Project IS
END tb_TDES_Project;

ARCHITECTURE tb_TDES_Project_behav OF tb_TDES_Project IS

	-- Importação de componente
	COMPONENT TDES_Project port (
		clock              : in  std_logic; -- Clock FPGA
		botao_0            : in  std_logic; -- botao
		botao_1            : in  std_logic; -- botao
		botao_2            : in  std_logic; -- botao
		botao_3            : in  std_logic; -- botao
		leds_green         : out std_logic_vector(7 downto 0); -- leds_green
		led_reset          : out std_logic; -- Informa reset
		--ledr               : out std_logic_vector(3 downto 0); -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! inutilizado
		pin_1_in           : in  std_logic; 
		pin_5_out          : out std_logic; 
		bus_displays_out   : out std_logic_vector(55 downto 0)
		);
	END COMPONENT;
	signal s_clock              : std_logic                    := '0'; -- Clock FPGA
	signal s_botao_0            : std_logic                    := '0'; -- botao
	signal s_botao_1            : std_logic                    := '0'; -- botao
	signal s_botao_2            : std_logic                    := '0'; -- botao
	signal s_botao_3            : std_logic                    := '0'; -- botao
	signal s_leds_green         : std_logic_vector(7 downto 0) := (others => '0'); -- leds_green
	signal s_led_reset          : std_logic                    := '0'; -- Informa reset
	--signal s_ledr               : std_logic_vector(3 downto 0) := (others => '0'); -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! inutilizado
	signal s_pin_1_in           : std_logic                    := '0'; 
	signal s_pin_5_out          : std_logic                    := '0'; 
	signal s_bus_displays_out   : std_logic_vector(55 downto 0):= (others => '0');


	COMPONENT newClock port (
	    clock_fpga : in std_logic;                         -- clock
		choice     : in std_logic_vector(2 downto 0);
		newClock  : out std_logic
		);
	END COMPONENT;

    signal s_clock_fpga : std_logic                     := '0';                         -- clock
	signal s_newClock   : std_logic                     := '0';
	signal s_choice     : std_logic_vector(2 downto 0)  := (others => '0');
   	constant half_period  : time                        := 1 ns;


	type st_type is (st_reset, 
					st_0, st_nada,
					st_1,
					st_2,
					st_3,
					st_4, st_4_1, st_4_2,
					st_5,
					st_6,
					st_7,
					st_8,
					st_8_1,
					st_8_2,
					st_8_3,
					st_8_4,
					st_8_5_1_1,
					st_8_5_1_2,
					st_8_5_2_1,
					st_8_5_2_2,
					st_8_5_3_1,
					st_8_5_3_2,
					st_8_8,
					st_9,
					st_10,
					st_11_1,
					st_11_2,
					st_12,
					st_13,
					st_14,
					st_15,
					st_16,
					st_17,
					st_18,
					st_19);
	
	signal estado                          : st_type := st_reset;




	-- 986 / 16 = 61,625.     (62 * 16) - (61,625 * 16) = 6 nibble que serão adicionados
	--signal texto : std_logic_vector (0 to (62 * 64) - 1) := x"477561726461692d766f7320646f732066616c736f732070726f66657461732c207175652076c3aa6d20612076c3b37320636f6d20766573746573206465206f76656c6861732c206d617320706f722064656e74726f2073c3a36f206c6f626f7320766f72617a65732e2050656c6f73207365757320667275746f73206f7320636f6e68656365726569732e20436f6c68656d2d73652c20706f7276656e747572612c207576617320646f7320657370696e686569726f732c206f75206669676f7320646f73206162726f6c686f733f20417373696d20746f6461206120c3a172766f726520626f612064c3a120626f6e7320667275746f732c20706f72c3a96d206120c3a172766f7265206dc3a12064c3a1206d61757320667275746f732e20556d6120c3a172766f726520626f61206ec3a36f20706f646520646172206d61757320667275746f732c206e656d20756d6120c3a172766f7265206dc3a12064617220626f6e7320667275746f732e20546f6461206120c3a172766f726520717565206ec3a36f2064c3a120626f6d20667275746f2c20c3a920636f72746164612065206c616ec3a7616461206e6f20666f676f2e204c6f676f2070656c6f207365757320667275746f73206f7320636f6e68656365726569732e20284d617465757320373a31352d323029000000";

	signal texto : std_logic_vector (0 to (62 * 64) - 1) := x"49dd93d0e4556a649c999d50269228062a6612015bca2013c6c77102fb42501ae6d1e3cf19ef877233a4a9eac78fe384a7bbae8c75826f696f315c4fbcf4dac1958aae2afec07dfc7fc563259b3fea11e2aaeafec635749ef6fe931c9deb3dfff96eb0fd7cf6d5bbc08016850ae344dc7943be553d4196e11f70b1ea16b82c8b72500ab1f43f098ac8ff527431c4b86d6d858b7c65425f00a4027e6f1bc6d2c6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

	signal i : std_logic_vector (3 downto 0) := (others => '0');
	signal j : std_logic_vector (3 downto 0) := (others => '0');
BEGIN
	-- Mapeamento de portas
	UUT_tdes: TDES_Project PORT MAP(
		clock            => s_clock           ,
		botao_0          => s_botao_0         ,
		botao_1          => s_botao_1         ,
		botao_2          => s_botao_2         ,
		botao_3          => s_botao_3         ,
		leds_green       => s_leds_green      ,
		led_reset        => s_led_reset       ,
		--ledr             => s_ledr            ,
		pin_1_in         => s_pin_1_in        ,
		pin_5_out        => s_pin_5_out       ,
		bus_displays_out => s_bus_displays_out
	);

	-- Mapeamento de portas
	UUT_entity_rom1: newClock PORT MAP(
	    clock_fpga => s_clock_fpga,
		choice  => s_choice,
		newClock => s_newClock
	);

	processClk: Process 
	BEGIN
		s_clock <= '0';
		wait for 1 ns;
		s_clock <= '1';
		wait for 1 ns;
	END PROCESS;

	s_choice <= "000";
	s_clock_fpga <= not s_clock_fpga after half_period;




	-- Processo de gereneciamento da maquina de estados da interface
	process (s_newClock)
	begin
		-- Quando os botoes 3 e 2 estao pressionados, o sistema e' resetado
		if (rising_edge(s_newClock)) then
			case estado is

				-- O sistema so reinicia quando recebe o comando 's'
				when st_reset=>
					estado <= st_0;

				when st_0 =>
					estado <= st_nada;

				when st_nada =>
					if (i > "1000") then
						estado <= st_1;
					end if;

				when st_1 =>
					if (i > "1000") then
						estado <= st_2;
					end if;

				when st_2 =>
					if (i > "1000") then
						estado <= st_3;
					end if;

				when st_3 =>
					if (i > "1000") then
						estado <= st_4;
					end if;

				when st_4 =>
					if (i > "1000") then
						estado <= st_4_1;
					end if;

				when st_4_1 =>
					if (i > "1000") then
						estado <= st_4_2;
					end if;

				when st_4_2 =>
					if (i > "1000") then
						estado <= st_5;
					end if;

				when st_5 =>
					if (i > "1000") then
						estado <= st_6;
					end if;

				when st_6 =>
					if (j > "0111") then
						estado <= st_7;
					end if;

				when st_7 =>
					if (j > "0111") then
						estado <= st_8_1;
					end if;

				when st_8_1 =>
					if (i > "1000") then
						estado <= st_8_2;
					end if;

				when st_8_2 =>
					if (i > "1000") then
						estado <= st_8_3;
					end if;

				when st_8_3 =>
					if (i > "1000") then
						estado <= st_8_4;
					end if;

				when st_8_4 =>
					if (i > "1000") then
						estado <= st_8_5_1_1;
					end if;

				when st_8_5_1_1 =>
					if (j > "0111") then
						estado <= st_8_5_1_2;
					end if;

				when st_8_5_1_2 =>
					if (j > "0111") then
						estado <= st_8_5_2_1;
					end if;

				when st_8_5_2_1 =>
					if (j > "0111") then
						estado <= st_8_5_2_2;
					end if;

				when st_8_5_2_2 =>
					if (j > "0111") then
						estado <= st_8_5_3_1;
					end if;

				when st_8_5_3_1 =>
					if (j > "0111") then
						estado <= st_8_5_3_2;
					end if;

				when st_8_5_3_2 =>
					if (j > "0111") then
						estado <= st_8_8;
					end if;



				when st_8_8 =>
					if (i > "1000") then
						estado <= st_9;
					end if;



				when st_9 =>
					if (i > "1000") then
						estado <= st_10;
					end if;

				when st_10 =>
					if (i > "1000") then
						estado <= st_11_1;
					end if;

				when st_11_1 =>
					if (i > "1000") then
						estado <= st_11_2;
					end if;

				when st_11_2 =>
					if (i > "1000") then
						estado <= st_12;
					end if;

				when st_12 =>
					if (i > "1000") then
						estado <= st_13;
					end if;

				when st_13 =>
					if (i > "1000") then
						estado <= st_14;
					end if;

--				when st_ =>
--					estado <= st_;

				when others =>
			end case;
		end if;
	end process;





	-- Maquina de estados que realiza o processo de interface entre o hardware criptografico e a comunicacao
	PROCESS (s_clock)
		variable flag : std_logic := '0';
		variable byte : std_logic_vector (7 downto 0) := (others => '0');
		variable bloco : std_logic_vector (63 downto 0) := (others => '0');
	BEGIN
		if (s_clock'event and s_clock = '1') then
			
			CASE estado IS
				when st_reset =>
					s_botao_0          <= '0'; 
					s_botao_1          <= '0'; 
					s_pin_1_in         <= '1'; 
					s_botao_3 <= '0';
					s_botao_2 <= '0';

				when st_0 =>
					-- Define tipo de operacao
					s_botao_3 <= '1';
					s_botao_2 <= '1';

				-- envia nada
				WHEN st_nada =>
					byte := x"ff"; 

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '1';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;



				-- menu principal
				WHEN st_1 =>
					byte := x"73"; -- s

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;






				-- menu texto
				WHEN st_2 =>
					byte := x"74"; -- t

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';    i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';    i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;

				-- quantidade blocos
				WHEN st_3 =>
					byte := x"64";

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;


				-- envia quantidade de blocos - pt 1
				WHEN st_4 =>
					byte := x"00";

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;


				-- envia quantidade de blocos - pt 2
				WHEN st_4_1 =>
					byte := x"00";

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;


				-- envia quantidade de blocos - pt 3
				WHEN st_4_2 =>
					byte := x"02";

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;






				-- define texto
				WHEN st_5 =>
					byte := x"61";

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;


				-- envia bloco de texto 1
				WHEN st_6 =>
					-- bloco := x"6c6f666c6f646f72"; --72 6f 64 6f 6c 66 6f 6c  61 62 69 61 70 61 72 69 encripta
					bloco := x"6398f5305d175929";  -- 29 59 17 5d 30 f5 98 63  	f4	ad	d0	c8	b9	e2	5f	77 decripta
 
						
					if (s_newClock = '1' and flag = '0') then  

						if (i = "1001" or j > "0111") then

							case j is 
								when "0000" => j <= j + 1; 
								when "0001" => j <= j + 1; 
								when "0010" => j <= j + 1; 
								when "0011" => j <= j + 1; 
								when "0100" => j <= j + 1; 
								when "0101" => j <= j + 1; 
								when "0110" => j <= j + 1; 
								when "0111" => j <= j + 1; 
								when "1000" => j <= (others => '0');  
								when "1001" => j <= (others => '0');
								when others => j <= (others => '0');
							end case;

						end if;

						case i is 
							when "0000" => s_pin_1_in <= '0';                                          flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= bloco (0  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= bloco (1  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= bloco (2  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= bloco (3  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= bloco (4  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= bloco (5  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= bloco (6  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= bloco (7  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

						end if ;

				-- envia bloco de texto 2
				WHEN st_7 =>
					-- bloco := x"6972617061696261"; -- 61 62 69 61 70 61 72 69 encripta
					bloco := x"775fe2b9c8d0adf4"; -- f4	ad	d0	c8	b9	e2	5f	77 decripta
						
					if (s_newClock = '1' and flag = '0') then  

						if (i = "1001" or j > "0111") then

							case j is 
								when "0000" => j <= j + 1; 
								when "0001" => j <= j + 1; 
								when "0010" => j <= j + 1; 
								when "0011" => j <= j + 1; 
								when "0100" => j <= j + 1; 
								when "0101" => j <= j + 1; 
								when "0110" => j <= j + 1; 
								when "0111" => j <= j + 1; 
								when "1000" => j <= (others => '0');  
								when "1001" => j <= (others => '0');
								when others => j <= (others => '0');
							end case;

						end if;

						case i is 
							when "0000" => s_pin_1_in <= '0';                                          flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= bloco (0  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= bloco (1  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= bloco (2  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= bloco (3  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= bloco (4  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= bloco (5  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= bloco (6  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= bloco (7  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;


				-- nada
				WHEN st_8_1 =>
					byte := x"66";

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;


				-- principal
				WHEN st_8_2 =>
					byte := x"46"; --F

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;


				-- menu chave
				WHEN st_8_3 =>
					byte := x"6B"; --k

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;



					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;


				-- define chave
				WHEN st_8_4 =>
					byte := x"61"; --a

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;



				-- envia bloco de texto 1
				WHEN st_8_5_1_1 =>
					bloco := x"3333323331333033"; 
						
					if (s_newClock = '1' and flag = '0') then  

						if (i = "1001" or j > "0111") then

							case j is 
								when "0000" => j <= j + 1; 
								when "0001" => j <= j + 1; 
								when "0010" => j <= j + 1; 
								when "0011" => j <= j + 1; 
								when "0100" => j <= j + 1; 
								when "0101" => j <= j + 1; 
								when "0110" => j <= j + 1; 
								when "0111" => j <= j + 1; 
								when "1000" => j <= (others => '0');  
								when "1001" => j <= (others => '0');
								when others => j <= (others => '0');
							end case;

						end if;

						case i is 
							when "0000" => s_pin_1_in <= '0';                                          flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= bloco (0  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= bloco (1  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= bloco (2  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= bloco (3  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= bloco (4  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= bloco (5  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= bloco (6  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= bloco (7  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

						end if ;


				-- envia bloco de texto 1
				WHEN st_8_5_1_2 =>
					bloco := x"3733363335333433"; --72 6f 64 6f 6c 66 6f 6c  61 62 69 61 70 61 72 69
						
					if (s_newClock = '1' and flag = '0') then  

						if (i = "1001" or j > "0111") then

							case j is 
								when "0000" => j <= j + 1; 
								when "0001" => j <= j + 1; 
								when "0010" => j <= j + 1; 
								when "0011" => j <= j + 1; 
								when "0100" => j <= j + 1; 
								when "0101" => j <= j + 1; 
								when "0110" => j <= j + 1; 
								when "0111" => j <= j + 1; 
								when "1000" => j <= (others => '0');  
								when "1001" => j <= (others => '0');
								when others => j <= (others => '0');
							end case;

						end if;

						case i is 
							when "0000" => s_pin_1_in <= '0';                                          flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= bloco (0  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= bloco (1  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= bloco (2  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= bloco (3  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= bloco (4  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= bloco (5  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= bloco (6  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= bloco (7  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

						end if ;

				-- envia bloco de texto 1
				WHEN st_8_5_2_1 =>
					bloco := x"3333323331333033"; 
						
					if (s_newClock = '1' and flag = '0') then  

						if (i = "1001" or j > "0111") then

							case j is 
								when "0000" => j <= j + 1; 
								when "0001" => j <= j + 1; 
								when "0010" => j <= j + 1; 
								when "0011" => j <= j + 1; 
								when "0100" => j <= j + 1; 
								when "0101" => j <= j + 1; 
								when "0110" => j <= j + 1; 
								when "0111" => j <= j + 1; 
								when "1000" => j <= (others => '0');  
								when "1001" => j <= (others => '0');
								when others => j <= (others => '0');
							end case;

						end if;

						case i is 
							when "0000" => s_pin_1_in <= '0';                                          flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= bloco (0  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= bloco (1  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= bloco (2  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= bloco (3  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= bloco (4  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= bloco (5  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= bloco (6  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= bloco (7  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

						end if ;


				-- envia bloco de texto 1
				WHEN st_8_5_2_2 =>
					bloco := x"3733363335333433"; --72 6f 64 6f 6c 66 6f 6c  61 62 69 61 70 61 72 69
						
					if (s_newClock = '1' and flag = '0') then  

						if (i = "1001" or j > "0111") then

							case j is 
								when "0000" => j <= j + 1; 
								when "0001" => j <= j + 1; 
								when "0010" => j <= j + 1; 
								when "0011" => j <= j + 1; 
								when "0100" => j <= j + 1; 
								when "0101" => j <= j + 1; 
								when "0110" => j <= j + 1; 
								when "0111" => j <= j + 1; 
								when "1000" => j <= (others => '0');  
								when "1001" => j <= (others => '0');
								when others => j <= (others => '0');
							end case;

						end if;

						case i is 
							when "0000" => s_pin_1_in <= '0';                                          flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= bloco (0  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= bloco (1  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= bloco (2  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= bloco (3  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= bloco (4  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= bloco (5  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= bloco (6  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= bloco (7  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

						end if ;


				-- envia bloco de texto 1
				WHEN st_8_5_3_1 =>
					bloco := x"3333323331333033"; 
						
					if (s_newClock = '1' and flag = '0') then  

						if (i = "1001" or j > "0111") then

							case j is 
								when "0000" => j <= j + 1; 
								when "0001" => j <= j + 1; 
								when "0010" => j <= j + 1; 
								when "0011" => j <= j + 1; 
								when "0100" => j <= j + 1; 
								when "0101" => j <= j + 1; 
								when "0110" => j <= j + 1; 
								when "0111" => j <= j + 1; 
								when "1000" => j <= (others => '0');  
								when "1001" => j <= (others => '0');
								when others => j <= (others => '0');
							end case;

						end if;

						case i is 
							when "0000" => s_pin_1_in <= '0';                                          flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= bloco (0  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= bloco (1  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= bloco (2  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= bloco (3  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= bloco (4  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= bloco (5  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= bloco (6  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= bloco (7  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

						end if ;


				-- envia bloco de texto 1
				WHEN st_8_5_3_2 =>
					bloco := x"3733363335333433"; --72 6f 64 6f 6c 66 6f 6c  61 62 69 61 70 61 72 69
						
					if (s_newClock = '1' and flag = '0') then  

						if (i = "1001" or j > "0111") then

							case j is 
								when "0000" => j <= j + 1; 
								when "0001" => j <= j + 1; 
								when "0010" => j <= j + 1; 
								when "0011" => j <= j + 1; 
								when "0100" => j <= j + 1; 
								when "0101" => j <= j + 1; 
								when "0110" => j <= j + 1; 
								when "0111" => j <= j + 1; 
								when "1000" => j <= (others => '0');  
								when "1001" => j <= (others => '0');
								when others => j <= (others => '0');
							end case;

						end if;

						case i is 
							when "0000" => s_pin_1_in <= '0';                                          flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= bloco (0  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= bloco (1  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= bloco (2  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= bloco (3  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= bloco (4  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= bloco (5  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= bloco (6  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= bloco (7  +  (to_integer(unsigned(j)) * 8));    flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';                                          flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

						end if ;




				-- define chave
				WHEN st_8_8 =>
					byte := x"46"; --F

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;





				-- define texto
				WHEN st_9 =>
					byte := x"6f"; --o

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;


				-- define texto
				WHEN st_10 =>
					byte := x"62"; --b

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;









				-- envia nada
				WHEN st_11_1 =>
					byte := x"ff"; 

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '1';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;

				-- envia nada
				WHEN st_11_2 =>
					byte := x"ff"; 

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '1';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;


				-- menu principal
				WHEN st_12 =>
					byte := x"46"; --F

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;




				-- define texto
				WHEN st_13 =>
					byte := x"66"; --f

					if (s_newClock = '1' and flag = '0') then  

						case i is 
							when "0000" => s_pin_1_in <= '0';        flag := '1';   i <= i + 1; 
							when "0001" => s_pin_1_in <= byte (0);   flag := '1';   i <= i + 1; 
							when "0010" => s_pin_1_in <= byte (1);   flag := '1';   i <= i + 1; 
							when "0011" => s_pin_1_in <= byte (2);   flag := '1';   i <= i + 1; 
							when "0100" => s_pin_1_in <= byte (3);   flag := '1';   i <= i + 1; 
							when "0101" => s_pin_1_in <= byte (4);   flag := '1';   i <= i + 1; 
							when "0110" => s_pin_1_in <= byte (5);   flag := '1';   i <= i + 1; 
							when "0111" => s_pin_1_in <= byte (6);   flag := '1';   i <= i + 1; 
							when "1000" => s_pin_1_in <= byte (7);   flag := '1';   i <= i + 1;  
							when "1001" => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
							when others => s_pin_1_in <= '1';        flag := '1';   i <= (others => '0');
						end case;

					elsif (s_newClock = '0' and flag = '1') then
						flag := '0';

					end if ;






				-- define texto
				WHEN st_14 =>
					s_pin_1_in <= '1';
					byte       := x"00"; 
					i          <= (others => '0');
					flag       := '0';

					
--				when st_menuPrincipal => 	
--					leds_green                             <= s_dado_recebido;
--					s_tdecodificador_displays(3 downto 0) <= x"0";
--					led_reset                              <= '0';
					







--	-- Processo responsavel pela variação no dado de entrada
--	signal_dadoA: PROCESS
--	BEGIN
		--0123456789ABCDEF
		--key-133457799BBCDFF1

-- Guardai-vos dos falsos profetas, que vêm a vós com vestes de ovelhas, mas por dentro são lobos vorazes. Pelos seus frutos os conhecereis. Colhem-se, porventura, uvas dos espinheiros, ou figos dos abrolhos? Assim toda a árvore boa dá bons frutos, porém a árvore má dá maus frutos. Uma árvore boa não pode dar maus frutos, nem uma árvore má dar bons frutos. Toda a árvore que não dá bom fruto, é cortada e lançada no fogo. Logo pelo seus frutos os conhecereis. (Mateus 7:15-20)
-- 477561726461692d766f7320646f732066616c736f732070726f66657461732c207175652076c3aa6d20612076c3b37320636f6d20766573746573206465206f76656c6861732c206d617320706f722064656e74726f2073c3a36f206c6f626f7320766f72617a65732e2050656c6f73207365757320667275746f73206f7320636f6e68656365726569732e20436f6c68656d2d73652c20706f7276656e747572612c207576617320646f7320657370696e686569726f732c206f75206669676f7320646f73206162726f6c686f733f20417373696d20746f6461206120c3a172766f726520626f612064c3a120626f6e7320667275746f732c20706f72c3a96d206120c3a172766f7265206dc3a12064c3a1206d61757320667275746f732e20556d6120c3a172766f726520626f61206ec3a36f20706f646520646172206d61757320667275746f732c206e656d20756d6120c3a172766f7265206dc3a12064617220626f6e7320667275746f732e20546f6461206120c3a172766f726520717565206ec3a36f2064c3a120626f6d20667275746f2c20c3a920636f72746164612065206c616ec3a7616461206e6f20666f676f2e204c6f676f2070656c6f207365757320667275746f73206f7320636f6e68656365726569732e20284d617465757320373a31352d323029


--		s_inStable <= '0';
--		wait for 2 ns;
--
--
--		-- Define chave
--		s_barramentoIn <= x"1133457799BBCDFF";
--		s_inStable <= '1';
--		wait for 2 ns;
--
--		s_inStable <= '0';
--		wait for 2 ns;
--
--		-- Define chave
--		s_barramentoIn <= x"1133457799BBCDFF";
--		s_inStable <= '1';
--		wait for 2 ns;
--
--		s_inStable <= '0';
--		wait for 2 ns;
--
--		-- Define chave
--		s_barramentoIn <= x"1133457799BBCDFF";
--		s_inStable <= '1';
--		wait for 2 ns;
--
--		s_inStable <= '0';
--		wait for 2 ns;
--		
--
--		-- Define quantidade blocos
--		s_barramentoIn <= x"000000000000003d";
--		s_inStable <= '1';
--		wait for 2 ns;
--
--		s_inStable <= '0';
--		wait for 2 ns;
--
--
--
--		for I in 0 to 61 loop
--			s_barramentoIn <= texto(i * 64 to (i + 1) * 64 - 1);
--			s_inStable <= '1';
--			wait for 2 ns;
--	
--			s_inStable <= '0';
--			wait for 2 ns;
--		end loop;
--
--
--
----		-- Define blocos
----		s_barramentoIn <= x"726f646f6c666f6c";
----		s_inStable <= '1';
----		wait for 2 ns;
----
----		s_inStable <= '0';
----		wait for 2 ns;
----
----
----
----		-- Define blocos
----		s_barramentoIn <= x"6162696170617269";
----		s_inStable <= '1';
----		wait for 2 ns;
--
--		s_inStable <= '0';
--		wait for 2 ns;
--
--		
--		s_inStable <= '1';
--		wait for 2 ns;
--
--		s_inStable <= '0';
--		wait for 2 ns;
--
--
--		wait for 2 ms;

--		wait; -- forever
--	END PROCESS;



				when others =>
			end case;
		end if;
	end process;

END ARCHITECTURE tb_TDES_Project_behav;