-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY realtime_counter_tb IS
END realtime_counter_tb;

ARCHITECTURE behavior OF realtime_counter_tb IS 

  -- Component Declaration
  COMPONENT realtime_counter
    PORT(
      clk,reset,enable : IN std_logic;
      single_out : out std_logic_vector (7 downto 0);
    ten_out : out std_logic_vector(7 downto 0);
    hundred_out : out std_logic_vector(7 downto 0));
  END COMPONENT;

  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal single_value : std_logic_vector (7 downto 0);
  signal ten_value :  std_logic_vector(7 downto 0);
  signal hundred_value : std_logic_vector(7 downto 0);
  signal tb_running : boolean := true;
  
BEGIN

  -- Component Instantiation
  uut: realtime_counter
    PORT MAP(
      clk => clk,
      reset => rst,
      enable => '1',
      single_out => single_value,
      ten_out => ten_value,
      hundred_out => hundred_value);

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

  

  stimuli_generator : process
  begin

    rst <= '1';
    
    wait for 100 ns;
    wait until rising_edge(clk);        -- se till att reset släpps synkront
    rst <= '0';                         -- med klockan
    report "Reset released" severity note;
    
    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  -- i
    
    tb_running <= false;                -- Stanna klockan (vilket medför att inga
                                        -- nya event genereras vilket stannar
                                        -- simuleringen).
    wait;
  end process;
      
END;
