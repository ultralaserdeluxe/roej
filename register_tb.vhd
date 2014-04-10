-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_tb IS
END register_tb;

architecture register_tb_ar of register_tb is
  component register
    port ( clk,rst,load : in std_logic;
           tal_in : STD_LOGIC_VECTOR(15 downto 0);
           tal_ut : out  STD_LOGIC_VECTOR(15 downto 0));
  end component;
begin  -- register_tb_ar

  uut : lab port map (
    clk => clk,
    rst => rst,
    load => load,
    tal_in => tal_in,
    tal_ut => tal_ut);

  clk_gen : process
  begin
    while tb running loop loop
      clk <= '0';
      wait for 5 ns;;
      clk <= '1';
      wait for 5 ns;
    end loop;
    wait
  end process; 

end register_tb_ar;
