library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity instruction_unit is
    port(
        CLK, Reset: in std_logic;
        offset: in std_logic_vector(23 downto 0);
        nPCsel: in std_logic;
        instruction: out std_logic_vector(31 downto 0)
    );
end entity;


architecture Igor of instruction_unit is
    signal offset_Ext, muxOut, pc, muxIn0, muxIn1: std_logic_vector(31 downto 0);
begin
    muxIn0 <= std_logic_vector(to_signed(to_integer(signed(PC)) + 1, 32));
    muxIn1 <= std_logic_vector(to_signed(to_integer(signed(PC) + signed(offset_Ext)) + 1, 32));

    Offset_Extend: entity work.Extend_Sign port map(offset, offset_Ext);
    MUX: entity work.Mux21 port map(nPCsel, muxIn0, muxIn1, muxOut);
    PC_SET: entity work.PC port map(CLK, Reset, muxOut, pc);
    INST_MEM: entity work.instruction_memory port map(pc, instruction);
end architecture Igor;
