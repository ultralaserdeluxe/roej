library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity realtime_counter is
  port(
    clk : in std_logic;
    reset : in std_logic;
    enable : in std_logic;
    single_out : out std_logic_vector (7 downto 0);
    ten_out : out std_logic_vector(7 downto 0);
    hundred_out : out std_logic_vector(7 downto 0));
  
end realtime_counter;

architecture realtime_counter_ar of realtime_counter is

  signal single_reset : std_logic;
  signal ten_reset : std_logic;
  signal hundred_reset : std_logic;
  signal clock_reset : std_logic;
  signal clock_value : std_logic_vector(28 downto 0);
  signal single_value : std_logic_vector(3 downto 0);
  signal ten_value : std_logic_vector(3 downto 0);
  signal hundred_value : std_logic_vector(3 downto 0);
  
begin
    
  process(clk) is
  begin
    if rising_edge(clk) then
      if reset = '1' then
        clock_value <= "00000000000000000000000000000";
        single_value <= "0000";
        ten_value <= "0000";
        hundred_value <= "0000";
      elsif hundred_reset = '1' then
        hundred_value <= "0000";
        ten_value <= "0000";
        single_value <= "0000";
        clock_value <= "00000000000000000000000000000";
      elsif ten_reset = '1' then
        ten_value <= "0000";
        single_value <= "0000";
        clock_value <= "00000000000000000000000000000";
        hundred_value <= hundred_value + 1;
      elsif single_reset = '1' then
        single_value <= "0000";
        clock_value <= "00000000000000000000000000000";
        ten_value <= ten_value + 1;
      elsif clock_reset = '1' then
        clock_value <= "00000000000000000000000000000";
        single_value <= single_value + 1;
      elsif enable = '1' then
        clock_value <= clock_value + 1;
      end if;
    end if;
  end process;
    
  clock_reset <= '1' when clock_value = "101111101011110000100000000" else '0';
  single_reset <= '1' when single_value = "1001" and clock_reset = '1' else '0';
  ten_reset <= '1' when ten_value = "1001" and single_reset = '1' else '0';
  hundred_reset <= '1' when hundred_value = "1001" and ten_reset = '1' else '0';
 
  hundred_out <= "0000" & hundred_value;
  single_out <= "0000" & single_value;
  ten_out <= "0000" & ten_value;
  
     --101111101011110000100000000             -- HUNDRA MILJONER
end realtime_counter_ar;
