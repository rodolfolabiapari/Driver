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
		dadoEntrada         : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- Sinais de saida
		displays            : out std_logic_vector (55 downto 0)
    );
 end decodificador7seg;

architecture decodificador of decodificador7seg is
	signal saida : STD_LOGIC_VECTOR(6 downto 0);
	signal count : std_LOGIC_VECTOR(3 downto 0) := "0000";
	signal bufferIn : std_logic_vector(31 downto 0) := x"00000000";
	signal bufferOut : std_logic_vector(55 downto 0) := x"00000000000000";
	signal atual : std_logic_vector (3 downto 0);
 begin
 
 
	process (clock) is
	begin
		
		if (reset = '1') then
			bufferOut <= "10000001000000100000010000001000000100000010000001000000";
			bufferIn <= x"00000000";
			count <= "0000";
			
		elsif(clock'event and clock = '1') then
			bufferIn <= dadoEntrada;
		
			case count is
				when "0000" => atual <= bufferIn (3 downto 0);
				when "0001" => atual <= bufferIn (7 downto 4);
				when "0010" => atual <= bufferIn (11 downto 8);
				when "0011" => atual <= bufferIn (15 downto 12);
				when "0100" => atual <= bufferIn (19 downto 16);
				when "0101" => atual <= bufferIn (23 downto 20);
				when "0110" => atual <= bufferIn (27 downto 24);
				when "0111" => atual <= bufferIn (31 downto 28);
				when others =>
			end case;
			
			
			case atual is
				when "0000" => saida <= "1000000";
				when "0001" => saida <= "1111001";
				when "0010" => saida <= "0100100";
				when "0011" => saida <= "0110000";
				when "0100" => saida <= "0011001";
				when "0101" => saida <= "0010010";
				when "0110" => saida <= "0000010";
				when "0111" => saida <= "1111000";
				when "1000" => saida <= "0000000";
				when "1001" => saida <= "0010000";
				when "1010" => saida <= "0001000";
				when "1011" => saida <= "0000011";
				when "1100" => saida <= "1000110";
				when "1101" => saida <= "0100001";
				when "1110" => saida <= "0000110";
				when "1111" => saida <= "0001110";
				when others =>
			end case;

			case count is
				when "0010" => bufferOut(6  downto 0 ) <= saida; count <= "0011";
				when "0011" => bufferOut(13 downto 7 ) <= saida; count <= "0100";
				when "0100" => bufferOut(20 downto 14) <= saida; count <= "0101";
				when "0101" => bufferOut(27 downto 21) <= saida; count <= "0110";
				when "0110" => bufferOut(34 downto 28) <= saida; count <= "0111";
				when "0111" => bufferOut(41 downto 35) <= saida; count <= "0000";
				when "0000" => bufferOut(48 downto 42) <= saida; count <= "0001";
				when "0001" => bufferOut(55 downto 49) <= saida; count <= "0010";
				when others => count <= "0000";
			end case;
			
			--displays <= "10010001000000100000010000011000000100000010001001000010";
			
		end if;
	end process;
	displays <= bufferOut;
end;


--				with atual select
--					 saida <= "0000001" when "0000", -- '0'
--							  "1001111" when "0001", -- '1'
--							  "0010010" when "0010", -- '2'
--							  "0000110" when "0011", -- '3'
--							  "1001100" when "0100", -- '4'
--							  "0100100" when "0101", -- '5'
--							  "0100000" when "0110", -- '6'
--							  "0001111" when "0111", -- '7'
--							  "0000000" when "1000", -- '8'
--							  "0000100" when "1001", -- '9'
--							  "0001000" when "1010", -- 'A'
--							  "1100000" when "1011", -- 'B'
--							  "0110001" when "1100", -- 'C'
--							  "1000010" when "1101", -- 'D'
--							  "0110000" when "1110", -- 'E'
--							  "0111000" when "1111", -- 'F'
--							  "1111111" when others; 
--