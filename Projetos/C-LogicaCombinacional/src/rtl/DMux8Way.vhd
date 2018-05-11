library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DMux8Way is
	port ( 
			a:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(2 downto 0);
			q0:  out STD_LOGIC;
			q1:  out STD_LOGIC;
			q2:  out STD_LOGIC;
			q3:  out STD_LOGIC;
			q4:  out STD_LOGIC;
			q5:  out STD_LOGIC;
			q6:  out STD_LOGIC;
			q7:  out STD_LOGIC);
end entity;

architecture jor of DMux8Way is
begin
	q0 <= a and not sel(2) and not sel(1) and not sel(0);
	q1 <= a and not sel(2) and not sel(1) and sel(0);
	q2 <= a and not sel(2) and sel(1) and not sel(0);
	q3 <= a and not sel(2) and sel(1) and sel(0);
	q4 <= a and sel(2) and not sel(1) and not sel(0);
	q5 <= a and sel(2) and not sel(1) and sel(0);
	q6 <= a and sel(2) and sel(1) and not sel(0);
	q7 <= a and sel(2) and sel(1) and sel(0);
end jor;