LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;

ENTITY usb_interface_tb IS
END usb_interface_tb;

ARCHITECTURE sinais OF usb_interface_tb IS

--	signal clockCY7C6200 : std_logic;

	COMPONENT usb_interface port (
		clock        : in std_logic;
		reset        : in std_logic;
		extrasOut    : out std_logic_vector(1 downto 0);
		extrasIn     : in  std_logic_vector(1 downto 0);
		otg_data_15  : inout std_logic_vector(15 downto 0);
		otg_addre_1  : out   std_logic_vector(1 downto 0);
		otg_chpse_n  : out   std_logic;
		otg_write_n  : out   std_logic;
		otg_read_n   : out   std_logic;
		otg_interrp  : in    std_logic;
		otg_reset_n  : out   std_logic
		);
	END COMPONENT;
	signal sig_clock        : std_logic := '0';
	signal sig_reset        : std_logic;
	signal sig_extrasOut    : std_logic_vector(1 downto 0);
	signal sig_extrasIn     : std_logic_vector(1 downto 0);
	signal sig_otg_data_15  : std_logic_vector(15 downto 0);
	signal sig_otg_addre_1  : std_logic_vector(1 downto 0);
	signal sig_otg_chpse_n  : std_logic;
	signal sig_otg_write_n  : std_logic;
	signal sig_otg_read_n   : std_logic;
	signal sig_otg_interrp  : std_logic;
	signal sig_otg_reset_n  : std_logic;
	signal count : std_logic_vector(5 downto 0) := "000000";

BEGIN
	UUT_usb: usb_interface PORT MAP(
		clock       => sig_clock      ,
		reset       => sig_reset      ,
		extrasOut   => sig_extrasOut  ,
		extrasIn    => sig_extrasIn   ,
		otg_data_15 => sig_otg_data_15,
		otg_addre_1 => sig_otg_addre_1,
		otg_chpse_n => sig_otg_chpse_n,
		otg_write_n => sig_otg_write_n,
		otg_read_n  => sig_otg_read_n ,
		otg_interrp => sig_otg_interrp,
		otg_reset_n => sig_otg_reset_n
	);
	
	sig_clock <= not sig_clock after 1 ns;
	
	-- RX
	process (sig_clock) is
	begin
		if (sig_clock'event and sig_clock = '1') then
			case count IS
				when "000000"=> count <= "000001"; sig_reset <= '1';
				when "000001"=> count <= "000010";
				when "000010"=> sig_reset <= '0';
				when others =>
			end case;
		end if;
	end process;
END ARCHITECTURE sinais;
