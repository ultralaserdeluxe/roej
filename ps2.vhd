library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ps2 is

  port(
    clk : in std_logic;
    rst : in std_logic;
    PS2MouseData : in std_logic;
    PS2MouseClk : in std_logic;
    led : out std_logic_vector(0 to 7));
  
end ps2;
    
architecture ps2_behv of ps2 is
  
begin

  led <= "01010101";
  
end ps2_behv;
