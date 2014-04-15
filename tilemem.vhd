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

  type tile_t is array (0 to 15, 0 to 15) of std_logic_vector(7 downto 0);
  type tilemem_t is array (0 to 7, 0 to 7) of tile_t;

  constant tile0 : tile_t := (("11100000", others => "00000000"),
                              (others => "00000011"),
                              (others => "00000000"),
                              (others => "00000000"),
                              (others => "00000000"),
                              (others => "00000000"),
                              (others => "00000000"),
                              ("11111111", others => "00000000"),
                              (others => "00000000"),
                              (others => "00000000"),
                              (others => "00000000"),
                              (others => "00000000"),
                              (others => "00000000"),
                              (others => "00000000"),
                              (others => "00000000"),
                              ("00011100", others => "00000000"));


  constant content : tilemem_t := (others => (others => tile0));
  signal tilemem : tilemem_t := content;

begin
  
  data_out <= tilemem(conv_integer(row_base), conv_integer(col_base))
              (conv_integer(row_offset), conv_integer(col_offset));
  
end tilemem_behv;
