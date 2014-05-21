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
end alu;

architecture alu_ar of alu is

  signal subinput: std_logic_vector(buswidth-1 downto 0);
begin 
  subinput <= (not input) + '1';
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
    (ar_in or input) when "11101",      --OR
    (ar_in xor input) when "11110",     --XOR
    (ar_in) when others;
  
end alu_ar;


  
