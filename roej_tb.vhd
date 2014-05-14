library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity roej_tb is
end roej_tb;

architecture roej_tb_behv of roej_tb is

  component roej
  port(
    clk : in std_logic;
    rst : in std_logic;
    vgaRed : out std_logic_vector(2 downto 0);
    vgaGreen : out std_logic_vector(2 downto 0);
    vgaBlue : out std_logic_vector(2 downto 1);
    Hsync : out std_logic;
    Vsync : out std_logic);
  end component;

  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal tb_running : boolean := true;
  
begin  -- roej_tb_behv

  roej_out : roej
    port map (
      clk => clk,
      rst => rst);

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
  
    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  -- i
    
    tb_running <= false;
  end process;

end roej_tb_behv;
