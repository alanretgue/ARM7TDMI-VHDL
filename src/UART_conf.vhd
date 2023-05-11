library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity UART_conf is
    port (
        Reset: in std_logic;
        Data: in std_logic_vector(7 downto 0);
        Go: out std_logic
        char: out std_logic_vector(7 downto 0)
    );
end entity;

architecture Yves of UART_conf is
    signal uart_conf: std_logic_vector(31 downto 0)
begin
    UART_REG: process(Reset, Data)
    begin
        if Reset = '1' then
            uart_conf <= (others => '0');
            go <= '0';
        end if;
        uart_conf(7 downto 0) <= Data;
        go <= '1';
    end process;
    char <= uart_conf(7 downto 0);
end architecture