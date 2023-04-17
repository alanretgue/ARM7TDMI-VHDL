library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity Register_Bench is
    port(
        CLK, Reset: in std_logic;
        W: in std_logic_vector(31 downto 0);
        RA, RB, RW: in std_logic_vector(3 downto 0);
        WE: in std_logic;
        A, B: out std_logic_vector(31 downto 0)
    );
end entity;

architecture steven of Register_Bench is
    -- type declaration
    type RegisterType is array (15 downto 0) of Std_logic_vector(31 downto 0);
    
    -- Fonction d'Initialisation du Banc de Registres
    function init_banc return RegisterType is
        variable result : RegisterType;
    begin
        for i in 13 downto 0 loop
            result(i) := (others=>'0');
        end loop;
        result(15):=X"00000030";
        result(14):=X"000F0A00";
        return result;
    end init_banc;

    -- Init registers
    signal registers: RegisterType := init_banc;
begin
    process (CLK, Reset, RA, RB)
    begin
        if Reset = '1' then
            A <= (others => '0');
            B <= (others => '0');
            registers <= (others => (others => '0'));
        end if;
        if RISING_EDGE(CLK) then
            if WE = '1' then
                registers(To_integer(unsigned(RW))) <= W;
            end if;
        end if;
    end process;
    A <= registers(To_integer(unsigned(RA)));
    B <= registers(To_integer(unsigned(RB)));
end architecture;