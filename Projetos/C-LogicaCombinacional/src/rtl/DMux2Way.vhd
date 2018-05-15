library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DMux2Way is
	port ( 
			a:   in  STD_LOGIC;
			sel: in  STD_LOGIC;
			q0:  out STD_LOGIC;
			q1:  out STD_LOGIC);
end entity;

architecture funk of DMux2Way is
signal bb : STD_LOGIC;
begin
	bb <= not sel;
	q0 <= bb and a;
	q1 <= sel and a;
	
end architecture funk;