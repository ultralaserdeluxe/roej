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
-- Sätt stackpekare.
    
"01010100",                             -- LDS omedelbar
"00001111", "11111111",                 -- #4095


-- Initialisera variabler.

-- Bomber minus flaggor
"00000100",                             -- LDA omedelbar
"00101000",                             -- #40
"00001000",                             -- STA absolut
"00001100", "00011011",                 -- $3099

-- Global end game flagga
"00000100",                             -- LDA omedelbar
"00000000",                             -- #0
"00001000",                             -- STA absolut
"00001100", "00011010",                 -- $3098


-- Ladda x- samt y-postioner
-- test
-- xpos
"00000100",                             -- LDA omedelbar
"00001111",                             -- #15
"00001000",                             -- STA absolut
"00001100", "00011001",                 -- #3097
-- ypos
"00000100",                             -- LDA omedelbar
"00001111",                             -- #15
"00001000",                             -- STA absolut
"00001100", "00011000",                 -- #3096
"00000100",                             -- LDA omedelbar
"00000001",                             -- #128
"00001000",                             -- STA absolut
"00001100", "00010111",                 -- #3095


-- Initialisera spelplan.
    
"00000100",                             -- LDA omedelbar
"01000000",                             -- #64
"00110100",                             -- LDX omedelbar
"11111111",                             -- #255
"00001010",                             -- STA indexerad
"00001100", "00011100",                 -- #3100
"01001101",                             -- DEX
"10001011",                             -- JMPN relativ
"00000000", "00000100",                 -- #4
"10000011",                             -- JMP relativ
"11111111", "11110111",                 -- #-9

    
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
"01001011",                             -- #11
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
"10001011",                             -- JMPN SLUT
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
"00000001",                             -- LDA
"00001011", "10111111",                 -- $3007
"00100101",                             -- INC
"00001001",                             -- STA
"00001011", "10111111",                 -- $3007
--nästa x
"11111000",                             -- LDA16ABSOLUT
"00001011", "10111010",                 -- $3002
"00100101",                             -- INC
"11101000",                             -- STA16ABSOLUT
"00001011", "10111010",                 -- $3002
"11011100",                             -- CMP
"00000010",                             -- #2
"10010011",                             -- JMPZ nästa y
"00000000", "00000100",                 -- 4
"10000011",                             -- JMP x_bound
"11111111", "11000101",                 -- -59
--nästa y
"11111000",                             -- LDA16ABSOLUT
"00001011", "10111000",                 -- $3000
"00010100",                             -- ADD
"00010000",                             -- #16
"11101000",                             -- STA16ABSOLUT
"00001011", "10111000",                 -- $3000
"11011100",                             -- CMP
"00100000",                             -- #32
"10010011",                             -- JMPZ 
"11111111", "10001101",                 -- -115
"10000011",                             -- JMP (y-bounds)
"11111111", "10010111",                 -- -105


-- Main loop.

"10011011",                             -- JSR rita spelplan
"00000000", "00001101",                 -- #13
"10011011",                             -- JSR statusrad
"00000000", "01100101",                 -- 101
"10011011",                             -- JSR mushantering
"00000000", "10110010",                 -- #178
"10011011",                             -- JSR End-Game
"00000001", "11111100",                 -- #508 (INNAN NYTT SKIT VAR DETTA
                                        -- VÄRDE 508 - 144)
"10000011",                             -- JMP
"11111111", "11110010",                 -- #-14


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
"10100101",                             -- RTS


-- 101 från hopp i mainanrop
-- Rita statusrad.

