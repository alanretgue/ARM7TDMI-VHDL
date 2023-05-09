library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity VIC_TB is
    port (OK : out boolean := true);
end entity;


architecture TEST of VIC_TB is
    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal RESET: std_logic;
    signal IRQ_SERV, IRQ0, IRQ1: std_logic;
    signal IRQ: std_logic;
    signal VICPC: std_logic_vector(31 downto 0);
begin
    CLK <= '0' when Done else not CLK after Period / 2;

    process begin
    RESET <= '1';
    IRQ0 <= '0';
    IRQ1 <= '0';
    IRQ_SERV <= '0';
    wait for 10 ns;
    RESET <= '0';
    wait for 10 ns;
    report "Check 1";
    assert VICPC = x"00000000" report "Error VICPC" severity warning;
    assert IRQ = '0' report "Error IRQ" severity warning;
    IRQ0 <= '1';
    wait for 10 ns;
    report "Check 2";
    assert VICPC = x"00000009" report "Error VICPC" severity warning;
    assert IRQ = '1' report "Error IRQ" severity warning;
    IRQ1 <= '1';
    wait for 10 ns;
    report "Check 3";
    assert VICPC = x"00000009" report "Error VICPC" severity warning;
    assert IRQ = '0' report "Error IRQ" severity warning;
    IRQ_SERV <= '1';
    wait for 10 ns;
    report "Check 4";
    assert VICPC = x"00000000" report "Error VICPC" severity warning;
    assert IRQ = '0' report "Error IRQ" severity warning;
    IRQ_SERV <= '0';
    wait for 10 ns;
    report "Check 5";
    assert VICPC = x"00000000" report "Error VICPC" severity warning;
    assert IRQ = '0' report "Error IRQ" severity warning;
    IRQ1 <= '0';
    wait for 10 ns;
    report "Check 6";
    assert VICPC = x"00000000" report "Error VICPC" severity warning;
    assert IRQ = '0' report "Error IRQ" severity warning;
    IRQ1 <= '1';
    wait for 10 ns;
    report "Check 7";
    assert VICPC = x"00000015" report "Error VICPC" severity warning;
    assert IRQ = '1' report "Error IRQ" severity warning;
    IRQ0 <= '0';
    wait for 10 ns;
    report "Check 8";
    assert VICPC = x"00000015" report "Error VICPC" severity warning;
    assert IRQ = '1' report "Error IRQ" severity warning;
    IRQ0 <= '1';
    wait for 10 ns;
    report "Check 9";
    assert VICPC = x"00000009" report "Error VICPC" severity warning;
    assert IRQ = '0' report "Error IRQ" severity warning;
    IRQ_SERV <= '1';
    wait for 10 ns;
    report "Check 10";
    assert VICPC = x"00000000" report "Error VICPC" severity warning;
    assert IRQ = '0' report "Error IRQ" severity warning;

    Done <= true;
    wait;
    end process;

    G: entity Work.VIC port map (CLK, RESET, IRQ_SERV, IRQ0, IRQ1, IRQ, VICPC);
end architecture;