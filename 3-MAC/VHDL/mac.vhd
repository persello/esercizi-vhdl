
LIBRARY ieee;
USE     ieee.std_logic_1164.ALL;
USE     ieee.fixed_pkg.ALL;

ENTITY mac IS
  GENERIC (P   :     INTEGER := -15);
  PORT    (clr : IN  STD_LOGIC;
           clk : IN  STD_LOGIC;
           xr  : IN  SFIXED (0 DOWNTO P);
           xi  : IN  SFIXED (0 DOWNTO P);
           yr  : IN  SFIXED (0 DOWNTO P);
           yi  : IN  SFIXED (0 DOWNTO P);
           pr  : OUT SFIXED (0 DOWNTO P);
           pi  : OUT SFIXED (0 DOWNTO P);
           ovf : OUT STD_LOGIC);
END mac;

ARCHITECTURE behavioral OF mac IS

  CONSTANT P2   : INTEGER := 2 * P;

  CONSTANT N1   : INTEGER := 1;
  CONSTANT N2   : INTEGER := 2 * N1;
  CONSTANT N3   : INTEGER := N2 + 1;
  CONSTANT N6   : INTEGER := 2 * N2 + 2;
  CONSTANT N5   : INTEGER := 2 * N2 + 1;

  CONSTANT WIp  : INTEGER := N1;
  CONSTANT WIn  : INTEGER := P;
  CONSTANT WPPp : INTEGER := N2;
  CONSTANT WPPn : INTEGER := P2;
  CONSTANT WPCp : INTEGER := N3;
  CONSTANT WPCn : INTEGER := P2;
  CONSTANT WTp  : INTEGER := N3;
  CONSTANT WTn  : INTEGER := P - 2;
  CONSTANT WApE : INTEGER := N6;
  CONSTANT WAnE : INTEGER := P - 2;
  CONSTANT WAp  : INTEGER := N5;
  CONSTANT WAn  : INTEGER := P - 2;
  CONSTANT WOpE : INTEGER := N2;
  CONSTANT WOnE : INTEGER := P;
  CONSTANT WOp  : INTEGER := N1;
  CONSTANT WOn  : INTEGER := P;

  SIGNAL xryr   : SFIXED (WPPp DOWNTO WPPn);
  SIGNAL xiyi   : SFIXED (WPPp DOWNTO WPPn);
  SIGNAL xryi   : SFIXED (WPPp DOWNTO WPPn);
  SIGNAL xiyr   : SFIXED (WPPp DOWNTO WPPn);
  SIGNAL pcr    : SFIXED (WPCp DOWNTO WPCn);
  SIGNAL pci    : SFIXED (WPCp DOWNTO WPCn);
  SIGNAL pctr   : SFIXED (WTp  DOWNTO WTn);
  SIGNAL pcti   : SFIXED (WTp  DOWNTO WTn);
  SIGNAL pctrE  : SFIXED (WApE DOWNTO WAnE);
  SIGNAL pctiE  : SFIXED (WApE DOWNTO WAnE);

  SIGNAL accrE  : SFIXED (WApE DOWNTO WAnE);
  SIGNAL acciE  : SFIXED (WApE DOWNTO WAnE);
  SIGNAL accr   : SFIXED (WAp  DOWNTO WAn);
  SIGNAL acci   : SFIXED (WAp  DOWNTO WAn);
  SIGNAL prE    : SFIXED (WOpE DOWNTO WOnE);
  SIGNAL piE    : SFIXED (WOpE DOWNTO WOnE);

  SIGNAL SR     : STD_LOGIC;

BEGIN

  mac1  : PROCESS (clr, clk)
          BEGIN
            IF (clk'EVENT AND clk = '1') THEN
              IF (clr = '0') THEN
                accr  <= (others => '0');
                acci  <= (others => '0');
                SR    <= '0';
              ELSE
                xryr  <= RESIZE (xr    * yr,    xryr); 
                xiyi  <= RESIZE (xi    * yi,    xiyi); 
                xryi  <= RESIZE (xr    * yi,    xiyi); 
                xiyr  <= RESIZE (xi    * yr,    xiyr); 
                pcr   <= RESIZE (xryr  - xiyi,  pcr); 
                pci   <= RESIZE (xryi  + xiyr,  pci); 
                pctr  <= RESIZE (pcr,           pctr); 
                pcti  <= RESIZE (pci,           pcti); 
                pctrE <= RESIZE (pctr,          pctrE); 
                pctiE <= RESIZE (pcti,          pctiE); 
                accrE <= RESIZE (accrE + pctrE, accrE); 
                acciE <= RESIZE (acciE + pctiE, acciE); 

                IF (accrE >= 16 OR accrE < -16) THEN
                  SR <= '1';
                END IF;

                accr  <= RESIZE (accrE, accr); 
                acci  <= RESIZE (acciE, acci); 

                prE   <= RESIZE (accrE, prE);
                piE   <= RESIZE (accrE, piE);

                IF (prE >= 1 OR accrE < -1) THEN
                  SR <= '1';
                END IF;

                pr    <= RESIZE (prE, pr);
                pi    <= RESIZE (piE, pi);
                ovf   <= SR;

              END IF;
            END IF;
          END PROCESS;

END behavioral;
