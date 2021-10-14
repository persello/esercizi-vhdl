LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY vectorGenerator IS
  PORT (
    clk  : OUT STD_LOGIC;
    rstn : OUT STD_LOGIC;
    d    : OUT STD_LOGIC;
    q    : IN STD_LOGIC;
    qn   : IN STD_LOGIC);
END vectorGenerator;

ARCHITECTURE behavioral OF vectorGenerator IS

  CONSTANT ckP           : TIME := 10 ns;
  CONSTANT ckHP          : TIME := 0.5 * ckP;

  SIGNAL id, iClk, iRstn : STD_LOGIC;

BEGIN
  PROCESS
  BEGIN
    iRstn <= '0';
    WAIT FOR ckHP;
    iRstn <= '1';
    WAIT;
  END PROCESS;

  PROCESS
    VARIABLE clkTmp : STD_LOGIC := '0';
  BEGIN
    iClk <= clkTmp;
    clkTmp := NOT clkTmp;
    WAIT FOR ckHP;
  END PROCESS;

  PROCESS
  BEGIN
    id <= '0';
    WAIT FOR 3 * ckP + ckHP;
    id <= '1';
    WAIT FOR 5 * ckP + ckHP;
    WAIT;
  END PROCESS;

  clk  <= iClk;
  rstn <= iRstn;
  d    <= id;
END behavioral;
