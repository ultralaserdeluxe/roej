-- TestBench Template 

library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY gp_reg_8_tb IS
END gp_reg_8_tb;

architecture gp_reg_8_tb_ar of gp_reg_8_tb is
  component gp_reg_8
    port ( clk,rst,load : in std_logic;
           tal_in : STD_LOGIC_VECTOR(7 downto 0);
           tal_ut : out  STD_LOGIC_VECTOR(7 downto 0));
  end component;

  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal load : std_logic := '0';
  signal tal_in : std_logic_vector(7 downto 0);
  signal tal_ut : std_logic_vector(7 downto 0);
  signal tb_running : boolean := true;
  
begin  -- gp_reg_8_tb_ar

  uut : gp_reg_8 port map (
    clk => clk,
    rst => rst,
    load => load,
    tal_in => tal_in,
    tal_ut => tal_ut);

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
    variable i : integer;
  begin

    rst <= '1';
    load <= '0';
    
    wait for 100 ns;
    wait until rising_edge(clk);        -- se till att reset släpps synkront
    rst <= '0';                         -- med klockan
    report "Reset released" severity note;

    wait for 100 ns;
    wait until rising_edge(clk);
    tal_in <= "10010011";
    report "Tal skall ej in" severity note;

    wait for 100 ns;
    wait until rising_edge(clk);
    tal_in <= "00000000";
    report "Tal skall ej in" severity note;
     
    wait for 100 ns;
    wait until rising_edge(clk);
    load <= '1';
    report "Load high" severity note;

    wait for 100 ns;
    wait until rising_edge(clk);
    tal_in <= "10010011";
    report "Tal skall ej in" severity note;
    
    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  -- i
    
    tb_running <= false;                -- Stanna klockan (vilket medför att inga
                                        -- nya event genereras vilket stannar
                                        -- simuleringen).
    wait;
  end process;

end gp_reg_8_tb_ar;
