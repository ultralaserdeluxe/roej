library IEEE;
use work.constants.all;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is    
   port (
     input : in std_logic_vector(buswidth-1 downto 0);  -- input from bus
     ar_in: in std_logic_vector(buswidth-1 downto 0);         -- input from ar
     ar_out : out std_logic_vector(buswidth-1 downto 0);      -- signal to ar
     alu_logic : in std_logic_vector(4 downto 0));    -- message vector
end alu;
    
architecture alu_ar of alu is
begin
  with alu_logic select
    ar_out <=
    input when "00001",                  --load ar
    (ar_in + 1) when "00010",                 --increment ar
    (ar_in - 1) when "00100",                 --decrement ar
    (ar_in + input) when "01000",             --add
    (ar_in - input) when "10000",             --sub
    "10101010" when others;
end alu_ar;
