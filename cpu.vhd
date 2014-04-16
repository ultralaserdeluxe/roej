library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity cpu is

  port(
    clk : in std_logic;
    rst : in std_logic;
    adr_bus : in std_logic_vector(buswidth-1 downto 0));
   
end cpu;

architecture cpu_ar of cpu is

  component gp_reg_8
	Port ( clk,rst,load,inc,dec : in  STD_LOGIC;
			input : in STD_LOGIC_VECTOR(7 downto 0);
			output : out  STD_LOGIC_VECTOR(7 downto 0));
  end component;
  -- ADR
  signal mm_2 : std_logic_vector(7 downto 0);
  signal mm_1 : std_logic_vector(7 downto 0;
  -- PC
  signal mm_17 : std_logic; -- inc
  signal mm_14 : std_logic_vector;
  signal mm_13 : std_logic_vector;
  signal mm_18 : std_logic_vector(7 downto 0);
  -- XR
  signal mm_19 : std_logic_vector(7 downto 0);
  signal mm_20 : std_logic_vector(7 downto 0);
  -- SP
  signal mm_21 : std_logic_vector(7 downto 0);
  signal mm_24 : std_logic_vector(7 downto 0);
  signal mm_22 : std_logic; -- inc
  signal mm_23 : std_logic; -- dec
  -- DR
  signal mm_5 : std_logic_vector(7 downto 0);
  signal mm_6 : std_logic_vector(7 downto 0);
  -- TR
  signal mm_25 : std_logic_vector(7 downto 0);
  signal mm_26 : std_logic_vector(7 downto 0);
  -- AR
  signal mm_33 : std_logic_vector(7 downto 0);
  signal mm_37 : std_logic_vector(7 downto 0);
  -- SR
  signal mm_34 : std_logic_vector(7 downto 0);
  signal mm_36 : std_logic_vector(7 downto 0);
  -- MPC
  signal mm_9 : std_logic_vector(4 downto 0); --K1
  signal mm_10 : std_logic_vector(2 downto 0); --K2
  signal mm_12 : std_logic; -- reset
  signal mm_11 : std_logic; -- inc
  
  -- ALU
  component ALU
	port (
     input : in std_logic_vector(buswidth-1 downto 0);      -- input from bus
     ar_in: in std_logic_vector(buswidth-1 downto 0);       -- input from ar
     ar_out : buffer std_logic_vector(buswidth-1 downto 0);    -- signal to ar
     alu_logic : in std_logic_vector(4 downto 0);			-- operation logic
	 statusreg_out : out std_logic_vector(buswidth-1 downto 0)); -- message vector
   end component;   
  signal mm_27 : std_logic_vector(7 downto 0); -- input
  signal mm_28 : std_logic_vector(4 downto 0):= "00010"; -- inc ar
  signal mm_29 : std_logic_vector(4 downto 0):= "00100"; -- dec ar
  signal mm_30 : std_logic_vector(4 downto 0):= "01000"; -- add
  signal mm_31 : std_logic_vector(4 downto 0):= "10000"; -- sub
  signal mm_32 : std_logic_vector(4 downto 0):= "00001"; -- load
  signal mm_33 : std_logic_vector(7 downto 0); -- ar out
  signal mm_37 : std_logic_vector(7 downto 0); -- ar in
  signal mm_34 : std_logic_vector(7 downto 0); -- SR
  
begin  -- cpu_ar

	ADR : gp_reg_8 
	port map(
		clk <= clk,
		rst <= '0',
		load <= mm_2,
		inc <= '0',
		dec <= '0',
		input <= mm_2,
		output <= mm_1);
	
	PC : gp_reg_8 
	port map(
		clk <= clk,
		rst <= rst,
		load <= mm_13,
		inc <= mm_17,
		dec <= '0',
		input <= mm_13,
		output <= mm_18);
		
	XR : gp_reg_8
	port map(
		clk <= clk,
		rst <= rst,
		load <= mm_19,
		inc <= '0',
		dec <= '0',
		input <= mm_19,
		output <= mm_20);
		
	SP : gp_reg_8 
	port map(
		clk <= clk,
		rst <= '0',
		load <= mm_21,
		inc <= mm_22,
		dec <= mm_23,
		input <= mm_21,
		output <= mm_24);
		
	DR : gp_reg_8 
	port map(
		clk <= clk,
		rst <= rst,
		load <= mm_6,
		inc <= '0',
		dec <= '0',
		input <= mm_6,
		output <= mm_7);
		
    TR : gp_reg_8 
	port map(
		clk <= clk,
		rst <= rst,
		load <= mm_25,
		inc <= '0',
		dec <= '0',
		input <= mm_25,
		output <= mm_26);
		
	AR : gp_reg_8 
	port map(
		clk <= clk,
		rst <= '0',
		load <= mm_33,
		inc <= '0',
		dec <= '0',
		input <= mm_33,
		output <= mm_37);
		
	SR : gp_reg_8 
	port map(
		clk <= clk,
		rst <= '0',
		load <= mm_34,
		inc <= '0',
		dec <= '0',
		input <= mm_34,
		output <= mm_36);
		
	MPC : gp_reg_8 
	port map(
		clk <= clk,
		rst <= mm_12,
		load <= mm_9 & mm_10,
		inc <= mm_11,
		dec <= '0',
		input <= mm_9 & mm_10,
		output <= mm);
		
	alu_comp : ALU'
	port map(
		input <= mm_27,      -- input from bus
		ar_in <= mm_37,       -- input from ar
		ar_out <= mm_33,    -- signal to ar
		alu_logic <= 	-- operation logic
		statusreg_out <= mm_34); -- message vector


end cpu_ar;
