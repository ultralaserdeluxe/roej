library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gp_reg_8 is
  Port ( clk,rst,load : in  STD_LOGIC;
         tal_in : in STD_LOGIC_VECTOR(7 downto 0);
         tal_ut : out  STD_LOGIC_VECTOR(7 downto 0));
end gp_reg_8;
architecture gp_reg_8_ar of gp_reg_8 is

begin  -- gp_reg_8_ar
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        tal_ut <= "00000000";
      elsif load = '1' then
        tal_ut <= tal_in;
      end if;
    end if;
  end process;
end gp_reg_8_ar;
