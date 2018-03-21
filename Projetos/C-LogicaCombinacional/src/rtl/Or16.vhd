library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity Or16 is
	port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end entity;

-----------------------------------------------------------------

architecture rtl of OR16 is
begin
	--Apenas determinei que a saída "q" terá o valor de "a or b". Um OR bem simples.
	q <= (a or b);
end rtl;
