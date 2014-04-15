library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mapmem is

  port(
    clk : in std_logic;
    addr_a_row : in std_logic_vector(5 downto 0);
    addr_a_col : in std_logic_vector(5 downto 0);
    data_a_out : out std_logic_vector(5 downto 0);    
    addr_b_row : in std_logic_vector(5 downto 0);
    addr_b_col : in std_logic_vector(5 downto 0);
    data_b_in : in std_logic_vector(5 downto 0);
    data_b_out : out std_logic_vector(5 downto 0);    
    write_enable : in std_logic);
  
end mapmem;
    
architecture mapmem_behv of mapmem is

  type mapmem_t is array (0 to 63, 0 to 63) of std_logic_vector(5 downto 0);
  signal mapmem : mapmem_t := (others => (others => "000000"));

begin

  data_a_out <= mapmem(conv_integer(addr_a_row), conv_integer(addr_a_col));
  data_b_out <= mapmem(conv_integer(addr_b_row), conv_integer(addr_b_col));
  process(clk)
  begin
    if rising_edge(clk) then
      if write_enable = '1' then
        mapmem(conv_integer(addr_b_row), conv_integer(addr_b_col)) <=
          data_b_in;
      end if;
    end if;
  end process;
  
end mapmem_behv;
