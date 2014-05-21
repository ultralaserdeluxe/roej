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
  
  k1_out <= "00111001" when k1_in = "00000" else  -- LDA
            "00111101" when k1_in = "00001" else  -- STA
            "00111111" when k1_in = "00010" else  -- ADDA
            "01000011" when k1_in = "00011" else  -- SUBA
            "01000111" when k1_in = "00100" else  -- INCA
            "01001001" when k1_in = "00101" else  -- DECA
            "01001011" when k1_in = "00110" else  -- LDX
            "01001101" when k1_in = "00111" else  -- STX
            "01001111" when k1_in = "01000" else  -- INX
            "01010100" when k1_in = "01001" else  -- DEX
            "01011001" when k1_in = "01010" else  -- LDS
            "01100010" when k1_in = "01011" else  -- LSLx4
            "01100000" when k1_in = "01100" else  -- INS
            "01100001" when k1_in = "01101" else  -- DES
            "01100111" when k1_in = "01110" else  -- PUSH
            "01101111" when k1_in = "01111" else  -- PULL
            "01111010" when k1_in = "10000" else  -- JMP
            "01111111" when k1_in = "10001" else  -- JMPN
            "10000101" when k1_in = "10010" else  -- JMPZ
            "10001011" when k1_in = "10011" else  -- JSR
            "10011001" when k1_in = "10100" else  -- RTS
            "11110010" when k1_in = "10101" else  -- XOR
            "10100001" when k1_in = "10110" else  -- LSR
            "10100011" when k1_in = "10111" else  -- LSL
            --"10100101" when k1_in = "11000" else  -- ASR
            --"10101010" when k1_in = "11001" else  -- ASL
            "10101111" when k1_in = "11010" else  -- ANDA
            "10110100" when k1_in = "11011" else  -- CMP
            "10111001" when k1_in = "11100" else  -- LDA16OMEDELBAR
            "11000011" when k1_in = "11101" else  -- STA16ABSOLUT(INDIREKT)
            "11010010" when k1_in = "11110" else  -- ADDA16OMEDELBAR
            "11011011" when k1_in = "11111" else  -- LDA16ABSOLUT(IDNIREKT)
            "11100100" when k1_in = "11000" else  -- ADD16ABSOLUT
            "11101101" when k1_in = "11001" else  -- ORA
            "00000000";

end k1_ar;
