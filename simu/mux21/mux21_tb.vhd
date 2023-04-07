library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity MUX21 is
    port (OK : out boolean := true);
end entity;


architecture TEST of MUX21_TB is
    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal COM: std_logic;
    signal A, B: std_logic_vector(31 downto 0);
    signal S: std_logic_vector(31 downto 0)
begin
    CLK <= '0' when Done else not CLK after Period / 2;

    process begin
    A <= x"00000000";
    B <= x"FFFFFFFF";
    COM <= '0'
    wait for 10 ns;
    report "Check 1";
    assert S = x"00000000" report "Error S on 1" severity warning;
    wait for 10 ns;
    COM <= '1'
    wait for 10 ns;
    report "Check 2";
    assert S = x"FFFFFFFF" report "Error S on 2" severity warning;
    wait for 10 ns;
    A <= x"00000001";
    COM <= '0'
    wait for 10 ns;
    report "Check 3";
    assert S = x"00000001" report "Error S on 3" severity warning;
    Done <= true;
    wait;
    end process;

    M: entity Work.Mux21 port map (COM, A, B, S);
end architecture;