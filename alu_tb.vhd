-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu_tb IS
END alu_tb;

ARCHITECTURE behavior OF alu_tb IS 

  -- Component Declaration
  COMPONENT alu
    PORT(
      input : in std_logic_vector(15 downto 0);   
      ar_in : in std_logic_vector(15 downto 0);           
      ar_out : out std_logic_vector(15 downto 0);     
      alu_logic : in std_logic_vector(4 downto 0));
  END COMPONENT;
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal ar_in_signal : std_logic_vector(15 downto 0);
  signal alu_logic_signal : std_logic_vector(4  downto 0);
  signal value_in : std_logic_vector(15 downto 0);
  signal value_out : std_logic_vector(15  downto 0);
  signal tb_running : boolean := true;
  
BEGIN

  -- Component Instantiation
  uut: alu PORT MAP(
    input => value_in,
    ar_in => ar_in_signal,
    ar_out => value_out,
    alu_logic => alu_logic_signal
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

    value_in <= "0000000000000111";
    wait for 100 ns;

    alu_logic_signal <= "01000";
    wait for 100 ns;

    alu_logic_signal <= "10000";
    wait for 100 ns;

    alu_logic_signal <= "00010";
    wait for 100 ns;

    alu_logic_signal <= "00100";
    wait for 100 ns;
    
    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  -- i
    
    tb_running <= false;                -- Stanna klockan (vilket medför att inga
                                        -- nya event genereras vilket stannar
                                        -- simuleringen).
    wait;
  end process;
      
END;
