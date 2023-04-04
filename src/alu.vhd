library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity ALU is
    port (
        OP: in std_logic_vector(2 downto 0);
        A, B: in std_logic_vector(31 downto 0);
        S: out std_logic_vector(31 downto 0);
        N, Z, C, V: out std_logic
    );
end entity;


architecture rts of ALU is 
begin
    process (OP, A, B)
        variable a_var: Std_logic_vector(32 downto 0);
        variable b_var: Std_logic_vector(32 downto 0);
        variable s_var: Std_logic_vector(32 downto 0);
    begin
        a_var := '0' & A;
        b_var := '0' & B;
        Case OP is
            when "000" =>
                -- a_var := To_integer(signed(A));
                -- b_var := To_integer(signed(B));
                -- S <= Std_logic_vector(To_signed(s_var, 33));
                s_var := Std_logic_vector(unsigned(a_var) + unsigned(b_var));
            when "001" =>
                S_var := B_var;
            when "010" =>
                -- a_var := To_integer(signed(A));
                -- b_var := To_integer(signed(B));
                -- s_var := a_var + b_var;
                s_var := Std_logic_vector(unsigned(a_var) + unsigned(b_var));
            when "011" => s_var := a_var;
            when "100" => s_var := a_var or b_var;
            when "101" => s_var := a_var and b_var;
            when "110" => s_var := a_var xor b_var;
            when "111" => s_var := not(a_var);
            when others => s_var := (others => '-');
        end case;
        S <= s_var(31 downto 0);
        -- FLAG Z
        if unsigned(s_var(31 downto 0)) = 0 then
            Z <= '1';
        else
            Z <= '0';
        end if;
        -- FLAG V
        if a_var(31) = b_var(31) and s_var(31) /= a_var(31) then
            V <= '1';
        else
            V <= '0';
        end if;
        -- FLAG C
        if s_var(32) = '1' then
            C <= '1';
        else
            C <= '0';
        end if;
        -- FLAG N
        if s_var(31) = '1' then
            N <= '1';
        else
            N <= '0';
        end if;
    end process;
end architecture;