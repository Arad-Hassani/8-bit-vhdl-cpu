LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sseg IS
  PORT (
    bcd      : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);  -- 4-bit signed number
    neg      : IN  STD_LOGIC;                     -- 1 if negative
    leds     : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- segment output
    negative : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)   -- "-" sign
  );
END sseg;

ARCHITECTURE Behavior OF sseg IS
  SIGNAL abs_bcd : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

 -- Convert signed 4-bit to absolute value
PROCESS(bcd)
  VARIABLE signed_bcd  : SIGNED(3 DOWNTO 0);
  VARIABLE abs_val     : SIGNED(3 DOWNTO 0);
BEGIN
  signed_bcd := SIGNED(bcd);
  IF signed_bcd < 0 THEN
    abs_val := -signed_bcd;
  ELSE
    abs_val := signed_bcd;
  END IF;
  abs_bcd <= STD_LOGIC_VECTOR(abs_val);
END PROCESS;

  -- Segment pattern for absolute value
  PROCESS(abs_bcd)
  BEGIN
    CASE abs_bcd IS
      WHEN "0000" => leds <= "1000000"; -- 0
      WHEN "0001" => leds <= "1111001"; -- 1
      WHEN "0010" => leds <= "0100100"; -- 2
      WHEN "0011" => leds <= "0110000"; -- 3
      WHEN "0100" => leds <= "0011001"; -- 4
      WHEN "0101" => leds <= "0010010"; -- 5
      WHEN "0110" => leds <= "0000010"; -- 6
      WHEN "0111" => leds <= "1111000"; -- 7
      WHEN "1000" => leds <= "0000000"; -- 8
      WHEN "1001" => leds <= "0010000"; -- 9
      WHEN OTHERS => leds <= "1111111"; -- blank
    END CASE;
  END PROCESS;

  -- Negative sign logic
  PROCESS(neg)
  BEGIN
    IF neg = '1' THEN
      negative <= "0111111"; -- Only segment G ON
    ELSE
      negative <= "1111111"; -- All segments OFF
    END IF;
  END PROCESS;

END Behavior;
