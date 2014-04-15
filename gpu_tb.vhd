library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gpu_tb is
end gpu_tb;

architecture gpu_tb_behv of gpu_tb is

  component gpu
  port(
    clk : in std_logic;
    reset : in std_logic;
    vgaRed : out std_logic_vector(2 downto 0);
    vgaGreen : out std_logic_vector(2 downto 0);
    vgaBlue : out std_logic_vector(2 downto 1);
    Hsync : out std_logic;
    Vsync : out std_logic;
    addr_col : in std_logic_vector(7 downto 0);
    addr_row : in std_logic_vector(7 downto 0);
    data_in : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0);    
    write_enable : in std_logic);
  end component;

  signal clk : std_logic := '0';
  signal reset : std_logic := '0';
  signal tb_running : boolean := true;

  signal a_c : std_logic_vector(7 downto 0);
  signal a_r : std_logic_vector(7 downto 0);
  signal d_i : std_logic_vector(7 downto 0);
  signal d_o : std_logic_vector(7 downto 0);
  signal w_e : std_logic := '0';
  
begin  -- gpu_tb_behv

  gpu_out : gpu
    port map (
      clk => clk,
      reset => reset,
      addr_col => a_c,
      addr_row => a_r,
      data_in => d_i,
      data_out => d_o,      
      write_enable => w_e);


  clk_gen : process
  begin
    while tb_running loop
      clk <= '0';
      wait for 5 ns;
      clk <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process;

  stimuli_gen : process
  begin
    reset <= '0';

    wait for 100 ns;
    wait until rising_edge(clk);
    reset <= '0';

    wait for 100 ns;
    wait until rising_edge(clk);
    a_c <= "00000001";
    a_r <= "00000000";
    d_i <= "00000001";
    w_e <= '1';

    wait for 100 ns;
    wait until rising_edge(clk);
    w_e <= '0';

    wait for 100 ns;
    wait until rising_edge(clk);
    a_c <= "00000000";
    a_r <= "00000001";
    d_i <= "00001001";
    w_e <= '1';

    wait for 100 ns;
    wait until rising_edge(clk);
    a_c <= "00000001";
    a_r <= "00000010";
    w_e <= '0';
    
    

    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  -- i
    
    tb_running <= false;
  end process;

end gpu_tb_behv;
