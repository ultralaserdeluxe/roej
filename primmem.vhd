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
--"00000100",                             --LDA
--"00000110",                             --6
--"00001000",                             --STA
--"00010000", "00000000",                 --4096
--"00000100",                             --LDA
--"00000100",                             --4
--"10110101",                             --LSR
--"00001000",                             --STA
--"00010000", "00000001",                 --4097
--"10111101",                             --LSL
--"00001000",                             --STA
--"00010000", "00000010",                 --4098
--"11010100",                             --AND
--"00000000",                             --0
--"00001000",                             --STA
--"00010000", "00000011",                 --4099
--"00000100",                             --LDA
--"00000011",                             --3
--"11011100",                             --CMP
--"00000011",                             --3
--"10010011",                             --JMPZ
--"00000000", "00000001",                 --1
--"10101101",                             --HH
--"00001000",                             --STA
--"00010000", "00000100",                 --4100
--"10101101",                             --HH

    --placera minor
--"00110100",                             --LDX omedelbar
--"00000000",                             --#40
--"00000000",                             --LDA abs
--"00100000", "00000001",                 --$8193
--"11010100",                             --AND omedelbar
--"00001111",                             --#15
--"00001000",                             --STA absolut
--"00001011", "10111000",                 --$3000
--"00000000",                             --LDA abs
--"00100000", "00000001",                 --$8193
--"11010100",                             --AND 
--"00001111",                             --#15
--"10111101",                             --LSL
--"10111101",                             --LSL
--"10111101",                             --LSL
--"10111101",                             --LSL
--"00010000",                             --ADD
--"00001011", "10111000",                 --$3000
--"11110000",                             --ADD16
--"00001100", "00011100",                 --#3100
--"00001000",                             --STA
--"00001011", "10111001",                 --$3001
--"00000100",                             --LDA
--"00001010",                             --#10
--"00000001",                             --CMP indirekt
--"00001011", "10111001",                 --$3001
--"10010100",                             --JMPZ
--"11111111", "11011111",                 --#-33
--"11101000",                             --STA16
--"00001011", "10111001",                 --$3001
--"01001101",                             --DEX
--"10010100",                             --JMPZ
--"00000000", "00000100",                 --#4
--"10000100",                             --JMP -25
--"11111111", "11010101",
--"10101101",                             --HH


  "11100100",                           --LDA16
  "00000001", "00000010",               -- 1 2
  "11101000",                           --STA16
  "00010000", "00100110",               -- 4134
  "11110100",                           --ADD16
  "00000001", "00000010",
  "11101000",                           --STA16
  "00010011", "11010100",               --5076
  "10101101",
  
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

