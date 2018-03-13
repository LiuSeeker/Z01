library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4Way is
	port ( 
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			c:   in  STD_LOGIC;
			d:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(1 downto 0);
			q:   out STD_LOGIC);
end entity;

architecture jor of Mux4Way is
begin
process (a,b,c,d,sel) is
begin
q <= a when sel="00";
q <= b when sel="01";
q <= c when sel="10";
q <= d when sel="11";
end process;
end jor;