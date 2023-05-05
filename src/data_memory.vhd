library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity Data_Memory is
    port (
        CLK, Reset: in std_logic;
        Addr: in std_logic_vector(5 downto 0);
        DataIn: in std_logic_vector(31 downto 0);
        WrEn: in std_logic;
        DataOut: out std_logic_vector(31 downto 0)
    );
end entity;


architecture marc of Data_Memory is
    -- type declaration
    type MemoryType is array (63 downto 0) of Std_logic_vector(31 downto 0);

    -- function declaration
    function init_memory return MemoryType is
        variable result : MemoryType;
    begin
        for i in 63 downto 0 loop
            result(i) := (others=>'0');
        end loop;
        result(16):=X"00000030";
        result(15):=X"000F0A00";
        return result;
    end init_memory;

    -- signal declaration
    signal memory: MemoryType;
begin
    DataOut <= memory(to_integer(unsigned(Addr)));
    process (CLK, Reset)
    begin
        if Reset = '1' then
            memory <= init_memory;
        end if;
        if Rising_Edge(CLK) then
            if WrEn = '1' then
                memory(to_integer(unsigned(Addr))) <= DataIn;
            end if;
        else
            memory <= memory;
        end if;
    end process;
end marc ;
