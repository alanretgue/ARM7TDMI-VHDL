LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Process_Unit is
    port (
        CLK, Reset: in std_logic;
        RA, RB, RW: in std_logic_vector(3 downto 0);
        OP: in std_logic_vector(2 downto 0);
        WE: in std_logic;
        N, Z, C, V: out std_logic
    ) ;
end entity Process_Unit;

architecture PU of Process_Unit is
    signal W, A, B: std_logic_vector(31 downto 0);
begin
    ALU: entity work.ALU port map(OP, A, B, W, N, Z, C, V);
    REG: entity work.Register_Bench port map (CLK, Reset, W, RA, RB, RW, WE, A, B);
end architecture;
