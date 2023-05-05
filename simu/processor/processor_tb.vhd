library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity PROCESSOR_TB is
    port (OK : out boolean := true);
end entity;

architecture TEST of PROCESSOR_TB is
    type RegisterType is array (15 downto 0) of Std_logic_vector(31 downto 0);
    type MemoryType is array (63 downto 0) of Std_logic_vector(31 downto 0);

    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal Reset: std_logic_vector(1 downto 0);
    signal R1, R2, R0: std_logic_vector(31 downto 0);
    signal HEX0, HEX1, HEX2, HEX3: std_logic_vector(1 to 7);

    signal RegisterBench: RegisterType;
    signal DataBench: MemoryType;
begin
    RegisterBench <= <<signal .processor_tb.p.register_and_memory.reg.registers: RegisterType>>;
    DataBench <= <<signal .processor_tb.p.register_and_memory.mem.memory: MemoryType>>;

    R0 <= RegisterBench(0);
    R1 <= RegisterBench(1);
    R2 <= RegisterBench(2);
    
    CLK <= '0' when Done else not CLK after Period / 2;

    process begin
        Reset <= "00";
        wait for 10 ns;
        Reset <= "01";

        for i in 0 to 2 loop
            wait for 10 ns;
            report "TEST 1";
            assert R1 = std_logic_vector(to_unsigned(16 + i, 32)) report "Error R1" severity warning;
            wait for 10 ns;
            report "TEST 2";
            assert R0 = x"00000030" report "Error R0" severity warning;
            wait for 10 ns;
            report "TEST 3";
            assert R2 = x"00000031" report "Error R2" severity warning;
            wait for 10 ns;
            report "TEST 4";
            assert R1 = std_logic_vector(to_unsigned(17 + i, 32)) report "Error R1" severity warning;
            wait for 10 ns;
            wait for 10 ns;
        end loop;
        
        wait for 1000 ns;

        Done <= true;
        wait;
    end process;


    P: entity Work.processor port map (CLK, Reset, HEX0, HEX1, HEX2, HEX3);
end architecture;

