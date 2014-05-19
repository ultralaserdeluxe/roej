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

type primmem_type is array (0 to 4095) of std_logic_vector(7 downto 0);
  signal primmem : primmem_type := (
-- Initialisera spelplan.
    
"00000100",                             -- LDA omedelbar
"11000000",                             -- #64
"00110100",                             -- LDX omedelbar
"11111111",                             -- #255
"00001010",                             -- STA indexerad
"00001100", "00011100",                 -- #3100
"01001101",                             -- DEX
"10001011",                             -- JMPN relativ
"00000000", "00000100",                 -- #4
"10000011",                             -- JMP relativ
"11111111", "11110110",                 -- #-10

    
-- Placera minor.

"00110100",                             -- LDX omedelbar
"00101000",                             -- #40
-- Hämta slumptal.
"00000000",                             -- LDA abs
"00100000", "00000001",                 -- $8193
-- Skapa x-offset.
"11010100",                             -- AND omedelbar
"00001111",                             -- #15
"00001000",                             -- STA absolut
-- Spara x-offset i 3000.
"00001011", "10111000",                 -- $3000
-- Skapa y-offset.
"00000000",                             -- LDA abs
"00100000", "00000001",                 -- $8193
"11010100",                             -- AND omedelbar
"00001111",                             -- #15
"10111101",                             -- LSL
"10111101",                             -- LSL
"10111101",                             -- LSL
"10111101",                             -- LSL
-- Lägg ihop x och y-offset.
"00010000",                             -- ADD absolut
"00001011", "10111000",                 -- $3000
-- Lägg till konstant (pekare in i spelplansdatastrukturen).
"11110100",                             -- ADD16 omedelbar
"00001100", "00011100",                 -- #3100
-- Spara adress i 3001.
"11101000",                             -- STA16 absolut
"00001011", "10111001",                 -- $3001
-- Ladda A med värdet för en osynlig mina.
"00000100",                             -- LDA omedelbar
"11001011",                             -- #11
-- Kolla om en mina redan ligger på den platsen.
"11011001",                             -- CMP indirekt
"00001011", "10111001",                 -- $3001
-- Börja om isf.
"10010011",                             -- JMPZ relativ
"11111111", "11011111",                 -- #-33
-- Spara minan i datastrukturen.
"00001001",                             -- STA indirekt
"00001011", "10111001",                 -- $3001
-- Räkna ner och börja om.
"01001101",                             -- DEX
"10010011",                             -- JMPZ
"00000000", "00000101",                 -- #5
"10000011",                             -- JMP -43
"11111111", "11010101",
"10101101",                             -- HH


-- Generera siffror.

"00110100",                             -- LDX omedelbar
"11111111",                             -- #255
-- Kolla mina och slut.
"00000010",                             -- LDA indexerad
"00001100", "00011100",                 -- #3100
"11010100",                             -- AND omedelbar
"00001111",                             -- #15
"11011100",                             -- CMP omedelbar
"00001011",                             -- #11
"10010011",                             -- JMPZ
"00000000", "00001000",
"01001101",                             -- DEX
"10001011",                             -- JMPN
"00000000", "01110100",
"10000011",                             -- JMP början
"11111111", "11110000",
-- Initiera y- och x-tillägg.
"11100100",                             -- LDA16
"11111111", "11110000",                 -- -16
"11101000",                             -- STA16
"00001011", "10111000",                 -- $3000
"11100100",                             -- LDA16
"11111111", "11111111",                 -- -1
"11101000",                             -- STA16
"00001011", "10111010",                 -- $3002
-- y-bounds
"00111000",                             -- STX
"00001011", "10111100",                 -- $3004
"00000000",                             -- LDA
"00001011", "10111100",                 -- $3004
"11010100",                             -- AND
"11110000",
"11000000",                             -- ADD16ABSOLUT
"00001011", "10111000",                 -- $3000
"10001011",                             -- JMPN
"00000000", "01000111",                 -- 71 
"10110101",                             -- LSR
"11011100",                             -- CMP
"10000000",                             -- #128
"10010011",                             -- JMPZ
"00000000", "01000001",                 -- 65
"10111101",                             -- LSL
"00001000",                             -- STA
"00001011", "10111101",                 -- $3005
-- x-bounds
"00000000",                             -- LDA
"00001011", "10111100",                 -- $3004
"11010100",                             -- AND
"00001111",                             -- #15
"11000000",                             -- ADD16ABSOLUT
"00001011", "10111010",                 -- $3002
"10001011",                             -- JMPN
"00000000", "00100011",                 -- 35
"11011100",                             -- CMP
"00010000",                             -- #16
"10010011",                             -- JMPZ
"00000000", "00011110",                 -- 30
"00001000",                              --STA
"00001011", "10111110",                 -- $3006

"00010000",                             -- ADD
"00001011", "10111101",                 -- $3005
"11110100",                             -- ADD16
"00001100", "00011100",                 -- #3100
"11101000",                             -- STA16ABSOLUT
"00001011", "10111111",                 -- $3007
"00000001",                             -- LDA
"00001011", "10111111",                 -- $3007
"11010100",                             -- AND
"00001111",                             -- #15
"11011100",                             -- CMP
"00001011",                             -- mina
"10010011",                             -- JMPZ
"00000000", "00001000",                 -- 8
"11111001",                             -- LDA16ABSOLUT(IDIREKT A.MOD)
"00001011", "10111111",                 -- $3007
"00100101",                             -- INC
"11101001",                             -- STA16ABSOLUT(IDIREKT A.MOD)
"00001011", "10111111",                 -- $3007
--nästa x
"11111000",                             -- LDA16ABSOLUT
"00001011", "10111010",                 -- $3002
"00100101",                             -- INC
"11101000",                             -- STA16
"00001011", "10111010",                 -- $3002
"11011100",                             -- CMP
"00000010",                             -- #2
                   -- RESET X-TILLÄG till -1 SAMMA GÄLLER inte Y (antagligen)
"10010011",                             -- JMPZ nästa y
"00000000", "00000100",                 -- 4
"10000011",                             -- JMP x_bound
"11111111", "11000101",                 -- -59
--nästa y
"11111000",                             -- LDA16ABSOLUT
"00001011", "10111000",                 -- $3000
"00010100",                             -- ADD
"00010000",                             -- #16
"11101000",                             -- STA16
"00001011", "10111000",                 -- $3000
"11011100",                             -- CMP
"00100000",                             -- #32
"10010011",                             -- JMPZ 
"11111111", "10001101",                 -- -115
"10000011",                             -- JMP (y-bounds)
--"11111111", "10110101",                 -- -75
"11111111", "10010111",                 -- -105


-- Rita spelplan.

-- Vänta på VSYNC.
"00000000",                             -- LDA absolut
"00100000", "00001001",                 -- $8201
"11010100",                             -- AND omedelbar
"00000001",                             -- #1
"10010011",                             -- JMPZ relativ
"11111111", "11111001",                 -- #-7
-- Ladda indexräknaren.
"00110100",                             -- LDX omedelbar
"11111111",                             -- #255
"00111000",                             -- STX absolut
"00001011", "10111000",                 -- $3000
"00000000",                             -- LDA absolut
"00001011", "10111000",                 -- $3000
-- x-offset
"11010100",                             -- AND omedelbar
"00001111",                             -- #15
"00001000",                             -- STA absolut
"00001011", "10111001",                 -- $3001
-- y-offset
"00000000",                             -- LDA absolut
"00001011", "10111000",                 -- $3000
"11010100",                             -- AND omedelbar
"11110000",                             -- #240
"10111101",                             -- LSL underförstådd
"10111101",                             -- LSL underförstådd
"00010000",                             -- ADD absolut
"00001011", "10111001",                 -- $3001
-- Lägg till konstant till adressen.
"11110100",                             -- ADD16 omedelbar
"00010001", "11001100",                 -- #4096
-- Spara adress till grafikminnet i 3002.
"11101000",                             -- STA16 absolut
"00001011", "10111010",                 -- $3002
-- Kolla om vi ska rita en flagga.
"00000010",                             -- LDA indexerad
"00001100", "00011100",                 -- #3100
"11010100",                             -- AND omedelbar
"01000000",                             -- #64
"10010011",                             -- JMPZ relativ
"00000000", "00010110",                 -- #22
-- Kolla om vi ska rita ett osynligt block.
"00000010",                             -- LDA indexerad
"00001100", "00011100",                 -- #3100
"11010100",                             -- AND omedelbar
"10000000",                             -- #128
"10010011",                             -- JMPZ relativ
"00000000", "00011010",                 -- #26
-- Rita synligt block.
"00000010",                             -- LDA indexerad
"00001100", "00011100",                 -- #3100
"00001001",                             -- STA indirekt
"00001011", "10111010",                 -- $3002
"01001101",                             -- DEX underförstådd
"10001011",                             -- JMPN relativ
"00000000", "00011100",                 -- #28
"10000011",                             -- JMP relativ
"11111111", "11001001",                 -- #-55
-- Rita flagga.
"00000100",                             -- LDA omedelbar
"00001100",                             -- #12
"00001001",                             -- STA indirekt
"00001011", "10111010",                 -- $3002
"01001101",                             -- DEX underförstådd
"10001011",                             -- JMPN relativ
"00000000", "00010000",                 -- #16
"10000011",                             -- JMP relativ
"11111111", "10111101",
-- Rita osynligt block.
"00000100",                             -- LDA omedelbar
"00001010",                             -- #10
"00001001",                             -- STA indirekt
"00001011", "10111010",                 -- $3002
"01001101",                             -- DEX underförstådd
"10001011",                             -- JMPN relativ
"00000000", "00000100",
"10000011",                             -- JMP relativ
"11111111", "10110001",

"10101101",                             -- HH
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

