library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sprite is

  port(
    clk : in std_logic;
    pixel_clk : in std_logic;
    rst : in std_logic;
    pixel_x_pos : in std_logic_vector(9 downto 0);
    pixel_y_pos : in std_logic_vector(9 downto 0);
    rgb_in : in std_logic_vector(7 downto 0);
    rgb_out : out std_logic_vector(7 downto 0));
    
end sprite;
    
architecture sprite_behv of sprite is

  component counter
    generic (
      n : integer);
    port (
      clk : in std_logic;
      reset : in  std_logic;
      enable : in  std_logic;
      value  : out std_logic_vector(n - 1 downto 0));
  end component;

  signal sprite_x_pos : std_logic_vector(9 downto 0) := "0000000001";
  signal sprite_y_pos : std_logic_vector(9 downto 0) := "0000000001";
  signal sprite_x_cnt : std_logic_vector(3 downto 0);
  signal sprite_y_cnt : std_logic_vector(3 downto 0);
  signal display_x : std_logic := '0';
  signal display_y : std_logic := '0';  
  signal display_sprite : std_logic := '0';
  signal x_cnt_enable : std_logic := '0';
  signal y_cnt_enable : std_logic := '0';

  type spritemem_t is array (0 to 255) of std_logic_vector(7 downto 0);
  signal spritemem : spritemem_t :=
    ("11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11011111","11011111","11011111","11011111","11011111","11011111","11011111","11011111","11011111","11011111","11011111","11011111","11011111","11011111","11011111","11011111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111",
     "11111111","11111111","11111111","11111111","11111111","11111111","11111111","11011111","11111111","11111111","11111111","11111111","11111111","11111111","11111111","11111111");

  signal sprite_rgb : std_logic_vector(7 downto 0);
  
begin

  sprite_x_counter : counter
    generic map (
      n => 4)
    port map (
      clk    => pixel_clk,
      reset  => rst,
      enable => x_cnt_enable,
      value  => sprite_x_cnt);

  sprite_y_counter : counter
    generic map (
      n => 4)
    port map (
      clk    => pixel_clk,
      reset  => rst,
      enable => y_cnt_enable,
      value  => sprite_y_cnt);

  display_x <= '1' when sprite_x_pos + sprite_x_cnt = pixel_x_pos else '0';
  x_cnt_enable <= display_x;
  
  display_y <= '1' when sprite_y_pos + sprite_y_cnt = pixel_y_pos else '0';
  y_cnt_enable <= '1' when display_y = '1' and sprite_x_cnt = "1111" else '0';

  display_sprite <= '1' when display_x = '1' and display_y = '1' else '0';

  sprite_rgb <= spritemem(conv_integer(sprite_y_cnt) * 16 + conv_integer(sprite_x_cnt));

  rgb_out <= sprite_rgb when display_sprite = '1' and sprite_rgb /= "11111111" else rgb_in;
  
end sprite_behv;