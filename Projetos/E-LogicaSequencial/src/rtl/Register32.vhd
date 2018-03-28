-- Elementos de Sistemas
-- by Luciano Soares
-- Register32.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Register32 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(31 downto 0); -- Input é um vetor de 32 bits
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(31 downto 0) -- Output é um vetor de 32 bits
	);
end entity;

architecture rtl of Register32 is

	component Register16 is -- Declaração do componente Register32
		port(
			clock:   in STD_LOGIC;
			input:   in STD_LOGIC_VECTOR(15 downto 0);
			load:    in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(15 downto 0)
			);
	end component;

	signal s1, s2: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

	begin

	-- r1 é um Register16 que recebe como input os 16 primeiros bits do Register32
	-- e tem como o output é o que está carregando/foi carregado 
	r1: Register16 port map (clock,input(31 downto 16),load,s1);
	-- r2 é um Register16 que recebe como input os 16 últimos bits do Register32
	-- e tem como o output é o que está carregando/foi carregado 
	r2: Register16 port map (clock,input(15 downto 0),load,s2);
	-- output do Register32 é a junção dos outputs dos Register32
	output <= s1 & s2;

end architecture;

