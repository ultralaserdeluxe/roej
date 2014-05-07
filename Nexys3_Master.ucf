library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ps2 is

  port(
    clk : in std_logic;
    rst : in std_logic;
    ja : inout std_logic_vector(0 to 7);
    led : out std_logic_vector(0 to 7));
  
end ps2;
    
architecture ps2_behv of ps2 is
  
  type state_type is (INIT, NOT_INIT);
  signal state : state_type := INIT;

  alias ps2_data : std_logic is ja(5);
  alias ps2_clk : std_logic is ja(6);
  
begin

  led(0 to 1) <= ps2_data & ps2_clk;
  led(2 to 7) <= "000000";
  
end ps2_behv;
