-- Elementos de Sistemas
-- by Luciano Soares
-- Add16.vhd

-- Soma dois valores de 16 bits
-- ignorando o carry mais significativo

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Add16 is	-- Declarando o nosso operador aritmético
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		b   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Add16 is

component FullAdder is
	port(
		a,b,c:      in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end component;

--component HalfAdder is
--	port(
--		a,b:      in STD_LOGIC;   -- entradas
--		soma,vaium: out STD_LOGIC   -- sum e carry
--	);
--end component;


	-- "Variáveis" globais auxiliares
	signal c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16 : std_logic:='0';


begin
	d : FullAdder port map (a(0),b(0),'0',q(0),c1);
	e : FullAdder port map (a(1),b(1),c1,q(1),c2);
	f : FullAdder port map (a(2),b(2),c2,q(2),c3);
	g : FullAdder port map (a(3),b(3),c3,q(3),c4);
	h : FullAdder port map (a(4),b(4),c4,q(4),c5);
	i : FullAdder port map (a(5),b(5),c5,q(5),c6);
	j : FullAdder port map (a(6),b(6),c6,q(6),c7);
	k : FullAdder port map (a(7),b(7),c7,q(7),c8);
	l : FullAdder port map (a(8),b(8),c8,q(8),c9);
	m : FullAdder port map (a(9),b(9),c9,q(9),c10);
	n : FullAdder port map (a(10),b(10),c10,q(10),c11);
	o : FullAdder port map (a(11),b(11),c11,q(11),c12);
	p : FullAdder port map (a(12),b(12),c12,q(12),c13);
	z : FullAdder port map (a(13),b(13),c13,q(13),c14);
	r : FullAdder port map (a(14),b(14),c14,q(14),c15); 
	s : FullAdder port map (a(15),b(15),c15,q(15),c16);

end architecture;
