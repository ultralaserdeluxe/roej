library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gpu_tb is
end gpu_tb;

architecture gpu_tb_behv of gpu_tb is

  component gpu
    port(
      clk : in std_logic);
  end component;

  signal clk : std_logic := '0';
  signal tb_running : boolean := true;
  
begin  -- gpu_tb_behv

  uut : gpu
    port map (
      clk => clk);

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


end gpu_tb_behv;
