library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity ALU_TB is
    port (OK : out boolean := true);
end entity;


architecture TEST of ALU_TB is
    signal CLK      : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal OP: std_logic_vector(2 downto 0);
    signal A, B: std_logic_vector(31 downto 0);
    signal S: std_logic_vector(31 downto 0);
    signal N, Z, C, V: std_logic;
begin
    CLK <= '0' when Done else not CLK after Period / 2;

    process begin
    OP <= "000";
    A <= x"00000004";
    B <= x"00000005";
    wait for 10 ns;
    assert S = x"00000009" report "Error RESULT on 1" severity warning;
    assert C = '0' report "Error C on 1" severity warning;
    assert V = '0' report "Error V on 1" severity warning;
    assert N = '0' report "Error N on 1" severity warning;
    assert Z = '0' report "Error Z on 1" severity warning;
    wait for 10 ns;
    A <= x"00000004";
    B <= x"FFFFFFFF";
    wait for 10 ns;
    assert S = x"00000003" report "Error RESULT on 2" severity warning;
    assert C = '1' report "Error C on 2" severity warning;
    assert V = '0' report "Error V on 2" severity warning;
    assert N = '0' report "Error N on 2" severity warning;
    assert Z = '0' report "Error Z on 2" severity warning;
    wait for 10 ns;
    OP <= "001";
    A <= x"00000104";
    B <= x"FFFFFFFF";
    wait for 10 ns;
    assert S = x"FFFFFFFF" report "Error RESULT on 3" severity warning;
    assert C = '0' report "Error C on 3" severity warning;
    assert V = '0' report "Error V on 3" severity warning;
    assert N = '1' report "Error N on 3" severity warning;
    assert Z = '0' report "Error Z on 3" severity warning;
    wait for 10 ns;
    OP <= "100";
    A <= x"00000104";
    B <= x"00000520";
    wait for 10 ns;
    assert S = x"00000524" report "Error RESULT on 4" severity warning;
    assert C = '0' report "Error C on 4" severity warning;
    assert V = '0' report "Error V on 4" severity warning;
    assert N = '0' report "Error N on 4" severity warning;
    assert Z = '0' report "Error Z on 4" severity warning;
    wait for 10 ns;
    OP <= "000";
    A <= x"00000001";
    B <= x"FFFFFFFF";
    wait for 10 ns;
    assert S = x"00000524" report "Error RESULT on 5" severity warning;
    assert C = '1' report "Error C on 5" severity warning;
    assert V = '0' report "Error V on 5" severity warning;
    assert N = '0' report "Error N on 5" severity warning;
    assert Z = '1' report "Error Z on 5" severity warning;
    wait for 10 ns;
    OP <= "101";
    A <= x"00000104";
    B <= x"11100000";
    wait for 10 ns;
    assert S = x"00000000" report "Error RESULT on 6" severity warning;
    assert C = '0' report "Error C on 6" severity warning;
    assert V = '0' report "Error V on 6" severity warning;
    assert N = '0' report "Error N on 6" severity warning;
    assert Z = '1' report "Error Z on 6" severity warning;
    wait for 10 ns;
    OP <= "000";
    A <= x"80000001";
    B <= x"8FFFFFFF";
    wait for 10 ns;
    assert S = x"10000000" report "Error RESULT on 7" severity warning;
    assert C = '1' report "Error C on 7" severity warning;
    assert V = '1' report "Error V on 7" severity warning;
    assert N = '0' report "Error N on 7" severity warning;
    assert Z = '0' report "Error Z on 7" severity warning;
    Done <= true;
    wait;
    end process;

    G: entity Work.ALU port map (OP, A, B, S, N, Z, C, V);
end architecture;