
library IEEE;
use IEEE.std_logic_1164.all; -- std_logic e std_logic_vector
use IEEE.numeric_std.all; -- unsigned: array of std_logic

entity usb_interface is
	port(
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
end usb_interface;

architecture usb_interface_behav of usb_interface is

	-- Maquina de estados
	type state_type is (
		st_controle_speed, st_done, st_interrupt_enable_register_processor_control, st_interrupt_enable_register,  
			st_gpio_status_port, st_gpio_control_register,
		st_reset
		);
	signal state   : state_type := st_reset;

--	signal dado_write    : std_logic_vector(15 downto 0);
--	signal dado_read     : std_logic_vector(15 downto 0);
--
--	signal address_write : std_logic_vector(15 downto 0);
--	signal address_read  : std_logic_vector(15 downto 0);
--
	signal cs, rd, wr    : std_logic := '1';

	signal status  : std_logic_vector(15 downto 0);
	
	signal clockCY7C6200 : std_logic := '0';

	signal memoria : std_logic := '1';
	signal requisicao : std_logic := '0';
	signal requisicao_done : std_logic := '1';
	signal rw : std_logic;


begin
	otg_chpse_n <= cs;
	otg_write_n <= wr;
	otg_read_n  <= rd;

	process (clockCY7C6200)
	begin
		-- reseta todos os dados
		if reset = '1' then
			state <= st_reset;
		else 
			if (clockCY7C6200'event and clockCY7C6200 = '1') then
				case state is
					-- Reset todo o processo
					when st_reset =>
						if (reset = '0') then
							state <= st_controle_speed;
						end if;


					when st_controle_speed =>
						if (memoria = '0') then
							if (requisicao = '1' and requisicao_done = '0') then
								state <= st_interrupt_enable_register;
							end if;
						end if;


					when st_interrupt_enable_register_processor_control =>
						if (memoria = '0') then
							if (requisicao = '1' and requisicao_done = '0') then
								state <= st_interrupt_enable_register;
							end if;
						end if;

					when st_interrupt_enable_register =>
						if (memoria = '0') then
							if (requisicao = '1' and requisicao_done = '0') then
								state <= st_gpio_status_port;
							end if;
						end if;

					when st_gpio_status_port =>
						if (requisicao = '1' and requisicao_done = '0') then
							state <= st_gpio_control_register;
						end if;



					when st_gpio_control_register =>
					if (memoria = '0') then
						if (requisicao = '1' and requisicao_done = '0') then
							state <= st_done;
						end if;
					end if;


					when others =>

				end case;
			end if;
		end if;
	end process;






	process (clockCY7C6200)
	begin
		if (reset = '1') then

					otg_data_15         <= x"0000";
--					otg_chpse_n         <= cs;
--
--					otg_write_n         <= wr;
--					otg_read_n          <= rd;
					otg_reset_n         <= '0';

--					dado_write          <= x"0000";
--					dado_read           <= x"0000";
--					address_write       <= x"0000";
--					address_read        <= x"0000";

--					cs                  <= '1';
--					rd                  <= '1';
--					wr                  <= '1';  
					rw                  <= '1';   

--					status              <= x"0000";
--					action              <= "001";

					memoria             <= '0';
					requisicao          <= '0';
		else
			if (rising_edge(clockCY7C6200)) then
				case state is

					-- HPI A[1:0]  A1  A0
					-- HPI Data     0   0
					-- HPI Mailbox  0   1
					-- HPI Address  1   0
					-- HPI Status   1   1

					when st_controle_speed =>

						if (requisicao_done = '1' and requisicao = '0') then
							if (memoria = '0') then
								-- pag 14 - Controle de speed
								otg_addre_1         <= "10";
								otg_data_15         <= x"C008";
								requisicao          <= '1';
								rw                  <= '0';
								memoria             <= '1';
							else 
								-- pag 14 - Controle de speed
								otg_addre_1         <= "00";
								otg_data_15         <= "000000000000" & "0000";
								requisicao          <= '1';
								rw                  <= '0';
								memoria             <= '0';
							end if;
						else 
							requisicao          <= '0';
						end if;


					when st_interrupt_enable_register_processor_control =>
						if (requisicao_done = '1' and requisicao = '0') then
							if (memoria = '0') then
								-- pag 16 - Controle de interrupcoes do processador de controle
								otg_addre_1         <= "10";
								otg_data_15         <= x"C00E";
								requisicao          <= '1';
								rw                  <= '0';
								memoria             <= '1';
							else 
								-- pag 16 - Controle de interrupcoes do processador de controle
								otg_addre_1         <= "00";
								otg_data_15         <= "0001001101100000";
								requisicao          <= '1';
								rw                  <= '0';
								memoria             <= '0';
							end if;
						else 
							requisicao          <= '0';
						end if;

					when st_interrupt_enable_register =>

						if (requisicao_done = '1' and requisicao = '0') then
							if (memoria = '0') then
								-- pag 43 - GPIO Control Register
								otg_addre_1         <= "10";
								otg_data_15         <= x"C006";
								requisicao          <= '1';
								rw                  <= '0';
								memoria             <= '1';
							else 
								-- pag 43 - GPIO Control Register
								otg_addre_1         <= "00";
								otg_data_15         <= "0000010100000000";
								requisicao          <= '1';
								rw                  <= '0';
								memoria             <= '0';
							end if;
						else 
							requisicao          <= '0';
						end if;

					when st_gpio_status_port =>
						if (requisicao = '0' and requisicao_done = '1') then
							-- pag 56 - Status HPI
							otg_addre_1         <= "11";
							status <= otg_data_15;
							requisicao          <= '1';
							rw                  <= '1';
						else 
							requisicao          <= '0';
						end if;



					when st_gpio_control_register =>

						if (requisicao_done = '1' and requisicao = '0') then
							if (memoria = '0') then
								-- pag 43 - Controle de gpio
								otg_addre_1         <= "10";
								otg_data_15         <= x"C006";
								requisicao          <= '1';
								rw                  <= '0';
								memoria             <= '1';
							else 
								-- pag 14 - Controle de speed
								otg_addre_1         <= "00";
								otg_data_15         <= "0000010100000000";
								requisicao          <= '1';
								rw                  <= '0';
								memoria             <= '0';
							end if;
						else 
							requisicao          <= '0';
						end if;



	--				when st_controle_energia =>
	--					-- pag 15 - Controle de energia
	--					otg_addre_1         <= "00";
	--					otg_data_15         <= "0_1_0_11_0_001_00_Z_00";
	--					cs                  <= '0';
	--					wr                  <= '0';

	--				when st_controle_interrupcao =>
	--					-- pag 15 - Controle de energia
	--					otg_addre_1         <= "00";
	--					otg_data_15         <= "000_10_0_11011_1_0111";
	--					cs                  <= '0';
	--					wr                  <= '0';
	--
	--
	--				when st_envia_dado =>
	--					otg_addre_1         <= "00";
	--					otg_data_15         <= x"00AA";
	--					cs                  <= '0';
	--					wr                  <= '0';


						when others =>
						requisicao <= '0';
					end case;
				end if;
			end if;
	end process;
	
	
	process (requisicao, clockCY7C6200) 
		variable TMP : std_logic := '0';
	begin
		if (requisicao_done = '1') then
			if (requisicao = '1') then
				cs <= '0';
				requisicao_done <= '0';
				TMP := '0';
			else 
				rd <= '1';
				wr <= '1';
				TMP := '0';
			end if;
		end if;

		if (rising_edge(clockCY7C6200)) then
			if (requisicao_done = '0') then
				if (cs = '0' and TMP = '0') then
					if (rd = '1' and wr = '1') then 
						if (rw = '1') then
							rd <= '0';
							wr <= '1';
						else 
							rd <= '1';
							wr <= '0';
						end if;
					else 
						rd <= '1';
						wr <= '1';
						TMP := '1';
					end if;

				else 
					TMP := '0';
					requisicao_done <= '1';
					cs <= '1';
				end if;
			else 
				rd <= '1';
				wr <= '1';
				TMP := '0';
			end if;

		end if;
	end process;	
	

	process (clock) 
	begin
		if (rising_edge(clock)) then
			clockCY7C6200 <= not clockCY7C6200;
		end if;
	end process;
end usb_interface_behav;


