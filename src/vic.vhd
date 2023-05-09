library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity VIC is
    port(
        CLK, RESET: in std_logic;
        IRQ_SERV, IRQ0, IRQ1: in std_logic;
        IRQ: out std_logic;
        VICPC: out std_logic_vector(31 downto 0)
    );
end entity VIC;


architecture Veronik of VIC is
    signal IRQ0_MEMO, IRQ0_PREV, IRQ1_MEMO, IRQ0_PREV: std_logic;
begin
    process(CLK, RESET)
        begin
            if RESET = '1' then
                IRQ0_MEMO <= '0';
                IRQ1_MEMO <= '0';
            end if;
            if RISING_EDGE(CLK) then
                -- PAS BON
                if IRQ0 = '1' and IRQ0_PREV = '0' then
                    IRQ0_MEMO <= '1';
                    VICPC <= x"9";
                elsif IRQ1 = '1' and IRQ1_PREV = '0' then
                    IRQ1_MEMO <= '1';
                    VICPC <= x"15";
                else
                    VICPC <= (others => '0');
                end if;
                if IRQ_SERV = '1' then
                    IRQ0_MEMO <= '0';
                    IRQ1_MEMO <= '0';
                end if;
            end if;
            IRQ0_PREV <= IRQ0;
            IRQ1_PREV <= IRQ1;
        end process;
end architecture Veronik;