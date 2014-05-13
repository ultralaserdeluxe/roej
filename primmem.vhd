library IEEE;
use work.constants.all;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity primmem is    
   port (
	 clk : in std_logic;
     adr_bus : in std_logic_vector(15 downto 0);
	 data_bus_in : in std_logic_vector(buswidth-1 downto 0);
	 data_bus_out : out std_logic_vector(buswidth-1 downto 0);
	 read_signal : in std_logic;
	 write_signal : in std_logic);
end primmem;

architecture primmem_behv of primmem is

type primmem_type is array (0 to 255) of std_logic_vector(7 downto 0);
  signal primmem : primmem_type := (
"00000000", "00001100", "00010100", "00000111", "00001000", "00001101", "00000000", 
"00000000", "00000000", "00000000", "00000000", "00000000", "00000001", "00000000",
others => "00000000"
);

begin
	process(clk)
		begin
		if read_signal = '1' then
			data_bus_out <= primmem(conv_integer(adr_bus));
		elsif write_signal = '1' then
			primmem(conv_integer(adr_bus)) <= data_bus_in;
		end if; 
	end process;
end primmem_behv;
