-- Elementos de Sistemas
-- by Luciano Soares
-- Ram512.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Ram512 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR( 8 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture behavi of Ram512 is

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

	component Ram64 is
		port(
			clock, load:   in  STD_LOGIC;
			input:   in  STD_LOGIC_VECTOR(15 downto 0);
			address: in  STD_LOGIC_VECTOR( 5 downto 0);
			output:  out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	--signal ;
	signal  l0,l1,l2,l3,l4,l5,l6,l7: std_logic:='0';
	signal  o0,o1,o2,o3,o4,o5,o6,o7: STD_LOGIC_VECTOR(15 downto 0);

begin
	-- Dmux que recebe 'load' como 'a', 'adress' como o seletor
	-- e retorna ln como o qn
	dmux1: DMux8Way port map(load, address(8 downto 6), l0, l1, l2, l3, l4, l5, l6, l7);

	-- Todas as Rams recebem o clock como o clock, 
	ram16_0: Ram64 port map(clock, l0, input, address(5 downto 0), o0);
	ram16_1: Ram64 port map(clock, l1, input, address(5 downto 0), o1);
	ram16_2: Ram64 port map(clock, l2, input, address(5 downto 0), o2);
	ram16_3: Ram64 port map(clock, l3, input, address(5 downto 0), o3);
	ram16_4: Ram64 port map(clock, l4, input, address(5 downto 0), o4);
	ram16_5: Ram64 port map(clock, l5, input, address(5 downto 0), o5);
	ram16_6: Ram64 port map(clock, l6, input, address(5 downto 0), o6);
	ram16_7: Ram64 port map(clock, l7, input, address(5 downto 0), o7);

	mux1: Mux8Way16 port map(o0, o1, o2, o3, o4, o5, o6, o7, address(8 downto 6), output);


end behavi;
