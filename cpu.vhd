library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity cpu is
  port(
    clk : in std_logic;
    rst : in std_logic;
    adr_bus : out std_logic_vector(adr_buswidth-1 downto 0);
	data_bus_out : inout std_logic_vector(buswidth-1 downto 0);
	read_signal : out std_logic;
	write_signal : out std_logic);
end cpu;
architecture cpu_ar of cpu is
	component gp_reg_8
		Port ( clk,rst,load,inc,dec : in  STD_LOGIC;
			input : in STD_LOGIC_VECTOR(buswidth-1 downto 0);
			output : out  STD_LOGIC_VECTOR(buswidth-1 downto 0));
	end component;
	component gp_reg_16
	Port (clk,rst,load : in  STD_LOGIC;
         input : in STD_LOGIC_VECTOR(15 downto 0);
         output : out  STD_LOGIC_VECTOR(15 downto 0));
	end component;
	-- ADR
	signal mm_2 : std_logic_vector(adr_buswidth-1 downto 0);
	signal mm_1 : std_logic_vector(buswidth-1 downto 0);
	signal adr_conc : std_logic_vector(adr_buswidth-1 downto 0);
	-- PC
	signal mm_14 : std_logic_vector(buswidth-1 downto 0);
	signal mm_13 : std_logic_vector(buswidth-1 downto 0);
	signal mm_18 : std_logic_vector(buswidth-1 downto 0);
	-- XR
	signal mm_19 : std_logic_vector(buswidth-1 downto 0);
	signal mm_20 : std_logic_vector(buswidth-1 downto 0);
	-- SP
	signal mm_21 : std_logic_vector(buswidth-1 downto 0);
	signal mm_24 : std_logic_vector(buswidth-1 downto 0);
	-- DR
	component data_reg
		Port ( clk,rst,load,to_db,read_signal,write_signal : in  STD_LOGIC;
			data_bus : inout STD_LOGIC_VECTOR(buswidth-1 downto 0);
			input : in STD_LOGIC_VECTOR(buswidth-1 downto 0);
			output : out  STD_LOGIC_VECTOR(buswidth-1 downto 0));
	end component;
	signal mm_5 : std_logic_vector(buswidth-1 downto 0);
	signal mm_6 : std_logic_vector(buswidth-1 downto 0);
	signal mm_7 : std_logic_vector(buswidth-1 downto 0);
	signal data_bus_signal : std_logic_vector(buswidth-1 downto 0);
	-- TR
	signal mm_25 : std_logic_vector(buswidth-1 downto 0);
	signal mm_26 : std_logic_vector(buswidth-1 downto 0);
	signal tr_out : std_logic_vector(buswidth-1 downto 0);
	-- AR
	signal mm_33 : std_logic_vector(buswidth-1 downto 0);
	signal mm_37 : std_logic_vector(buswidth-1 downto 0);   -- signal to alu and bus (if risen in mm_signal)
	-- SR
	signal mm_36 : std_logic_vector(buswidth-1 downto 0);
	-- MPC
	signal mm_9 : std_logic_vector(buswidth-1 downto 0); 	-- K1
	signal mm_10 : std_logic_vector(buswidth-1 downto 0); 	-- K2
	signal mm_12_connect : std_logic; 						-- reset
	signal mm_11_connect : std_logic; 						-- inc
	signal mpc_load_connect : std_logic;
	signal mpc_reset : std_logic;							-- rst
	-- HR
	signal mm_38 : std_logic_vector(buswidth-1 downto 0);
	signal mm_39 : std_logic_vector(buswidth-1 downto 0);
	-- ALU
	component ALU
		port (
			input : in std_logic_vector(buswidth-1 downto 0);      		-- input from bus
			ar_in: in std_logic_vector(buswidth-1 downto 0);       		-- input from ar
			ar_out : buffer std_logic_vector(buswidth-1 downto 0);    	-- signal to ar
			alu_logic : in std_logic_vector(4 downto 0);				-- operation logic
			statusreg_out : out std_logic_vector(buswidth-1 downto 0)); -- message vector
	end component;   
	signal mm_27 : std_logic_vector(buswidth-1 downto 0); 						-- ALU-input
	signal alu_logic_signal : std_logic_vector(4 downto 0); 			-- ALU-logic
	signal ar_connect : std_logic_vector(buswidth-1 downto 0); 					-- ar out
	signal sr_connect : std_logic_vector(buswidth-1 downto 0); 					-- SR-signal
	
	-- inc/dec signals
	-- K3
	signal mm_15 : std_logic;
	signal mm_16: std_logic;
	-- PC
	signal mm_17: std_logic;
	-- SP
	signal mm_22: std_logic;
	signal mm_23: std_logic;
	-- Micromemory
	component micromem
	port(
		mpc_in : in std_logic_vector(buswidth-1 downto 0);
		mm_out : out std_logic_vector(1 to 39)
		);
	end component;
	signal mm_signal : std_logic_vector(1 to 39);
	signal mm_input : std_logic_vector(buswidth-1 downto 0);
	--bus signal
	signal bus_signal : std_logic_vector(buswidth-1 downto 0);
	-- IR
	signal mm_8 : std_logic_vector(buswidth-1 downto 0);
	signal ir_out : std_logic_vector(buswidth-1 downto 0);
	-- k1
	component k1
	port(k1_in : in STD_LOGIC_VECTOR(4 downto 0);
		k1_out : out STD_LOGIC_VECTOR(buswidth-1 downto 0));
	end component;
	signal k1_in_connect : std_logic_vector(4 downto 0);
	signal k1_out_connect : std_logic_vector(buswidth-1 downto 0);
	-- k2
	component k2
	port(k2_in : in STD_LOGIC_VECTOR(2 downto 0);
		k2_out : out STD_LOGIC_VECTOR(buswidth-1 downto 0));
	end component;
	signal k2_in_connect : std_logic_vector(2 downto 0);
	signal k2_out_connect : std_logic_vector(buswidth-1 downto 0);
	signal mpc_connect : std_logic_vector(7 downto 0);
	-- k3
	component k3
	port(mm_signal: in std_logic_vector(1 to 39);
		input: in std_logic_vector(buswidth-1 downto 0);
		k3_out : out STD_LOGIC_VECTOR(buswidth-1 downto 0));
	end component;
	signal pc_connect: std_logic_vector(buswidth-1 downto 0);
	signal pc_load_signal: std_logic;
	
