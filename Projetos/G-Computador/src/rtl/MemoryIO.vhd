library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoryIO is

   PORT(
        -- Sistema
        CLK_SLOW : IN  STD_LOGIC;
        CLK_FAST : IN  STD_LOGIC;
        RST      : IN  STD_LOGIC;

        -- RAM 16K
        ADDRESS		: IN  STD_LOGIC_VECTOR (14 DOWNTO 0);
        INPUT		: IN  STD_LOGIC_VECTOR (15 DOWNTO 0);
        LOAD		: IN  STD_LOGIC ;
        OUTPUT		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);

        -- LCD EXTERNAL I/OS
        LCD_CS_N     : OUT   STD_LOGIC;
        LCD_D        : INOUT STD_LOGIC_VECTOR(15 downto 0);
        LCD_RD_N     : OUT   STD_LOGIC;
        LCD_RESET_N  : OUT   STD_LOGIC;
        LCD_RS       : OUT   STD_LOGIC;	-- (DCx) 0 : reg, 1: command
        LCD_WR_N     : OUT   STD_LOGIC;
        LCD_ON       : OUT   STD_LOGIC := '1';	-- liga e desliga o LCD
        LCD_INIT_OK  : OUT   STD_LOGIC;

        -- Switchs
        SW  : in std_logic_vector(9 downto 0);
        LED : OUT std_logic_vector(9 downto 0)

		);
end entity;


ARCHITECTURE logic OF MemoryIO IS

  component Screen is
      PORT(
          INPUT        : IN STD_LOGIC_VECTOR(15 downto 0);
          LOAD         : IN  STD_LOGIC;
          ADDRESS      : IN STD_LOGIC_VECTOR(13 downto 0);

          -- Sistema
          CLK_FAST : IN  STD_LOGIC;
          CLK_SLOW : IN  STD_LOGIC;
          RST 	   : IN  STD_LOGIC;

          -- LCD EXTERNAL I/OS
          LCD_INIT_OK  : OUT STD_LOGIC;
          LCD_CS_N     : OUT   STD_LOGIC;
          LCD_D        : INOUT STD_LOGIC_VECTOR(15 downto 0);
          LCD_RD_N     : OUT   STD_LOGIC;
          LCD_RESET_N  : OUT   STD_LOGIC;
          LCD_RS       : OUT   STD_LOGIC;	-- (DCx) 0 : reg, 1: command
          LCD_WR_N     : OUT   STD_LOGIC
          );
  end component;

  component RAM16K IS
      PORT
      (
          address	: IN STD_LOGIC_VECTOR (13 DOWNTO 0);
          clock		: IN STD_LOGIC  := '1';
          data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
          wren		: IN STD_LOGIC;
          q		   : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
      );
  end component;

  component Register16 IS
  	PORT
  	(
  		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(15 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(15 downto 0) 
  	);
  end component;

  component DMux4Way IS
  	PORT
  	(
  		a: in STD_LOGIC;
  		sel: IN STD_LOGIC_VECTOR(1 downto 0);
  		q0: out STD_LOGIC;
  		q1: out STD_LOGIC;
  		q2: out STD_LOGIC;
  		q3: out STD_LOGIC
  	);
  end component;

  component Mux4Way16 IS
  	PORT
  	(
  		a: in STD_LOGIC_VECTOR(15 downto 0);
  		b: in STD_LOGIC_VECTOR(15 downto 0);
  		sel: in STD_LOGIC;
  		q: out STD_LOGIC_VECTOR(15 downto 0)
  	);
  end component;

SIGNAL dataout, reg_out, sw16: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL address14: std_logic_vector (13 downto 0);
SIGNAL dmux_out0, dmux_out1, dmux_out2, dmux_out3, sel_mux: std_logic;
SIGNAL sel_dmux: std_logic_vector(1 downto 0);

BEGIN
	address14 <= ADDRESS(13 downto 0); -- address para ser usado no SCREEN
	sel_dmux <= ADDRESS(14 downto 13); -- Seletor do dmux, composto pelos dois bits da esquerda do address
	sw16 <= "000000" & SW; -- vetor composto por seis 0 e o SW, para entrar no mux

	DMUX: DMux4Way port map(LOAD, sel_dmux, dmux_out0, dmux_out1, dmux_out2, dmux_out3); -- out0 vai para ram, out1 para o register, out2 para o SCREEN, out3 para o seletor do mux
	MUX: Mux4Way16 port map(dataout, sw16, dmux_out3, OUTPUT); 

	RAM: RAM16K port map(address14, CLK_FAST, INPUT, dmux_out0, dataout);
	REG: Register16 port map(CLK_SLOW, INPUT, dmux_out1, reg_out);
	SRC: Screen port map(INPUT, dmux_out2, address14, CLK_FAST, CLK_SLOW, RST, LCD_INIT_OK, LCD_CS_N, LCD_D, LCD_RD_N, LCD_RESET_N, LCD_RS, LCD_WR_N);

	LED <= reg_out(9 downto 0); -- LED tem q ser um vetor de 10 bits (10 da direitra)
								-- o input do register até poderia ser de 10 bits para ser igual ao led, mas o register é de 16

END logic;