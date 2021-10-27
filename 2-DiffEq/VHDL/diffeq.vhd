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

  -- xi: starting x
  -- yi: y(xi)
  -- ui: y'(xi)
  -- dx: x increment
  -- a: upper limit
  -- c: completion flag
  -- x: output current x
  -- y: output current y

  -- u: resized ui

  -- xl: next x
  -- yl: next y
  -- ul: next u
BEGIN

  dComp : PROCESS (rst, clk)
  BEGIN
    IF (rst = '0') THEN
      x  <= RESIZE (xi, x);
      y  <= RESIZE (yi, y);
      u  <= RESIZE (ui, u);
      xl <= RESIZE (xi, x);
      yl <= RESIZE (yi, y);
      ul <= RESIZE (ui, u);
      c  <= '0';
    ELSE
      IF (clk'EVENT AND clk = '1') THEN
        xl <= RESIZE (x + dx, xl);
        ul <= RESIZE (u - (3 * x * u * dx) - (3 * y * dx), ul);
        yl <= RESIZE (y + u * dx, yl);
        x  <= xl;
        u  <= ul;
        y  <= yl;
        c  <= '1' WHEN x >= a ELSE
          '0';
      END IF;
    END IF;
  END PROCESS;

END ARCHITECTURE;
