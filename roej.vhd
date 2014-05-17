LIBRARY ieee;
use work.constants.all;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

ENTITY roej IS

    port(
    clk : in std_logic;
    rst : in std_logic;
    vgaRed : out std_logic_vector(2 downto 0);
    vgaGreen : out std_logic_vector(2 downto 0);
    vgaBlue : out std_logic_vector(2 downto 1);
    Hsync : out std_logic;
    Vsync : out std_logic);
  
END roej;

ARCHITECTURE behavior OF roej IS 

  component cpu
  port(
    clk : in std_logic;
    rst : in std_logic;
    adr_bus : out std_logic_vector(adr_buswidth-1 downto 0);
    data_bus_out : out std_logic_vector(7 downto 0);
    data_bus_in : in std_logic_vector(7 downto 0);
    read_signal : out std_logic;
    write_signal : out std_logic);
  end component;
  
  component primmem
  port(
    clk : in std_logic;
    adr_bus : in std_logic_vector(15 downto 0);
    data_bus_in : in std_logic_vector(7 downto 0);
    data_bus_out : out std_logic_vector(7 downto 0);
    read_signal : in std_logic;
    write_signal : in std_logic);
  end component;

  component gpu
  port(
    clk : in std_logic;
    rst : in std_logic;
    vgaRed : out std_logic_vector(2 downto 0);
    vgaGreen : out std_logic_vector(2 downto 0);
    vgaBlue : out std_logic_vector(2 downto 1);
    Hsync : out std_logic;
    Vsync : out std_logic;
    address : in std_logic_vector(15 downto 0);
    data_in : in std_logic_vector(7 downto 0);
    w_enable : in std_logic;
    sprite_x_pos : in std_logic_vector(9 downto 0);
    sprite_y_pos : in std_logic_vector(9 downto 0));
  end component;

  component prng
    port (
      clk   : in  std_logic;
      rst   : in  std_logic;
      value : out std_logic_vector(7 downto 0));
  end component;

  component realtime_counter
    port(
    clk : in std_logic;
    reset : in std_logic;
    enable : in std_logic;
    single_out : out std_logic_vector (7 downto 0);
    ten_out : out std_logic_vector(7 downto 0);
    hundred_out : out std_logic_vector(7 downto 0));
  end component;
  
  signal adr_bus_connect : std_logic_vector(adr_buswidth-1 downto 0);
  signal data_bus_out_connect : std_logic_vector(7 downto 0);
  signal data_bus_in_connect : std_logic_vector(7 downto 0) := "00000000";
  signal read_signal_connect : std_logic;
  signal write_signal_connect : std_logic;
  signal memory_connect : std_logic_vector(7 downto 0);
  signal mem_address : std_logic_vector(15 downto 0);

  signal write_enable_gpu : std_logic;
  signal gpu_address : std_logic_vector(15 downto 0);  
  signal write_enable_mem : std_logic;

  signal sprite_x_pos : std_logic_vector(9 downto 0) := "0000100000";
  signal sprite_y_pos : std_logic_vector(9 downto 0) := "0000100000";

  signal prng_value : std_logic_vector(7 downto 0);

  signal single_value : std_logic_vector(7 downto 0);
  signal ten_value : std_logic_vector(7 downto 0);
  signal hundred_value : std_logic_vector(7 downto 0);

  signal vsync_connect : std_logic;

BEGIN

  cpu_comp : cpu
  port map(
    clk => clk,
    rst => rst,
    adr_bus => adr_bus_connect,
    data_bus_out => data_bus_out_connect,
    data_bus_in => data_bus_in_connect,	
    read_signal => read_signal_connect,
    write_signal => write_signal_connect);
  
  primmem_comp : primmem
  port map(
    clk => clk,
    adr_bus => mem_address,
    data_bus_in => data_bus_out_connect,
    data_bus_out => memory_connect,
    read_signal => read_signal_connect,
    write_signal => write_enable_mem);

  gpu_comp : gpu
    port map (
      clk => clk,
      rst => rst,
      vgaRed => vgaRed,
      vgaGreen => vgaGreen,
      vgaBlue => vgaBlue,
      Hsync => Hsync,
      Vsync => vsync_connect,
      address => gpu_address,
      data_in => data_bus_out_connect,
      w_enable => write_enable_gpu,
      sprite_x_pos => sprite_x_pos,
      sprite_y_pos => sprite_y_pos);

  Vsync <= vsync_connect;

  prng_comp : prng
    port map (
      clk   => clk,
      rst   => rst,
      value => prng_value);

  timer : realtime_counter
    port map (
      clk => clk,
      reset => rst,
      enable => '1',
      single_out => single_value,
      ten_out => ten_value,
      hundred_out => hundred_value);
    
  data_bus_in_connect <= memory_connect when conv_integer(adr_bus_connect) <= 4095 else
                         prng_value when conv_integer(adr_bus_connect) = 8193 else
                         single_value when conv_integer(adr_bus_connect) = 8198 else
                         ten_value when conv_integer(adr_bus_connect) = 8199 else
                         hundred_value when conv_integer(adr_bus_connect) = 8200 else
                         "0000000" & vsync_connect when conv_integer(adr_bus_connect) = 8201 else
                         "00000000";

  write_enable_mem <= '1' when (conv_integer(adr_bus_connect) <= 4095 and
                                write_signal_connect = '1') else
                      '0';

  write_enable_gpu <= '1' when (conv_integer(adr_bus_connect) > 4095 and
                                conv_integer(adr_bus_connect) <= 8192 and
                                write_signal_connect = '1') else
                      '0';

  gpu_address <= adr_bus_connect - 4096;

  mem_address <= adr_bus_connect when conv_integer(adr_bus_connect) <= 4095 else "0000000000000000";

END;
