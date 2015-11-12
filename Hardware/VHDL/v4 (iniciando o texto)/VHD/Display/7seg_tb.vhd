LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;

ENTITY decodificador7seg_tb IS
END decodificador7seg_tb;

ARCHITECTURE sinais OF decodificador7seg_tb IS
	signal sig_clock           : std_logic;
	signal sig_dadoEntrada     : std_logic_vector(3 downto 0);
	signal sig_posicao_display : std_logic_vector(2 downto 0);
	signal sig_A               : std_logic;
	signal sig_B               : std_logic;
	signal sig_C               : std_logic;
	signal sig_D               : std_logic;
	signal sig_E               : std_logic;
	signal sig_F               : std_logic;
	signal sig_G               : std_logic;
	signal sig_displays        : std_logic_vector(7 downto 0);

	-- Importação de componente
	COMPONENT decodificador7seg port (
		 -- Sinais de entrada
		clock : in std_logic;
		dadoEntrada     : in STD_LOGIC_VECTOR(3 DOWNTO 0);
		posicao_display : in std_logic_vector (2 downto 0);
		-- Sinais de saída
		A, B, C, D, E, F, G : out STD_LOGIC;
		displays        : out std_logic_vector (7 downto 0)
	    );
	 end COMPONENT;

BEGIN

	UUT_7seg: decodificador7seg port map (
		clock           => sig_clock          ,
		dadoEntrada     => sig_dadoEntrada    ,
		posicao_display => sig_posicao_display,
		A               => sig_A,
		B               => sig_B,
		C               => sig_C,
		D               => sig_D,
		E               => sig_E,
		F               => sig_F,
		G               => sig_G,
		displays        => sig_displays

	);

	-- Processo responsavel pela variação no dado de entrada
	signal_dadoA: PROCESS
	BEGIN
		sig_clock <= '0'; WAIT FOR 1 ns;
		sig_clock <= '1'; WAIT FOR 1 ns;
		sig_clock <= '0'; WAIT FOR 1 ns;
		sig_clock <= '1'; WAIT FOR 1 ns;
		sig_clock <= '0'; WAIT FOR 1 ns;
		sig_clock <= '1'; WAIT FOR 1 ns;
		sig_clock <= '0'; WAIT FOR 1 ns;
		sig_clock <= '1'; WAIT FOR 1 ns;
		sig_clock <= '0'; WAIT FOR 1 ns;
		sig_clock <= '1'; WAIT FOR 1 ns;
		sig_clock <= '0'; WAIT FOR 1 ns;
		sig_clock <= '1'; WAIT FOR 1 ns;

--		sig_clk <= '0'; WAIT FOR 50 ns;
--		sig_address16 <= "0001";
--		sig_address4 <= "00";
--		sig_clk <= '0'; WAIT FOR 50 ns;
--
--
--		sig_clk <= '0'; WAIT FOR 50 ns;
--		sig_address16 <= "0010";
--		sig_address4 <= "00";
--		sig_clk <= '0'; WAIT FOR 50 ns;
	END PROCESS;

END ARCHITECTURE sinais;