"00000000",                             -- LDA
"00100000", "00001000",                 -- $8200
"00010100",                             -- ADD omedelbar
"00010000",                             -- #16
"00001000",                             -- STA
"00010001", "10010001",                 -- $4497
"00000000",                             -- LDA
"00100000", "00000111",                 -- $8199
"00010100",                             -- ADD omedelbar
"00010000",                             -- #16
"00001000",                             -- STA
"00010001", "10010010",                 -- $4498
"00000000",                             -- LDA
"00100000", "00000110",                 -- $8198
"00010100",                             -- ADD omedelbar
"00010000",                             -- #16
"00001000",                             -- STA
"00010001", "10010011",                 -- $4499
"00000100",                             -- LDA
"00001010",                             -- #10
"00001000",                             -- STA
"00001011", "11101010",                 -- $3050 -- nämnare
"00000000",                             -- LDA
"00001100", "00011011",                 -- $3099
"00001000",                             -- STA
"00001011", "11101011",                 -- $3051 -- täljare
"10011011",                             -- JSR division
"00000000", "00010010",                 -- #18
"00000000",                             -- LDA
"00001011", "11101100",                 -- $3052 kvot
"00010100",                             -- ADD omedelbar
"00010000",                             -- #16
"00001000",                             -- STA
"00010001", "10010101",                 -- $4501
"00000000",                             -- LDA
"00001011", "11101101",                 -- $3053 rest
"00010100",                             -- ADD omedelbar
"00010000",                             -- #16
"00001000",                             -- STA
"00010001", "10010110",                 -- $4502
"10100101",                             -- RTS


-- 155 från main-funktionen
-- Division

"00110100",                             -- LDX
"00000000",                             -- #0
"00000000",                             -- LDA
"00001011", "11101011",                 -- $3051 -- täljare
"00011000",                             -- SUB
"00001011", "11101010",                 -- $3050 -- nämnare
"10001011",                             -- JMPN
"00000000", "00000101",                 -- 5
"01000101",                             -- INX
"10000011",                             -- JMP
"11111111", "11110111",                 -- -9
"00010000",                             -- ADD
"00001011", "11101010",                 -- $3050 -- nämnare
"00001000",                             -- STA
"00001011", "11101101",                 -- $3053 rest
"00111000",                             -- STX
"00001011", "11101100",                 -- $3052 kvot
"10100101",                             -- RTS


-- 178 från main-funktionen
-- Mushantering

