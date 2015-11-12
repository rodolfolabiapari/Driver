library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.math_real.all;

entity newClock is
  port (
	clock_fpga : in std_logic;                         -- clock
	choice     : in std_logic_vector(2 downto 0);
	newClock   : out std_logic
  );
end newClock;

architecture newClock_behav of newClock is
-- Clock 0
	constant Intervalo4800Baud : natural := 10417; -- 50,000,000 / 4800
	constant Intervalo4800BaudHalf : natural := 5208; -- (50,000,000 / 4800) / 2
	
-- Clock 1
	constant Intervalo115740Baud : natural := 432; -- 50,000,000 / 115740
	constant Intervalo115740BaudHalf : natural := 216; -- (50,000,000 / 115740) / 2

-- Clock 2
	constant Intervalo576000Baud : natural := 87; -- 50,000,000 / 576000
	constant Intervalo576000BaudHalf : natural := 43; -- (50,000,000 / 576000) / 2

	signal count : natural range 0 to Intervalo4800Baud - 1 := 0;
begin

	-- Dividiu-se o clock do FPGA (50.000.000) pelo boud rate requerido (9.600) e resultou 5208
	-- Este significa o intervalo para que o o clock do boud rate no FPGA seja realizado
	process (clock_fpga)
	begin
		-- Verifica se é borda de subida no clock do FPGA
		if rising_edge(clock_fpga) then
			case choice is
				when "000" =>
					-- Verifica se a contagem chegou no limite que é 5208 (indexado de zero, ou seja 5207)
					if count >= (Intervalo4800Baud - 1) then
						-- Reseta o contador para 0
						count <= 0;
						-- E define o novo clock para 0
						newClock <= '0';
					-- Caso esteja mais da metade da contagem, define o contador para 1
					-- Isso para que fique metade do tempo 0, metade 1
					elsif ((count >= Intervalo4800BaudHalf) and (count <= Intervalo4800Baud - 2)) then 
						-- Define o novo clock para 1
						newClock <= '1';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					-- Caso esteja menos da metade da contagem, define o contador para 0
					-- Isso para que fique metade do tempo 0, metade 1
					else
						-- Define o novo clock para 0
						newClock <= '0';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					end if;

				when "001" =>
					-- Verifica se a contagem chegou no limite que é 5208 (indexado de zero, ou seja 5207)
					if count >= (Intervalo115740Baud - 1) then
						-- Reseta o contador para 0
						count <= 0;
						-- E define o novo clock para 0
						newClock <= '0';
					-- Caso esteja mais da metade da contagem, define o contador para 1
					-- Isso para que fique metade do tempo 0, metade 1
					elsif ((count >= Intervalo115740BaudHalf) and (count <= Intervalo115740Baud - 2)) then 
						-- Define o novo clock para 1
						newClock <= '1';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					-- Caso esteja menos da metade da contagem, define o contador para 0
					-- Isso para que fique metade do tempo 0, metade 1
					else
						-- Define o novo clock para 0
						newClock <= '0';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					end if;
					
				when "010" =>
					-- Verifica se a contagem chegou no limite que é 5208 (indexado de zero, ou seja 5207)
					if count >= (Intervalo576000Baud - 1) then
						-- Reseta o contador para 0
						count <= 0;
						-- E define o novo clock para 0
						newClock <= '0';
					-- Caso esteja mais da metade da contagem, define o contador para 1
					-- Isso para que fique metade do tempo 0, metade 1
					elsif ((count >= Intervalo576000BaudHalf) and (count <= Intervalo576000Baud - 2)) then 
						-- Define o novo clock para 1
						newClock <= '1';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					-- Caso esteja menos da metade da contagem, define o contador para 0
					-- Isso para que fique metade do tempo 0, metade 1
					else
						-- Define o novo clock para 0
						newClock <= '0';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					end if;
					
				when "011" =>
				when "100" =>
				when "101" =>
				when "110" =>
				when "111" =>
				when others =>
			end case;
		end if;
	end process;
end newClock_behav;