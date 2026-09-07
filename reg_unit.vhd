LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY reg_unit IS
    PORT (
        A   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- 8-bit data input
        clk : IN  STD_LOGIC;                     -- clock
        res : IN  STD_LOGIC;                     -- active-low asynchronous reset
        Q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)   -- registered 8-bit output
    );
END reg_unit;


ARCHITECTURE behavior OF reg_unit IS
BEGIN

    PROCESS(clk, res)
    BEGIN

        -- Active-low asynchronous reset
        IF res = '0' THEN
            Q <= (OTHERS => '0');

        -- Capture input on rising clock edge
        ELSIF rising_edge(clk) THEN
            Q <= A;

        END IF;

    END PROCESS;

END behavior;
