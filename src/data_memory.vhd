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
begin
    process (CLK, Reset)
        variable memory: MemoryType;
    begin
        if Reset = '1' then
            memory := (others => (others => '0'));
        end if;
        if Rising_Edge(CLK) then
            if WrEn = '1' then
                memory(to_integer(unsigned(Addr))) := DataIn;
            end if;
        end if;
        DataOut <= memory(to_integer(unsigned(Addr)));
    end process;
end marc ;