-- Elementos de Sistemas
-- by Luciano Soares
-- Ram64.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Ram64 is --definição do Ram64
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR( 5 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Ram64 is

	component Ram8 is --Definição do componente Ram8
		port(
			clock, load: in STD_LOGIC;   
			input: in STD_LOGIC_VECTOR(15 downto 0);
			address: in  STD_LOGIC_VECTOR(2 downto 0);
			output: out STD_LOGIC_VECTOR(15 downto 0)  
		);
	end component;

	component DMux8Way is --Definição do componente DMux8Way
		port(
			a: in STD_LOGIC;
			sel: in STD_LOGIC_VECTOR(2 downto 0);
			q0,q1,q2,q3,q4,q5,q6,q7: out STD_LOGIC 
		);
	end component;

	component Mux8Way16 is --Definição do componente Mux8Way16
		port(
			a,b,c,d,e,f,g,h: in STD_LOGIC_VECTOR(15 downto 0);
			sel: in STD_LOGIC_VECTOR(2 downto 0);
			q: out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	-- "Variáveis" globais auxiliares
	signal  l0,l1,l2,l3,l4,l5,l6,l7: std_logic:='0';
	signal  o0,o1,o2,o3,o4,o5,o6,o7: STD_LOGIC_VECTOR(15 downto 0);

	begin
		-- Dmux que recebe 'load' como 'a', 'adress' como o seletor
		-- e retorna ln como o qn
		dmux: DMux8Way port map(load, address(5 downto 3), l0, l1, l2, l3, l4, l5, l6, l7);

		-- Todas as Rams recebem o clock como o clock, 
		ram8_0: Ram8 port map(clock, l0, input, address(2 downto 0), o0);
		ram8_1: Ram8 port map(clock, l1, input, address(2 downto 0), o1);
		ram8_2: Ram8 port map(clock, l2, input, address(2 downto 0), o2);
		ram8_3: Ram8 port map(clock, l3, input, address(2 downto 0), o3);
		ram8_4: Ram8 port map(clock, l4, input, address(2 downto 0), o4);
		ram8_5: Ram8 port map(clock, l5, input, address(2 downto 0), o5);
		ram8_6: Ram8 port map(clock, l6, input, address(2 downto 0), o6);
		ram8_7: Ram8 port map(clock, l7, input, address(2 downto 0), o7);

		mux: Mux8Way16 port map(o0, o1, o2, o3, o4, o5, o6, o7, address(5 downto 3), output);

end architecture;
