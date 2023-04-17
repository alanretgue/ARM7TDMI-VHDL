library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity DATA_MEMORY_TB is
    port (OK : out boolean := true);
end entity;


architecture TEST of DATA_MEMORY_TB is
    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal Reset: std_logic;
    signal Addr: std_logic_vector(5 downto 0);
    signal DataIn: std_logic_vector(31 downto 0);
    signal WrEn: std_logic;
    signal DataOut: std_logic_vector(31 downto 0);
begin
    CLK <= '0' when Done else not CLK after Period / 2;

    process begin
        Reset <= '1';
        wait for 1 ns;
        Reset <= '0';
        Addr <= "000000";
        DataIn <= x"0000FFFF";
        WrEn <= '1';
        wait for 10 ns;
        assert DataOut = x"0000FFFF" report "Error DataOut on 1" severity warning;
        wait for 10 ns;
        Addr <= "000001";
        DataIn <= x"11110000";
        WrEn <= '1';
        wait for 10 ns;
        assert DataOut = x"11110000" report "Error DataOut on 2" severity warning;
        wait for 10 ns;
        Addr <= "000000";
        WrEn <= '0';
        wait for 10 ns;
        assert DataOut = x"0000FFFF" report "Error DataOut on 3" severity warning;
        wait for 10 ns;
        Addr <= "000100";
        DataIn <= x"FFFFFFFF";
        WrEn <= '1';
        wait for 10 ns;
        assert DataOut = x"FFFFFFFF" report "Error DataOut on 3" severity warning;
        wait for 10 ns;
        Addr <= "000001";
        WrEn <= '0';
        wait for 10 ns;
        assert DataOut = x"11110000" report "Error DataOut on 4" severity warning;
        wait for 10 ns;
        Reset <= '1';
        Addr <= "000001";
        WrEn <= '0';
        wait for 10 ns;
        assert DataOut = x"00000000" report "Error DataOut on 5" severity warning;

        Done <= True;
        wait;
    end process;

    G: entity Work.data_memory port map (
        CLK, Reset,
        Addr,
        DataIn,
        WrEn,
        DataOut
    );
end architecture;
