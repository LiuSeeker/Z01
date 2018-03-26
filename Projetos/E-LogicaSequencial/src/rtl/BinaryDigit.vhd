-- Elementos de Sistemas
-- by Luciano Soares
-- BinaryDigit.vhd

Library ieee;
use ieee.std_logic_1164.all;

entity BinaryDigit is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC;
		load:    in STD_LOGIC;
		output: out STD_LOGIC
	);
end entity;

architecture aaa of BinaryDigit is
  signal outmux, outdff: STD_LOGIC;

  component FlipFlopD is          --Utilizando o componente FlipFlopD
  port(
    clock:  in std_logic;
    d:      in std_logic;
    clear:  in std_logic;
    preset: in std_logic;
    q:     out std_logic);
  end component;

  component Mux2Way is            --Utilizando o componente Mux2Way
    port(a:   in  STD_LOGIC;
  			 b:   in  STD_LOGIC;
  			 sel: in  STD_LOGIC;
  			 q:   out STD_LOGIC);
  end component;
begin

  DFF1: FlipFlopD port map(clock, outmux, '0', '0', outdff);
  MUX1: Mux2Way port map(outdff,input,load,outmux);

output <= outdff;

end architecture;
