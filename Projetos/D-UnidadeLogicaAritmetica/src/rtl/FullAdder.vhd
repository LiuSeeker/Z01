-- Elementos de Sistemas
-- by Luciano Soares
-- FullAdder.vhd

-- Implementa Full Adder

Library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
	port(
		a,b,c:      in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end entity;

architecture rtl of FullAdder is
	component HalfAdder -- Faz do HalfAdder um sub-módulo do FullAdder
		port(
			a,b:         in STD_LOGIC;   -- entradas
			soma,vaium: out STD_LOGIC   -- sum e carry
		);
	end component;

	-- "Variáveis" globais auxiliares
	signal s1,c1,c2 : std_logic:='0';

	begin
		-- HalfAdder que recebe 'a' e 'b' e retorna 'soma' como 's1', e 'vaium' como 'c1'
		H1: HalfAdder port map (
			a => a,
			b => b,
			soma => s1,
			vaium => c1
		);
		-- HalfAdder que recebe 's1' e 'c' e retorna 'soma', e 'vaium' como 'c2'
		H2: HalfAdder port map (
			a => s1,
			b => c,
			soma => soma,
			vaium => c2
		);
		-- vaium é o resultado entre 'or' dos carrys dos dois HalfAdder
		vaium <= c1 or c2;

end architecture;
