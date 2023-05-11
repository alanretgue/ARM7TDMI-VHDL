library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity UART_TX is
    generic(div: integer:= 2);
    port (
        CLK, Reset: in std_logic;
        go: in std_logic;
        Data: in std_logic_vector(7 downto 0);
        Tx: out std_logic
    );
end entity;

architecture JeanMarc of UART_TX is
    type State_UART_TX is (E1, E2, E3, E4);
    signal state: State_UART_TX;
    signal reg: std_logic_vector(9 downto 0);
    signal cnt_bit: integer range 0 to 15;
    signal Tick_bit: std_logic;
begin
    -- FDIV: process(CLK, Reset)
    --     variable count : integer range 0 to div;
    -- begin
    --     if Reset = '1' then
    --         count := 0;
    --         Tick_bit <= '0';
    --     end if;
    --     if RISING_EDGE(CLK) then
    --         count := count + 1;
    --         if count = div then
    --             if Tick_bit = '1' then
    --                 Tick_bit <= '0';
    --             else
    --                 Tick_bit <= '1';
    --             end if;
    --             count := 0;
    --         else
    --             Tick_bit <= Tick_bit;
    --         end if;
    --     else
    --         Tick_bit <= Tick_bit;
    --     end if;
    -- end process;
    FDIV: process(CLK, Reset)
        variable count : integer range 0 to div;
    begin
        if Reset = '1' then
            count := 0;
            Tick_bit <= '0';
        end if;
        if FALLING_EDGE(CLK) then
            count := count + 1;
            if count = div then
                Tick_bit <= '1';
                count := 0;
            else
                Tick_bit <= '0';
            end if;
        else
            Tick_bit <= '0';
        end if;
    end process;

    TX_process: process(CLK, Reset)
    begin
        if Reset = '1' then
            Tx <= '1';
            cnt_bit <= 0;
            reg <= (others => '0');
        end if;
        if RISING_EDGE(CLK) then
            case state is
                when E1 =>
                    if go = '1' then
                        state <= E2;
                    end if;
                    cnt_bit <= 0;
                when E2 =>
                    if Tick_bit = '1' then
                        state <= E3;
                    end if;
                    reg <= '1' & Data & '0';
                    cnt_bit <= 0;
                when E3 =>
                    TX <= reg(cnt_bit);
                    state <= E4;
                when E4 =>
                    if cnt_bit >= 9 then
                        state <= E1;
                    elsif Tick_bit = '1' then
                        state <= E3;
                        cnt_bit <= cnt_bit + 1;
                    end if;
                when others =>
                    state <= E1;
            end case;
        end if;
    end process;
end architecture;