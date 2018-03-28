-- Elementos de Sistemas
-- by Luciano Soares
-- FlipFlopD.vhd

library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopD is --Gera os sinais necessários
	port(
		clock:  in std_logic;
		d:      in std_logic;
		clear:  in std_logic;
		preset: in std_logic;
		q:     out std_logic
	);
end entity;

architecture arch of FlipFlopD is
begin
process(clock, clear, preset) --Inicia os sinais clock, clear e preset como processos. Para que o output seja atualizado com qualquer mudança nesses sinais
begin

	if(clear = '1') then --Clear ligado -> saída recebe 0, independente da entrada
		q <= '0';
		
	elsif(preset = '1') then --Preset ligado -> saída recebe 1, independente da entrada
		q <= '1';
		
	elsif(rising_edge(clock)) then --Saída recebe o sinal de entrada quando o clock é atualizado (de 0 para 1)
		q <= d;
		
end if;
end process;
end architecture;