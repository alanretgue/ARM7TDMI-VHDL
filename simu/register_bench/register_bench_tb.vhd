library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity REGISTER_BENCH_TB is
    port (OK : out boolean := true);
end entity;


architecture TEST of REGISTER_BENCH_TB is
    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal Reset: std_logic;
    signal W: std_logic_vector(31 downto 0);
    signal RA, RB, RW: std_logic_vector(3 downto 0);
    signal WE: std_logic;
    signal A, B: std_logic_vector(31 downto 0);
begin
    CLK <= '0' when Done else not CLK after Period / 2;

    process begin
    Reset <= '1';
    wait for 10 ns;
    Reset <= '0';
    RA <= x"F";
    RB <= x"F";
    RW <= x"2";
    WE <= '0';
    W <= x"1111A94F";
    wait for 10 ns;
    report "Check 1";
    assert A = x"00000000" report "Error A on 1" severity warning;
    assert B = x"00000000" report "Error B on 1" severity warning;
    wait for 10 ns;
    Reset <= '0';
    RA <= x"2";
    RB <= x"F";
    RW <= x"0";
    WE <= '1';
    W <= x"0F00A94F";
    wait for 10 ns;
    report "Check 2";
    assert A = x"00000000" report "Error A on 2" severity warning;
    assert B = x"00000000" report "Error B on 2" severity warning;
    wait for 10 ns;
    RA <= x"2";
    RB <= x"0";
    RW <= x"2";
    W <= x"0F001111";
    WE <= '1';
    wait for 10 ns;
    report "Check 3";
    assert A = x"0F001111" report "Error A on 3" severity warning;
    assert B = x"0F00A94F" report "Error B on 3" severity warning;
    wait for 10 ns;
    RA <= x"0";
    RB <= x"1";
    WE <= '0';
    wait for 10 ns;
    report "Check 4";
    assert A = x"0F00A94F" report "Error A on 4" severity warning;
    assert B = x"00000000" report "Error B on 4" severity warning;
    Done <= true;
    wait;
    end process;

    G: entity Work.Register_bench port map (CLK, Reset, W, RA, RB, RW, WE, A, B);
end architecture;