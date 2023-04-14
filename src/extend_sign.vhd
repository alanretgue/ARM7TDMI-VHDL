library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity Extend_Sign is
    generic (N: integer := 32);
    port (
        E: in std_logic_vector(N - 1 downto 0);
        S: out std_logic_vector(31 downto 0)
    );
end entity;

architecture Pascal of Extend_Sign is
begin
    S <= std_logic_vector(To_signed(To_integer(Signed(E)), 32));
end architecture;