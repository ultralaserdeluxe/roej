library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gp_reg_8 is
  Port ( clk,rst,load,inc,dec : in  STD_LOGIC;
         input : in STD_LOGIC_VECTOR(7 downto 0);
         output : out  STD_LOGIC_VECTOR(7 downto 0));
end gp_reg_8;
architecture gp_reg_8_ar of gp_reg_8 is
	signal reg_value : std_logic_vector(7 downto 0);
begin  -- gp_reg_8_ar
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        reg_value <= "00000000";
      elsif load = '1' then
        reg_value <= input;
      elsif inc = '1' then
        reg_value <= reg_value + '1';
      elsif dec = '1' then
        reg_value <= reg_value - '1';
      end if;
    end if;
  end process;
  output <= reg_value;
end gp_reg_8_ar;
