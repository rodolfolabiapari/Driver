library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rx is
	port(
		clock   : in std_logic;
		reset   : in std_logic;
		busy    : out std_logic := '0';
		data    : out std_logic_vector(7 downto 0) := "00000000";
		rx_line : in std_logic
	);
end rx;


architecture rx_behiv of rx is
	signal datafll  : std_logic_vector(7 downto 0);
	signal index    : integer range 0 to 9 := 5;
	signal recebido : std_logic            := '0';

	type st_type is (st_reset, 
					st_ocioso, 
					st_start,
					st_1_8,
					st_9);
	
	signal estado                          : st_type := st_reset;

begin

	-- Processo de gereneciamento da maquina de estados da interface
	process (clock)
	begin
		-- Quando os botoes 3 e 2 estao pressionados, o sistema e' resetado
		if (rising_edge(clock)) then
			case estado is

				when st_reset =>
					if (reset = '0') then
						estado <= st_ocioso;
					end if;

				when st_ocioso =>
					if (rx_line = '0' ) then
						estado <= st_start;
					end if;

				when st_start =>
					estado <= st_1_8;

				WHEN st_1_8 =>
					if (index = 8) then
						if (rx_line = '1') then
							estado <= st_9;
						else 
							estado <= st_ocioso;
						end if;
					end if;

				WHEN st_9 =>
					if (rx_line = '0') then
						estado <= st_start;
					else 
						estado <= st_ocioso;
					end if;

				when others =>
			end case;
		end if;
	end process;



	process(clock)
	BEGIN
		if (clock'event and clock = '1') then
			
			CASE estado IS
				when st_reset =>
					busy <= '1';
					datafll <= "11111111";
					data <= x"00";


				when st_ocioso =>
					busy <= '0';
					datafll <= "00000000";
					data <= x"00";

				when st_start =>
					index<=1;
					busy<='1';
					datafll(0) <= rx_line;
					datafll(7 downto 1) <= "0000000";


				WHEN st_1_8 =>

					case index is 
						when 1 => datafll(1) <= rx_line;
						when 2 => datafll(2) <= rx_line;
						when 3 => datafll(3) <= rx_line;
						when 4 => datafll(4) <= rx_line;
						when 5 => datafll(5) <= rx_line;
						when 6 => datafll(6) <= rx_line;
						when 7 => datafll(7) <= rx_line;
						when others => index <= 7;
					end case;

					index <= index + 1;


				WHEN st_9 =>
					data<= datafll(7 downto 0);
					index <= 5;
					busy <='0';

				when others =>
			end case;
		end if;
	end process;





--		if (clock'event and clock='1') then
--			if (reset = '1') then
--				busy <= '0';
--				rx_flg <= '0';
--				datafll <= "0000000000";
--				data <= x"00";
--			else
--				
--				if (rx_flg='0' and rx_line='1') then
--					busy <= '0';
--					rx_flg <='0';
--					datafll <= "0000000000";
--					data <= x"00";
--					
--				elsif (rx_flg='0' and rx_line='0') then
--					datafll(0)<='0';
--					index<=1;
--					busy<='1';
--					rx_flg<='1';
--					recebido <= '0';
--				
--				elsif (rx_flg='1') then
--					datafll(index)<= rx_line;
--					if (index<9 and recebido = '0') then
--						index <= index+1;
--
--					elsif (index = 9 and recebido = '0') then
--						recebido <= '1';
--
--					elsif (recebido = '1') then
--						if(datafll(0)='0' and datafll(9) ='1') then
--							data<= datafll(8 downto 1);
--							index <= 0;
--						else
--							data<= (others=>'0');
--						end if;
--						
--						rx_flg <='0';
--						busy <='0';
--					end if;
--				end if;
--			end if;
--		end if;

--
--		if (rx_flg='1') then
--			datafll(index)<= rx_line;
--			if(prscl<5207) then
--				prscl<= prscl + 1;
--			else
--				prscl <= 0;
--			end if;
--
--			if(prscl=2500) then
--				if (index<9) then
--					index <= index+1;
--				else 
--					if(datafll(0)='0' and datafll(9) ='1') then
--						data<= datafll(8 downto 1);
--					else
--						data<= (others=>'0');
--					end if;
--				rx_flg <='0';
--				busy <='0';
--				end if;
--			end if;
--		end if;
--	end process;
end rx_behiv;