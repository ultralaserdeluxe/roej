library IEEE;
use work.constants.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity k3 is    
  port (mm_signal: in std_logic_vector(1 to 40);
        input: in std_logic_vector(buswidth-1 downto 0);
        k3_out : out STD_LOGIC_VECTOR(buswidth-1 downto 0);
        sr_input : in std_logic_vector(7 downto 0);
        pc_input : in std_logic_vector(buswidth-1 downto 0));
end k3;  
architecture k3_ar of k3 is
begin
  k3_out <= input when mm_signal(14)='1' and 
            ((sr_input(6)='1' and mm_signal(15)='1') or
             (sr_input(7)='1' and mm_signal(16)='1')) else pc_input;	  	-- k3 output
  
end k3_ar;
