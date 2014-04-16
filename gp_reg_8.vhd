library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gp_reg_8 is
  Port ( clk,rst,load,inc,dec : in  STD_LOGIC;
         input : in STD_LOGIC_VECTOR(7 downto 0);
         output : out  STD_LOGIC_VECTOR(7 downto 0));
end gp_reg_8;
architecture gp_reg_8_ar of gp_reg_8 is

begin  -- gp_reg_8_ar
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
<<<<<<< HEAD
        output <= "00000000";
=======
        tal_ut <= "00000000";
>>>>>>> 1c219ad54cb26ddb0be298b13cc071fa25f3e9a9
      elsif load = '1' then
        output <= input;
      elsif inc = '1' then
        output <= output + '1'
      elsif dec = '1' then
        output <= output - '1'  
      end if;
    end if;
  end process;
end gp_reg_8_ar;
