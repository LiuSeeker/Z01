-- Elementos de Sistemas
-- by Luciano Soares
-- Inc16.vhd

-- Incrementador de 16 bits
-- adiciona 1 ao valore de entrada (adição aritmética)

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Inc16 is --Criando o Inc16
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Inc16 is --Definindo a arquitetura do Inc16

component Add16 is --Chamando o Add16 para usar com o port map mais abaixo
	port(
		a,b   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0)
	);
end component;

begin
	
	j : Add16 port map (a,"0000000000000001",q); --Criando o Inc16 com uso o Add16 colocando "1" no último bit do vetor b
end architecture;
