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
	signal Intervalo : natural := 10417; -- 50,000,000 / 4800
	signal IntervaloHalf : natural := 5208; -- (50,000,000 / 4800) / 2
	
	signal count : natural range 0 to 10418 := 0;
begin

	process (clock_fpga) 
	begin
			case choice is
				-- 4800
				when "000" =>
					Intervalo <= 50000000 / 4800;
					IntervaloHalf <= (50000000 / 4800) / 2;
					
				-- 9600
				when "001" =>
					Intervalo <= 50000000 / 9600;
					IntervaloHalf <= (50000000 / 9600) / 2;
					
				-- 115740
				when "010" =>
					Intervalo <= 50000000 / 115740;
					IntervaloHalf <= (50000000 / 115740) / 2;
					
				-- 576000
				when "011" =>
					Intervalo <= 50000000 / 576000;
					IntervaloHalf <= (50000000 / 576000) / 2;
				when others =>
			end case;
	end process;

	-- Dividiu-se o clock do FPGA (50.000.000) pelo boud rate requerido (9.600) e resultou 5208
	-- Este significa o intervalo para que o o clock do boud rate no FPGA seja realizado
	process (clock_fpga)
	begin
		-- Verifica se é borda de subida no clock do FPGA
		if rising_edge(clock_fpga) then
			-- Verifica se a contagem chegou no limite que é 5208 (indexado de zero, ou seja 5207)
			if count >= (Intervalo - 1) then
				-- Reseta o contador para 0
				count <= 0;
				-- E define o novo clock para 0
				newClock <= '0';
			-- Caso esteja mais da metade da contagem, define o contador para 1
			-- Isso para que fique metade do tempo 0, metade 1
			elsif ((count >= IntervaloHalf) and (count <= Intervalo - 2)) then 
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
		end if;
	end process;
end newClock_behav;