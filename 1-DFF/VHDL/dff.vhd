LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dff IS
  PORT (
    clk  : IN STD_LOGIC;
    rstn : IN STD_LOGIC;
    d    : IN STD_LOGIC;
    q    : OUT STD_LOGIC;
    qn   : OUT STD_LOGIC);
END dff;

ARCHITECTURE behavioral OF dff IS
  SIGNAL qI : STD_LOGIC;

BEGIN

  dffP : PROCESS (rstn, clk)
  BEGIN
    IF (rstn = '0') THEN
      qI <= '0';
    ELSE
      IF (clk'EVENT AND clk = '1') THEN
        qI <= d;
      END IF;
    END IF;
  END PROCESS;

  q  <= qI;
  qn <= NOT qI;

END behavioral;
