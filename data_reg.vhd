library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity data_reg is
  Port ( clk,rst,load,double_read_signal : in  STD_LOGIC;
         input : in STD_LOGIC_VECTOR(adr_buswidth-1 downto 0);
         output : out  STD_LOGIC_VECTOR(adr_buswidth-1 downto 0));
end data_reg;
architecture data_reg_ar of data_reg is
	signal reg_value : std_logic_vector(adr_buswidth-1 downto 0);
begin  -- data_reg_ar
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        reg_value <= "0000000000000000";
      elsif load = '1' then
        reg_value(7 downto 0) <= input(7 downto 0);
      elsif double_read_signal = '1' then
        reg_value(15 downto 8) <= reg_value(7 downto 0);
      end if;
    end if;
  end process;
  output <= reg_value;
end data_reg_ar;
