LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU_unit IS
  PORT (
    clk, res        : IN  STD_LOGIC;
    fsm_valid       : IN  STD_LOGIC;
    Reg1, Reg2      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- SW[0–15]
    opcode          : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- One-hot opcode from decoder
    Result_upper    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Result_lower    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Sign_upper      : OUT STD_LOGIC;
    Sign_lower      : OUT STD_LOGIC
  );
END ALU_unit;

ARCHITECTURE behavior OF ALU_unit IS
  SIGNAL full_result : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL reg_upper   : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL reg_lower   : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL opcode_reg  : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL reg_sign_hi : STD_LOGIC;
  SIGNAL reg_sign_lo : STD_LOGIC;
BEGIN

  PROCESS(clk, res)
  VARIABLE result_reset : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- temporary variable
BEGIN
  IF res = '0' THEN
    result_reset := Reg1 + Reg2;

    full_result  <= result_reset;
    reg_upper    <= result_reset(7 DOWNTO 4);
    reg_lower    <= result_reset(3 DOWNTO 0);
    reg_sign_hi  <= result_reset(7);
    reg_sign_lo  <= result_reset(3);

  ELSIF rising_edge(clk) THEN
    IF fsm_valid = '1' THEN
      CASE opcode IS
        WHEN "00000001" => full_result <= Reg1 + Reg2;
        WHEN "00000010" => full_result <= Reg1 - Reg2;
        WHEN "00000100" => full_result <= NOT Reg1;
        WHEN "00001000" => full_result <= NOT (Reg1 AND Reg2);
        WHEN "00010000" => full_result <= NOT (Reg1 OR Reg2);
        WHEN "00100000" => full_result <= Reg1 AND Reg2;
        WHEN "01000000" => full_result <= Reg1 XOR Reg2;
        WHEN "10000000" => full_result <= Reg1 OR Reg2;
        WHEN OTHERS     => full_result <= (OTHERS => '0');
      END CASE;

      reg_upper   <= full_result(7 DOWNTO 4);
      reg_lower   <= full_result(3 DOWNTO 0);
      reg_sign_hi <= full_result(7);
      reg_sign_lo <= full_result(3);
    END IF;
  END IF;
END PROCESS;




  -- Output assignment
  Result_upper <= reg_upper;
  Result_lower <= reg_lower;
  Sign_upper   <= reg_sign_hi;
  Sign_lower   <= reg_sign_lo;

END behavior;



