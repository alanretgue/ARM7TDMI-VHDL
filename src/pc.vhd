library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC is
    port(
        CLK, Reset: in std_logic;
        PCin: in std_logic_vector(31 downto 0);
        PCout: out std_logic_vector(31 downto 0)
    );
end entity PC;


architecture Patrick of PC is
begin
    process (CLK, Reset)
    begin
        if Reset = '1' then
            PCout <= (others => '0');
        end if;
        if Rising_Edge(CLK) then
            PCout <= PCin;
        end if;
    end process;
end architecture Patrick;