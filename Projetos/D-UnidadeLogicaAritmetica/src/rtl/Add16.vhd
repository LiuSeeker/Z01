-- Elementos de Sistemas
-- by Luciano Soares
-- Add16.vhd

-- Soma dois valores de 16 bits
-- ignorando o carry mais significativo

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Add16 is
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		b   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Add16 is

component FullAdder is
	port(
		a,b,c:      in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end component;

component HalfAdder is
	port(
		a,b:      in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end component;

signal s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16 : std_logic:='0';

begin

	  HA1 : HalfAdder port map (
          a => a(0),
          b => b(0),
          soma => s1,
          vaium => c1
        );
      FA2 : FullAdder port map (
          a => a(1),
          b => b(1),
          c => c1,
          soma => s2,
          vaium => c2
        );
       FA3 : FullAdder port map (
          a => a(2),
          b => b(2),
          c => c2,
          soma => s3,
          vaium => c3
        );
       FA4 : FullAdder port map (
          a => a(3),
          b => b(3),
          c => c3,
          soma => s4,
          vaium => c4
        );
       FA5 : FullAdder port map (
          a => a(4),
          b => b(4),
          c => c4,
          soma => s5,
          vaium => c5
        );
       FA6 : FullAdder port map (
          a => a(5),
          b => b(5),
          c => c5,
          soma => s6,
          vaium => c6
        );
       FA7 : FullAdder port map (
          a => a(6),
          b => b(6),
          c => c6,
          soma => s7,
          vaium => c7
        );
       FA8 : FullAdder port map (
          a => a(7),
          b => b(7),
          c => c7,
          soma => s8,
          vaium => c8
        );
        FA9 : FullAdder port map (
          a => a(8),
          b => b(8),
          c => c8,
          soma => s9,
          vaium => c9
        );
        FA10 : FullAdder port map (
          a => a(9),
          b => b(9),
          c => c9,
          soma => s10,
          vaium => c10
        );
        FA11 : FullAdder port map (
          a => a(10),
          b => b(10),
          c => c10,
          soma => s11,
          vaium => c11
        );
        FA12 : FullAdder port map (
          a => a(11),
          b => b(11),
          c => c11,
          soma => s12,
          vaium => c12
        );
        FA13 : FullAdder port map (
          a => a(12),
          b => b(12),
          c => c12,
          soma => s13,
          vaium => c13
        );
        FA14 : FullAdder port map (
          a => a(13),
          b => b(13),
          c => c13,
          soma => s14,
          vaium => c14
        );
        FA15 : FullAdder port map (
          a => a(14),
          b => b(14),
          c => c14,
          soma => s15,
          vaium => c15
        );
        FA16 : FullAdder port map (
          a => a(15),
          b => b(15),
          c => c15,
          soma => s16,
          vaium => c16
        );
    q(0) <= s1;
    q(1) <= s2;
    q(2) <= s3;
    q(3) <= s4;
    q(4) <= s5;
    q(5) <= s6;
    q(6) <= s7;
    q(7) <= s8;
    q(8) <= s9;
    q(9) <= s10;
    q(10) <= s11;
    q(11) <= s12;
    q(12) <= s13;
    q(13) <= s14;
    q(14) <= s15;
	 q(15) <= s16;


end architecture;
