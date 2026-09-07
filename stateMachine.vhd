LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY stateMachine IS
  PORT (
    data_in       : IN  std_logic;
    clk, reset    : IN  std_logic;
    student_id    : OUT std_logic_vector(3 DOWNTO 0);
    current_state : OUT std_logic_vector(2 DOWNTO 0);
    fsm_valid     : OUT std_logic                    
  );
END stateMachine;

ARCHITECTURE fsm OF stateMachine IS
  TYPE state_type IS (s0, s1, s2, s3, s4, s5, s6, s7);
  SIGNAL yfsm : state_type;
BEGIN

  -- FSM-0 state transitions
  PROCESS(clk, reset)
BEGIN
  IF reset = '0' THEN
    yfsm <= s0;
  ELSIF rising_edge(clk) THEN
    CASE yfsm IS
      WHEN s0 => IF data_in = '1' THEN yfsm <= s1; ELSE yfsm <= s0; END IF;
      WHEN s1 => IF data_in = '1' THEN yfsm <= s2; ELSE yfsm <= s1; END IF;
      WHEN s2 => IF data_in = '1' THEN yfsm <= s3; ELSE yfsm <= s2; END IF;
      WHEN s3 => IF data_in = '1' THEN yfsm <= s4; ELSE yfsm <= s3; END IF;
      WHEN s4 => IF data_in = '1' THEN yfsm <= s5; ELSE yfsm <= s4; END IF;
      WHEN s5 => IF data_in = '1' THEN yfsm <= s6; ELSE yfsm <= s5; END IF;
      WHEN s6 => IF data_in = '1' THEN yfsm <= s7; ELSE yfsm <= s6; END IF;
      WHEN s7 => IF data_in = '1' THEN yfsm <= s0; ELSE yfsm <= s7; END IF;
    END CASE;
  END IF;
END PROCESS;



  -- Moore output logic (including fsm_valid)
  PROCESS(yfsm)
  BEGIN
    CASE yfsm IS
      WHEN s0 =>
        current_state <= "000"; student_id <= "0000"; fsm_valid <= '1';
      WHEN s1 =>
        current_state <= "001"; student_id <= "0001"; fsm_valid <= '1';
      WHEN s2 =>
        current_state <= "010"; student_id <= "0010"; fsm_valid <= '1';
      WHEN s3 =>
        current_state <= "011"; student_id <= "0011"; fsm_valid <= '1';
      WHEN s4 =>
        current_state <= "100"; student_id <= "0100"; fsm_valid <= '1';
      WHEN s5 =>
        current_state <= "101"; student_id <= "0101"; fsm_valid <= '1';
      WHEN s6 =>
        current_state <= "110"; student_id <= "0110"; fsm_valid <= '1';
      WHEN s7 =>
        current_state <= "111"; student_id <= "0111"; fsm_valid <= '1';
    END CASE;
  END PROCESS;

END fsm;

