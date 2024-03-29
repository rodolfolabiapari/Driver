library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tx is
	port (
		clockFast     :  in std_logic;
		clockSlow     :  in std_logic;
		start         :  in std_logic;
		busy          : out std_logic;
		data          :  in std_logic_vector (7 downto 0);
		tx_line       : out std_logic
	);
end tx;

architecture tx_behiv of tx is
signal index   : integer range 0 to 9         := 0;
signal datafll : std_logic_vector(9 downto 0) ;
signal tx_flg  : std_logic                    := '0';
begin
	-- Processo que envia os caracteres atraves de UART
	process(clockSlow, clockFast)
	begin
		
		if (tx_flg = '0') then 
			if (start = '1') then
				-- Se sim, seta os valores pra que possa enviar os dados
				tx_flg <= '1'; -- Diz que está processando algo (flag interna)
				busy <= '1'; -- Diz que está processando algo (flag externa)
				
				datafll(0) <= '0'; -- Define o bit de start do protocolo
				datafll(9) <= '1'; -- Define o bit de stop do protocolo

				-- Diz qual posição do vetor de dados está enviando no momento
				index <= 0;

				datafll(8 downto 1)<= data; -- Recebe o dado
				
			elsif (start = '0') then
			-- Verifica se não está processando nada
			-- para que seja liberado o canal evitando 
			-- interferências ou corrompimentos
				busy <= '0'; -- Diz que não está trabalhando
				tx_line<='1'; -- Libera o canal
			end if;
		elsif (tx_flg = '1') then
	
			-- Para cada borda de subida
			if (clockSlow'event and clockSlow='1') then
				-- Verifica se pode enviar algo,
					-- Talvez o botão start não tenha sido pressionado (start) ou
					-- talvez algo já esteja sendo processado (tx_flg)

				-- Verifica se pode começar o trabalho de envio
				--if (tx_flg='1') then
					--Envia o bit no indice indicado
					tx_line <= datafll(index);

					-- Se o indice for menor que 10 (indexado de 0)
					-- Ou seja, não enviou os bits ainda
					if (index<9) then
						-- Incrementa o indice pro envio do proximo
						index <= index + 1;

					-- Se tiver enviado todos os 10 bits
					else
						-- Reseta todas as flags avisando que está 
						-- pronto pra um próximo envio de dado
						tx_flg<='0'; -- Diz que NÃO está processando algo (flag interna)
						busy<='0'; -- Diz que NÃO está processando algo (flag externa)
						index<=0; -- Reseta o indice para 0
						tx_line<='1'; -- Libera o canal dos dispositivos
					end if;
			end if;
		end if;
	end process;
end tx_behiv;