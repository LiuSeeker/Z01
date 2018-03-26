--
-- Elementos de Sistemas - Aula 5 - Logica Combinacional
-- Rafael . Corsi @ insper . edu . br 
--
-- Arquivo exemplo para acionar os LEDs e ler os bottoes
-- da placa DE0-CV utilizada no curso de elementos de 
-- sistemas do 3s da eng. da computacao

----------------------------
-- Bibliotecas ieee       --
----------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

----------------------------
-- Entrada e saidas do bloco
----------------------------
entity TopLevel is
	port(
		A : in std_logic;
		B : in std_logic;
		C : in std_logic;
		Q: out std_logic
	);
end entity;

--------------------
-- A'*B + B*C = Q --
--------------------

----------------------------
-- Implementacao do bloco -- 
----------------------------
architecture rtl of TopLevel is

component And16
	--Definindo portas
	port ( 
			--Saida A
			a:   in  STD_LOGIC;
			--Saida B
			b:   in  STD_LOGIC;
			--Resultado
			q:   out STD_LOGIC);
end component;

component Not16 
	port ( 
			a:   in  STD_LOGIC;
			q:   out STD_LOGIC);
end component;

 
component Or16 
	port ( 
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			q:   out STD_LOGIC);
end component;
--------------
-- signals
--------------
signal si1, si2, si3, si4: STD_LOGIC:='0';

---------------
-- implementacao
---------------
begin

NOT1: Not16 port map(A,si1);
AND1: And16 port map(si1,B,si2);
AND2: And16 port map(B,C,si3);
OR1: Or16 port map(si2,si3,si4);

Q <= si4;

end rtl;
