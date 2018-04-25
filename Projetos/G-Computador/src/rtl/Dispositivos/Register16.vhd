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

  component Register8 is      --adicionando componente Register8
  	port(
  		clock:   in STD_LOGIC;
  		input:   in STD_LOGIC_VECTOR(7 downto 0);
  		load:    in STD_LOGIC;
  		output: out STD_LOGIC_VECTOR(7 downto 0));
  end component;

signal out1,out2: STD_LOGIC_VECTOR(7 downto 0); --sinais de saida dos registers
begin

		R1: Register8 port map (clock,input(7 downto 0),load,out1); --port map dos registers
		R2: Register8 port map (clock,input(15 downto 8),load,out2);

		output(7 downto 0) <= out1; --definindo a saida do register 16, baseado nas saidas dos registers 8
		output(15 downto 8) <= out2;

end rtl;
