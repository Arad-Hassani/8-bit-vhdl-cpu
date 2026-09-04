LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decoder3to8 IS
  PORT (
    sel : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);  -- 3-bit selector (e.g. from FSM)
    outp : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  -- 8-bit one-hot output
  );
END decoder3to8;

ARCHITECTURE behavior OF decoder3to8 IS
BEGIN
  PROCESS(sel)
  BEGIN
    CASE sel IS
      WHEN "000" => outp <= "00000001"; --s0
      WHEN "001" => outp <= "00000010"; --s1
      WHEN "010" => outp <= "00000100"; --s2
      WHEN "011" => outp <= "00001000"; --s3
      WHEN "100" => outp <= "00010000"; --s4
      WHEN "101" => outp <= "00100000"; --s5
      WHEN "110" => outp <= "01000000"; --s6
      WHEN "111" => outp <= "10000000"; --s7
      WHEN OTHERS => outp <= (OTHERS => '0');
    END CASE;
  END PROCESS;
END behavior;


