-- Elementos de Sistemas
-- by Luciano Soares
-- inversor16.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity inversor16 is
   port(z   : in STD_LOGIC;
	      a   : in STD_LOGIC_VECTOR(15 downto 0);
        y   : out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture rtl of inversor16 is
begin
process(z,a)                 -- iniciando o processo com z e a para fazer um if
begin
     if ( z = '1' ) then     -- quando o seletor tiver valor 1, a saída y
       y <= NOT a ;          -- recebe not a (a invertido)
     else
       y <= a ;              -- quando o seletor valer 0, y recebe a
     end if ;
end process ;

end architecture;