begin  -- cpu_ar
	ADR : gp_reg_16 
	port map(
		clk => clk,
		rst => rst,
		load => mm_signal(1),
		input => adr_conc,  
		output => adr_bus);
		
	PC : gp_reg_8 
	port map(
		clk => clk,
		rst => rst,
		load => pc_load_signal,
		inc => mm_signal(17),
		dec => '0',
		input => pc_connect,
		output => mm_18);
		
	XR : gp_reg_8
	port map(
		clk => clk,
		rst => rst,
		load => mm_signal(19),
		inc => '0',
		dec => '0',
		input => mm_19,
		output => mm_20);
		
	SP : gp_reg_8 
	port map(
		clk => clk,
		rst => rst,
		load => mm_signal(21),
		inc => mm_signal(22),
		dec => mm_signal(23),
		input => mm_21,
		output => mm_24);
		
	DR : data_reg 
	port map(
		clk => clk,
		rst => rst,
		load => mm_signal(6),
		data_bus => data_bus_signal,
		to_db => mm_signal(5),
		read_signal => mm_signal(3),
		write_signal => mm_signal(4),
		input => mm_6,
		output => mm_7);
		
    TR : gp_reg_8 
	port map(
		clk => clk,
		rst => rst,
		load => mm_signal(25),
		inc => '0',
		dec => '0',
		input => mm_25,
		output => mm_26);
		
	AR : gp_reg_8 
	port map(
		clk => clk,
		rst => rst,
		load => mm_signal(33),
		inc => '0',
		dec => '0',
		input => ar_connect,
		output => mm_37);
		
	SR : gp_reg_8 
	port map(
		clk => clk,
		rst => rst,
		load => mm_signal(34),
		inc => '0',
		dec => '0',
		input => sr_connect,
		output => mm_36);
		
	MPC : gp_reg_8 
	port map(
		clk => clk,
		rst => mpc_reset,
		load => mpc_load_connect,
		inc => mm_signal(11),
		dec => '0',
		input => mpc_connect,
		output => mm_input);
		
	HR : gp_reg_8 
	port map(
		clk => clk,
		rst => rst,
		load => mm_signal(38),
		inc => '0',
		dec => '0',
		input => mm_38,
		output => mm_39);
		
	IR : gp_reg_8
	port map(clk => clk,
		rst => rst,
		load => mm_signal(8),
		inc => '0',
		dec => '0',
		input => mm_8,
		output => ir_out);
		
	alu_comp : ALU
	port map(
		input => mm_27,      			-- input from bus
		ar_in => mm_37,       			-- input from AR
		ar_out => mm_33,    			-- output to AR
		alu_logic => alu_logic_signal,	-- operation logic
		statusreg_out => sr_connect); 	-- output to SR
		
	mm : micromem
	port map(
		mpc_in => mm_input,
		mm_out => mm_signal);
	
	k1_comp : k1
	port map(
		k1_in => k1_in_connect,
		k1_out => k1_out_connect);
		
	k2_comp : k2
	port map(
		k2_in => k2_in_connect,
		k2_out => k2_out_connect);
	
	k3_comp : k3
	port map(
		mm_signal => mm_signal,
		input => bus_signal,
		k3_out => mm_14);
	
	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				mpc_reset <= rst;
			else
				mpc_reset <= mm_signal(12);
			end if;
		end if;
		-- mm_signal(12) <= '1' when rst = '1' else '0';
		
	end process;
	
	adr_conc <= ("00000000" & mm_1);
	k1_in_connect <= mm_8(buswidth-1 downto 3);
	k2_in_connect <= mm_8(2 downto 0);
	mm_11_connect <= mm_signal(11);
	mm_12_connect <= mm_signal(12);
	mpc_connect <= k1_out_connect when mm_signal(9) = '1';
	mpc_connect <= k2_out_connect when mm_signal(10) = '1';
	mpc_load_connect <= '1' when (mm_signal(9)='1' or mm_signal(10)='1') else '0';
		
	--to bus mux	
	bus_signal <= mm_7 when mm_signal(7) = '1' else 	-- DR -> bus
				  mm_18 when mm_signal(18) = '1' else 	-- PC -> bus
				  mm_20 when mm_signal(20) = '1' else 	-- XR -> bus
				  mm_24 when mm_signal(24) = '1' else 	-- SP -> bus
				  mm_26 when mm_signal(26) = '1' else 	-- TR -> bus
				  mm_36 when mm_signal(36) = '1' else 	-- SR -> bus
				  mm_37 when mm_signal(37) = '1' else	-- AR -> bus
				  "00000000";	
	--from bus mux    (every register has a load-signal that allows bus_signal to be stored)
	mm_1 <= bus_signal;		-- bus -> ADR
	mm_6 <= bus_signal;		-- bus -> DR
	mm_8 <= bus_signal;		-- bus -> IR
	mm_13 <= bus_signal;	-- bus -> PC
	mm_19 <= bus_signal;	-- bus -> XR
	mm_21 <= bus_signal;	-- bus -> SP
	mm_25 <= bus_signal;	-- bus -> TR
		
	read_signal <= mm_signal(3);								-- Read-output
	write_signal <= mm_signal(4);								-- Write-output	
	mm_27 <= mm_26 when mm_signal(27) = '1' else "00000000";	-- ALU-input
	pc_connect <= mm_14 when mm_signal(14)='1' else mm_13;		-- PC-input
	pc_load_signal <= (mm_signal(13) or mm_signal(14));			-- PC-load
	alu_logic_signal <= mm_signal(28 to 32);					-- ALU-logic-signal
	mm_38 <= mm_37;												-- HR-input
	ar_connect <= mm_39 when mm_signal(39)='1' else mm_33;		-- AR-input
	

	data_bus_out <= data_bus_signal;
end cpu_ar;
--micromem