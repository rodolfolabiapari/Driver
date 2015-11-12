library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sbox1 is
	port(
		clk 	: IN std_logic;
		reset : IN std_logic;
		busIn6 	: IN std_logic_vector(0 TO 5);
		done : OUT std_logic;
		busOut4 : OUT std_logic_vector(0 TO 3)
	);
end sbox1;

architecture sbox1_behav of sbox1 is
type memory is array (integer range 0 to 16) of std_logic_vector (0 TO 3);
 	constant mem_Rom0 : memory := (
	--  q0 t0 0-15
	-- 0X  XX XXXX
	-- 0x8, 0x1, 0x7, 0xd, 0x6, 0xf, 0x3, 0x2, 0x0, 0xb, 0x5, 0x9, 0xe, 0xc, 0xa, 0x4, //00-15
	-- 00000000 a 00001111
			0  => x"E",
			1  => x"4",
			2  => x"D",
			3  => x"1",
			4  => x"2",
			5  => x"F",
			6  => x"B",
			7  => x"8",
			8  => x"3",
			9  => x"A",
			10 => x"6",
			11 => x"C",
			12 => x"5",
			13 => x"9",
			14 => x"0",
			15 => x"7",
			others => "0000"
		);

	constant mem_Rom1 : memory := (
			0  => x"0",
			1  => x"F",
			2  => x"7",
			3  => x"4",
			4  => x"E",
			5  => x"2",
			6  => x"D",
			7  => x"1",
			8  => x"A",
			9  => x"6",
			10 => x"C",
			11 => x"B",
			12 => x"9",
			13 => x"5",
			14 => x"3",
			15 => x"8",
			others => "0000"
		);


	constant mem_Rom2 : memory := (
			0  => x"4",
			1  => x"1",
			2  => x"E",
			3  => x"8",
			4  => x"D",
			5  => x"6",
			6  => x"2",
			7  => x"B",
			8  => x"F",
			9  => x"C",
			10 => x"9",
			11 => x"7",
			12 => x"3",
			13 => x"A",
			14 => x"5",
			15 => x"0",
			others => "0000"
		);


	constant mem_Rom3 : memory := (
			0  => x"F",
			1  => x"C",
			2  => x"8",
			3  => x"2",
			4  => x"4",
			5  => x"9",
			6  => x"1",
			7  => x"7",
			8  => x"5",
			9  => x"B",
			10 => x"3",
			11 => x"E",
			12 => x"A",
			13 => x"0",
			14 => x"6",
			15 => x"D",
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

end sbox1_behav;
