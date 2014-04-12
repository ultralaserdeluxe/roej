library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is
  
  generic (
  n : integer);
  port(
    clk : in std_logic;
    reset : in std_logic;
    enable : in std_logic;
    value : out std_logic_vector(n - 1 downto 0));
--    value : out std_logic_vector(10 - 1 downto 0));
  
end counter;
    
architecture counter_ar of counter is
  
  signal count : std_logic_vector(n - 1 downto 0);
--  signal count : std_logic_vector(10 - 1 downto 0);  
  signal init : std_logic := '0';
  
begin  -- counter_ar
  
  process(clk) is
  begin
    if rising_edge(clk) then
      if init = '0' then
        count <= (count'range => '0');
        init <= '1';
      elsif reset = '1' then
        count <= (count'range => '0');
      elsif enable = '1' then
        count <= count + 1;  
      end if;
    end if;
  end process;
  
  value <= count;
  
end counter_ar;
