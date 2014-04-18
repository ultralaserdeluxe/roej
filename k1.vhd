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
    WHEN  "00000"  =>  k1_out <= "00011101";
    WHEN  "00001"  =>  k1_out <= "00100010";
    WHEN  "00010"  =>  k1_out <= "00100100";
    WHEN OTHERS =>  k1_out <= "00000000";
  END CASE;

end k1_ar;
