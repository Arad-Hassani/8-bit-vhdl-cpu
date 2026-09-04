LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY reg_unit IS
  PORT (
    A   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- 8-bit input
    clk : IN  STD_LOGIC;                     -- clock
    res : IN  STD_LOGIC;                     -- synchronous reset (active low)
    Q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)   -- 8-bit output
  );
END reg_unit;

ARCHITECTURE behavior OF reg_unit IS
BEGIN
  PROCESS(clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF res = '0' THEN
        Q <= (OTHERS => '0');
      ELSE
        Q <= A;
      END IF;
    END IF;
  END PROCESS;
END behavior;
