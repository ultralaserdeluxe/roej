library IEEE;
use work.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity k1 is    
  port (k1_in : in STD_LOGIC_VECTOR(4 downto 0);
		k1_out : out STD_LOGIC_VECTOR(buswidth-1 downto 0));
end k1;  
architecture k1_ar of k1 is
begin
  
  k1_out <= "00011110" when k1_in = "00000" else 	-- LDA
			"00100010" when k1_in = "00001" else 	-- STA
			"00100100" when k1_in = "00010" else 	-- ADDA
			"00101000" when k1_in = "00011" else 	-- SUBA
			"00101100" when k1_in = "00100" else 	-- INCA
			"00101110" when k1_in = "00101" else 	-- DECA
			"00110000" when k1_in = "00110" else 	-- LDX
			"00110010" when k1_in = "00111" else 	-- STX
			"00110100" when k1_in = "01000" else 	-- INX
			"00111001" when k1_in = "01001" else 	-- DEX
			"00111110" when k1_in = "01010" else 	-- LDS
			"01000000" when k1_in = "01011" else 	-- STS
			"01000010" when k1_in = "01100" else 	-- INS
			"01000011" when k1_in = "01101" else 	-- DES
			"01000100" when k1_in = "01110" else 	-- PUSH
			"01000111" when k1_in = "01111" else 	-- PULL
			"01001101" when k1_in = "10000" else 	-- JMP
			"01001110" when k1_in = "10001" else 	-- JMPN
			"01001111" when k1_in = "10010" else 	-- JMPZ
			"01010000" when k1_in = "10011" else 	-- JSR
			"01010011" when k1_in = "10100" else 	-- RTS
			"00000000";

end k1_ar;
