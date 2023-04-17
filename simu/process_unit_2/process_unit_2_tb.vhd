library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity PROCESS_UNIT_2_TB is
    port (OK : out boolean := true);
end entity;

architecture TEST of PROCESS_UNIT_2_TB is
    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal Reset: std_logic;
    signal RA, RB, RW: std_logic_vector(3 downto 0);
    signal Imm: std_logic_vector(7 downto 0);
    signal OP: std_logic_vector(2 downto 0);
    signal RegWr, WrEn, mux1Input, mux2Input: std_logic;
    signal N, Z, C, V: std_logic;
    signal ALUOut: std_logic_vector(31 downto 0);
    signal BusA, BusB: std_logic_vector(31 downto 0);
    signal Ext: std_logic_vector(31 downto 0);
begin
    CLK <= '0' when Done else not CLK after Period / 2;

    ALUOut <= <<signal .process_unit_2_tb.p.AluOut: std_logic_vector(31 downto 0)>>;
    BusA <= <<signal .process_unit_2_tb.p.A: std_logic_vector(31 downto 0)>>;
    BusB <= <<signal .process_unit_2_tb.p.B: std_logic_vector(31 downto 0)>>;
    Ext <= <<signal .process_unit_2_tb.p.Extended: std_logic_vector(31 downto 0)>>;
    process begin
        -- Write 0x0F to R0
        Reset <= '1';
        wait for 1 ns;
        Reset <= '0';
        OP <= "000";
        RA <= x"0";
        RB <= x"0";
        RW <= x"0";
        RegWr <= '1';
        WrEn <= '0';
        mux1Input <= '1';
        mux2Input <= '0';
        Imm <= x"0F";
        wait for 10 ns;
        -- Write 0x01 to R1
        RW <= x"1";
        RA <= x"1";
        Imm <= x"01";
        wait for 10 ns;
        -- Add R0 and R1 into R2
        RW <= x"2";
        RA <= x"1";
        RB <= x"0";
        mux1Input <= '0';
        wait for 10 ns;
        wait for 10 ns;
        Done <= true;
        wait;
    end process;


    P: entity Work.process_unit_2 port map (
        CLK, Reset,
        RA, RB, RW,
        Imm,
        OP,
        RegWr, WrEn, mux1Input, mux2Input,
        N, Z, C, V
    );
end architecture;

