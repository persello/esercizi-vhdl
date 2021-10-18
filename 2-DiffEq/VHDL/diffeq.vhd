-- y'' + 3xy' + 3y = 0

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.fixed_pkg.ALL;

ENTITY diffeq IS

  -- SSZ: Single Size
  -- DSZ: Double Size
  -- LLM: Lower Limit
  GENERIC
  (
    SSZ : INTEGER;
    DSZ : INTEGER;
    LLM : INTEGER
  );

  PORT (
    clk  : IN STD_LOGIC;
    rst  : IN STD_LOGIC;
    xi   : IN SFIXED (SSZ - 1 DOWNTO LLM);
    yi   : IN SFIXED (SSZ - 1 DOWNTO LLM);
    ui   : IN SFIXED (SSZ - 1 DOWNTO LLM);
    dxi  : IN SFIXED (SSZ - 1 DOWNTO LLM);
    ai   : IN SFIXED (SSZ - 1 DOWNTO LLM);
    done : OUT STD_LOGIC;
    xo   : OUT SFIXED (DSZ - 1 DOWNTO LLM);
    yo   : OUT SFIXED (DSZ - 1 DOWNTO LLM)
  );
END diffeq;

ARCHITECTURE behavior OF diffeq IS

  SIGNAL c                   : STD_LOGIC;
  SIGNAL x, y, u, xl, yl, ul : SFIXED (DSZ - 1 DOWNTO LLM);

BEGIN

  dComp : PROCESS (rst, clk)
  BEGIN
    IF (rst = '1') THEN
      x    <= RESIZE(xi, x);
      y    <= RESIZE(yi, y);
      u    <= RESIZE(ui, u);
      xl   <= RESIZE(xi, xl);
      yl   <= RESIZE(yi, yl);
      ul   <= RESIZE(ui, ul);
      c    <= '0';
      done <= '0';
      xo   <= (OTHERS => '0');
      yo   <= (OTHERS => '0');
    ELSE

    END IF;
  END PROCESS;

END ARCHITECTURE;
