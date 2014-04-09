library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gpu is
end gpu;
    
architecture gpu_behv of gpu is

  component counter
    generic (
      pixels : integer);
    port (
      clk, reset, enable : in  std_logic;
      value              : out std_logic_vector(9 downto 0));
  end component;

  signal clk : std_logic := '0';
  signal x_value : std_logic_vector(9 downto 0);
  
begin

  x_counter : counter
    generic map (pixels => 10)
    port map (
      clk    => clk,
      reset  => '0',
      enable => '1',
      value  => x_value);
  
end gpu_behv;
