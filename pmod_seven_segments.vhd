--------------------------------------------------------------------------------
--
--   FileName:         pmod_seven_segments.vhd
--   Dependencies:     seven_segments.vhd, binary_to_bcd.vhd,
--                     binary_to_bcd_digit.vhd, bcd_to_7seg_display.vhd
--   Design Software:  Vivado 2017.2
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 02/13/2019 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

ENTITY pmod_seven_segments IS
  GENERIC(
    clk_freq : INTEGER := 125);  --the provided system clock frequency in MHz
  PORT(
    clk          : IN      STD_LOGIC;                      --system clock       
    number       : IN      INTEGER;                        --number to display on the 7 segment displays
    digit_select : BUFFER  STD_LOGIC;                      --output to the pmod digit select pin
    segments     : OUT     STD_LOGIC_VECTOR(6 DOWNTO 0));  --outputs to the pmod seven segment displays
END pmod_seven_segments;

ARCHITECTURE behavior OF pmod_seven_segments IS
  signal number1 : std_logic_vector(3 downto 0);
  begin
  number1 <= std_logic_vector(to_unsigned(number, number1'length));
  with number1 select
    segments <= "1111110" when "0000",  --0  
                "0110000" WHEN "0001",  --1
                "1101101" WHEN "0010",  --2
                "1111001" WHEN "0011",  --3
                "0110011" WHEN "0100",  --4
                "1011011" WHEN "0101",  --5
                "1011111" WHEN "0110",  --6
                "1110000" WHEN "0111",  --7
                "1111111" WHEN "1000",  --8
                "1111011" WHEN "1001",  --9
                "1110111" WHEN "1010", --10, A
                "1111111" WHEN "1011", --11, B
                "1001110" WHEN "1100", --12, C
                "0111101" WHEN "1101", --13, d
                "1001111" WHEN "1110", --14, E
                "1000111" WHEN "1111", --15, F
                "0000000" WHEN OTHERS;  --blank when not a digit

digit_select <= '0';

END behavior;