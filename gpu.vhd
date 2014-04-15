library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gpu is

  port(
    clk : in std_logic;
    reset : in std_logic;
    vgaRed : out std_logic_vector(2 downto 0);
    vgaGreen : out std_logic_vector(2 downto 0);
    vgaBlue : out std_logic_vector(2 downto 1);
    Hsync : out std_logic;
    Vsync : out std_logic);
  
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

  -- Clock divider.
  
  signal pixel_counter_value : std_logic_vector(1 downto 0);
  signal pixel_clk : std_logic;


-- Pixel x-counter.
  
  signal x_value : std_logic_vector(9 downto 0) := "0000000000";
  constant x_max : std_logic_vector(9 downto 0) := "1100011111";  -- 799
  signal x_reset : std_logic;
  signal x_enable : std_logic;


  -- Pixel y-counter.
  
  signal y_value : std_logic_vector(9 downto 0) := "0000000000";
  constant y_max : std_logic_vector(9 downto 0) := "1000001000";  -- 520
  signal y_reset : std_logic;
  signal y_enable : std_logic;


  -- Sync-generator.

  signal h_sync : std_logic := '0';
  constant h_sync_fp : std_logic_vector(9 downto 0) := "1010000000";  -- 640
  constant h_sync_pw : std_logic_vector(9 downto 0) := "1010010000";  -- 656
  constant h_sync_bp : std_logic_vector(9 downto 0) := "1011110000";  -- 752
  signal v_sync : std_logic := '0';
  constant v_sync_fp : std_logic_vector(9 downto 0) := "0111100000";  -- 480
  constant v_sync_pw : std_logic_vector(9 downto 0) := "0111101010";  -- 490
  constant v_sync_bp : std_logic_vector(9 downto 0) := "0111101100";  -- 492
  signal display_valid : std_logic := '0';


  -- Map memory.

  component mapmem
    port(
      clk : in std_logic;
      addr_a_row : in std_logic_vector(5 downto 0);
      addr_a_col : in std_logic_vector(5 downto 0);
      data_a_out : out std_logic_vector(5 downto 0));
  end component;

  signal mapmem_data_a_out : std_logic_vector(5 downto 0);


  -- Tile memory.

  component tilemem
      port(
        row_base : in std_logic_vector(2 downto 0);
        row_offset : in std_logic_vector(3 downto 0);
        col_base : in std_logic_vector(2 downto 0);
        col_offset : in std_logic_vector(3 downto 0);
        data_out : out std_logic_vector(7 downto 0));
  end component;
  
  signal tilemem_data_out : std_logic_vector(7 downto 0);
  signal tilemem_col : std_logic_vector(2 downto 0);
  signal tilemem_row : std_logic_vector(2 downto 0);
  signal tilemem_x : std_logic_vector(3 downto 0);
  signal tilemem_y : std_logic_vector(3 downto 0);
  
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
      n => 10)
    port map (
      clk    => pixel_clk,
      reset  => x_reset,
      enable => x_enable,
      value  => x_value);

  x_reset <= '1' when x_value = x_max or reset = '1' else
             '0';
  x_enable <= '1';


  -- Pixel y-counter.
  
  y_counter : counter
    generic map (
      n => 10)
    port map (
      clk    => pixel_clk,
      reset  => y_reset,
      enable => y_enable,
      value  => y_value);

  y_reset <= '1' when y_value = y_max and x_value = x_max else
             '1' when reset = '1' else
             '0';
  y_enable <= '1' when x_reset = '1' else
              '0';


  -- Sync-generator.
  
  h_sync <= '1' when x_value >= h_sync_pw and x_value < h_sync_bp else
            '0';
  v_sync <= '1' when y_value >= v_sync_pw and y_value < v_sync_bp else
            '0';
  display_valid <= '1' when x_value < h_sync_fp and y_value < v_sync_fp else
                   '0';
  Hsync <= h_sync;
  Vsync <= v_sync;


  -- Map memory.

  map_memory : mapmem
    port map (
      clk => clk,
      addr_a_row  => y_value(9 downto 4),
      addr_a_col  => x_value(9 downto 4),
      data_a_out  => mapmem_data_a_out);

  
  -- Tile memory.
  
  tile_memory : tilemem
    port map (
      row_base => tilemem_row,
      row_offset => tilemem_y,
      col_base => tilemem_col,
      col_offset => tilemem_x,
      data_out => tilemem_data_out);

  tilemem_col <= mapmem_data_a_out(2 downto 0);
  tilemem_row <= mapmem_data_a_out(5 downto 3);
  tilemem_x <= x_value(3 downto 0);
  tilemem_y <= y_value(3 downto 0);  


  -- Connect VGA-port pins.
  
  vgaRed <= tilemem_data_out(7 downto 5) when display_valid = '1' else "000";
  vgaGreen <= tilemem_data_out(4 downto 2) when display_valid = '1' else "000";
  vgaBlue <= tilemem_data_out(1 downto 0) when display_valid = '1' else "00";         
  
end gpu_behv;
