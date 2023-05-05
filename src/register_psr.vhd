library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- I don't really understand the use of this file.
-- Is it to register PSR or to register RegAff ?

entity Register_PSR is
    port(
        CLK, RST: in std_logic;
        WE: in std_logic;
        DATAIN: in std_logic_vector(31 downto 0);
        DATAOUT: out std_logic_vector(31 downto 0)
    );
end entity Register_PSR;


architecture Pascale of Register_PSR is
    signal DATASAVED: std_logic_vector(31 downto 0);
begin
    DATAOUT <= DATASAVED;
    process (CLK, RST)
    begin
        if RST = '1' then
            DATASAVED <= (others => '0');
        end if;
        if Rising_Edge(CLK) then
            if WE = '1' then
                DATASAVED <= DATAIN;
            end if;
        else
            DATASAVED <= DATASAVED;
        end if;
    end process;
end Pascale ; -- Pascale