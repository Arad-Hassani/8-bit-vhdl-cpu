LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU_unit IS
    PORT (
        clk, res        : IN  STD_LOGIC;
        fsm_valid       : IN  STD_LOGIC;
        Reg1, Reg2      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        opcode          : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);

        Result_upper    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Result_lower    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Sign_upper      : OUT STD_LOGIC;
        Sign_lower      : OUT STD_LOGIC
    );
END ALU_unit;


ARCHITECTURE behavior OF ALU_unit IS

    -- Stores the complete 8-bit ALU result
    SIGNAL full_result : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    PROCESS(clk, res)

        VARIABLE alu_result : STD_LOGIC_VECTOR(7 DOWNTO 0);

    BEGIN

        -- Active-low asynchronous reset
        IF res = '0' THEN

            full_result <= (OTHERS => '0');

            Result_upper <= (OTHERS => '0');
            Result_lower <= (OTHERS => '0');

            Sign_upper <= '0';
            Sign_lower <= '0';


        ELSIF rising_edge(clk) THEN

            IF fsm_valid = '1' THEN

                -- Default value for undefined opcodes
                alu_result := (OTHERS => '0');

                CASE opcode IS

                    -- Addition: A + B
                    WHEN "00000001" =>
                        alu_result :=
                            STD_LOGIC_VECTOR(
                                UNSIGNED(Reg1) + UNSIGNED(Reg2)
                            );

                    -- Subtraction: A - B
                    WHEN "00000010" =>
                        alu_result :=
                            STD_LOGIC_VECTOR(
                                UNSIGNED(Reg1) - UNSIGNED(Reg2)
                            );

                    -- Bitwise NOT A
                    WHEN "00000100" =>
                        alu_result := NOT Reg1;

                    -- Bitwise NAND
                    WHEN "00001000" =>
                        alu_result := NOT (Reg1 AND Reg2);

                    -- Bitwise NOR
                    WHEN "00010000" =>
                        alu_result := NOT (Reg1 OR Reg2);

                    -- Bitwise AND
                    WHEN "00100000" =>
                        alu_result := Reg1 AND Reg2;

                    -- Bitwise XOR
                    WHEN "01000000" =>
                        alu_result := Reg1 XOR Reg2;

                    -- Bitwise OR
                    WHEN "10000000" =>
                        alu_result := Reg1 OR Reg2;

                    -- Invalid / unused opcode
                    WHEN OTHERS =>
                        alu_result := (OTHERS => '0');

                END CASE;


                -- Store full 8-bit result
                full_result <= alu_result;

                -- Split result into two 4-bit values
                Result_upper <= alu_result(7 DOWNTO 4);
                Result_lower <= alu_result(3 DOWNTO 0);

                -- MSB of each nibble represents its sign
                Sign_upper <= alu_result(7);
                Sign_lower <= alu_result(3);

            END IF;

        END IF;

    END PROCESS;

END behavior;

