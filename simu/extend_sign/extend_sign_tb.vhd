library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity EXTEND_SIGN_TB is
    port (OK : out boolean := true);
end entity;


architecture TEST of EXTEND_SIGN_TB is
    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal E: std_logic_vector(16 downto 0);
    signal S: std_logic_vector(31 downto 0)
begin
    CLK <= '0' when Done else not CLK after Period / 2;

    process begin
    E <= x"0000";
    wait for 10 ns;
    report "Check 1";
    assert S = x"00000000" report "Error S on 1" severity warning;
    wait for 10 ns;
    E <= x"8000";
    wait for 10 ns;
    report "Check 2";
    assert S = x"80000000" report "Error S on 2" severity warning;
    wait for 10 ns;
    E <= x"FFFF";
    COM <= '0'
    wait for 10 ns;
    report "Check 3";
    assert S = x"FFFFFFFF" report "Error S on 3" severity warning;
    Done <= true;
    wait;
    end process;

    M: entity Work.Extend_sign port map (E, S);
end architecture;