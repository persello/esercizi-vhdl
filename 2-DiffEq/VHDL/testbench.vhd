LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.fixed_pkg.ALL;

ENTITY testBench IS
END ENTITY;

ARCHITECTURE structural OF testBench IS

  CONSTANT SSZ : integer := 16;
  CONSTANT LLM : integer := - 16;
  CONSTANT DSZ : integer := 2 * SSZ;

  CONSTANT VGV : string := "BEHAVIORAL";
  -- CONSTANT VGV : STRING  := "ASSERTIVE";

  COMPONENT diffeq IS
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
  END COMPONENT;

  COMPONENT vectorGenerator IS
    GENERIC (
      SSZ : integer;
      DSZ : integer;
      LLM : integer
    );
    PORT (
      clk : OUT std_logic;
      rst : OUT std_logic;
      xi  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      yi  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      ui  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      dx  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      a   : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      c   : IN std_logic;
      x   : IN SFIXED(DSZ - 1 DOWNTO LLM);
      y   : IN SFIXED(DSZ - 1 DOWNTO LLM)
    );
  END COMPONENT;

  SIGNAL clkTB, rstTB                : std_logic;
  SIGNAL xiTB, yiTB, uiTB, dxTB, aTB : SFIXED (SSZ - 1 DOWNTO LLM);
  SIGNAL cTB                         : std_logic;
  SIGNAL xTB, yTB                    : SFIXED (DSZ - 1 DOWNTO LLM);

BEGIN

  df1 : diffeq GENERIC MAP(
    SSZ => SSZ,
    DSZ => DSZ,
    LLM => LLM
    ) PORT MAP (
    clk => clkTB,
    rst => rstTB,
    xi  => xiTB,
    yi  => yiTB,
    ui  => uiTB,
    dx  => dxTB,
    a   => aTB,
    c   => cTB,
    x   => xTB,
    y   => yTB
  );

  vgA : IF (VGV = "ASSERTIVE") GENERATE
    vg1 : ENTITY work.vectorGenerator (assertive)
      GENERIC MAP(
        SSZ => SSZ,
        DSZ => DSZ,
        LLM => LLM
        ) PORT MAP (
        clk => clkTB,
        rst => rstTB,
        xi  => xiTB,
        yi  => yiTB,
        ui  => uiTB,
        dx  => dxTB,
        a   => aTB,
        c   => cTB,
        x   => xTB,
        y   => yTB
      );
  END GENERATE;

  vgB : IF (VGV = "BEHAVIORAL") GENERATE
    vg1 : ENTITY work.vectorGenerator (behavioral)
      GENERIC MAP(
        SSZ => SSZ,
        DSZ => DSZ,
        LLM => LLM
        ) PORT MAP (
        clk => clkTB,
        rst => rstTB,
        xi  => xiTB,
        yi  => yiTB,
        ui  => uiTB,
        dx  => dxTB,
        a   => aTB,
        c   => cTB,
        x   => xTB,
        y   => yTB
      );
  END GENERATE;

END structural;