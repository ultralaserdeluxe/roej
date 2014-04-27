library IEEE;
use work.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity k1 is    
  port (k1_in : in STD_LOGIC_VECTOR(4 downto 0);
		k1_out : out STD_LOGIC_VECTOR(buswidth-1 downto 0);
end k1;  
architecture k1_ar of k1 is
begin
  CASE k1_in IS 
    WHEN  "00000"  =>  k1_out <= "00011110"; -- LDA
    WHEN  "00001"  =>  k1_out <= "00100010"; -- STA
    WHEN  "00010"  =>  k1_out <= "00100100"; -- ADDA
	WHEN  "00011"  =>  k1_out <= "00101000"; -- SUBA
	WHEN  "00100"  =>  k1_out <= "00101100"; -- INCA
	WHEN  "00101"  =>  k1_out <= "00101110"; -- DECA
	WHEN  "00110"  =>  k1_out <= "00110000"; -- LDX
	WHEN  "00111"  =>  k1_out <= "00110010"; -- STX
	WHEN  "01000"  =>  k1_out <= "00110100"; -- INX
	WHEN  "01001"  =>  k1_out <= "00111001"; -- DEX
	WHEN  "01010"  =>  k1_out <= "00111110"; -- LDS
	WHEN  "01011"  =>  k1_out <= "01000000"; -- STS
	WHEN  "01100"  =>  k1_out <= "01000010"; -- INS
	WHEN  "01101"  =>  k1_out <= "01000011"; -- DES
	WHEN  "01110"  =>  k1_out <= "01000100"; -- PUSH
	WHEN  "01111"  =>  k1_out <= "01000111"; -- PULL
	WHEN  "10000"  =>  k1_out <= "01001101"; -- JMP
	WHEN  "10001"  =>  k1_out <= "01001110"; -- JMPN
	WHEN  "10010"  =>  k1_out <= "01001111"; -- JMPZ
	WHEN  "10011"  =>  k1_out <= "01010000"; -- JSR
	WHEN  "10100"  =>  k1_out <= "01010011"; -- RTS
	--WHEN  "10101"  =>  k1_out <= "01010011"; -- 
	--WHEN  "10110"  =>  k1_out <= "01010011"; -- 
	--WHEN  "10111"  =>  k1_out <= "01010011"; -- 
	--WHEN  "11000"  =>  k1_out <= "01010011"; -- 
	--WHEN  "11001"  =>  k1_out <= "01010011"; -- 
	--WHEN  "11010"  =>  k1_out <= "01010011"; -- 
	--WHEN  "11011"  =>  k1_out <= "01010011"; -- 
	--WHEN  "11100"  =>  k1_out <= "01010011"; -- 
	--WHEN  "11101"  =>  k1_out <= "01010011"; -- 
	--WHEN  "11110"  =>  k1_out <= "01010011"; -- 
	--WHEN  "11111"  =>  k1_out <= "01010011"; -- 	
    WHEN OTHERS =>  k1_out <= "00000000";
  END CASE;

end k1_ar;
