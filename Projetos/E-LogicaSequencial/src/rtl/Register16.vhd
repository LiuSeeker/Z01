-- Elementos de Sistemas
-- by Luciano Soares
-- Register16.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Register16 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(15 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;


architecture rtl of Register16 is

component Register8 is
	port(
		clock,input,load:      in STD_LOGIC;   -- entradas
		output: out STD_LOGIC   -- sum e carry
	);
end component;

signal out1,out2: STD_LOGIC_VECTOR(7 downto 0);

begin

		R1: Register8 port map (
			clock => clock,
			input => ínput(7 downto 0),
			load => load,
			output => out1
		);

		R2: Register8 port map (
			clock => clock,
			input => ínput(15 downto 8),
			load => load,
			output => out2
		);

		output(7 downto 0) <= out1;
		output(15 downto 8) <= out2;


end rtl;