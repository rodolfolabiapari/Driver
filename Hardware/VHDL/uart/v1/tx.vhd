library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TX is
	port (
		clk: in std_logic;
		start: in std_logic;
		busy: out std_logic;
		data: in std_logic_vector (7 downto 0);
		tx_line: out std_logic
	);
end TX;

architecture tx_behiv of tx is

signal prscl: integer range 0 to 5208 := 0;
signal index: integer range 0 to 9 := 0;
signal datafll: std_logic_vector(9 downto 0);
signal tx_flg: std_logic:= '0';
begin
	process(clk)
	begin
		if (clk'event and clk='1') then
			if (tx_flg='0' and start='1') then
				tx_flg<='1';
				busy<='1';
				datafll(0)<='0';
				datafll(9)<='1';

				datafll(8 downto 1)<= data;
			end if;

			if (tx_flg='1') then
				if (prscl<5205) then
					prscl <= prscl + 1;

				else
					prscl<= 0;

				end if;

				if (prscl=2607) then
					tx_line <= datafll(index);

					if (index<9) then
						index <= index + 1;

					else
						tx_flg<='0';
						busy<='0';
						index<=0;
					end if;

				end if;
			end if;
		end if;
	end process;
end tx_behiv;