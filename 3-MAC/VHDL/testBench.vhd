
LIBRARY ieee;
USE     ieee.std_logic_1164.ALL;
USE     ieee.fixed_pkg.ALL;

ENTITY testBench IS
END testBench;

ARCHITECTURE structural OF testBench IS

  CONSTANT LP  : INTEGER := -15;
  CONSTANT LNP : INTEGER :=   1;
  CONSTANT LN  : INTEGER :=   3;

  COMPONENT mac
    GENERIC (P   :     INTEGER);
    PORT    (clr : IN  STD_LOGIC;
             clk : IN  STD_LOGIC;
             xr  : IN  SFIXED (0 DOWNTO P);
             xi  : IN  SFIXED (0 DOWNTO P);
             yr  : IN  SFIXED (0 DOWNTO P);
             yi  : IN  SFIXED (0 DOWNTO P);
             pr  : OUT SFIXED (0 DOWNTO P);
             pi  : OUT SFIXED (0 DOWNTO P);
             ovf : OUT STD_LOGIC);
  END COMPONENT;

  COMPONENT vectorGenerator IS
    GENERIC (P   :     INTEGER;
             NP  :     INTEGER;
             N   :     INTEGER);
    PORT    (clr : OUT STD_LOGIC;
             clk : OUT STD_LOGIC;
             xr  : OUT SFIXED (0 DOWNTO P);
             xi  : OUT SFIXED (0 DOWNTO P);
             yr  : OUT SFIXED (0 DOWNTO P);
             yi  : OUT SFIXED (0 DOWNTO P);
             pr  : IN  SFIXED (0 DOWNTO P);
             pi  : IN  SFIXED (0 DOWNTO P);
             ovf : IN  STD_LOGIC);
  END COMPONENT;

  SIGNAL lclr : STD_LOGIC;
  SIGNAL lclk : STD_LOGIC;
  SIGNAL lxr  : SFIXED (0 DOWNTO LP);
  SIGNAL lxi  : SFIXED (0 DOWNTO LP);
  SIGNAL lyr  : SFIXED (0 DOWNTO LP);
  SIGNAL lyi  : SFIXED (0 DOWNTO LP);
  SIGNAL lpr  : SFIXED (0 DOWNTO LP);
  SIGNAL lpi  : SFIXED (0 DOWNTO LP);
  SIGNAL lovf : STD_LOGIC;


BEGIN

  dMac : mac
           GENERIC MAP (P   => LP)
           PORT    MAP (clr => lclr,
                        clk => lclk,
                        xr  => lxr,
                        xi  => lxi,
                        yr  => lyr,
                        yi  => lyi,
                        pr  => lpr,
                        pi  => lpi,
                        ovf => lovf);

  dVec : vectorGenerator
           GENERIC MAP (P   => LP,
                        NP  => LNP,
                        N   => LN)
           PORT    MAP (clr => lclr,
                        clk => lclk,
                        xr  => lxr,
                        xi  => lxi,
                        yr  => lyr,
                        yi  => lyi,
                        pr  => lpr,
                        pi  => lpi,
                        ovf => lovf);

END structural;
