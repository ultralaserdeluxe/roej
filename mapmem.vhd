library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mapmem is

  port(
    clk : in std_logic;
    addr_a_row : in std_logic_vector(5 downto 0);
    addr_a_col : in std_logic_vector(5 downto 0);
    data_a_out : out std_logic_vector(5 downto 0));    
  
end mapmem;
    
architecture mapmem_behv of mapmem is

  type mapmem_t is array (0 to 4096) of std_logic_vector(5 downto 0);
  signal mapmem : mapmem_t := (others => "000000");

begin

  process(clk)
  begin
    if rising_edge(clk) then
      data_a_out <= mapmem(conv_integer(addr_a_row) * 4 + conv_integer(addr_a_col));
    end if;
  end process;
  
end mapmem_behv;
