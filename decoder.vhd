----------------------------------------------------------------------------------
-- Company: Digilent Inc 2011
-- Engineer: Michelle Yu  
-- Create Date:      17:18:24 08/23/2011 
--
-- Module Name:    Decoder - Behavioral 
-- Project Name:  PmodKYPD
-- Target Devices: Nexys3
-- Tool versions: Xilinx ISE 13.2
-- Description: 
--	This file defines a component Decoder for the demo project PmodKYPD. 
-- The Decoder scans each column by asserting a low to the pin corresponding to the column 
-- at 1KHz. After a column is asserted low, each row pin is checked. 
-- When a row pin is detected to be low, the key that was pressed could be determined.
--
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Decoder is
    Port (
		  clk : in  STD_LOGIC;
          Row: in  STD_LOGIC_VECTOR (3 downto 0);
		  Col : out  STD_LOGIC_VECTOR (3 downto 0);
          DecodeOut : out  std_logic_vector (3 downto 0)
          );
end Decoder;

architecture Behavioral of Decoder is
signal sclk :STD_LOGIC_VECTOR(19 downto 0) := "00000000000000000000";
begin
	process(clk)
		begin 
		if rising_edge(clk) then
		sclk <= std_logic_vector(unsigned(sclk) + 1);
			-- 1ms
			if sclk = "00011110100001001000" then 
				--C1
				Col<= "1110";
				
			-- check row pins
			elsif sclk = "00011110100010101100" then	
				--R1
				if Row = "1110" then
					DecodeOut <= "0001";	--1
				--R2
				elsif Row = "1101" then
					DecodeOut <= "0100"; --4
				--R3
				elsif Row = "1011" then
					DecodeOut <= "0111"; --7
				--R4
				elsif Row = "0111" then
					DecodeOut <= "0000"; --0
				end if;
			-- 2ms
			elsif sclk = "00111101000010010000" then	
				--C2
				Col<= "1101";
			-- check row pins
			elsif sclk = "00111101000011110100" then	
				--R1
				if Row = "1110" then		
					DecodeOut <= "0010"; --2
				--R2
				elsif Row = "1101" then
					DecodeOut <= "0101"; --5
				--R3
				elsif Row = "1011" then
					DecodeOut <= "1000"; --8
				--R4
				elsif Row = "0111" then
					DecodeOut <= "1111"; --F
				end if;
			--3ms
			elsif sclk = "01011011100011011000" then 
				--C3
				Col<= "1011";
			-- check row pins
			elsif sclk = "01011011100100111100" then 
				--R1
				if Row = "1110" then
					DecodeOut <= "0011"; --3	
				--R2
				elsif Row = "1101" then
					DecodeOut <= "0110"; --6
				--R3
				elsif Row = "1011" then
					DecodeOut <= "1001"; --9
				--R4
				elsif Row = "0111" then
					DecodeOut <= "1110"; --E
				end if;
			--4ms
			elsif sclk = "01111010000100100000" then 			
				--C4
				Col<= "0111";
			-- check row pins
			elsif sclk = "01111010000110000100" then 
				--R1
				if Row = "1110" then
					DecodeOut <= "1010"; --A
				--R2
				elsif Row = "1101" then
					DecodeOut <= "1011"; --B
				--R3
				elsif Row = "1011" then
					DecodeOut <= "1100"; --C
				--R4
				elsif Row = "0111" then
					DecodeOut <= "1101"; --D
				end if;
			end if;
			if sclk = "01111010000110000101" then
			sclk <= "00000000000000000000";	
			end if;
		end if;
	end process;
						 
end Behavioral;
