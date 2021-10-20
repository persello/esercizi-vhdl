-- y'' + 3xy' + 3y = 0

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.fixed_pkg.ALL;

ENTITY diffeq IS

  -- SSZ: Single Size
  -- DSZ: Double Size
  -- LLM: Lower Limit
  GENERIC (
    SSZ : INTEGER;
    DSZ : INTEGER;
    LLM : INTEGER
  );

  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    xi  : IN SFIXED (SSZ - 1 DOWNTO LLM);
    yi  : IN SFIXED (SSZ - 1 DOWNTO LLM);
    ui  : IN SFIXED (SSZ - 1 DOWNTO LLM);
    dx  : IN SFIXED (SSZ - 1 DOWNTO LLM);
    a   : IN SFIXED (SSZ - 1 DOWNTO LLM);
    c   : OUT STD_LOGIC;
    x   : OUT SFIXED (DSZ - 1 DOWNTO LLM);
    y   : OUT SFIXED (DSZ - 1 DOWNTO LLM)
  );
END diffeq;

ARCHITECTURE behavior OF diffeq IS

  SIGNAL u, xl, yl, ul : SFIXED (DSZ - 1 DOWNTO LLM);

BEGIN

  dComp : PROCESS (rst, clk)
  BEGIN
    IF (rst = '0') THEN
      u  <= RESIZE(ui, u);
      xl <= RESIZE(xi, xl);
      yl <= RESIZE(yi, yl);
      ul <= RESIZE(ui, ul);
      c  <= '0';
      x  <= (OTHERS => '0');
      y  <= (OTHERS => '0');
    ELSE
      IF (clk'event AND clk = '1') THEN
        xl <= x + dx;
        ul <= u - (3 * x * u * dx) - (3 * y * dx);
        yl <= y + (u * dx);
        c  <= '1' WHEN x < a;
        x  <= xl;
        y  <= yl;
        u  <= ul;
      END IF;
    END IF;
  END PROCESS;

END ARCHITECTURE;
