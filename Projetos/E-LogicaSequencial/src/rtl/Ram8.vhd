-- Elementos de Sistemas
-- by Luciano Soares
-- Ram8.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Ram8 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR( 2 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Ram8 is

	component DMux8Way is
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
	end component;

	component Mux8Way16 is
		port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			c:   in  STD_LOGIC_VECTOR(15 downto 0);
			d:   in  STD_LOGIC_VECTOR(15 downto 0);
			e:   in  STD_LOGIC_VECTOR(15 downto 0);
			f:   in  STD_LOGIC_VECTOR(15 downto 0);
			g:   in  STD_LOGIC_VECTOR(15 downto 0);
			h:   in  STD_LOGIC_VECTOR(15 downto 0);
			sel: in  STD_LOGIC_VECTOR(2 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0));
	end component;

	component Register16 is
		port(
			clock:   in STD_LOGIC;
			input:   in STD_LOGIC_VECTOR(15 downto 0);
			load:    in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	signal l0, l1, l2, l3, l4, l5, l6, l7: STD_LOGIC; 
	signal o0, o1, o2, o3, o4, o5, o6, o7, out1: STD_LOGIC_VECTOR(15 downto 0);



begin 

	D1 : DMux8Way port map (load, address, l0, l1, l2, l3, l4, l5, l6, l7);
    R1 : Register16 port map (clock,input, l0, o0);
    R2 : Register16 port map (clock,input, l1, o1);
    R3 : Register16 port map (clock,input, l2, o2);
    R4 : Register16 port map (clock,input, l3, o3);
    R5 : Register16 port map (clock,input, l4, o4);
    R6 : Register16 port map (clock,input, l5, o5);
    R7 : Register16 port map (clock,input, l6, o6);
    R8 : Register16 port map (clock,input, l7, o7);
    M1 : Mux8Way16 port map (o0, o1, o2, o3, o4, o5, o6, o7, address, output);

end rtl;