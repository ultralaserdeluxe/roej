library IEEE;
use work.constants.all;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is    
   port (
     input : in std_logic_vector(buswidth-1 downto 0);      -- input from bus
     ar_in: in std_logic_vector(buswidth-1 downto 0);       -- input from ar
     ar_out : buffer std_logic_vector(buswidth-1 downto 0);    -- signal to ar
     alu_logic : in std_logic_vector(4 downto 0);			-- operation logic
	 statusreg_out : out std_logic_vector(buswidth-1 downto 0)); -- message vector
end alu;
    
architecture alu_ar of alu is

	--internal signals for operations
	type sr_rec is 
		record
			z: std_logic; --zero
			n: std_logic; --negative
			c: std_logic; --carry
			o: std_logic; --overflow
			l: std_logic; --loop counter
			unused: std_logic_vector(0 to 2);
		end record;	
	signal sr : sr_rec;
	signal overflow : std_logic;
	signal result: std_logic_vector(buswidth-1 downto 0);
	signal statusreg: std_logic_vector(buswidth-1 downto 0);
	signal subinput: std_logic_vector(buswidth-1 downto 0);
	signal carry_result: std_logic_vector(buswidth downto 0);
	
begin
	sr.unused <= "000";
	result <= ar_in + input; 
	subinput <= (not input) + '1';					--reverse the bits in input and add 1
	carry_result <= "000000000" + (ar_in + input);
	overflow <= '1' when 
			(ar_in(buswidth-1)='1' and input(buswidth-1)='1' and result(buswidth-1)='0') 
		or (ar_in(buswidth-1)='0' and input(buswidth-1)='0' and result(buswidth-1)='1') else '0'; 
		
	with alu_logic select
	ar_out <= 														--set the AR-signal
		input when "00001",			 								--load ar
		ar_in + 1 when "00010", 									--increment ar
		ar_in - 1 when "00100",										--decrement ar
		result(buswidth-1 downto 0) when "01000",					--add
		ar_in + subinput when "10000",								--sub
		"01010101" when others;				
		
	sr.n <= '1' when ar_out(buswidth-1) = '1' else '0';						--set n-flag
	sr.z <= '1' when ar_out = "00000000" else '0'; 	 						--set z-flag
	sr.c <= '1' when carry_result(buswidth)='1' or 
					(ar_in="11111111" and alu_logic="00010") else '0';				--set c-flag
	sr.o <= '1' when overflow = '1' or
					(alu_logic = "00010" and ar_in = "01111111") else '0'; 	--set o-flag	
	sr.l <= '0';															--set l-flag
						
	statusreg(buswidth-1) <= sr.n;
	statusreg(buswidth-2) <= sr.z;
	statusreg(buswidth-3) <= sr.c;
	statusreg(buswidth-4) <= sr.o;
	statusreg(buswidth-5) <= sr.l;
	statusreg(buswidth-6 downto 0) <= sr.unused;
	
	statusreg_out <= statusreg; 									--set the SR-signal
	
end alu_ar;

