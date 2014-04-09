-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY counter_tb IS
END counter_tb;

ARCHITECTURE behavior OF counter_tb IS 

  -- Component Declaration
  COMPONENT counter
    generic(n : integer);
    PORT(
      clk,reset, enable : IN std_logic;
      value : out std_logic_vector(7 downto 0));
  END COMPONENT;

  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal enable : std_logic := '0';
  signal value_out : std_logic_vector(7 downto 0);
  signal tb_running : boolean := true;
  
BEGIN

  -- Component Instantiation
  uut: counter
    generic map (
      n => 8)
    PORT MAP(
      clk => clk,
      reset => rst,
      enable => enable,
      value => value_out);


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
    enable <= '0';
    
    wait for 100 ns;
    wait until rising_edge(clk);        -- se till att reset släpps synkront
    rst <= '0';                         -- med klockan
    report "Reset released" severity note;

    wait for 100 ns;
    wait until rising_edge(clk);
    enable <= '1';
    report "Enable high" severity note;

    wait for 100 ns;
    wait until rising_edge(clk);
    enable <= '0';
    report "Enable low" severity note;
    
    wait for 100 ns;
    wait until rising_edge(clk);
    enable <= '1';
    report "Enable high" severity note;
    
    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  -- i
    
    tb_running <= false;                -- Stanna klockan (vilket medför att inga
                                        -- nya event genereras vilket stannar
                                        -- simuleringen).
    wait;
  end process;
      
END;