-- Spara xpos
"00000000",                             -- LDA absolut
"00001100", "00011001",                 -- $3097
"00001000",                             -- STA absolut
"00001011", "10111000",                 -- $3000
-- Spara ypos
"00000000",                             -- LDA absolut
"00001100", "00011000",                 -- $3096
"00001000",                             -- STA absolut
"00001011", "10111001",                 -- $3001
-- Räkna ut adress
"01011101",                             -- LSLx4
"00010000",                             -- ADD absolut
"00001011", "10111000",                 -- $3000
"11110100",                             -- ADD16 omedelbar
"00001100", "00011100",                 -- #3100
"11101000",                             -- STA16 absolut
"00001011", "10111011",                 -- $3003
-- Hantera klick
"00000000",                             -- LDA absolut
"00001100", "00010111",                 -- klick #3095
"00001000",                             -- STA absolut
"00001011", "10111010",                 -- $3002
"11010100",                             -- AND omedelbar
"10000000",                             -- #128
"10010011",                             -- JMPZ hoppa till högerklick-hantering
"00000000", "00101100",                 -- 44
-- Kolla om cellen är synlig
"00000001",                             -- LDA indirekt
"00001011", "10111011",                 -- $3003
"11010100",                             -- AND omedelbar
"10000000",                             -- #128
"10010011",                             -- JMPZ hoppa över rts
"00000000", "00000010",                 -- #2
"10100101",                             -- RTS (gå ur)
-- Kolla om cellen är flaggad
"00000001",                             -- LDA indirekt
"00001011", "10111011",                 -- $3003
"11010100",                             -- AND omedelbar
"01000000",                             -- #64
"10010011",                             -- JMPZ gå ur
"11111111", "11111000",                 -- #-8
-- Kolla om cellen är en mina
"00000001",                             -- LDA indirekt
"00001011", "10111011",                 -- $3003
"11011100",                             -- CMP omedelbar
"01001011",                             -- #75 (kolla om mina)
"10010011",                             -- JMPZ end-game
"00000000", "00101011",                 -- #43
"00110100",                             -- LDX omedelbar
"00000000",                             -- #0
-- Cellen är tom eller numrerad, starta flood-fill
"00000000",                             -- LDA absolut
"00001011", "10111000",                 -- $3000 x-pos
"00001010",                             -- STA index
"00000111", "11010001",                 -- $2001
"00000000",                             -- LDA absolut
"00001011", "10111001",                 -- $3001 y-pos
"00001010",                             -- STA index
"00000111", "11010000",                 -- $2000
"10011011",                             -- JSR (Flood Fill)
"00000000", "00100000",                 -- #32
"10100101",                             -- RTS
-- Högerklick
-- Kolla om högerklick
"00000000",                             -- LDA absolut
"00001011", "10111010",                 -- $3002 klick-info
"11010100",                             -- AND omedelbar
"00000001",                             -- #1 högerklick
"10010011",                             -- JMPZ hoppa tll rts
"00000000", "00001010",                 -- #10
-- Kolla om cellen är synlig
"00000001",                             -- LDA indirekt
"00001011", "10111011",                 -- $3003 spelplanscell
"11010100",                             -- AND omedelbar
"10000000", "00000000",                 -- #128
"10010011",                             -- JMPZ hoppa över rts
"00000000", "00000010",                 -- #2
"10100101",                             -- RTS
-- Cellen är osynlig, toggla flagga
"10101100",                             -- XOR omedelbar
"01000000",                             -- #64 toggla flagga
"00001001",                             -- STA indirekt
"00001011", "10111011",                 -- $3003 spelplanscell
"10100101",                             -- RTS
-- End-game, sätt end-game flagga i minnet
"00000100",                             -- LDA omedelbar
"00000001",                             -- #1 
"00001000",                             -- STA absolut
"00001100", "00011010",                 -- $3098 game over flagga
"10100101",                             -- RTS


