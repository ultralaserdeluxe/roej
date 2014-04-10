1library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register is
    Port ( clk,rst,load : in  STD_LOGIC;
           tal_in : in STD_LOGIC_VECTOR(15 downto 0);
           tal_ut : out  STD_LOGIC_VECTOR(15 downto 0));
end register;
architecture register_ar of register is

begin  -- register_ar
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        tal <= "0000000000000000";
      elsif load = '1' then
        tal_ut <= tal_in;
      end if;
    end if;
  end process;
end register_ar;
