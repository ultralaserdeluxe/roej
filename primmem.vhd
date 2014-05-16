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
    --placera minor
"00110100",                             --LDX omedelbar
"00101000",                             --#40
"00000000",                             --LDA abs
"00100000", "00000001",                 --$8193
"11010100",                             --AND omedelbar
"00001111",                             --#15
"00001000",                             --STA absolut
"00001011", "10111000",                 --$3000
"00000000",                             --LDA abs
"00100000", "00000001",                 --$8193
"11010100",                             --AND omedelbar
"00001111",                             --#15
"10111101",                             --LSL
"10111101",                             --LSL
"10111101",                             --LSL
"10111101",                             --LSL
"00010000",                             --ADD absolut
"00001011", "10111000",                 --$3000
"11110100",                             --ADD16 omedelbar
"00001100", "00011100",                 --#3100
"11101000",                             --STA16 absolut
"00001011", "10111001",                 --$3001
"00000100",                             --LDA omedelbar
"00001010",                             --#10
"11011001",                             --CMP indirekt
"00001011", "10111001",                 --$3001
"10010011",                             --JMPZ relativ
"11111111", "11011111",                 --#-33
"00001001",                             --STA indirekt
"00001011", "10111001",                 --$3001
"01001101",                             --DEX
"10010011",                             --JMPZ
"00000000", "00000011",                 --#3
"10000011",                             --JMP -43
"11111111", "11010101",
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

