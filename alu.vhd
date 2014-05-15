library IEEE;
use work.constants.all;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is    
   port (
     input : in std_logic_vector(buswidth-1 downto 0);      	 -- input from bus
     ar_in: in std_logic_vector(buswidth-1 downto 0);       	 -- input from ar
     ar_out : buffer std_logic_vector(buswidth-1 downto 0);      -- signal to ar
     alu_logic : in std_logic_vector(4 downto 0));		       -- operation logic
	 --statusreg_out : out std_logic_vector(7 downto 0)); -- message vector
end alu;

architecture alu_ar of alu is

  --internal signals for operations
  --type sr_rec is 
  --record
  --  z: std_logic; --zero
  --  n: std_logic; --negative
  --  c: std_logic; --carry
  --  o: std_logic; --overflow
  --  l: std_logic; --loop counter
  --  unused: std_logic_vector(0 to 2);
  --end record;	
  --signal sr : sr_rec;
  --signal overflow : std_logic;
  --signal result: std_logic_vector(buswidth downto 0);
  --signal statusreg: std_logic_vector(7 downto 0);
  signal subinput: std_logic_vector(buswidth-1 downto 0);
  --signal shift_carry: std_logic;
begin
  --sr.unused <= "000";
  --result <= (ar_in(buswidth-1) & ar_in) + (input(buswidth-1) & input); 
  subinput <= (not input) + '1';       	--reverse the bits in input and add 1
  --shift_carry <= ar_in(buswidth-1);
  --overflow <= '1' when 
  --            (ar_in(buswidth-1)='1' and input(buswidth-1)='1' and result(buswidth-1)='0') 
  --            or (ar_in(buswidth-1)='0' and input(buswidth-1)='0' and result(buswidth-1)='1') else '0'; 
  
  with alu_logic select
    ar_out <= 		 	--set the AR-signal
    (ar_in + 1) when "10000",	    	--inc
    (ar_in - 1) when "01000",    	--dec
    (ar_in + input) when "00100",	 --add
    (ar_in + subinput) when "00010", 	       	--sub
    (input) when "00001",			  	--load
    ("0" & ar_in(buswidth-1 downto 1)) when "10001",	--LSR
    (ar_in(buswidth-2 downto 0) & "0") when "10010",	--LSL
    (ar_in(buswidth-1) & ar_in(buswidth-1 downto 1)) when "10100", 	--ASR
    (ar_in(buswidth-1) & ar_in(buswidth-3 downto 0) & "0") when "11000",  --ASL
    (ar_in and input) when "11100",                       --AND
    (ar_in) when others;				
  
  ---- Set SR-flags	
  --sr.n <= '1' when ar_out(buswidth-1) = '1' else '0';	  	--check if negative
  --sr.z <= '1' when ar_out = "0000000000000000" else '0';       	--check if zero
  --sr.c <= '1' when (result(buswidth)='1' and alu_logic="00100") or 	--check add result
  --        (ar_in="1111111111111111" and alu_logic="10000") or 	--check inc result
  --        (shift_carry='1' and alu_logic="10010") else '0';	--check shift result
  --sr.o <= '1' when overflow = '1' or   	--check overflow (add/inc) result
  --        ((alu_logic = "10000" and ar_in = "0111111111111111") or
  --         ((alu_logic = "00010" or alu_logic = "01000") and	--check overflow (sub/dec) result
  --          ar_in = "1000000000000000"))
  --        else '0'; 	
  --sr.l <= '0';
  
  --statusreg(7) <= sr.n;
  --statusreg(6) <= sr.z;
  --statusreg(5) <= sr.c;
  --statusreg(4) <= sr.o;
  --statusreg(3) <= sr.l;
  --statusreg(2 downto 0) <= sr.unused;
  
  --statusreg_out <= statusreg; 	    --set the SR-signal
  
end alu_ar;

