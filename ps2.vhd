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

  component counter
    generic (
      n : integer);
    port (
      clk    : in  std_logic;
      reset  : in  std_logic;
      enable : in  std_logic;
      value  : out std_logic_vector(n - 1 downto 0));
  end component;
  
  alias ps2_data : std_logic is ja(5);
  alias ps2_clk : std_logic is ja(7);

  signal data_enable : std_logic := '0';
  signal data_out : std_logic;
  signal data_in : std_logic;

  signal clk_enable : std_logic := '0';
  signal clk_out : std_logic;
  signal clk_in : std_logic;

  type state_type is (init, post_init, get_bat_byte);
  signal state : state_type := init;

  constant delay_50_us : std_logic_vector := "1001110001000";
  signal delay_reset : std_logic;
  signal delay_enable : std_logic;
  signal delay_value : std_logic_vector(12 downto 0);

  signal bat_byte : std_logic_vector(10 downto 0) := "00000000000";
  
begin

  -- Tri-state buffers.
  
  ps2_data <= data_out when data_enable = '1' else 'Z';
  data_in <= ps2_data;

  ps2_clk <= clk_out when clk_enable = '1' else 'Z';
  clk_in <= ps2_clk;


  -- Leds.

  led(0) <= data_in;
  led(1) <= clk_in;
  led(4 to 7) <= bat_byte(5 downto 2);


  delay_cnt : counter
    generic map (
      n => 13)
    port map (
      clk => clk,
      reset => delay_reset,
      enable => delay_enable,
      value => delay_value);
      
  
  -- State machine.

  process(clk, clk_in)
  begin
    if rising_edge(clk) then
      if state = init then
        led(2 to 3) <= "00";

        clk_enable <= '1';
        clk_out <= '0';
        
        delay_enable <= '1';
        delay_reset <= '0';
        if delay_value = delay_50_us then
          state <= post_init;
          delay_enable <= '0';
          delay_reset <= '1';
        end if;
      elsif state = post_init then
        led(2 to 3) <= "01";

        clk_enable <= '0';

        delay_enable <= '1';
        delay_reset <= '0';
        if delay_value = delay_50_us then
          state <= get_bat_byte;
          delay_enable <= '0';
          delay_reset <= '1';
        end if;
      elsif state = get_bat_byte then
        led(2 to 3) <= "10";

        if falling_edge(clk_in) then
          bat_byte <= data_in & bat_byte(9 downto 0);
        end if;
      end if;
    end if;
  end process;
  
end ps2_behv;
