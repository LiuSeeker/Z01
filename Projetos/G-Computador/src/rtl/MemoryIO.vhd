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
        ADDRESS   : IN  STD_LOGIC_VECTOR (14 DOWNTO 0);
        INPUT   : IN  STD_LOGIC_VECTOR (15 DOWNTO 0);
        LOAD    : IN  STD_LOGIC ;
        OUTPUT    : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);

        -- LCD EXTERNAL I/OS
        LCD_CS_N     : OUT   STD_LOGIC;
        LCD_D        : INOUT STD_LOGIC_VECTOR(15 downto 0);
        LCD_RD_N     : OUT   STD_LOGIC;
        LCD_RESET_N  : OUT   STD_LOGIC;
        LCD_RS       : OUT   STD_LOGIC; -- (DCx) 0 : reg, 1: command
        LCD_WR_N     : OUT   STD_LOGIC;
        LCD_ON       : OUT   STD_LOGIC := '1';  -- liga e desliga o LCD
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
          RST      : IN  STD_LOGIC;

          -- LCD EXTERNAL I/OS
          LCD_INIT_OK  : OUT STD_LOGIC;
          LCD_CS_N     : OUT   STD_LOGIC;
          LCD_D        : INOUT STD_LOGIC_VECTOR(15 downto 0);
          LCD_RD_N     : OUT   STD_LOGIC;
          LCD_RESET_N  : OUT   STD_LOGIC;
          LCD_RS       : OUT   STD_LOGIC; -- (DCx) 0 : reg, 1: command
          LCD_WR_N     : OUT   STD_LOGIC
          );
  end component;

  component RAM16K IS
      PORT
      (
          address : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
          clock   : IN STD_LOGIC  := '1';
          data    : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
          wren    : IN STD_LOGIC;
          q      : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
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

  component Mux16 IS
    PORT
    (
      a:   in  STD_LOGIC_VECTOR(15 downto 0);
      b:   in  STD_LOGIC_VECTOR(15 downto 0);
      sel: in  STD_LOGIC;
      q:   out STD_LOGIC_VECTOR(15 downto 0) 
    );
  end component;


SIGNAL dataout, reg_out, sw16: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL address14: std_logic_vector (13 downto 0);
SIGNAL loadRAM, loadLCD, loadLED, sel_mux: STD_LOGIC;

BEGIN
  address14 <= ADDRESS(13 downto 0); -- address para ser usado no SCREEN

  loadRAM <= '1' when (ADDRESS <= "0011111111111111") else
             '0';
  loadLCD <= '1' when (ADDRESS > "0011111111111111" and ADDRESS <= "0101001010111111") else
             '0';
  loadLED <= '1' when (ADDRESS = "101001011000000") else
             '0';
  sel_mux <= '1' when (ADDRESS = "101001011000001") else
             '0';

  sw16 <= "000000" & sw;

  RAM: RAM16K port map(address14, CLK_FAST, INPUT, loadRAM, dataout);
  REG: Register16 port map(CLK_SLOW, INPUT, loadLED, reg_out);
  SRC: Screen port map(INPUT, loadLCD, address14, CLK_FAST, CLK_SLOW, RST, LCD_INIT_OK, LCD_CS_N, LCD_D, LCD_RD_N, LCD_RESET_N, LCD_RS, LCD_WR_N);
  MUX: Mux16 port map(dataout, sw16, sel_mux, OUTPUT);

  LED <= reg_out(9 downto 0); -- LED tem q ser um vetor de 10 bits (10 da direita)
                -- o input do register até poderia ser de 10 bits para ser igual ao led, mas o register é de 16

END logic;