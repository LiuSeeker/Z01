	-- Elementos de Sistemas
-- by Luciano Soares
-- Register32.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Register32 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(31 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(31 downto 0)
	);
end entity;

architecture rtl of Register32 is

	component Register16 is
		port(
			clock:   in STD_LOGIC;
			input:   in STD_LOGIC_VECTOR(15 downto 0);
			load:    in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(15 downto 0)
			);
	end component;

	signal s1, s2: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

	begin

	r1: Register16 port map (clock,input(31 downto 16),load,s1);
	r2: Register16 port map (clock,input(15 downto 0),load,s2);
	output <= s1 & s2;

end architecture;

