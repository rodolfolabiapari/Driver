LIBRARY IEEE;
	use IEEE.STD_LOGIC_UNSIGNED.ALL;
	use IEEE.math_real.all;
	use ieee.std_logic_1164.all;  
	use ieee.numeric_std.all;  
	use IEEE.math_real.all;

entity decodificador7seg is
    port (
		-- Sinais de entrada
		clock               : in std_logic;
		reset               : in std_logic;
		dadoEntrada         : in STD_LOGIC_VECTOR(3 DOWNTO 0);
		posicao_display     : in std_logic_vector (2 downto 0);
		-- Sinais de saída
		A, B, C, D, E, F, G : out STD_LOGIC;
		 displays           : out std_logic_vector (7 downto 0)
    );
 end decodificador7seg;

architecture decodificador of decodificador7seg is
	signal saida : STD_LOGIC_VECTOR(0 to 6);
	signal count : natural range 0 to 10 := 0;
	signal interval : natural range 0 to 30000 := 0;
	signal dis_buffer : std_logic_vector(31 downto 0) := x"00000000";
	signal atual : std_logic_vector (3 downto 0);
 begin
 
	process (clock) is
	begin
		if(clock'event and clock = '1') then
			
			if (reset = '1') then
				dis_buffer <= x"00000000";
				displays <= "11111110";
				atual <= "0000";
				count <= 0;
				interval <= 0;
			else
				case posicao_display is
					when "000" => dis_buffer (3 downto 0) <= dadoEntrada;
					when "001" => dis_buffer (7 downto 4) <= dadoEntrada;
					when "010" => dis_buffer (11 downto 8) <= dadoEntrada;
					when "011" => dis_buffer (15 downto 12) <= dadoEntrada;
					when "100" => dis_buffer (19 downto 16) <= dadoEntrada;
					when "101" => dis_buffer (23 downto 20) <= dadoEntrada;
					when "110" => dis_buffer (27 downto 24) <= dadoEntrada;
					when "111" => dis_buffer (31 downto 28) <= dadoEntrada;
					when others =>
				end case;
				
				case count is
					when 0 =>
						displays <= "11111110"; atual <= dis_buffer (3 downto 0);
					when 1 =>
						displays <= "11111101"; atual <= dis_buffer (7 downto 4);
					when 2 =>
						displays <= "11111011"; atual <= dis_buffer (11 downto 8);
					when 3 =>
						displays <= "11110111"; atual <= dis_buffer (15 downto 12);
					when 4 =>
						displays <= "11101111"; atual <= dis_buffer (19 downto 16);
					when 5 =>
						displays <= "11011111"; atual <= dis_buffer (23 downto 20);
					when 6 =>
						displays <= "10111111"; atual <= dis_buffer (27 downto 24);
					when 7 =>
						displays <= "01111111"; atual <= dis_buffer (31 downto 28);		
					when others =>
						displays <= "11111111";
				end case;
				
				--atual <= interval;
				--atual <= std_logic_vector(to_unsigned(count, 4));
				
				if (interval >= 30000) then
					interval <= 0;
					if (count >= 7) then
						count <= 0;
					else
						count <= count + 1;
					end if;
				else
					interval <= interval + 1;
				end if;
			end if;
			
		end if;
	end process;
 
	with atual select
		 saida <= "0000001" when "0000", -- '0'
		 "1001111" when "0001", -- '1'
		 "0010010" when "0010", -- '2'
		 "0000110" when "0011", -- '3'
		 "1001100" when "0100", -- '4'
		 "0100100" when "0101", -- '5'
		 "0100000" when "0110", -- '6'
		 "0001111" when "0111", -- '7'
		 "0000000" when "1000", -- '8'
		 "0000100" when "1001", -- '9'
		 "0001000" when "1010", -- 'A'
		 "1100000" when "1011", -- 'B'
		 "0110001" when "1100", -- 'C'
		 "1000010" when "1101", -- 'D'
		 "0110000" when "1110", -- 'E'
		 "0111000" when "1111", -- 'F'
		 "1111111" when others; 

	A <= saida(0);
	B <= saida(1);
	C <= saida(2);
	D <= saida(3);
	E <= saida(4);
	F <= saida(5);
	G <= saida(6);
end;