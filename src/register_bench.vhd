library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity Register_Bench is
    port(
        CLK, Reset: in std_logic;
        W: in std_logic_vector(31 downto 0);
        RA, RB, RW: in std_logic_vector(3 downto 0);
        WE: in std_logic;
        A, B: out std_logic_vector(31 downto 0)
    );
end entity;

architecture steven of Register_Bench is
    type RegisterType is array (15 downto 0) of Std_logic_vector(31 downto 0);
begin
    process (CLK, Reset, RA, RB)
        variable registers: RegisterType;
    begin
        if Reset = '1' then
            A <= (others => '0');
            B <= (others => '0');
            registers := (others => (others => '0'));
        end if;
        if RISING_EDGE(CLK) then
            if WE = '1' then
                registers(To_integer(unsigned(RW))) := W;
            end if;
        end if;
        A <= registers(To_integer(unsigned(RA)));
        B <= registers(To_integer(unsigned(RB)));
    end process;
end architecture;