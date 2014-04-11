library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gpu is

  port(
    clk : in std_logic;
    reset : in std_logic);
  
end gpu;
    
architecture gpu_behv of gpu is

  component counter
    generic (
      n : integer);
    port (
      clk : in std_logic;
      reset : in  std_logic;
      enable : in  std_logic;
      value  : out std_logic_vector(n - 1 downto 0));
  end component;

  signal pixel_counter_value : std_logic_vector(1 downto 0);
  signal pixel_clk : std_logic;
  
  signal x_value : std_logic_vector(7 downto 0) := "00000000";
  signal x_reset : std_logic;
  signal x_enable : std_logic;
  
  signal y_value : std_logic_vector(7 downto 0) := "00000000";
  signal y_reset : std_logic;
  signal y_enable : std_logic;
  
begin

  -- Clock divider for pixel clock.
  -- pixel_clk = clk / 4 (100MHz => 25 MHz)
  
  pixel_counter : counter
    generic map (
      n => 2)
    port map (
      clk    => clk,
      reset  => reset,
      enable => '1',
      value  => pixel_counter_value);

  pixel_clk <= pixel_counter_value(1);


  -- Pixel x-counter.
  
  x_counter : counter
    generic map (
      n => 8)
    port map (
      clk    => pixel_clk,
      reset  => x_reset,
      enable => x_enable,
      value  => x_value);

  x_reset <= '1' when x_value = "11" or reset = '1' else
             '0';
  x_enable <= '1';


  -- Pixel y-counter.
  
  y_counter : counter
    generic map (
      n => 8)
    port map (
      clk    => pixel_clk,
      reset  => y_reset,
      enable => y_enable,
      value  => y_value);

  y_reset <= '1' when y_value = "11" and x_value = "11" or reset = '1' else
             '0';
  y_enable <= '1' when x_reset = '1' else
              '0';
      
end gpu_behv;
