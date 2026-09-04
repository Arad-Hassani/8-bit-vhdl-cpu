LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decoder4to16 IS
  PORT (
    sel  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);   -- 4-bit input
    outp : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)   -- 16-bit one-hot output
  );
END decoder4to16;

ARCHITECTURE behavior OF decoder4to16 IS
BEGIN
  PROCESS(sel)
  BEGIN
    CASE sel IS
      WHEN "0000" => outp <= "0000000000000001";
      WHEN "0001" => outp <= "0000000000000010";
      WHEN "0010" => outp <= "0000000000000100";
      WHEN "0011" => outp <= "0000000000001000";
      WHEN "0100" => outp <= "0000000000010000";
      WHEN "0101" => outp <= "0000000000100000";
      WHEN "0110" => outp <= "0000000001000000";
      WHEN "0111" => outp <= "0000000010000000";
      WHEN "1000" => outp <= "0000000100000000";
      WHEN "1001" => outp <= "0000001000000000";
      WHEN "1010" => outp <= "0000010000000000";
      WHEN "1011" => outp <= "0000100000000000";
      WHEN "1100" => outp <= "0001000000000000";
      WHEN "1101" => outp <= "0010000000000000";
      WHEN "1110" => outp <= "0100000000000000";
      WHEN "1111" => outp <= "1000000000000000";
      WHEN OTHERS => outp <= (OTHERS => '0');
    END CASE;
  END PROCESS;
END behavior;
