library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gp_reg_16 is
  Port ( clk,rst,load : in  STD_LOGIC;
         input : in STD_LOGIC_VECTOR(adr_buswidth-1 downto 0);
         output : out  STD_LOGIC_VECTOR(adr_buswidth-1 downto 0));
end gp_reg_16;
architecture gp_reg_16_ar of gp_reg_16 is
	signal value : std_logic_vector(adr_buswidth-1 downto 0);
begin  -- gp_reg_16_ar
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        value <= "0000000000000000";
      elsif load = '1' then
        value <= input;
      end if;
    end if;
	output <= value;
  end process;
end gp_reg_16_ar;
