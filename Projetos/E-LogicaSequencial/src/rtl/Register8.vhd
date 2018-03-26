-- Elementos de Sistemas
-- by Luciano Soares
-- Register8.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Register8 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(7 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(7 downto 0)
	);
end entity;


architecture behavioral of Register8 is

	component BinaryDigit is
		port(
			clock:   in STD_LOGIC;
			input:   in STD_LOGIC;
			load:    in STD_LOGIC;
			output: out STD_LOGIC
		);
	end component;
	--Variavel auxiliar para vetor output de 8 bits
	signal outp: STD_LOGIC_VECTOR(7 downto 0);

begin
	--Criar generate for para o vetor de 8 bits
	GEN_ADD: for I in 0 to 7 generate
		-- Para um Register8 precisa de 8 binarydigit para cada posição do vetor
		BIX: BinaryDigit port map(clock,input(I),load,outp(I));
	--Fechando for
	end generate GEN_ADD;

	--Output do Register8 recebe a saida do BI1
	output <= outp;

end behavioral;