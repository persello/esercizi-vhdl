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
    SSZ : integer;
    DSZ : integer;
    LLM : integer
  );

  PORT (
    clk : IN std_logic;
    rst : IN std_logic;
    xi  : IN SFIXED (SSZ - 1 DOWNTO LLM);
    yi  : IN SFIXED (SSZ - 1 DOWNTO LLM);
    ui  : IN SFIXED (SSZ - 1 DOWNTO LLM);
    dx  : IN SFIXED (SSZ - 1 DOWNTO LLM);
    a   : IN SFIXED (SSZ - 1 DOWNTO LLM);
    c   : OUT std_logic;
    x   : OUT SFIXED (DSZ - 1 DOWNTO LLM);
    y   : OUT SFIXED (DSZ - 1 DOWNTO LLM)
  );
END diffeq;

ARCHITECTURE behavior OF diffeq IS

  SIGNAL u : SFIXED (DSZ - 1 DOWNTO LLM);

  -- xi: starting x
  -- yi: y(xi)
  -- ui: y'(xi)
  -- dx: x increment
  -- a: upper limit
  -- c: completion flag
  -- x: output current x
  -- y: output current y

  -- u: resized ui
BEGIN

  dComp : PROCESS (rst, clk)
  BEGIN
    IF (rst = '0') THEN
      x <= RESIZE (xi, x);
      y <= RESIZE (yi, y);
      u <= RESIZE (ui, u);
      c <= '0';
    ELSE
      IF (clk'EVENT AND clk = '1') THEN
        x <= RESIZE (x + dx, x);
        u <= RESIZE (u - (3 * x * u * dx) - (3 * y * dx), u);
        y <= RESIZE (y + u * dx, y);
        c <= '1' WHEN x >= a ELSE
          '0';
      END IF;
    END IF;
  END PROCESS;

END ARCHITECTURE;