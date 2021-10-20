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
      dxi : IN SFIXED (SSZ - 1 DOWNTO LLM);
      ai  : IN SFIXED (SSZ - 1 DOWNTO LLM);
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
      dx  : OUT SFIXED(DSZ - 1 DOWNTO LLM);
      a   : OUT SFIXED(SSZ - 1 DOWNTO LLM);
      c   : IN STD_LOGIC;
      x   : IN SFIXED(DSZ - 1 DOWNTO LLM);
      y   : IN SFIXED(DSZ - 1 DOWNTO LLM)
    );
  END COMPONENT;

BEGIN

END structural;
