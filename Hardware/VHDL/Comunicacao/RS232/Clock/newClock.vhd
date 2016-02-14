library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.math_real.all;

entity clockOut is
  port (
	clock      : in std_logic;                         -- clock
	choice     : in std_logic_vector(2 downto 0);
	clockOut   : out std_logic
  );
end clockOut;

architecture clockOut_behav of clockOut is
-- clock 0
	constant Intervalo4800Baud : natural := 10417; -- 50,000,000 / 4800
	constant Intervalo4800BaudHalf : natural := 5208; -- (50,000,000 / 4800) / 2

-- clock 1
	constant Intervalo9600Baud : natural := 5208; -- 50,000,000 / 9600
	constant Intervalo9600BaudHalf : natural := 2604; -- (50,000,000 / 9600) / 2
	
-- clock 2
	constant Intervalo115740Baud : natural := 432; -- 50,000,000 / 115740
	constant Intervalo115740BaudHalf : natural := 216; -- (50,000,000 / 115740) / 2

-- clock 3
	constant Intervalo576000Baud : natural := 87; -- 50,000,000 / 576000
	constant Intervalo576000BaudHalf : natural := 43; -- (50,000,000 / 576000) / 2

	signal count : natural range 0 to 50000000 := 0;
begin

	-- Dividiu-se o clock do FPGA (50.000.000) pelo boud rate requerido (9.600) e resultou 5208
	-- Este significa o intervalo para que o o clock do boud rate no FPGA seja realizado
	process (clock)
	begin
		-- Verifica se é borda de subida no clock do FPGA
		if rising_edge(clock) then
			case choice is
				when "000" =>
					-- Verifica se a contagem chegou no limite
					if count >= (Intervalo4800Baud - 1) then
						-- Reseta o contador para 0
						count <= 0;
						-- E define o novo clock para 0
						clockOut <= '0';
					-- Caso esteja mais da metade da contagem, define o contador para 1
					-- Isso para que fique metade do tempo 0, metade 1
					elsif ((count >= Intervalo4800BaudHalf) and (count <= Intervalo4800Baud - 2)) then 
						-- Define o novo clock para 1
						clockOut <= '1';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					-- Caso esteja menos da metade da contagem, define o contador para 0
					-- Isso para que fique metade do tempo 0, metade 1
					else
						-- Define o novo clock para 0
						clockOut <= '0';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					end if;

				when "001" =>
					-- Verifica se a contagem chegou no limite 
					if count >= (Intervalo115740Baud - 1) then
						-- Reseta o contador para 0
						count <= 0;
						-- E define o novo clock para 0
						clockOut <= '0';
					-- Caso esteja mais da metade da contagem, define o contador para 1
					-- Isso para que fique metade do tempo 0, metade 1
					elsif ((count >= Intervalo115740BaudHalf) and (count <= Intervalo115740Baud - 2)) then 
						-- Define o novo clock para 1
						clockOut <= '1';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					-- Caso esteja menos da metade da contagem, define o contador para 0
					-- Isso para que fique metade do tempo 0, metade 1
					else
						-- Define o novo clock para 0
						clockOut <= '0';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					end if;
					
				when "010" =>
					-- Verifica se a contagem chegou no limite 
					if count >= (Intervalo576000Baud - 1) then
						-- Reseta o contador para 0
						count <= 0;
						-- E define o novo clock para 0
						clockOut <= '0';
					-- Caso esteja mais da metade da contagem, define o contador para 1
					-- Isso para que fique metade do tempo 0, metade 1
					elsif ((count >= Intervalo576000BaudHalf) and (count <= Intervalo576000Baud - 2)) then 
						-- Define o novo clock para 1
						clockOut <= '1';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					-- Caso esteja menos da metade da contagem, define o contador para 0
					-- Isso para que fique metade do tempo 0, metade 1
					else
						-- Define o novo clock para 0
						clockOut <= '0';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					end if;
					
				when "011" =>
					-- Verifica se a contagem chegou no limite que é 5208 (indexado de zero, ou seja 5207)
					if count >= (Intervalo96000Baud - 1) then
						-- Reseta o contador para 0
						count <= 0;
						-- E define o novo clock para 0
						clockOut <= '0';
					-- Caso esteja mais da metade da contagem, define o contador para 1
					-- Isso para que fique metade do tempo 0, metade 1
					elsif ((count >= Intervalo96000BaudHalf) and (count <= Intervalo96000Baud - 2)) then 
						-- Define o novo clock para 1
						clockOut <= '1';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					-- Caso esteja menos da metade da contagem, define o contador para 0
					-- Isso para que fique metade do tempo 0, metade 1
					else
						-- Define o novo clock para 0
						clockOut <= '0';
						-- Incrementa a contagem do intervalo
						count <=  count + 1;
					end if;

				when others =>
			end case;
		end if;
	end process;
end clockOut_behav;