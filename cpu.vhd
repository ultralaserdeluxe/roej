library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity cpu is

  port(
    clk : in std_logic;
    rst : in std_logic;
    adr_bus : in std_logic_vector(15 downto 0);
	data_bus : inout std_logic_vector(7 downto 0));
   
end cpu;

architecture cpu_ar of cpu is

  component gp_reg_8
	Port ( clk,rst,load,inc,dec : in  STD_LOGIC;
			input : in STD_LOGIC_VECTOR(7 downto 0);
			output : out  STD_LOGIC_VECTOR(7 downto 0));
  end component;
  -- ADR
  signal mm_2 : std_logic_vector(15 downto 0);
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
  component data_reg
	Port ( clk,rst,load,to_db,read_signal,write_signal : in  STD_LOGIC;
		 data_bus : inout STD_LOGIC_VECTOR(7 downto 0);
         input : in STD_LOGIC_VECTOR(7 downto 0);
         output : out  STD_LOGIC_VECTOR(7 downto 0));
  end component;
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
  signal mm_12_connect : std_logic; -- reset
  signal mm_11_connect : std_logic; -- inc
  
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
  signal alu_logic_signal : std_logic_vector(4 downto 0);
  signal ar_connect : std_logic_vector(7 downto 0); -- ar out
  signal alu_buss : std_logic_vector(7 downto 0); -- ar in
  signal sr_connect : std_logic_vector(7 downto 0); -- SR
  
  component mm_logic_mux
	port(
		input : in std_logic_vector(2 downto 0);
		alu_logic_signal : out std_logic_vector(4 downto 0));
   end component;
   
   signal alu_logic_connect : std_logic_vector(4 downto 0);
	
   component mm_incdec_mux
	port(
		input : in std_logic_vector(2 downto 0);
		mm_15 : in std_logic;
		mm_16 : in std_logic;
		mm_17 : in std_logic;
		mm_22 : in std_logic;
		mm_23 : in std_logic);
	end component

	signal mm_15_connect : std_logic;
	signal mm_16_connect : std_logic;
	signal mm_17_connect : std_logic;
	signal mm_22_connect : std_logic;
	signal mm_23_connect : std_logic;
	
	component micromem
	port(
		mpc_in : in std_logic_vector(7 downto 0);
		mm_out : out std_logic_vector(1 to 39)
		);
	end component;
	
	signal mm_signal : std_logic_vector(1 to 39);
	signal mm_input : std_logic_vector(7 downto 0);
	
begin  -- cpu_ar

	ADR : gp_reg_16 
	port map(
		clk <= clk,
		rst <= '0',
		load <= mm_signal(1),
		input <= mm_1,  
		output <= adr_bus);
	
	PC : gp_reg_8 
	port map(
		clk <= clk,
		rst <= rst,
		load mm_signal(13),
		inc <= mm_signal(17),
		dec <= '0',
		input <= mm_13,
		output <= mm_18);
		
	XR : gp_reg_8
	port map(
		clk <= clk,
		rst <= rst,
		load <= mm_signal(19),
		inc <= '0',
		dec <= '0',
		input <= mm_19,
		output <= mm_20);
		
	SP : gp_reg_8 
	port map(
		clk <= clk,
		rst <= '0',
		load <= mm_signal(21),
		inc <= mm_signal(22),
		dec <= mm_signal(23),
		input <= mm_21,
		output <= mm_24);
		
	DR : data_reg 
	port map(
		clk <= clk,
		rst <= rst,
		load <= mm_6,
		data_bus <= data_bus,
		to_db <= mm_signal(5),
		read_signal <= mm_signal(3),
		write_signal <= mm_signal(4),
		input <= mm_6,
		output <= mm_7);
		
    TR : gp_reg_8 
	port map(
		clk <= clk,
		rst <= rst,
		load <= mm_signal(25),
		inc <= '0',
		dec <= '0',
		input <= mm_25,
		output <= mm_26);
		
	AR : gp_reg_8 
	port map(
		clk <= clk,
		rst <= '0',
		load <= mm_signal(33),
		inc <= '0',
		dec <= '0',
		input <= mm_33,
		output <= mm_37);
		
	SR : gp_reg_8 
	port map(
		clk <= clk,
		rst <= '0',
		load <= mm_signal(34),
		inc <= '0',
		dec <= '0',
		input <= sr_connect,
		output <= mm_36);
		
	MPC : gp_reg_8 
	port map(
		clk <= clk,
		rst <= mm_signal(12),
		load <= mm_signal(9) or mm_signal(10),
		inc <= mm_signal(11),
		dec <= '0',
		input <= k1 & k2,
		output <= mm_input);
		
	alu_comp : ALU
	port map(
		input <= mm_27,      -- input from bus
		ar_in <= mm_37,       -- input from ar
		ar_out <= mm_33,    -- signal to ar
		alu_logic <= alu_logic_signal,	-- operation logic
		statusreg_out <= sr_connect); -- message vector
		
	mm : micromem
	port map(
		mpc_in <= mm_input,
		mm_out <= mm_signal);

end cpu_ar;

--MUXBUSS
--k1k2
--micromem
--