library IEEE;
use work.constants.all;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity primmem is    
   port (
	 clk : in std_logic;
     adr_bus : in std_logic_vector(15 downto 0);
	 data_bus_in : in std_logic_vector(7 downto 0);
	 data_bus_out : out std_logic_vector(7 downto 0);
	 read_signal : in std_logic;
	 write_signal : in std_logic);
end primmem;

architecture primmem_behv of primmem is

type primmem_type is array (0 to 4096) of std_logic_vector(7 downto 0);
  signal primmem : primmem_type := (
"00000100",                             --LDA
"00000110",                             --6
"00001000",                             --STA
"00010000", "00000000",                 --4096
"00000100",                             --LDA
"00000100",                             --4
"10110101",                             --LSR
"00001000",                             --STA
"00010000", "00000001",                 --4097
"10111101",                             --LSL
"00001000",                             --STA
"00010000", "00000010",                 --4098
"11010100",                             --AND
"00000000",                             --0
"00001000",                             --STA
"00010000", "00000011",                 --4099
"00000100",                             --LDA
"00000011",                             --7
"11011100",                             --CMP
"00000011",                             --7
"10010011",                             --JMPZ
"00000000", "00000001",                 --1
"10101101",                             --HH
"00001000",                             --STA
"00010000", "00000100",                 --4100
"10101101",                             --HH
others => "00000000"
);

begin
  process(clk)
    begin
      if rising_edge(clk) then
          data_bus_out <= primmem(conv_integer(adr_bus));
        if write_signal ='1' then
          primmem(conv_integer(adr_bus)) <= data_bus_in;
      end if;
    end if;
    end process;            
end primmem_behv;

