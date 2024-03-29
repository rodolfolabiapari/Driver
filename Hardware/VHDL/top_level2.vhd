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
	signal sig_enviar_busy      : std_logic; 
	signal sig_enviar           : std_logic := '0';
	signal sig_receber          : std_logic_vector (7 downto 0); 

	signal sig_decod_In         : std_logic_vector (3 downto 0);

	signal sig_uart_display8seg : std_logic_vector (7 downto 0);
	type state_type is (reset, recebeChave, retornaChave, recebeTexto);

	-- Register to hold the current state
	signal estado               : state_type := reset;
	signal countEstado          : std_logic_vector(3 downto 0) := "0000";
	signal countBytesLidos      : std_logic_vector(3 downto 0) := "00000";
	signal botaoAvancaByte      : std_logic;

	component uart is
	port (
		clock               : in  std_logic; -- Clock FPGA
		comando_enviar      : in  std_logic; -- botao
		recebido            : out std_logic_vector(7 downto 0); -- Leds
		enviar              : in  std_logic_vector(7 downto 0); -- Leds
		enviar_busy         : out std_logic;
		uart_tx             : out std_logic; -- Saida Tx
		uart_rx             : in  std_logic;
		som                 : out std_logic;
		A, B, C, D, E, F, G : out std_logic
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
		clock          => clock,
		comando_enviar => sig_enviar,
		recebido       => sig_receber,
		enviar         => sig_dado_enviar,
		enviar_busy    => sig_enviar_busy,
		uart_tx        => sig_uart_tx,
		uart_rx        => pinIn121,
		A              => sig_uart_display8seg(0),
		B              => sig_uart_display8seg(1),
		C              => sig_uart_display8seg(2),
		D              => sig_uart_display8seg(3),
		E              => sig_uart_display8seg(4),
		F              => sig_uart_display8seg(5),
		G              => sig_uart_display8seg(6)
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
	--ledred <= not sig_receber;

	-- Logic to advance to the next state
	process (clock, botao4, botao3)
	signal completado : std_logic := 0;
	begin
		if botao4 = '0' and botao3 = '0' then
			estado <= reset;
			countEstado <= "0000";
			display8segSelect <= "01111111";
			botaoAvancaByte <= '0';
			display8seg(7) <= '1';
			sig_decod_In <= "0000";
			countBytesLidos <= "00000";
			completado <= '0';
		elsif (rising_edge(clock)) then
			case estado is
				when reset=>
					--if sig_receber = "01100001" then
					if (botao1 = '0') then 
						estado <= recebeChave;
						countEstado <= "0010";
						display8segSelect <= "11111110";
					end if;

					sig_dado_enviar<= "01100001";
					sig_des_reset  <= '1';
					--sig_des_key    <= x"3031323334353637";
					sig_des_key    <= x"0000000000000000";
					sig_des_text64 <= x"0000000000000000";
					--pinSound <= '1';
				
				when recebeChave=>
					if (botao1 = '0' and countBytesLidos = 15) then 
						estado <= retornaChave;
						countBytesLidos <= "00000";
						display8seg(7) <= '1';
						
					elsif (botao2 = '0' and botaoAvancaByte = '0' and completado = '0' and countBytesLidos < 15) then
						botaoAvancaByte <= '1';
						sig_des_key(0 to 3) <= sig_receber(3 downto 0);						
						--sig_des_key(0 to 4) <= sig_receber(0) & sig_receber(1) & sig_receber(2) & sig_receber(3) & sig_receber(4);
						countEstado <= countBytesLidos (3 downto 0);
						countBytesLidos <= countBytesLidos + 1;
						
					elsif (botao2 = '0' and botaoAvancaByte = '0' and countBytesLidos < 15) then
						botaoAvancaByte <= '1';
						sig_des_key(0 to 3) <= sig_receber(3 downto 0);						
						--sig_des_key(0 to 4) <= sig_receber(0) & sig_receber(1) & sig_receber(2) & sig_receber(3) & sig_receber(4);
						countEstado <= countBytesLidos (3 downto 0);
						countBytesLidos <= countBytesLidos + 1;
						
					elsif (botao2 = '1' and botaoAvancaByte = '1' and countBytesLidos < 16) then
						botaoAvancaByte <= '0';
						sig_des_key <= std_logic_vector(shift_right(unsigned(sig_des_key), 4));
						--display8segSelect <= "11111110";
						countEstado <= "0000";
						
					elsif (botao2 = '1' and botaoAvancaByte = '1' and countBytesLidos = 15) then
						botaoAvancaByte <= '0';
						countEstado <= "0000";
						display8seg(7) <= '0';
					end if;
					sig_decod_In <= countEstado;
					ledred <= not sig_receber;
					
				when retornaChave =>
					if (countBytesLidos = 9 and sig_enviar_busy = '0') then
						sig_enviar <= '0';
						countEstado <= "0110";
						if (botao4 = '0') then
							estado <= recebeTexto;
							display8seg(7) <= '0';
						elsif (botao2 = '0') then
							countBytesLidos <= "00000";
						end if;
					elsif (sig_enviar = '1') then
						sig_enviar <= '0';
						countBytesLidos <= countBytesLidos + 1;
						display8seg(7) <= sig_enviar_busy;
						countEstado <= "0101";
						
					elsif (sig_enviar_busy = '0' and sig_enviar = '0') then

						sig_enviar <= '1';
						sig_decod_In <= countEstado;
						countEstado <= "0100";
						
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
					
				when recebeTexto =>
					display8segSelect <= "01111110";
					countEstado <= "1000";
					sig_decod_In <= countEstado;
			end case;
		end if;
	end process;

end uart_behav;