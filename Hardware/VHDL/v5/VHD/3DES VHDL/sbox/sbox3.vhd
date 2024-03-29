library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sbox3 is
	port(
		clk 	: IN std_logic;
		reset : IN std_logic;
		busIn6 	: IN std_logic_vector(0 TO 5);
		done : OUT std_logic;
		busOut4 : OUT std_logic_vector(0 TO 3)
	);
end sbox3;

architecture sbox3_behav of sbox3 is
type memory is array (integer range 0 to 255) of std_logic_vector (0 TO 3);


	constant mem_Rom0 : memory := (
	--  q0 t0 0-15
	-- 0X  XX XXXX
	-- 0x8, 0x1, 0x7, 0xd, 0x6, 0xf, 0x3, 0x2, 0x0, 0xb, 0x5, 0x9, 0xe, 0xc, 0xa, 0x4, //00-15
	-- 00000000 a 00001111
			0 => x"A",
			1 => x"0",
			2 => x"9",
			3 => x"E",
			4 => x"6",
			5 => x"3",
			6 => x"F",
			7 => x"5",
			8 => x"1",
			9 => x"D",
			10 => x"C",
			11 => x"7",
			12 => x"B",
			13 => x"4",
			14 => x"2",
			15 => x"8",
			others => "0000"
		);


	constant mem_Rom1 : memory := (
	--  q0 t0 0-15
	-- 0X  XX XXXX
	-- 0x8, 0x1, 0x7, 0xd, 0x6, 0xf, 0x3, 0x2, 0x0, 0xb, 0x5, 0x9, 0xe, 0xc, 0xa, 0x4, //00-15
	-- 00000000 a 00001111
			0 => x"D",
			1 => x"7",
			2 => x"0",
			3 => x"9",
			4 => x"3",
			5 => x"4",
			6 => x"6",
			7 => x"A",
			8 => x"2",
			9 => x"8",
			10 => x"5",
			11 => x"E",
			12 => x"C",
			13 => x"B",
			14 => x"F",
			15 => x"1",
			others => "0000"
		);


	constant mem_Rom2 : memory := (
	--  q0 t0 0-15
	-- 0X  XX XXXX
	-- 0x8, 0x1, 0x7, 0xd, 0x6, 0xf, 0x3, 0x2, 0x0, 0xb, 0x5, 0x9, 0xe, 0xc, 0xa, 0x4, //00-15
	-- 00000000 a 00001111
			0 => x"D",
			1 => x"6",
			2 => x"4",
			3 => x"9",
			4 => x"8",
			5 => x"F",
			6 => x"3",
			7 => x"0",
			8 => x"B",
			9 => x"1",
			10 => x"2",
			11 => x"C",
			12 => x"5",
			13 => x"A",
			14 => x"E",
			15 => x"7",
			others => "0000"
		);


	constant mem_Rom3 : memory := (
	--  q0 t0 0-15
	-- 0X  XX XXXX
	-- 0x8, 0x1, 0x7, 0xd, 0x6, 0xf, 0x3, 0x2, 0x0, 0xb, 0x5, 0x9, 0xe, 0xc, 0xa, 0x4, //00-15
	-- 00000000 a 00001111
			0 => x"1",
			1 => x"A",
			2 => x"D",
			3 => x"0",
			4 => x"6",
			5 => x"9",
			6 => x"8",
			7 => x"7",
			8 => x"4",
			9 => x"F",
			10 => x"E",
			11 => x"3",
			12 => x"B",
			13 => x"5",
			14 => x"2",
			15 => x"C",
			others => "0000"
		);

--	constant mem_RomX : memory := (
--	--  q0 t0 0-15
--	-- 0X  XX XXXX
--	-- 0x8, 0x1, 0x7, 0xd, 0x6, 0xf, 0x3, 0x2, 0x0, 0xb, 0x5, 0x9, 0xe, 0xc, 0xa, 0x4, //00-15
--	-- 00000000 a 00001111
--			0 => x"",
--			1 => x"",
--			2 => x"",
--			3 => x"",
--			4 => x"",
--			5 => x"",
--			6 => x"",
--			7 => x"",
--			8 => x"",
--			9 => x"",
--			10 => x"",
--			11 => x"",
--			12 => x"",
--			13 => x"",
--			14 => x"",
--			15 => x"",
--			others => "0000"
--		);

	-- Build an enumerated type for the state machine
	type state_type is (inicia, consultaRam, pronto);

	-- Register to hold the current state
	signal state   : state_type;

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '1' then
			done <= '0';
			state <= inicia;

		elsif (rising_edge(clk)) then
			case state is
				when inicia=>
					done <= '0';

					state <= consultaRam;

				when consultaRam=>


					if (clk'event and clk='1') then
						if 	  (BusIn6(0) = '0' and BusIn6(5) = '0') then
							busOut4 <= mem_Rom0(to_integer(unsigned(BusIn6( 1 TO 4 ))));

						elsif (BusIn6(0) = '0' and BusIn6(5) = '1') then
							busOut4 <= mem_Rom1(to_integer(unsigned(BusIn6( 1 TO 4 ))));

						elsif (BusIn6(0) = '1' and BusIn6(5) = '0') then
							busOut4 <= mem_Rom2(to_integer(unsigned(BusIn6( 1 TO 4 ))));

						elsif (BusIn6(0) = '1' and BusIn6(5) = '1') then
							busOut4 <= mem_Rom3(to_integer(unsigned(BusIn6( 1 TO 4 ))));
						end if;
					end if;

					state <= pronto;

				when pronto=>
					done <= '1';

					state <= pronto;

			end case;
		end if;
	end process;

end sbox3_behav;
