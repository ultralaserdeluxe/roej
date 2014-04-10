library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gpu is

  port(
    clk : in std_logic);
  
end gpu;
    
architecture gpu_behv of gpu is

  component counter
    generic (
      pixels : integer);
    port (
      clk, reset, enable : in  std_logic;
      value              : out std_logic_vector(9 downto 0));
  end component;

  signal x_value : std_logic_vector(9 downto 0);
  signal y_value : std_logic_vector(9 downto 0);
  signal y_enable : std_logic;
  
begin

  x_counter : counter
    generic map (
      pixels => 10)
    port map (
      clk    => clk,
      reset  => '0',
      enable => '1',
      value  => x_value);

  y_counter : counter
    generic map (
      pixels => 10)
    port map (
      clk    => clk,
      reset  => '0',
      enable => '1',
      value  => y_value);

  y_enable <= '1' when x_value = "101" else
              '0';
    
end gpu_behv;
