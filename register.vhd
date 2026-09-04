LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY register IS
  PORT (
    A   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
    clk, res : IN  STD_LOGIC;
    Q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END register;

ARCHITECTURE behavior OF register IS
BEGIN
  PROCESS (res, clk)
  BEGIN
    IF res = '1' THEN
      Q <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      Q <= A;
    END IF;
  END PROCESS;
END behavior;
