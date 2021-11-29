
LIBRARY ieee;
USE     ieee.std_logic_1164.ALL;
USE     ieee.numeric_std.ALL;
USE     ieee.fixed_pkg.ALL;
USE     ieee.math_real.ALL;

USE     std.textio.ALL;

ENTITY vectorGenerator IS
  GENERIC (P   :     INTEGER := -15;
           NP  :     INTEGER :=   1;
           N   :     INTEGER :=  64);
  PORT    (clr : OUT STD_LOGIC;
           clk : OUT STD_LOGIC;
           xr  : OUT SFIXED (0 DOWNTO P);
           xi  : OUT SFIXED (0 DOWNTO P);
           yr  : OUT SFIXED (0 DOWNTO P);
           yi  : OUT SFIXED (0 DOWNTO P);
           pr  : IN  SFIXED (0 DOWNTO P);
           pi  : IN  SFIXED (0 DOWNTO P);
           ovf : IN  STD_LOGIC);
END vectorGenerator;

ARCHITECTURE dumping OF vectorGenerator IS

  CONSTANT ckP     : TIME := 100 ns;
  CONSTANT ckHP    : TIME := 0.5 * ckP;

  CONSTANT totalN  : INTEGER := NP * N;

  FILE     inFile  : TEXT;
  FILE     outFile : TEXT;


BEGIN

  fopP : PROCESS
           CONSTANT IFN : STRING := "RESULTS/SIM.in";
           CONSTANT OFN : STRING := "RESULTS/SIM.out";
         BEGIN
           FILE_OPEN (inFile,  IFN, READ_MODE);
           FILE_OPEN (outFile, OFN, WRITE_MODE);
           WAIT;
         END PROCESS;

  clkP : PROCESS
           VARIABLE inLine  : LINE;
           VARIABLE outLine : LINE;
           VARIABLE clkTmp  : STD_LOGIC := '0';
           VARIABLE res     : BOOLEAN;
           VARIABLE xrR, xiR, yrR, yiR : REAL;
           VARIABLE count   : INTEGER := 0;
           VARIABLE clrCnt  : INTEGER := 0;
         BEGIN
           IF (count = totalN) THEN
             FILE_CLOSE (inFile);
             FILE_CLOSE (outFile);
             WAIT;
           END IF;
           IF (clrCnt = N) THEN
             clr <= '0';
           ELSE
             clr <= '1';
           END IF;
           clk <= clkTmp;
           clkTmp := NOT clkTmp;
           READLINE (inFile, inLine);
           READ (inLine, xrR, res);
           READ (inLine, xiR, res);
           READ (inLine, yrR, res);
           READ (inLine, yiR, res);
           xr <= TO_SFIXED (xrR, 0, P);
           xi <= TO_SFIXED (xiR, 0, P);
           yr <= TO_SFIXED (yrR, 0, P);
           yi <= TO_SFIXED (yiR, 0, P);
           WAIT FOR ckHP;
           IF (clrCnt = N) THEN
             clr    <= '1';
             clrCnt := 0;
           END IF;
           WRITE     (outLine, pr);
           WRITE     (outLine, string'(" "));
           WRITE     (outLine, pi);
           WRITELINE (outFile, outLine);
           count  := count  + 1;
           clrCnt := clrCnt + 1;
         END PROCESS;

END dumping;
