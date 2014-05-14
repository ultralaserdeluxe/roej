library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity prng_tb is
end prng_tb;

architecture prng_tb_behv of prng_tb is

  component prng
  port(
    clk : in std_logic;
    rst : in std_logic;
    value : out std_logic_vector(7 downto 0));
  end component;

  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal value : std_logic_vector(7 downto 0);
  signal tb_running : boolean := true;
  
begin  -- prng_tb_behv

  prng_out : prng
    port map (
      clk   => clk,
      rst   => rst,
      value => value);

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
    rst <= '1';
    wait for 100 ns;
    wait until rising_edge(clk);
    
    rst <= '0';
    wait for 100 ns;
    wait until rising_edge(clk);

    rst <= '1';
    wait for 100 ns;
    wait until rising_edge(clk);

    rst <= '0';
    wait for 100 ns;
    wait until rising_edge(clk);
  
    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  -- i
    
    tb_running <= false;
  end process;

end prng_tb_behv;
