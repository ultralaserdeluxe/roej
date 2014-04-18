LIBRARY ieee;
use work.constants.all;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY cpu_tb IS
END cpu_tb;

ARCHITECTURE behavior OF cpu_tb IS 

  -- Component Declaration
  COMPONENT alu
    PORT(
      input : in std_logic_vector(buswidth-1 downto 0);   
      ar_in : in std_logic_vector(buswidth-1 downto 0);           
      ar_out : buffer std_logic_vector(buswidth-1 downto 0);     
      alu_logic : in std_logic_vector(4 downto 0);
	  statusreg_out : out std_logic_vector(buswidth-1 downto 0));
  END COMPONENT;
  
  component gp_reg_8
    port (clk, rst, load: in std_logic;
          tal_in: in std_logic_vector(buswidth-1 downto 0);
          tal_ut: out std_logic_vector(buswidth-1 downto 0));
  end component;
  
  signal clk : std_logic := '0';
  signal rst : std_logic := '0';
  signal ar_in : std_logic_vector(buswidth-1 downto 0);
  signal alu_logic : std_logic_vector(4  downto 0);
  signal input : std_logic_vector(buswidth-1 downto 0);
  signal ar_out : std_logic_vector(buswidth-1  downto 0);
  signal load : std_logic := '0';
  signal tal_in : std_logic_vector(buswidth-1 downto 0);
  signal tal_ut : std_logic_vector(buswidth-1 downto 0);
  signal tb_running : boolean := true;
  signal to_bus : std_logic_vector(buswidth-1 downto 0);
  signal ar_connect : std_logic_vector(buswidth-1 downto 0);
  signal ar_connect_wrap : std_logic_vector(buswidth -1 downto 0);
  signal statusreg_connect : std_logic_vector(buswidth-1 downto 0);
  
BEGIN

  -- Component Instantiation
	alucomp: alu PORT MAP(
		input => input,
		ar_in => ar_connect_wrap,
		ar_out => ar_connect,
		alu_logic => alu_logic,
		statusreg_out => statusreg_connect);

	arcomp: gp_reg_8 port map (
		clk => clk,
		rst => rst,
		load => load,
		tal_in => ar_connect,
		tal_ut => ar_connect_wrap);
	
	srcomp: gp_reg_8 port map(
		clk => clk,
		rst => rst,
		load => load,
		tal_in => statusreg_connect,
		tal_ut => to_bus);

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
  
  begin
  
	rst <= '1';
	wait for 100 ns;
    wait until rising_edge(clk);
	rst <= '0';
	
	load <= '1';
	input <= "00000001";
	alu_logic <= "00010";
	wait for 100 ns;
	
	alu_logic <= "00000";
	wait for 100 ns;
	
	alu_logic <= "00100";
	wait for 10 ns;
	
	alu_logic <= "00000";
	wait for 10 ns;
	
    for i in 0 to 50000000 loop         -- Vänta ett antal klockcykler
      wait until rising_edge(clk);
    end loop;  
    
  end process;
END;
