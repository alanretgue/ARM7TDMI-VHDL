library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity INSTR_UNIT_TB is
end entity;

architecture TEST of INSTR_UNIT_TB is
    -- type declaration
    type RegisterType is array (15 downto 0) of Std_logic_vector(31 downto 0);

    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal Reset: std_logic;
    signal offset: std_logic_vector(23 downto 0);
    signal nPCsel: std_logic;
    signal instruction: std_logic_vector(31 downto 0);
    
begin
    CLK <= '0' when Done else not CLK after Period / 2;
    process
    begin
        reset <= '1';
        nPCsel <= '0';
        offset <= x"FFFFFC";
        wait for Period;
        report "CHECK 0";
        assert instruction = x"E3A01010" report "Error wrong instruction" severity warning;
        reset <= '0';
        wait for Period;
        report "CHECK 1";
        assert instruction = x"E3A02000" report "Error wrong instruction" severity warning;
        wait for Period;
        report "CHECK 2";
        assert instruction = x"E6110000" report "Error wrong instruction" severity warning;
        wait for Period;
        report "CHECK 3";
        assert instruction = x"E0822000" report "Error wrong instruction" severity warning;
        wait for Period;
        report "CHECK 4";
        assert instruction = x"E2811001" report "Error wrong instruction" severity warning;
        wait for Period;
        report "CHECK 5";
        assert instruction = x"E351001A" report "Error wrong instruction" severity warning;
        wait for Period;
        report "CHECK 6";
        assert instruction = x"BAFFFFFB" report "Error wrong instruction" severity warning;
        wait for Period;
        report "CHECK 7";
        assert instruction = x"E6012000" report "Error wrong instruction" severity warning;
        wait for Period;
        report "CHECK 8";
        assert instruction = x"EAFFFFF7" report "Error wrong instruction" severity warning;
        nPCsel <= '1';
        wait for Period;
        report "CHECK -2";
        assert instruction = x"E351001A" report "Error wrong instruction" severity warning;
        wait for Period;
        report "CHECK -5";
        assert instruction = x"E6110000" report "Error wrong instruction" severity warning;
        offset <= x"000001";
        wait for Period;
        report "CHECK 7";
        assert instruction = x"E2811001" report "Error wrong instruction" severity warning;
        Done <= true;
        wait;
    end process;


    P: entity Work.instruction_unit port map (CLK, Reset, offset, nPCsel, instruction);
end architecture;