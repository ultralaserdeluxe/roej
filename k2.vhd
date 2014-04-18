library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity k2 is    
  port (k2_in : in STD_LOGIC_VECTOR(2 downto 0);
		k2_out : out STD_LOGIC_VECTOR(7 downto 0);
end k2;  
architecture k1k2_ar of k1k2 is
begin

CASE k2 IS
    WHEN  "000"  =>  k2_out <= "00000100";
    WHEN  "001"  =>  k2_out <= "00011011";
    WHEN OTHERS =>  k2_out <= "00000000";
  END CASE;
  
end k2_ar;