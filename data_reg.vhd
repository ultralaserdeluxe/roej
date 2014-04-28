library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity data_reg is
  Port ( clk,rst,load,to_db,read_signal,write_signal : in  STD_LOGIC;
		 data_bus : inout STD_LOGIC_VECTOR(buswidth-1 downto 0);
         input : in STD_LOGIC_VECTOR(buswidth-1 downto 0);
         output : out  STD_LOGIC_VECTOR(buswidth-1 downto 0));
end data_reg;
architecture data_reg_ar of data_reg is

signal value_signal : STD_LOGIC_VECTOR(buswidth-1 downto 0);

begin  -- data_reg_ar
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        value_signal <= "00000000";
      elsif load = '1' then
        value_signal <= input;
      elsif to_db = '1' then
		if read_signal = '1' then
			value_signal <= data_bus;
		elsif write_signal = '1' then
			data_bus <= value_signal;
		end if;
      end if;
    end if;
	output <= value_signal;
  end process;
end data_reg_ar;
