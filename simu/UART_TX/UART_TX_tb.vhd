library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity UART_TX_TB is
    port (OK : out boolean := true);
end entity;


architecture TEST of UART_TX_TB is
    signal CLK : std_logic := '0';
    constant Period : time := 10 ns; -- speed up simulation with a 100MHz clock
    signal Done : boolean;
    signal RESET: std_logic;
    signal go, Tx: std_logic;
    signal Data: std_logic_vector(7 downto 0);
    type State_UART_TX is (E1, E2, E3, E4);
    signal state: State_UART_TX;
    signal Tick_bit: std_logic;
begin
    CLK <= '0' when Done else not CLK after Period / 2;

    State <= <<signal .UART_TX_tb.G.state: State_UART_TX>>;
    Tick_bit <= <<signal .UART_TX_tb.G.Tick_bit: std_logic>>;

    process begin
    RESET <= '1';
    go <= '0';
    Data <= "01101001";
    wait for 10 ns;
    -- cnt = 0
    -- state = E1
    RESET <= '0';
    wait for 10 ns;
    -- cnt = 1
    -- state = E1
    go <= '1';
    wait for 10 ns;
    -- cnt = 0 ****
    -- state = E2
    wait for 10 ns;
    -- cnt = 1
    -- state = E3
    wait for 10 ns;
    -- cnt = 0 ****
    -- state = E4
    report "CHECK 1";
    assert Tx = '0';
    wait for 20 ns;
    report "CHECK 2";
    assert Tx = '1';
    wait for 20 ns;
    report "CHECK 3";
    assert Tx = '0';
    wait for 20 ns;
    report "CHECK 4";
    assert Tx = '0';
    wait for 20 ns;
    report "CHECK 5";
    assert Tx = '1';
    wait for 20 ns;
    report "CHECK 6";
    assert Tx = '0';
    wait for 20 ns;
    report "CHECK 7";
    assert Tx = '1';
    wait for 20 ns;
    report "CHECK 8";
    assert Tx = '1';
    wait for 20 ns;
    report "CHECK 9";
    assert Tx = '0';
    wait for 20 ns;
    report "CHECK 10";
    assert Tx = '1';
    wait for 20 ns;

    Done <= true;
    wait;
    end process;

    G: entity Work.UART_TX generic map (2) port map (CLK, RESET, go, Data, Tx);
end architecture;