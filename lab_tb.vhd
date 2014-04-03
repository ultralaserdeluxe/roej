-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY lab_tb IS
END lab_tb;

ARCHITECTURE behavior OF lab_tb IS 

  -- Component Declaration
  COMPONENT counter
    generic(n : integer := 8);
    PORT(
      clk,reset, enable : IN std_logic;
      value : out std_logic_vector(31 - 1 downto 0)
      );
  END COMPONENT;

  SIGNAL clk : std_logic := '0';
  SIGNAL rst : std_logic := '0';
  signal enable : std_logic := '1';
  signal value_out : std_logic_vector(31 - 1 downto 0);
  signal tb_running : boolean := true;
  
BEGIN

  -- Component Instantiation
  uut: counter PORT MAP(
    clk => clk,
    reset => rst,
    enable => enable,
    value => value_out
    );


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
    -- Aktivera reset ett litet tag.
    rst <= '1';
    wait for 500 ns;

    wait until rising_edge(clk);        -- se till att reset släpps synkront
                                        -- med klockan
    rst <= '0';
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
