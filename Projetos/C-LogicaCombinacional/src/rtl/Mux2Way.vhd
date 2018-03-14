library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2Way is
	port ( 
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			sel: in  STD_LOGIC;
			q:   out STD_LOGIC);
end entity;

architecture jor of Mux2Way is
begin
q <= (a and (not sel)) or (b and sel);
end jor;