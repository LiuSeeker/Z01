library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2Way is
	--Definindo declaração de portas
	port ( 
			--Saida A
			a:   in  STD_LOGIC;
			--Saida B
			b:   in  STD_LOGIC;
			--Seletor
			sel: in  STD_LOGIC;
			--Resultado
			q:   out STD_LOGIC);
end entity;

architecture jor of Mux2Way is
begin
--Logica para Mux2Way
q <= a when (sel = '0') else b when (sel = '1');
end jor;