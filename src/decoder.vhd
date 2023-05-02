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
    type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT, NOP);
begin
    process(RegPSR, Instr)
        variable Cond: std_logic_vector(3 downto 0);
        variable Sharp: std_logic;
        variable Sel: std_logic_vector(1 downto 0);
        variable Opcode: std_logic_vector(4 downto 0);
        variable Rn: std_logic_vector(3 downto 0);
        variable Rd: std_logic_vector(3 downto 0);
        variable TinyOffset: std_logic_vector(11 downto 0);
        variable BigOffset: std_logic_vector(24 downto 0);

        variable DoInstr: std_logic;
        variable instr_courante: enum_instruction;
    begin
        Sel := Instr(27 downto 26);
        sharp := Instr(25);
        Cond := Instr(31 downto 28);


        Rn <= Instr(19 downto 16);
        Rn <= Instr(15 downto 12);
        case Sel is
            when "00" =>
                case Opcode is
                    when "0100" => instr_courante := ADDi when sharp = '1' else ADDr;
                    when "1010" => instr_courante := CMP;
                    when "1101" => instr_courante := MOV;
                    when others => instr_courante := NOP;
                end case;
            when "01" =>
                if Instr(20) = '0' then
                    instr_courante := LDR;
                else
                    instr_courante := STR;
                end if;
            when "10" =>
                if sharp = '1' and Instr(24) = '0' then
                    if Cond = "1011" then
                        instr_courante := BLT;
                    elsif Cond = "1110" then
                        instr_courante := BAL;
                    else
                        instr_courante := NOP;
                    end if;
                else
                    instr_courante := NOP;
                end if;
            when others => instr_courante := NOP;
        end case;

        case instr_courante is
            when MOV =>
                nPCSel <= '0';
                RegWr <= '1';
                ALUSrc <= '1';
                ALUCtr <= "001";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                RegAff <= '0';
            when ADDi =>
                nPCSel <= '0';
                RegWr <= '1';
                ALUSrc <= '1';
                ALUCtr <= "000";
                PSREn <= '1';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';
            when ADDr =>
                nPCSel <= '0';
                RegWr <= '1';
                ALUSrc <= '0';
                ALUCtr <= "000";
                PSREn <= '1';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';
            when CMP =>
                nPCSel <= '0';
                RegWr <= '0';
                ALUSrc <= '1';
                ALUCtr <= "010";
                PSREn <= '1';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';
            when LDR =>
                nPCSel <= '0';
                RegWr <= '1';
                ALUSrc <= '1';
                ALUCtr <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '1';
                RegAff <= '0';
            when STR =>
                nPCSel <= '0';
                RegWr <= '0';
                ALUSrc <= '1';
                ALUCtr <= "000";
                PSREn <= '1';
                MemWr <= '1';
                WrSrc <= '0';
                RegSel <= '1';
                RegAff <= '1';
            when BAL =>
                nPCSel <= '1';
                RegWr <= '0';
                ALUSrc <= '0';
                ALUCtr <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';
            when BLT =>
                if RegPSR(28) /= RegPSR(31) then
                    nPCSel <= '1';
                else
                    nPCSel <= '0';
                end if;
                RegWr <= '0';
                ALUSrc <= '0';
                ALUCtr <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';
            when others =>
                nPCSel <= '0';
                RegWr <= '0';
                ALUSrc <= '0';
                ALUCtr <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';
        end case;


    end process;
end architecture Derick;
