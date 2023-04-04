library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity Register_Bench is
    port(
        CLK, Reset: in std_logic;
        W: in std_logic_vector(31 downto 0);
        RA, RB, RW: in std_logic_vector(3 downto 0);
        WE: in std_logic;
        A, B: in std_logic_vector(31 downto 0);
    );
end entity;

architecture steven of Register_Bench is
    type RegisterType is array (15 downto 0) of Std_logic_vector(31 downto 0);
    signal registers: RegisterType;
begin
    process (CLK, Reset)
    begin
        if Reset = '1' then
            
        end if;
    end process;
end architecture;