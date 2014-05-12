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
    data_bus_out : out std_logic_vector(buswidth-1 downto 0);
    data_bus_in : in std_logic_vector(buswidth-1 downto 0);
    read_signal : out std_logic;
    write_signal : out std_logic);
  end component;
  
  --component primmem
  --port(
  --  clk : in std_logic;
  --  adr_bus : in std_logic_vector(15 downto 0);
  --  data_bus_in : in std_logic_vector(buswidth-1 downto 0);
  --  data_bus_out : out std_logic_vector(buswidth-1 downto 0);
  --  read_signal : in std_logic;
  --  write_signal : in std_logic);
  --end component;

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
  
  signal adr_bus_connect : std_logic_vector(adr_buswidth-1 downto 0);
  signal data_bus_out_connect : std_logic_vector(buswidth-1 downto 0);
  signal data_bus_in_connect : std_logic_vector(buswidth-1 downto 0) := "00000000";
  signal read_signal_connect : std_logic;
  signal write_signal_connect : std_logic;

  signal write_enable_gpu : std_logic;
  signal write_enable_mem : std_logic;

  signal sprite_x_pos : std_logic_vector(9 downto 0) := "0000100000";
  signal sprite_y_pos : std_logic_vector(9 downto 0) := "0000100000";
    
  type memory_type is array (0 to 4095) of std_logic_vector(7 downto 0);
  signal memory : memory_type := ("00000000", others => ("00000000"));
  
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
  
  --primmem_comp : primmem
  --port map(
  --  clk => clk,
  --  adr_bus => adr_bus_connect,
  --  data_bus_in => data_bus_out_connect,
  --  data_bus_out => data_bus_in_connect,
  --  read_signal => read_signal_connect,
  --  write_signal => write_signal_connect);

  gpu_comp : gpu
    port map (
      clk => clk,
      rst => rst,
      vgaRed => vgaRed,
      vgaGreen => vgaGreen,
      vgaBlue => vgaBlue,
      Hsync => Hsync,
      Vsync => Vsync,
      address => adr_bus_connect,
      data_in => data_bus_out_connect,
      w_enable => write_enable_gpu,
      sprite_x_pos => sprite_x_pos,
      sprite_y_pos => sprite_y_pos);

  data_bus_in_connect <= memory(conv_integer(adr_bus_connect)) when conv_integer(adr_bus_connect) <= 4095 else "00000000";

  write_enable_mem <= '1' when (conv_integer(adr_bus_connect) <= 4095 and
                                write_signal_connect = '1') else
                      '0';

  write_enable_gpu <= '1' when (conv_integer(adr_bus_connect) > 4095 and
                                conv_integer(adr_bus_connect) <= 8192 and
                                write_signal_connect = '1') else
                      '0';

  process(clk)
  begin
    if rising_edge(clk) then
      if write_enable_mem = '1' then
        memory(conv_integer(adr_bus_connect)) <= data_bus_out_connect;
      end if;
    end if;
  end process;
  
END;
