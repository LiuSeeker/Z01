-- Elementos de Sistemas
-- by Luciano Soares
-- Ram4K.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Ram4K is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0); -- Input é um vetor de 16 bits
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR(11 downto 0); -- Address é um vetor de 12 bits, 3 bits para serem 
													-- usados no Dmux8Way e 9 bits para serem usados nas ram512
		output:  out STD_LOGIC_VECTOR(15 downto 0)  -- Output é um vetor de 16 bits
	);
end entity;

architecture rtl of Ram4K is

	component Ram512 is -- Declaração do componente Ram512
		port(
			clock, load: in STD_LOGIC;   
			input: in STD_LOGIC_VECTOR(15 downto 0);
			address: in  STD_LOGIC_VECTOR(8 downto 0);
			output: out STD_LOGIC_VECTOR(15 downto 0)  
		);
	end component;

	component DMux8Way is -- Declaração do componente DMux8Way
		port(
			a: in STD_LOGIC;
			sel: in STD_LOGIC_VECTOR(2 downto 0);
			q0,q1,q2,q3,q4,q5,q6,q7: out STD_LOGIC 
		);
	end component;

	component Mux8Way16 is -- Declaração do componente Mux8Way16
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
		-- Dmux recebe o load, o address como seu seletor, e devolve a saída dependendo do seletor
		dmux: DMux8Way port map(load, address(11 downto 9), l0, l1, l2, l3, l4, l5, l6, l7);

		-- Cada Ram512 é ligada a uma saída do Dmux, e recebe o input e o restante do address da ram4K
		-- como seu próprio address. Seu output é o que foi carregado/está carregando. 
		ram512_0: Ram512 port map(clock, l0, input, address(8 downto 0), o0);
		ram512_1: Ram512 port map(clock, l1, input, address(8 downto 0), o1);
		ram512_2: Ram512 port map(clock, l2, input, address(8 downto 0), o2);
		ram512_3: Ram512 port map(clock, l3, input, address(8 downto 0), o3);
		ram512_4: Ram512 port map(clock, l4, input, address(8 downto 0), o4);
		ram512_5: Ram512 port map(clock, l5, input, address(8 downto 0), o5);
		ram512_6: Ram512 port map(clock, l6, input, address(8 downto 0), o6);
		ram512_7: Ram512 port map(clock, l7, input, address(8 downto 0), o7);

		-- Mux seleciona qual output das rams512 será o output da ram4k, dependendo do address, que é seu seletor
		mux: Mux8Way16 port map(o0, o1, o2, o3, o4, o5, o6, o7, address(11 downto 9), output);

end architecture;
