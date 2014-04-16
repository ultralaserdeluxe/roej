library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- 8x8 16x16 blocks of 8 bit RGB

entity tilemem is

  port(
    row_base : in std_logic_vector(2 downto 0);
    row_offset : in std_logic_vector(3 downto 0);
    col_base : in std_logic_vector(2 downto 0);
    col_offset : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(7 downto 0));
  
end tilemem;
    
architecture tilemem_behv of tilemem is

  type tilemem_t is array (0 to 16383) of std_logic_vector(7 downto 0);
  signal tilemem : tilemem_t := ("00000011","11100000","11100000","11100000","11100000","11100000","11100000","11100000","11100000","11100000","11100000","11100000","11100000","11100000","11100000","11100000","00011100", others => "11100011");

begin
  
  data_out <= tilemem((conv_integer(row_base & row_offset)) * 16 + conv_integer(col_base & col_offset));
  
end tilemem_behv;
