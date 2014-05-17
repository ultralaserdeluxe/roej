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
  
  alias ps2_data : std_logic is ja(4);
  alias ps2_clk : std_logic is ja(6);

  signal data_enable : std_logic := '0';
  signal data_out : std_logic;
  signal data_in : std_logic;

  signal clk_enable : std_logic := '0';
  signal clk_out : std_logic;
  signal clk_in : std_logic;

  signal clk_sync_reg : std_logic_vector(1 to 3);
  signal data_sync_reg : std_logic_vector(1 to 3);
  signal clk_rise : std_logic;
  signal clk_fall : std_logic;

  type state_type is (init, set_clock_low, set_data_low, release_clk,
                      send_bit, wait_clk_high_tx, wait_clk_low_tx, wait_clk_high_ack,
                      wait_clk_low_ack, wait_clk_rel_ack, wait_clk_low_ack_command,
                      get_ack_command_bit, wait_clk_high_ack_command,
                      wait_clk_low_rx, wait_clk_high_rx, get_bit, rx_done, rx_done_2);
  signal state : state_type := init;

  -- 500 us delay counter
  constant delay_500_max : std_logic_vector(15 downto 0) := "1100001101010000";
  signal delay_500_value : std_logic_vector(15 downto 0);
  signal delay_500_enable : std_logic;
  signal delay_500_reset : std_logic;
  signal delay_500_done : std_logic;

  -- 200 us delay counter
  constant delay_200_max : std_logic_vector(15 downto 0) := "0100111000100000";
  signal delay_200_value : std_logic_vector(15 downto 0);
  signal delay_200_enable : std_logic;
  signal delay_200_reset : std_logic;
  signal delay_200_done : std_logic;
  
  -- 15 us delay counter
  constant delay_15_max : std_logic_vector(15 downto 0) := "0000010111011100";
  signal delay_15_value : std_logic_vector(15 downto 0);
  signal delay_15_enable : std_logic;
  signal delay_15_reset : std_logic;
  signal delay_15_done : std_logic;  
  
  -- Enable data reporting command, 0xF4.
  -- Parity and stop bits in front of 0xF4. Start bit excluded.
  signal command : std_logic_vector(9 downto 0) := "1011110100";
  signal bit_counter : std_logic_vector(3 downto 0) := "0000";

  signal mouse_data_packet : std_logic_vector(32 downto 0) := "000000000000000000000000000000000";
  signal mouse_data_counter : std_logic_vector(5 downto 0) := "000000";
  signal command_ack_packet : std_logic_vector(10 downto 0);

  signal num_clicks : std_logic_vector(1 downto 0) := "00";
  signal mouse_clicks : std_logic_vector(1 downto 0) := "00";
  
