library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity k1 is    
  port (k1_in : in STD_LOGIC_VECTOR(4 downto 0);
		k1_out : out STD_LOGIC_VECTOR(7 downto 0);
end k1;  
architecture k1_ar of k1 is
begin
  CASE k1 IS 
    WHEN  "00000"  =>  k1_out <= "00011110"; -- LDA
    WHEN  "00001"  =>  k1_out <= "00100010"; -- STA
    WHEN  "00010"  =>  k1_out <= "00100100"; -- ADDA
	WHEN  "00011"  =>  k1_out <= "00101000"; -- SUBA
	WHEN  "00010"  =>  k1_out <= "00101100"; -- INCA
	WHEN  "00010"  =>  k1_out <= "00101110"; -- DECA
	WHEN  "00010"  =>  k1_out <= "00110000"; -- LDX
	WHEN  "00010"  =>  k1_out <= "00110010"; -- STX
	WHEN  "00010"  =>  k1_out <= "00110100"; -- INX
	WHEN  "00010"  =>  k1_out <= "00111001"; -- DEX
	WHEN  "00010"  =>  k1_out <= "00111110"; -- LDS
	WHEN  "00010"  =>  k1_out <= "01000000"; -- STS
	WHEN  "00010"  =>  k1_out <= "01000010"; -- INS
	WHEN  "00010"  =>  k1_out <= "01000011"; -- DES
	WHEN  "00010"  =>  k1_out <= "01000100"; -- PUSH
	WHEN  "00010"  =>  k1_out <= "01000111"; -- PULL
	WHEN  "00010"  =>  k1_out <= "01001101"; -- JMP
	WHEN  "00010"  =>  k1_out <= "01001110"; -- JMPN
	WHEN  "00010"  =>  k1_out <= "01001111"; -- JMPZ
	WHEN  "00010"  =>  k1_out <= "01010000"; -- JSR
	WHEN  "00010"  =>  k1_out <= "01010011"; -- RTS
    WHEN OTHERS =>  k1_out <= "00000000";
  END CASE;

end k1_ar;
