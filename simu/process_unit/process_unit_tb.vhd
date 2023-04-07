library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity PROCESS_UNIT_TB is
    port (OK : out boolean := true);
end entity;

architecture TEST of PROCESS_UNIT_TB is
    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal Reset: std_logic;
    signal RA, RB, RW: std_logic_vector(3 downto 0);
    signal WE, N, Z, C, V: std_logic;
    signal OP: std_logic_vector(2 downto 0);
begin
    CLK <= '0' when Done else not CLK after Period / 2;

    process begin
        Reset <= '0';
        -- Write register 15 into 1
        wait for 10 ns;
        OP <= "011";
        RA <= x"F";
        RW <= x"1";
        WE <= '1';
        wait for 10 ns;
        -- Add register 15 & 14 and write in 13
        OP <= "000";
        RB <= x"E";
        RW <= x"D";
        wait for 10 ns;
        -- Substract register 13 with 14 and write the result in 9
        OP <= "010";
        RA <= x"D";
        RB <= x"E";
        RW <= x"9";
        WE <= '0';
        wait for 10 ns;
        WE <= '1';
        wait for 10 ns;
        Done <= true;
        wait;
    end process;


    P: entity Work.Process_Unit port map (CLK, Reset, RA, RB, RW, OP, WE, N, Z, C, V);
end architecture;