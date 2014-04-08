library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is                           --derp
   port (
     input : in std_logic_vector(15 downto 0);        -- input from buss
     ar_in: in std_logic_vector(15 downto 0);           -- input from ar
     ar_out : out std_logic_vector(15 downto 0);      -- signal to ar
     alu_logic : in std_logic_vector(4 downto 0));    -- message vector
end alu;
    
architecture alu_ar of alu is
begin
  
  with alu_logic select
    ar_out <=
    input when "00001",                  --bit 0    load ar
    (ar_in + 1) when "00010",                 --bit 1    increment ar
    (ar_in - 1) when "00100",                 --bit 2    decrement ar
    (ar_in + input) when "01000",             --bit 3    add
    (ar_in - input) when "10000",             --bit 4    sub
    "1010101010101010" when others;   --COMMITTA SKITEN
  
end alu_ar;
