LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY testBench IS
END testBench;
ARCHITECTURE structural OF testBench IS

  COMPONENT dff
    PORT (
      clk  : IN STD_LOGIC;
      rstn : IN STD_LOGIC;
      d    : IN STD_LOGIC;
      q    : OUT STD_LOGIC;
      qn   : OUT STD_LOGIC
    );
  END COMPONENT;

  COMPONENT vectorGenerator
    PORT (
      clk  : OUT STD_LOGIC;
      rstn : OUT STD_LOGIC;
      d    : OUT STD_LOGIC;
      q    : IN STD_LOGIC;
      qn   : IN STD_LOGIC
    );
  END COMPONENT;

  SIGNAL clkTB, rstnTB, dTB, qTB, qnTB : STD_LOGIC;

BEGIN

  d1 : dff PORT MAP(
    q    => qTB,
    rstn => rstnTB,
    qn   => qnTB,
    clk  => clkTB,
    d    => dTB);

  v1 : vectorGenerator PORT MAP(
    q    => qTB,
    rstn => rstnTB,
    qn   => qnTB,
    clk  => clkTB,
    d    => dTB);

END structural;
