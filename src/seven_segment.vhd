-- SevenSeg.vhd
-- ------------------------------
--   squelette de l'encodeur sept segment
-- ------------------------------

--
-- Notes :
--  * We don't ask for an hexadecimal decoder, only 0..9
--  * outputs are active high if Pol='1'
--    else active low (Pol='0')
--  * Order is : Segout(1)=Seg_A, ... Segout(7)=Seg_G
--
--  * Display Layout :
--
--       A=Seg(1)
--      -----
--    F|     |B=Seg(2)
--     |  G  |
--      -----
--     |     |C=Seg(3)
--    E|     |
--      -----
--        D=Seg(4)


library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

-- ------------------------------
    Entity SEVEN_SEG is
-- ------------------------------
  port ( Data: in  std_logic_vector(3 downto 0); -- Expected within 0 .. F
         Pol: in  std_logic;                    -- '0' if active LOW
         Segout: out std_logic_vector(1 to 7) );   -- Segments A, B, C, D, E, F, G
end entity SEVEN_SEG;

-- -----------------------------------------------
    Architecture COMB of SEVEN_SEG is
-- ------------------------------------------------
  signal sevseg : std_logic_vector(1 to 7);
begin
  process(Data, Pol, sevseg)
  begin
    case(Data) is
      when x"0"=> sevseg <= "1111110";
      when x"1" => sevseg <= "0110000";
      when x"2" => sevseg <= "1101101";
      when x"3" => sevseg <= "1111001";
      when x"4" => sevseg <= "0110011";
      when x"5" => sevseg <= "1011011";
      when x"6" => sevseg <= "1011111";
      when x"7" => sevseg <= "1110000";
      when x"8" => sevseg <= "1111111";
      when x"9" => sevseg <= "1111011";
      when x"A" => sevseg <= "1110111";
      when x"B" => sevseg <= "0011111"; -- b minuscule
      when x"C" => sevseg <= "1001110";
      when x"D" => sevseg <= "0111101"; -- d minuscule
      when x"E" => sevseg <= "1001111";
      when x"F" => sevseg <= "1000111";
      when others => sevseg <= (others => '-');
    end case;
    if (Pol = '1') then
      Segout <= sevseg;
    else
      Segout <= not(sevseg);
    end if;
  end process;
end architecture COMB;
