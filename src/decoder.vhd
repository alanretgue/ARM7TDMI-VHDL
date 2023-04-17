library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decoder is
    port(
        RegPSR: in std_logic_vector(31 downto 0);
        Instr: in std_logic_vector(31 downto 0);
        nPCSel: out std_logic;
        RegWrite: out std_logic;
        RegSel: out std_logic;
        ALUSrc: out std_logic;
        RegAff: out std_logic_vector(31 downto 0);
        MemWr: out std_logic;
        ALUCtr: out std_logic;
        PSREn: out std_logic;
        WrSrc: out std_logic;
    );
end entity Decoder;

architecture Derick of Decoder is
    type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
    signal instr_courante: enum_instruction;
begin
    process(RegPSR, Instr)
        variable Cond: std_logic_vector(3 downto 0);
        variable Sel: std_logic_vector(1 downto 0);
        variable Opcode: std_logic_vector(4 downto 0);
        variable Rn: std_logic_vector(3 downto 0);
        variable Rd: std_logic_vector(3 downto 0);
        variable TinyOffset: std_logic_vector(11 downto 0);
        variable BigOffset: std_logic_vector(24 downto 0);

        variable DoInstr: std_logic;
    begin
        Sel := Instr(27 downto 26);
        Cond := Instr(31 downto 28);

        case Cond is
            when "0000" => DoInstr := RegPSR(29);
            when "0001" => DoInstr := not(RegPSR(29));
            when others => DoInstr := '0';
        end case;

        case Sel is
            when "00" =>
            when "01" =>
            when "10" =>
            when others =>
        end case;
    end process;
end architecture Derick;
