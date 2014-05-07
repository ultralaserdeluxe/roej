LIBRARY ieee;
use work.constants.all;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY cpu_tb IS
END cpu_tb;

ARCHITECTURE behavior OF cpu_tb IS 

  -- Component Declaration
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
  
  component primmem
  port(
	 clk : in std_logic;
	 adr_bus : in std_logic_vector(15 downto 0);
	 data_bus_in : in std_logic_vector(buswidth-1 downto 0);
	 data_bus_out : out std_logic_vector(buswidth-1 downto 0);
	 read_signal : in std_logic;
	 write_signal : in std_logic);
  end component;
  
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal adr_bus_connect : std_logic_vector(adr_buswidth-1 downto 0);
  signal data_bus_out_connect : std_logic_vector(buswidth-1 downto 0);
  signal data_bus_in_connect : std_logic_vector(buswidth-1 downto 0);
  signal read_signal_connect : std_logic;
  signal write_signal_connect : std_logic;
  signal tb_running : boolean := true;
  
BEGIN

	

  -- Component Instantiation
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
	adr_bus => adr_bus_connect,
	data_bus_in => data_bus_out_connect,
	data_bus_out => data_bus_in_connect,
	read_signal => read_signal_connect,
	write_signal => write_signal_connect);
  
  clk_gen : process
  begin
    while tb_running loop
      clk <= '0';
      wait for 20 ns;
      clk <= '1';
      wait for 20 ns;
    end loop;
    wait;
  end process;

  stimuli_generator : process
  
  begin
  rst <= '0';
  wait for 40 ns;
  rst <= '1';
  wait for 400 ns;
  rst <= '0';
  wait for 40 ns;
	
    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  

    
  end process;
END;
