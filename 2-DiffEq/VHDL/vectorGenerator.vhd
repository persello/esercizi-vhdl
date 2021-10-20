LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.fixed_pkg.ALL;
USE std.textio.ALL;

ENTITY vectorGenerator IS
  GENERIC (
    SSZ : INTEGER;
    DSZ : INTEGER;
    LLM : INTEGER);
  PORT (
    clk : OUT STD_LOGIC;
    rst : OUT STD_LOGIC;
    xi  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
    yi  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
    ui  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
    dx  : OUT SFIXED(DSZ - 1 DOWNTO LLM);
    a   : OUT SFIXED(SSZ - 1 DOWNTO LLM);
    c   : IN STD_LOGIC;
    x   : IN SFIXED(DSZ - 1 DOWNTO LLM);
    y   : IN SFIXED(DSZ - 1 DOWNTO LLM));
END ENTITY vectorGenerator;

ARCHITECTURE behavioral OF vectorGenerator IS

  CONSTANT ckP   : TIME   := 100 ns;
  CONSTANT ckHP  : TIME   := 0.5 * ckP;

  CONSTANT fName : STRING := "RESULTS/diffeq.out";
  FILE outFile   : TEXT;

BEGIN

  rstP : PROCESS
  BEGIN
    rst <= '0';
    FILE_OPEN(outFile, fName, WRITE_MODE);
    WAIT FOR ckHP - 20 ns;
    rst <= '1';
    WAIT;
  END PROCESS;

  clkP : PROCESS
    VARIABLE outLine : LINE;
    VARIABLE ckTmp   : STD_LOGIC := '0';
  BEGIN
    clk <= ckTmp;
    ckTmp := NOT ckTmp;
    WAIT FOR ckHP;
    WRITE (outLine, TO_REAL(x));
    WRITE (outLine, STRING'(" "));
    WRITE (outLine, TO_REAL(y));
    WRITELINE (outFile, outLine);
    IF c = '1' THEN
      WAIT;
    END IF;
  END PROCESS;

  iniP : PROCESS
  BEGIN
    xi <= TO_SFIXED(0.0, xi);
    yi <= TO_SFIXED(1.0, yi);
    ui <= TO_SFIXED(0.0, ui);
    dx <= TO_SFIXED(0.001, dx);
    a  <= TO_SFIXED(3.0, a);
    WAIT;
  END PROCESS;

END behavioral;
