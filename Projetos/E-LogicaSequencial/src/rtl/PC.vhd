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

entity PC is
    port(
        clock     : in  STD_LOGIC;
        increment : in  STD_LOGIC;
        load      : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        input     : in  STD_LOGIC_VECTOR(15 downto 0);
        output    : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity;

architecture arch of PC is

signal count, zr : unsigned(15 downto 0):= "0000000000000000";

begin
  
  
  process(clock, reset, increment, load) is
  begin
    if (reset = '1') then
      count <= zr;
    elsif (rising_edge(clock)) then
      if (load = '1') then 
        count <= unsigned(input);
      elsif (increment = '1') then
        count <= count + "0000000000000001";
      else
        count <= count;
      end if;
    end if;
    
    
  end process;
  output <=  STD_LOGIC_VECTOR(count);
end architecture;