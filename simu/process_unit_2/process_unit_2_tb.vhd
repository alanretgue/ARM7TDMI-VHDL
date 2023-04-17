library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity PROCESS_UNIT_2_TB is
    port (OK : out boolean := true);
end entity;

architecture TEST of PROCESS_UNIT_2_TB is
    type RegisterType is array (15 downto 0) of Std_logic_vector(31 downto 0);
    type MemoryType is array (63 downto 0) of Std_logic_vector(31 downto 0);

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
    signal InALU2: std_logic_vector(31 downto 0);

    signal RegisterBench: RegisterType;
    signal DataBench: MemoryType;
begin
    CLK <= '0' when Done else not CLK after Period / 2;

    ALUOut <= <<signal .process_unit_2_tb.p.AluOut: std_logic_vector(31 downto 0)>>;
    BusA <= <<signal .process_unit_2_tb.p.A: std_logic_vector(31 downto 0)>>;
    BusB <= <<signal .process_unit_2_tb.p.B: std_logic_vector(31 downto 0)>>;
    Ext <= <<signal .process_unit_2_tb.p.Extended: std_logic_vector(31 downto 0)>>;
    RegisterBench <= <<signal .process_unit_2_tb.p.reg.registers: RegisterType>>;
    DataBench <= <<signal .process_unit_2_tb.p.mem.memory: MemoryType>>;
    InALU2 <= <<signal .process_unit_2_tb.p.mux1Out: std_logic_vector(31 downto 0)>>;
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
        assert BusA = x"0000000F" report "Error BusA on 1" severity warning;
        assert InALU2 = x"0000000F" report "Error InALU2 on 1" severity warning;
        assert ALUOut = x"0000001E" report "Error ALUOut on 1" severity warning;
        
        -- Write 0x01 to R1
        RW <= x"1";
        RA <= x"1";
        Imm <= x"01";
        wait for 10 ns;
        assert BusA = x"00000001" report "Error BusA on 2" severity warning;
        assert InALU2 = x"00000001" report "Error InALU2 on 2" severity warning;
        assert ALUOut = x"00000002" report "Error ALUOut on 2" severity warning;
        -- Add R0 and R1 into R2
        RW <= x"2";
        RA <= x"1";
        RB <= x"0";
        mux1Input <= '0';
        wait for 10 ns;
        assert BusA = x"00000001" report "Error BusA on 3" severity warning;
        assert BusB = x"0000000F" report "Error BusA on 3" severity warning;
        assert InALU2 = x"0000000F" report "Error InALU2 on 3" severity warning;
        assert ALUOut = x"00000010" report "Error ALUOut on 3" severity warning;
        assert RegisterBench(2) = x"00000010" report "Error Register Bench on 3" severity warning;
        wait for 10 ns;
        -- Copy R2 into R3
        OP <= "011";
        RW <= x"3";
        RA <= x"2";
        RB <= x"0";
        wait for 10 ns;
        assert BusA = x"00000010" report "Error BusA on 4" severity warning;
        assert BusB = x"0000000F" report "Error BusA on 4" severity warning;
        assert InALU2 = x"0000000F" report "Error InALU2 on 4" severity warning;
        assert ALUOut = x"00000010" report "Error ALUOut on 4" severity warning;
        assert RegisterBench(3) = x"00000010" report "Error Register Bench on 4" severity warning;
        wait for 10 ns;
        -- Sub R1 to R2 into R0
        OP <= "010";
        RW <= x"0";
        RA <= x"2";
        RB <= x"1";
        mux1Input <= '0';
        wait for 10 ns;
        assert BusA = x"00000010" report "Error BusA on 5" severity warning;
        assert BusB = x"00000001" report "Error BusA on 5" severity warning;
        assert InALU2 = x"00000001" report "Error InALU2 on 5" severity warning;
        assert ALUOut = x"0000000F" report "Error ALUOut on 5" severity warning;
        assert RegisterBench(0) = x"0000000F" report "Error Register Bench on 5" severity warning;
        wait for 10 ns;
        -- Sub 1 to R2 into R4
        OP <= "010";
        RW <= x"4";
        RA <= x"2";
        RB <= x"0";
        mux1Input <= '1';
        Imm <= x"01";
        wait for 10 ns;
        assert BusA = x"00000010" report "Error BusA on 6" severity warning;
        assert BusB = x"0000000F" report "Error BusA on 6" severity warning;
        assert InALU2 = x"00000001" report "Error InALU2 on 6" severity warning;
        assert ALUOut = x"0000000F" report "Error ALUOut on 6" severity warning;
        assert RegisterBench(4) = x"0000000F" report "Error Register Bench on 6" severity warning;
        wait for 10 ns;
        -- Write R2 into data memory(0)
        OP <= "011";
        RW <= x"0";
        RA <= x"5";
        RB <= x"2";
        RegWr <= '0';
        WrEn <= '1';
        mux1Input <= '0';
        wait for 10 ns;
        assert BusA = x"00000000" report "Error BusA on 6" severity warning;
        assert BusB = x"00000010" report "Error BusA on 6" severity warning;
        assert InALU2 = x"00000010" report "Error InALU2 on 6" severity warning;
        assert ALUOut = x"00000000" report "Error ALUOut on 6" severity warning;
        assert DataBench(0) = x"00000010" report "Error Data Bench on 6" severity warning;
        wait for 10 ns;
        -- Write data memory(0) into R5
        OP <= "011";
        RW <= x"5";
        RA <= x"6";
        RB <= x"0";
        RegWr <= '1';
        WrEn <= '0';
        mux2Input <= '1';
        wait for 10 ns;
        assert BusA = x"00000000" report "Error BusA on 7" severity warning;
        assert BusB = x"0000000F" report "Error BusA on 7" severity warning;
        assert InALU2 = x"0000000F" report "Error InALU2 on 7" severity warning;
        assert ALUOut = x"00000000" report "Error ALUOut on 7" severity warning;
        assert DataBench(0) = x"00000010" report "Error Data Bench on 7" severity warning;
        assert RegisterBench(5) = x"00000010" report "Error register Bench on 7" severity warning;


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

