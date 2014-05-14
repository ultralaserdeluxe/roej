library IEEE;
use work.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity k1 is    
  port (k1_in : in STD_LOGIC_VECTOR(4 downto 0);
		k1_out : out STD_LOGIC_VECTOR(7 downto 0));
end k1;  
architecture k1_ar of k1 is
begin
  
  k1_out <= "01000111" when k1_in = "00000" else 	-- LDA
            "01010000" when k1_in = "00001" else 	-- STA
            "01010111" when k1_in = "00010" else 	-- ADDA
            "01100000" when k1_in = "00011" else 	-- SUBA
            "01101001" when k1_in = "00100" else 	-- INCA
            "01110000" when k1_in = "00101" else 	-- DECA
            "01110111" when k1_in = "00110" else 	-- LDX
            "01111110" when k1_in = "00111" else 	-- STX
            "10000101" when k1_in = "01000" else 	-- INX
            "10001111" when k1_in = "01001" else 	-- DEX
            "10011001" when k1_in = "01010" else 	-- LDS
            "10100000" when k1_in = "01011" else 	-- STS
            "10100110" when k1_in = "01100" else 	-- INS
            "10101100" when k1_in = "01101" else 	-- DES
            "10110010" when k1_in = "01110" else 	-- PUSH
            "10111010" when k1_in = "01111" else 	-- PULL
            "11000101" when k1_in = "10000" else 	-- JMP
            "11001100" when k1_in = "10001" else 	-- JMPN
            "11010010" when k1_in = "10010" else 	-- JMPZ
            "11011000" when k1_in = "10011" else 	-- JSR
            "11100001" when k1_in = "10100" else 	-- RTS
            "11101001" when k1_in = "10101" else        -- HH
            "00000000";

end k1_ar;
