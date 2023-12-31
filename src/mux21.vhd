library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity Mux21 is
    generic (N: integer := 32);
    port (
        COM: in std_logic;
        A, B: in std_logic_vector(N - 1 downto 0);
        S: out std_logic_vector(N - 1 downto 0)
    );
end entity;

architecture Michel of Mux21 is
begin
    S <= A when COM = '0' else B;
end architecture;