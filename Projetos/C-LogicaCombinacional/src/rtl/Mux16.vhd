library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux16 is
	--Declaração de portas
	port ( 
			--Saida A com 16 BITS
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			--Saida B com 16 BITS
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			--Seletor Logico
			sel: in  STD_LOGIC;
			--Resultado com 16 BITS
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture jor of Mux16 is
begin

--Lógica para funcionamento do Mux16
q <= a when (sel = '0') else b;
	  
end jor;