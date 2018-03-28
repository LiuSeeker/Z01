-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: PC.vhd
-- date: 4/4/2017

-- Contador de 16bits
-- if (reset[t] == 1) out[t+1] = 0
-- else if (load[t] == 1)  out[t+1] = in[t]
-- else if (inc[t] == 1) out[t+1] = out[t] + 1
-- else out[t+1] = out[t]

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity PC is --Gera os sinais necessários
    port(
        clock     : in  STD_LOGIC;
        increment : in  STD_LOGIC; --Soma 1 ao último output
        load      : in  STD_LOGIC; --Carrega o input
        reset     : in  STD_LOGIC; --Zera o output
        input     : in  STD_LOGIC_VECTOR(15 downto 0); --Entrada
        output    : out STD_LOGIC_VECTOR(15 downto 0) --Saída
    );
end entity;

architecture arch of PC is

  signal toout : STD_LOGIC_VECTOR(15 downto 0); --Cria um sinal que será utilizado como out(t-1)
  signal incremento : STD_LOGIC_VECTOR(15 downto 0); --Cria um sinal que adicionará 1 ao out(t-1)
  
  component Inc16 is
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0)
	);
end component;
begin
  PC : inc16 port map(input,incremento); --Port map do Inc16, para somar 1 ao out(t-1)
  
  process (reset,load,increment, clock) begin

    if (reset = '1') then
      toout <= toout and "0"; --Reset ligado -> output zerado
    elsif (load = '1') then
      toout <= input; --Load ligado -> output recebe input
    elsif (increment = '1') then
      toout <= incremento; --Increment ligado -> out(t) = out(t-1) + 1
    else
      toout <= toout; --Todas as chaves desligadas -> out(t) = out(t-1)

  end if;

  output <= toout;
	
  end process;

	end architecture;