-- Flood fill
-- Hämta ypos
"00000010",                             -- LDA index
"00000111", "11010000",                 -- $2000
-- Kolla om ypos är giltig
"11010100",                             -- AND omedelbar
"11110000",                             -- #240
"10010011",                             -- JMPZ
"00000000", "00000010",                 -- #2
-- Hoppar ur rekursionen
"10100101",                             -- RTS
-- Hämta xpos
"00000010",                             -- LDA index
"00000111", "11010001",                 -- $2001
-- Kolla om xpos är giltig
"11010100",                             -- AND omedelbar
"11110000",                             -- #240
"10010011",                             -- JMPZ
"00000000", "00000010",                 -- #2
-- Hoppa ur rekursionen
"10100101",                             -- RTS
-- Räkna ut adress
"00000010",                             -- LDA8 indexerad
"00000111", "11010000",                 -- $2000
"01011101",                             -- LSLx4
"00010010",                             -- ADD index
"00000111", "11010001",                 -- $2001
"11110100",                             -- ADD16 omedelbar
"00001100", "00011100",                 -- #3100
"11101000",                             -- STA16 absolut
"00001011", "10111010",                 -- $3002
-- Hämta cellen
"00000001",                             -- LDA indirekt
"00001011", "10111010",                 -- $3002
-- Kolla om cellen är flaggad
"11010100",                             -- AND
"01000000",                             -- #64
-- Hoppa ur om cellen är flaggad
"10010011",                             -- JMPZ 
"00000000", "00101011",                 -- #43
-- Hämta cellen igen
"00000001",                             -- LDA indirekt
"00001011", "10111010",                 -- $3002
-- Kolla om cellen är synlig
"11010100",                             -- AND omedelbar
"10000000",                             -- #128
-- Hoppa till 'gör cellen synlig'
"10010011",                             -- JMPZ
"00000000", "00000010",                 -- #2
-- Hoppa ur rekursionen
"10100101",                             -- RTS
-- Gör cellen synlig
"00000001",                             -- LDA indirekt
"00001011", "10111010",                 -- $3002
"11001100",                             -- OR omedelbar
"10000000",                             -- #128
"00001001",                             -- STA indirekt
"00001011", "10111010",                 -- $3002
-- Kolla om cellen är en nolla
"11010100",                             -- AND omedelbar
"00001111",                             -- #15
-- Hoppa till rekursivt anrop
"10010011",                             -- JMPZ
"00000000", "00000010",                 -- 2
-- Hoppa ur rekursionen
"10100101",                             -- RTS
-- Rekursivt anrop
-- Nord
-- Spara ny xpos
"00000010",                             -- LDA indexerad
"00000111", "11010001",                 -- $2001
"00001010",                             -- STA indexerad
"00000111", "11010011",                 -- $2003
-- Spara ny ypos
"00000010",                             -- LDA indexerad
"00000111", "11010000",                 -- $2000
"00101101",                             -- DECA
"00001010",                             -- STA indexerad
"00000111", "11010010",                 -- $2002
-- Öka indexeringen
"01000101",                             -- INX
"01000101",                             -- INX
-- Starta om algoritm
"10011011",                             -- JSR
"11111111", "10110001",                 -- #-79
"01001101",                             -- DEX
"01001101",                             -- DEX
-- NYTT SKIT
-- Nordost
-- Spara ny xpos
"00000010",                             -- LDA indexerad
"00000111", "11010001",                 -- $2001
"00100101",                             -- INCA
"00001010",                             -- STA indexerad
"00000111", "11010011",                 -- $2003
-- Spara ny ypos
"00000010",                             -- LDA indexerad
"00000111", "11010000",                 -- $2000
"00101101",                             -- DECA
"00001010",                             -- STA indexerad
"00000111", "11010010",                 -- $2002
-- Öka indexeringen
"01000101",                             -- INX
"01000101",                             -- INX
-- Starta om algoritm
"10011011",                             -- JSR
"11111111", "10011100",                 -- #-100
"01001101",                             -- DEX
"01001101",                             -- DEX
-- Ost
-- Spara ny xpos
"00000010",                             -- LDA indexerad
"00000111", "11010001",                 -- $2001
"00100101",                             -- INCA
"00001010",                             -- STA indexerad
"00000111", "11010011",                 -- $2003
-- Spara ny ypos
"00000010",                             -- LDA indexerad
"00000111", "11010000",                 -- $2000
"00001010",                             -- STA indexerad
"00000111", "11010010",                 -- $2002
-- Öka indexeringen
"01000101",                             -- INX
"01000101",                             -- INX
-- Starta om algoritm
"10011011",                             -- JSR
"11111111", "10001000",                 -- #-120
"01001101",                             -- DEX
"01001101",                             -- DEX
-- Sydost
-- Spara ny xpos
"00000010",                             -- LDA indexerad
"00000111", "11010001",                 -- $2001
"00100101",                             -- INCA
"00001010",                             -- STA indexerad
"00000111", "11010011",                 -- $2003
-- Spara ny ypos
"00000010",                             -- LDA indexerad
"00000111", "11010000",                 -- $2000
"00100101",                             -- INCA
"00001010",                             -- STA indexerad
"00000111", "11010010",                 -- $2002
-- Öka indexeringen
"01000101",                             -- INX
"01000101",                             -- INX
-- Starta om algoritm
"10011011",                             -- JSR
"11111111", "01110011",                 -- #-141
"01001101",                             -- DEX
"01001101",                             -- DEX
-- Syd
-- Spara ny xpos
"00000010",                             -- LDA indexerad
"00000111", "11010001",                 -- $2001
"00001010",                             -- STA indexerad
"00000111", "11010011",                 -- $2003
-- Spara ny ypos
"00000010",                             -- LDA indexerad
"00000111", "11010000",                 -- $2000
"00100101",                             -- INCA
"00001010",                             -- STA indexerad
"00000111", "11010010",                 -- $2002
-- Öka indexeringen
"01000101",                             -- INX
"01000101",                             -- INX
-- Starta om algoritm
"10011011",                             -- JSR
"11111111", "01011111",                 -- #-161
"01001101",                             -- DEX
"01001101",                             -- DEX
-- Sydväst
-- Spara ny xpos
"00000010",                             -- LDA indexerad
"00000111", "11010001",                 -- $2001
"00101101",                             -- DECA
"00001010",                             -- STA indexerad
"00000111", "11010011",                 -- $2003
-- Spara ny ypos
"00000010",                             -- LDA indexerad
"00000111", "11010000",                 -- $2000
"00100101",                             -- INCA
"00001010",                             -- STA indexerad
"00000111", "11010010",                 -- $2002
-- Öka indexeringen
"01000101",                             -- INX
"01000101",                             -- INX
-- Starta om algoritm
"10011011",                             -- JSR
"11111111", "01001010",                 -- #-182
"01001101",                             -- DEX
"01001101",                             -- DEX
-- Väst
-- Spara ny xpos
"00000010",                             -- LDA indexerad
"00000111", "11010001",                 -- $2001
"00101101",                             -- DECA
"00001010",                             -- STA indexerad
"00000111", "11010011",                 -- $2003
-- Spara ny ypos
"00000010",                             -- LDA indexerad
"00000111", "11010000",                 -- $2000
"00001010",                             -- STA indexerad
"00000111", "11010010",                 -- $2002
-- Öka indexeringen
"01000101",                             -- INX
"01000101",                             -- INX
-- Starta om algoritm
"10011011",                             -- JSR
"11111111", "00110110",                 -- #-202
"01001101",                             -- DEX
"01001101",                             -- DEX
-- Nordväst
-- Spara ny xpos
"00000010",                             -- LDA indexerad
"00000111", "11010001",                 -- $2001
"00101101",                             -- DECA
"00001010",                             -- STA indexerad
"00000111", "11010011",                 -- $2003
-- Spara ny ypos
"00000010",                             -- LDA indexerad
"00000111", "11010000",                 -- $2000
"00101101",                             -- DECA
"00001010",                             -- STA indexerad
"00000111", "11010010",                 -- $2002
-- Öka indexeringen
"01000101",                             -- INX
"01000101",                             -- INX
-- Starta om algoritm
"10011011",                             -- JSR
"11111111", "00100001",                 -- #-223
"01001101",                             -- DEX
"01001101",                             -- DEX
-- SLUT NYTT SKIT
"10100101",                             -- RTS


-- End Game

-- Ladda global End-game-flagga
"00000000",                             -- LDA absolut
"00001100", "00011010",                 -- $3098
"11011100",                             -- CMP
"00000001",                             -- #1
"10010011",                             -- JMPZ
"00000000", "00000010",                 -- #2
"10100101",                             -- RTS
"00110100",                             -- LDX omedelbar
"11111111",                             -- #255
-- Hämta spelcell
"00000010",                             -- LDA indexerad
"00001100", "00011100",                 -- #3100
-- Gör cellen synlig
"11001100",                             -- OR omedelbar
"10000000",                             -- #128
-- Spara cellen
"00001010",                             -- STA indexerad
"00001100", "00011100",                 -- #3100
-- Börja om
"01001101",                             -- DEX
"10001011",                             -- JMPN relativ
"00000000", "00000100",                 -- #4
"10000011",                             -- JMP relativ
"11111111", "11110010",                 -- #-14
-- Rita ut spelplan
"10011011",                             -- JSR
"11111101", "11101100",                 -- #-532 (INNAN NYTT SKIT så var detta
                                        -- värde -532 + 144)
-- HALT i Tengils namn
"00000111",
 
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

