library IEEE;
use work.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity k2 is    
  port (k2_in : in STD_LOGIC_VECTOR(2 downto 0);
		k2_out : out STD_LOGIC_VECTOR(7 downto 0));
end k2;  
architecture k2_ar of k2 is
begin
  
  k2_out <= "00001010" when k2_in = "000" else 	-- absolut
            "00010100" when k2_in = "001" else 	-- indirekt
            "00100000" when k2_in = "010" else 	-- indexerad
            "00101101" when k2_in = "011" else 	-- relativ
            "00111010" when k2_in = "100" else 	-- omedelbar
            "01000001" when k2_in = "101" else 	-- underförstådd
            "00000000";
  
end k2_ar;