begin

  -- Tri-state buffers.
  
  ps2_data <= data_out when data_enable = '1' else 'Z';
  ps2_clk <= clk_out when clk_enable = '1' else 'Z';


  -- Sync and rise/fall detection.

  process(clk)
  begin
    if rising_edge(clk) then
      data_sync_reg <= ps2_data & data_sync_reg(1 to 2);
      clk_sync_reg <= ps2_clk & clk_sync_reg(1 to 2);
    end if;
  end process;

  clk_rise <= clk_sync_reg(2) and not clk_sync_reg(3);
  clk_fall <= clk_sync_reg(3) and not clk_sync_reg(2);
  data_in <= data_sync_reg(3);
  clk_in <= clk_sync_reg(3);
  
  
  -- Leds.

  --led(0) <= data_in;
  led(0) <= clk_in;

  
  -- State machine.

  process(clk)
  begin
    if rising_edge(clk) then
      delay_500_enable <= '0';
      delay_500_reset <= '1';
      delay_200_enable <= '0';
      delay_200_reset <= '1';
      delay_15_enable <= '0';
      delay_15_reset <= '1';
      clk_enable <= '0';
      data_enable <= '0';
      
      if state = init then
        led(1 to 5) <= "00000";

        clk_enable <= '0';
        data_enable <= '0';

        num_clicks <= "00";
        mouse_data_counter <= (others => '0');
        mouse_data_packet <= (others => '0');
        command_ack_packet <= (others => '0');

        delay_500_enable <= '1';
        delay_500_reset <= '0';

      elsif state = set_clock_low then
        led(1 to 5) <= "00001";
        
        clk_enable <= '1';
        clk_out <= '0';

        delay_200_enable <= '1';
        delay_200_reset <= '0';

      elsif state = set_data_low then
        led(1 to 5) <= "00010";

        clk_enable <= '1';
        clk_out <= '0';
        data_enable <= '1';
        data_out <= '0';
        
        delay_15_enable <= '1';
        delay_15_reset <= '0';

      elsif state = release_clk then
        led(1 to 5) <= "00011";

        clk_enable <= '0';
        data_enable <= '1';
        data_out <= '0';

      elsif state = send_bit then
        led(1 to 5) <= "00100";

        data_enable <= '1';        
        data_out <= command(0);
        command <= '0' & command(9 downto 1);
        bit_counter <= bit_counter + 1;

      elsif state = wait_clk_high_tx then
        led(1 to 5) <= "00101";

        data_enable <= '1';
        
      elsif state = wait_clk_low_tx then
        led(1 to 5) <= "00110";

        data_enable <= '1';

      elsif state = wait_clk_high_ack then
        led(1 to 5) <= "00111";

      elsif state = wait_clk_low_ack then
        led(1 to 5) <= "01000";

      elsif state = wait_clk_rel_ack then
        led(1 to 5) <= "01001";

      elsif state = wait_clk_low_ack_command then
        led(1 to 5) <= "01010";

      elsif state = get_ack_command_bit then
        led(1 to 5) <= "01011";

        command_ack_packet <= data_in & command_ack_packet(10 downto 1);

      elsif state = wait_clk_high_ack_command then
        led(1 to 5) <= "01100";

      elsif state = wait_clk_low_rx then
        led(1 to 5) <= "01101";

      elsif state = wait_clk_high_rx then
        led(1 to 5) <= "01110";

      elsif state = get_bit then
        led(1 to 5) <= "01111";

        mouse_data_packet <= data_in & mouse_data_packet(32 downto 1);
        mouse_data_counter <= mouse_data_counter + 1;

      elsif state = rx_done then
        led(1 to 5) <= "10000";

        mouse_data_counter <= (others => '0');

        led(6) <= mouse_data_packet(1);
        led(7) <= mouse_data_packet(2);

      end if;
    end if;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        state <= init;
        
      elsif state = init and delay_500_done = '1' then
        state <= set_clock_low;

      elsif state = set_clock_low and delay_200_done = '1' then
        state <= set_data_low;

      elsif state = set_data_low and delay_15_done = '1' then
        state <= release_clk;

      elsif state = release_clk and clk_fall = '1' then
        state <= send_bit;

      elsif state = send_bit then
        state <= wait_clk_high_tx;

      elsif state = wait_clk_high_tx and clk_rise = '1' then
        state <= wait_clk_low_tx;

      elsif state = wait_clk_low_tx  and clk_fall = '1' then
        if bit_counter = "1010" then
          state <= wait_clk_high_ack;
        else
          state <= send_bit;
        end if;

      elsif state = wait_clk_high_ack and clk_rise = '1' then
        state <= wait_clk_low_ack;

      elsif state = wait_clk_low_ack and clk_fall = '1' then
        state <= wait_clk_rel_ack;

      elsif state = wait_clk_rel_ack and clk_rise = '1' then
        state <= wait_clk_low_ack_command;

      elsif state = wait_clk_low_ack_command and clk_fall = '1' then
        state <= get_ack_command_bit;

      elsif state = get_ack_command_bit then
        if command_ack_packet = "10111101000" then
          state <= wait_clk_low_rx;
        else
          state <= wait_clk_high_ack_command;
        end if;

      elsif state = wait_clk_high_ack_command and clk_rise = '1' then
        state <= wait_clk_low_ack_command;        

      elsif state = wait_clk_low_rx and clk_fall = '1' then
        state <= get_bit;

      elsif state = wait_clk_high_rx and clk_rise = '1' then
        state <= wait_clk_low_rx;

      elsif state = get_bit then
        if mouse_data_counter = "100001" then
          state <= rx_done;
        else
          state <= wait_clk_high_rx;
        end if;

      elsif state = rx_done then
        state <= wait_clk_low_rx;

      end if;
    end if;
  end process;

  
  -- Delay counters

  counter_500 : counter
    generic map (
      n => 16)
    port map (
      clk => clk,
      reset => delay_500_reset,
      enable => delay_500_enable,
      value => delay_500_value);

  counter_200 : counter
    generic map (
      n => 16)
    port map (
      clk => clk,
      reset => delay_200_reset,
      enable => delay_200_enable,
      value => delay_200_value);

  counter_15 : counter
    generic map (
      n => 16)
    port map (
      clk => clk,
      reset => delay_15_reset,
      enable => delay_15_enable,
      value => delay_15_value);

  process(clk)
  begin
    if rising_edge(clk) then
        delay_500_done <= '0';
        delay_200_done <= '0';        
        delay_15_done <= '0';        

      if delay_500_value = delay_500_max then
        delay_500_done <= '1';
      end if;
        

      if delay_200_value = delay_200_max then
        delay_200_done <= '1';
      end if;

      if delay_15_value = delay_15_max then
        delay_15_done <= '1';
      end if;
        
    end if;
  end process;

end ps2_behv;
