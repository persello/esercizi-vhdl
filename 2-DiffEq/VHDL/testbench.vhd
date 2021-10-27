LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.fixed_pkg.ALL;

ENTITY testBench IS
END ENTITY;

ARCHITECTURE structural OF testBench IS

  CONSTANT SSZ : INTEGER := 16;
  CONSTANT LLM : INTEGER := - 16;
  CONSTANT DSZ : INTEGER := 2 * SSZ;

  CONSTANT VGV : STRING  := "BEHAVIORAL";
  -- CONSTANT VGV : STRING  := "ASSERTIVE";

  COMPONENT diffeq IS
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
  END COMPONENT;

  COMPONENT vectorGenerator IS
    GENERIC (
      SSZ : INTEGER;
      DSZ : INTEGER;
      LLM : INTEGER
    );
    PORT (
      clk : OUT STD_LOGIC;
      rst : OUT STD_LOGIC;
      xi  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      yi  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      ui  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      dx  : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      a   : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      c   : IN STD_LOGIC;
      x   : IN SFIXED(DSZ - 1 DOWNTO LLM);
      y   : IN SFIXED(DSZ - 1 DOWNTO LLM)
    );
  END COMPONENT;

  SIGNAL clkTB, rstTB                : STD_LOGIC;
  SIGNAL xiTB, yiTB, uiTB, dxTB, aTB : SFIXED (SSZ - 1 DOWNTO LLM);
  SIGNAL cTB                         : STD_LOGIC;
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
