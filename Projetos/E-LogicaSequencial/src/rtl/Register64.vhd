-- Elementos de Sistemas
-- by Luciano Soares
-- Register64.vhd

Library ieee;
use ieee.std_logic_1164.all;

entity Register64 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(63 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(63 downto 0)
	);
end entity;

architecture reg64 of Register64 is
  signal saida: STD_LOGIC_VECTOR(63 downto 0);

  component Register32 is
    port(
      clock:   in STD_LOGIC;
      input:   in STD_LOGIC_VECTOR(31 downto 0);
      load:    in STD_LOGIC;
      output: out STD_LOGIC_VECTOR(31 downto 0)
    );
  end component;
begin

    R1: Register32 port map(clock, input(31 downto 0), load, saida(31 downto 0));
    R2: Register32 port map(clock, input(63 downto 32), load,saida(63 downto 32));

    output <= saida;

end reg64;
