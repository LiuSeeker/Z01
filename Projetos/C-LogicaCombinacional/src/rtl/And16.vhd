library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity And16 is
	--Definindo portas
	port ( 
			--Saida A
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			--Saida B
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			--Resultado
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end entity;
--Iniciando arquitetura 
architecture rtl of And16 is
begin
	--Logica para AND
   q <=  (a and b);
end rtl;
