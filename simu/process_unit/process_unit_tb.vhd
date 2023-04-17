library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity PROCESS_UNIT_TB is
    port (OK : out boolean := true);
end entity;

architecture TEST of PROCESS_UNIT_TB is
    -- type declaration
    type RegisterType is array (15 downto 0) of Std_logic_vector(31 downto 0);

    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal Reset: std_logic;
    signal RA, RB, RW: std_logic_vector(3 downto 0);
    signal WE, N, Z, C, V: std_logic;
    signal OP: std_logic_vector(2 downto 0);
    signal memory: RegisterType;
begin
    CLK <= '0' when Done else not CLK after Period / 2;
    memory <= <<signal .process_unit_tb.p.REG.registers: RegisterType>>;
    process
        variable test: RegisterType;
    begin
        Reset <= '1';
        wait for 10 ns;
        Reset <= '0';
        report "CHECK 1";
        assert memory(15) = x"00000030" report "Error register 15" severity warning;
        -- Write register 15 into 1
        OP <= "011";
        RA <= x"F";
        RW <= x"1";
        WE <= '1';
        wait for 10 ns;
        report "CHECK 2";
        assert memory(1) = x"00000030" report "Error register 1" severity warning;
        -- R(1) = R(1) + R(15)
        OP <= "000";
        RB <= x"1";
        RW <= x"1";
        wait for 10 ns;
        report "CHECK 3";
        assert memory(1) = x"00000060" report "Error register 1" severity warning;
        -- R(2) = R(1) + R(15)
        RW <= x"2";
        wait for 10 ns;
        report "CHECK 4";
        assert memory(2) = x"00000090" report "Error register 2" severity warning;
        -- R(3) = R(1) – R(15)
        OP <= "010";
        RA <= x"1";
        RB <= x"F";
        RW <= x"3";
        wait for 10 ns;
        report "CHECK 5";
        assert memory(3) = x"00000030" report "Error register 3" severity warning;
        -- R(5) = R(7) – R(15)
        RA <= x"7";
        RW <= x"5";
        wait for 10 ns;
        report "CHECK 6";
        assert memory(5) = x"FFFFFFD0" report "Error register 5" severity warning;
        assert N = '1' report "Error flag N" severity warning;        
        Done <= true;
        wait;
    end process;


    P: entity Work.Process_Unit port map (CLK, Reset, RA, RB, RW, OP, WE, N, Z, C, V);
end architecture;