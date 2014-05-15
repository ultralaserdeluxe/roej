library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity prng is

  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    value : out std_logic_vector(7 downto 0));
  
end prng;
    
architecture prng_ar of prng is

  component counter
    generic (
      n : integer);
    port (
      clk    : in  std_logic;
      reset  : in  std_logic;
      enable : in  std_logic;
      value  : out std_logic_vector(n - 1 downto 0));
  end component;

  signal counter_value : std_logic_vector(7 downto 0);
  signal reg_value : std_logic_vector(7 downto 0);
  
begin

  cnt : counter
    generic map (
      n => 8)
    port map (
      clk    => clk,
      reset  => '0',
      enable => '1',
      value  => counter_value);

  process(clk)
    begin
      if rising_edge(clk) then
        if rst = '1' then
          reg_value <= counter_value;
        else
          reg_value(7) <= (reg_value(0) xor reg_value(1)) xor reg_value(3);
          reg_value(6 downto 0) <= reg_value(7 downto 1);
        end if;
      end if;
    end process;

    value <= reg_value;
  
end prng_ar;
