LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY stateMachine IS
    PORT (
        data_in       : IN  STD_LOGIC;                     -- FSM enable
        clk           : IN  STD_LOGIC;                     -- clock
        reset         : IN  STD_LOGIC;                     -- active-low asynchronous reset

        student_id    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- display value
        current_state : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- program counter / state
        fsm_valid     : OUT STD_LOGIC                      -- ALU enable
    );
END stateMachine;


ARCHITECTURE fsm OF stateMachine IS

    TYPE state_type IS (
        s0, s1, s2, s3,
        s4, s5, s6, s7
    );

    SIGNAL yfsm : state_type;

BEGIN

    --------------------------------------------------------------------
    -- State register and state transitions
    --
    -- data_in acts as an enable:
    --   data_in = '1' -> advance to the next state
    --   data_in = '0' -> remain in the current state
    --------------------------------------------------------------------

    PROCESS(clk, reset)
    BEGIN

        -- Active-low asynchronous reset
        IF reset = '0' THEN
            yfsm <= s0;

        ELSIF rising_edge(clk) THEN

            IF data_in = '1' THEN

                CASE yfsm IS
                    WHEN s0 =>
                        yfsm <= s1;

                    WHEN s1 =>
                        yfsm <= s2;

                    WHEN s2 =>
                        yfsm <= s3;

                    WHEN s3 =>
                        yfsm <= s4;

                    WHEN s4 =>
                        yfsm <= s5;

                    WHEN s5 =>
                        yfsm <= s6;

                    WHEN s6 =>
                        yfsm <= s7;

                    WHEN s7 =>
                        yfsm <= s0;
                END CASE;

            END IF;

        END IF;

    END PROCESS;


    --------------------------------------------------------------------
    -- Moore output logic
    --
    -- current_state provides the 3-bit state to the opcode decoder.
    -- student_id provides a generic 0-7 demonstration sequence for
    -- the seven-segment display.
    --------------------------------------------------------------------

    PROCESS(yfsm)
    BEGIN

        CASE yfsm IS

            WHEN s0 =>
                current_state <= "000";
                student_id    <= "0000";  -- 0

            WHEN s1 =>
                current_state <= "001";
                student_id    <= "0001";  -- 1

            WHEN s2 =>
                current_state <= "010";
                student_id    <= "0010";  -- 2

            WHEN s3 =>
                current_state <= "011";
                student_id    <= "0011";  -- 3

            WHEN s4 =>
                current_state <= "100";
                student_id    <= "0100";  -- 4

            WHEN s5 =>
                current_state <= "101";
                student_id    <= "0101";  -- 5

            WHEN s6 =>
                current_state <= "110";
                student_id    <= "0110";  -- 6

            WHEN s7 =>
                current_state <= "111";
                student_id    <= "0111";  -- 7

        END CASE;

    END PROCESS;


    --------------------------------------------------------------------
    -- The current CPU implementation always permits ALU execution.
    -- This signal is retained so the external interface remains
    -- compatible with the existing top-level schematic.
    --------------------------------------------------------------------

    fsm_valid <= '1';

END fsm;
