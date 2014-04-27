library IEEE;
use work.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity k2 is    
  port (k2_in : in STD_LOGIC_VECTOR(2 downto 0);
		k2_out : out STD_LOGIC_VECTOR(buswidth-1 downto 0);
end k2;  
architecture k2_ar of k2 is
begin

CASE k2_in IS
    WHEN  "000"  =>  k2_out <= "00000100"; -- absolut
	WHEN  "001"  =>  k2_out <= "00000111"; -- indirekt
	WHEN  "010"  =>  k2_out <= "00001100"; -- indexerad
	WHEN  "011"  =>  k2_out <= "00010011"; -- relativ
    WHEN  "100"  =>  k2_out <= "00011011"; -- omedelbar
	WHEN  "101"  =>  k2_out <= "00011101"; -- underförstådd
  END CASE;
  
end k2_ar;