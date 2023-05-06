LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity register_and_memory is
    port (
        CLK, Reset: in std_logic;
        RA, RB, RW: in std_logic_vector(3 downto 0);
        Imm: in std_logic_vector(7 downto 0);
        OP: in std_logic_vector(2 downto 0);
        RegWr, WrEn, ALUSrc, WrSrc, RegAff: in std_logic;
        N, Z, C, V: out std_logic;
        Segout0, Segout1, Segout2, Segout3: out std_logic_vector(1 to 7)
    ) ;
end entity register_and_memory;

architecture PU of register_and_memory is
    signal W, A, B, AluOut, Extended, mux1Out, DataOut, Afficheur: std_logic_vector(31 downto 0);
begin
    IMM_EXTEND: entity work.Extend_Sign generic map(8) port map(Imm, Extended);
    MUX_1: entity work.Mux21 port map(ALUSrc, B, Extended, mux1Out);
    ALU: entity work.ALU port map(OP, A, mux1Out, AluOut, N, Z, C, V);
    MEM: entity work.Data_Memory port map(CLK, Reset, AluOut(5 downto 0), B, WrEn, DataOut);
    MUX_2: entity work.Mux21 port map(WrSrc, AluOut, DataOut, W);
    REG: entity work.Register_Bench port map(CLK, Reset, W, RA, RB, RW, RegWr, A, B);
    AFF: entity work.Register_PSR port map(CLK, Reset, RegAff, B, Afficheur);
    SEG1: entity work.Seven_Seg port map(Afficheur(3 downto 0), '0', Segout0);
    SEG2: entity work.Seven_Seg port map(Afficheur(7 downto 4), '0', Segout1);
    SEG3: entity work.Seven_Seg port map(Afficheur(11 downto 8), '0', Segout2);
    SEG4: entity work.Seven_Seg port map(Afficheur(15 downto 12), '0', Segout3);
end architecture;
