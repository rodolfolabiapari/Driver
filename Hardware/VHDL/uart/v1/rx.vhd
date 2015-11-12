library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RX is
	port(
		clk: in std_logic;
		rx_line: in std_logic;
		data: out std_logic_vector(7 downto 0);
		busy: out std_logic
	);
end RX;

architecture rx_behiv of RX is
signal datafll: std_logic_vector(9 downto 0);
signal rx_flg: std_logic:= '0';
signal prscl: integer range 0 to 5208:=0;
signal index: integer range 0 to 9:=0;
begin
	process(clk)
	begin
		if (rx_flg='0' and rx_line='0') then
			index<=0;
			prscl<=0;
			busy<='1';
			rx_flg<='1';
		end if;

		if (rx_flg='1') then
			datafll(index)<= rx_line;
			if(prscl<5207) then
				prscl<= prscl + 1;
			else
				prscl <= 0;
			end if;

			if(prscl=2500) then
				if (index<9) then
					index <= index+1;
				else 
					if(datafll(0)='0' and datafll(9) ='1') then
						data<= datafll(8 downto 1);
					else
						data<= (others=>'0');
					end if;
				rx_flg <='0';
				busy <='0';
				end if;
			end if;
		end if;
	end process;
end rx_behiv;