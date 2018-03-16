-- Elementos de Sistemas
-- by Luciano Soares
-- HalfAdder.vhd

-- Implementa Half Adder

Library ieee;
use ieee.std_logic_1164.all;

entity HalfAdder is
	port(
		a,b:         in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end entity;

architecture rtl of HalfAdder is
begin

soma  <= a xor b; --Para fazermos o halfAdder, temos a saída soma e valium e eles 
vaium <= a and b; --recebem, respectivamente, o 'xor' e 'and' das entradas

end architecture;
