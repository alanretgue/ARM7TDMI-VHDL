library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TOP_LEVEL is
    port(
        CLK: in std_logic;
        KEY: in std_logic_vector(1 downto 0);
        HEX0, HEX1, HEX2, HEX3: out std_logic_vector(0 to 6)
        );
end entity;

architecture Victor of TOP_LEVEL is
    signal Reset: std_logic;
    signal Instruction, RegPSR, Flags: std_logic_vector(31 downto 0);
    signal Rn, Rd, Rm, Rb: std_logic_vector(3 downto 0);
    signal nPCSel, RegWr, RegSel, ALUSrc, RegAff, MemWr, PSREn, WrSrc: std_logic;
    signal ALUCtr: std_logic_vector(2 downto 0);
    signal Imm8: std_logic_vector(7 downto 0);
    signal Imm24: std_logic_vector(23 downto 0);
begin
    Reset <= not KEY(0);
    Rn <= Instruction(19 downto 16);
    Rd <= Instruction(15 downto 12);
    Rm <= Instruction(3 downto 0);
    Imm8 <= Instruction(7 downto 0);
    Imm24 <= Instruction(23 downto 0);

    MUX_Rb: entity work.Mux21 generic map(4) port map(RegSel, Rm, Rd, Rb);
    Instr_Unit: entity work.instruction_unit port map(
        CLK, Reset,
        Imm24,
        nPCsel,
        Instruction
    );
    Dec: entity work.Decoder port map(
        RegPSR, Instruction,
        nPCSel, RegWr, RegSel, ALUSrc, RegAff, MemWr, ALUCtr, PSREn, WrSrc
    );
    REGISTER_AND_MEMORY: entity work.register_and_memory port map(
        CLK, Reset,
        Rn, Rb, Rd,
        Imm8,
        ALUCtr,
        RegWr, MemWr,ALUSrc, WrSrc, RegAff,
        Flags(31), Flags(30), Flags(29), Flags(28),
        HEX0, HEX1, HEX2, HEX3
    );
    REG_PSR: entity work.Register_PSR port map(
        CLK, Reset,
        PSREn,
        Flags,
        RegPSR
    );
end architecture Victor;
