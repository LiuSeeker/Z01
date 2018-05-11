library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2Way16 is
	port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			sel: in  STD_LOGIC;
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture mux2_16 of Mux2Way16 is
begin
process (a,b,sel) is
begin
  if (sel ='0') then
      q <= a;
  elsif (sel ='1') then
      q <= b;
  end if;
  
end process;
end mux2_16;