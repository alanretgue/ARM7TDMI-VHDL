LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Process_Unit_2 is
    port (
        CLK, Reset: in std_logic;
        RA, RB, RW: in std_logic_vector(3 downto 0);
        Imm: in std_logic_vector(7 downto 0);
        OP: in std_logic_vector(2 downto 0);
        RegWr, WrEn, ALUSrc, WrSrc: in std_logic;
        N, Z, C, V: out std_logic
    ) ;
end entity Process_Unit_2;

architecture PU of Process_Unit_2 is
    signal W, A, B, AluOut, Extended, mux1Out, DataOut: std_logic_vector(31 downto 0);
begin
    IMM_EXTEND: entity work.Extend_Sign generic map(8) port map(Imm, Extended);
    MUX_1: entity work.Mux21 port map(ALUSrc, B, Extended, mux1Out);
    ALU: entity work.ALU port map(OP, A, mux1Out, AluOut, N, Z, C, V);
    MEM: entity work.Data_Memory port map(CLK, Reset, AluOut(5 downto 0), B, WrEn, DataOut);
    MUX_2: entity work.Mux21 port map(WrSrc, AluOut, DataOut, W);
    REG: entity work.Register_Bench port map (CLK, Reset, W, RA, RB, RW, RegWr, A, B);
end architecture;
