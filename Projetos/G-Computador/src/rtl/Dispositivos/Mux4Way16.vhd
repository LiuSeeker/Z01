library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4Way16 is
	port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			sel: in  STD_LOGIC
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture mux4_16 of Mux4Way16 is
begin
process (a,b,c,d,sel) is
begin
  if (sel ='0') then
      q <= a;
  elsif (sel(0) ='1') then
      q <= b;
  end if;
  
end process;
end mux4_16;