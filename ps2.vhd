library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ps2 is

  port(
    clk : in std_logic;
    rst : in std_logic;
    ja : inout std_logic_vector(0 to 7);
    led : out std_logic_vector(0 to 7);
    x_position   : out std_logic_vector(9 downto 0);
    y_position   : out std_logic_vector(9 downto 0);
    click : out std_logic_vector(7 downto 0);
    x_tile_pos : out std_logic_vector(7 downto 0);
    y_tile_pos : out std_logic_vector(7 downto 0);
    read : in std_logic);  
  
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
  signal rst_sync_reg : std_logic_vector(1 to 3);
  signal clk_rise : std_logic;
  signal clk_fall : std_logic;
  signal rst_rise : std_logic;

  type state_type is (init, set_clock_low, set_data_low, release_clk,
                      wait_clk_low_1, send_bit, wait_clk_high, wait_clk_low_2,
                      done, wait_clk_high_2, wait_clk_low_3, wait_half_second);
  signal state : state_type := init;

  constant delay_500_us : std_logic_vector(15 downto 0) := "1100001101010000";
  constant delay_200_us : std_logic_vector(15 downto 0) := "0100111000100000";
  constant delay_15_us : std_logic_vector(15 downto 0) := "0000010111011100";
  signal delay_reset : std_logic;
  signal delay_enable : std_logic;
  signal delay_value : std_logic_vector(15 downto 0);

  -- Enable data reporting command, 0xF4.
  -- Parity and stop bits in front of 0xF4. Start bit excluded.
  signal command : std_logic_vector(9 downto 0) := "1011110100";
  signal bit_counter : std_logic_vector(3 downto 0) := "0000";

  signal mouse_data_packet : std_logic_vector(32 downto 0) := "000000000000000000000000000000000";
  signal mouse_data_counter : std_logic_vector(5 downto 0) := "000000";

  signal half_second_counter : std_logic_vector(31 downto 0);
  signal xpos : std_logic_vector(9 downto 0) := "0000000000";
  signal ypos : std_logic_vector(9 downto 0) := "0000000000";
  signal xvel : std_logic_vector(9 downto 0) := "0000000000";
  signal yvel : std_logic_vector(9 downto 0) := "0000000000";
  signal x_tile_temp : std_logic_vector(9 downto 0) := "1111111111";
  signal y_tile_temp : std_logic_vector(9 downto 0) := "1111111111";  
  signal data_read : std_logic := '0';
  
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
      rst_sync_reg <= rst & rst_sync_reg(1 to 2);
    end if;
  end process;

  clk_rise <= clk_sync_reg(2) and not clk_sync_reg(3);
  clk_fall <= clk_sync_reg(3) and not clk_sync_reg(2);
  rst_rise <= rst_sync_reg(3) and not rst_sync_reg(2);
  data_in <= data_sync_reg(3);
  clk_in <= clk_sync_reg(3);
  
  
  -- Leds.

  led(0) <= data_in;
  led(1) <= clk_in;
  led(6) <= mouse_data_packet(1);
  led(7) <= read;
  
  
  -- State machine.

  delay_cnt : counter
    generic map (
      n => 16)
    port map (
      clk => clk,
      reset => delay_reset,
      enable => delay_enable,
      value => delay_value);

  process(clk)
  begin
    if rising_edge(clk) then
      if read = '1' then
        data_read <= '1';
      end if;
      
      if rst = '1' then
        state <= init;
        xpos <= (others => '0');
        ypos <= (others => '0');                
      end if;
      
      if state = init then
        led(2 to 5) <= "0000";

        clk_enable <= '0';
        data_enable <= '0';

        data_read <= '0';
        click <= (others => '0');
        mouse_data_packet <= (others => '0');
        half_second_counter <= (others => '0');
        mouse_data_counter <= (others => '0');
        bit_counter <= (others => '0');

        delay_enable <= '1';
        delay_reset <= '0';
        if delay_value = delay_500_us then
          state <= set_clock_low;
          delay_enable <= '0';
          delay_reset <= '1';
        end if;

      elsif state = set_clock_low then
        led(2 to 5) <= "0001";
        
        clk_enable <= '1';
        clk_out <= '0';

        delay_enable <= '1';
        delay_reset <= '0';
        if delay_value = delay_200_us then
          state <= set_data_low;
          delay_enable <= '0';
          delay_reset <= '1';   
        end if;

      elsif state = set_data_low then
        led(2 to 5) <= "0010";
        
        data_enable <= '1';
        data_out <= '0';
        
        delay_enable <= '1';
        delay_reset <= '0';
        if delay_value = delay_15_us then
          state <= release_clk;        
          delay_enable <= '0';
          delay_reset <= '1';
        end if;

      elsif state = release_clk then
        led(2 to 5) <= "0011";

        clk_enable <= '0';
        state <= wait_clk_low_1;

      elsif state = wait_clk_low_1 then
        led(2 to 5) <= "0100";

        if clk_fall = '1' then
          state <= send_bit;
        end if;

      elsif state = send_bit then
        led(2 to 5) <= "0101";
        
        data_out <= command(0);
        command <= '0' & command(9 downto 1);
        bit_counter <= bit_counter + 1;
        state <= wait_clk_high;

      elsif state = wait_clk_high then
        if clk_rise = '1' then
          state <= wait_clk_low_2;          
        end if;

      elsif state = wait_clk_low_2 then
        if clk_fall = '1' then
          if bit_counter = "1010" then
            state <= wait_half_second;
            clk_enable <= '0';
            data_enable <= '0';
          else
            state <= send_bit;
          end if;
        end if;

      elsif state = wait_half_second then
        led(2 to 5) <= "1001";
        if half_second_counter = "00000101111101011110000100000000" then
          state <= wait_clk_high_2;
        else
          half_second_counter <= half_second_counter + 1;
        end if;

      elsif state = done then
        led(2 to 5) <= "0110";

        clk_enable <= '0';
        data_enable <= '0';

        if data_read = '1' then
          if (xpos >= "0011000000" and xpos <= "0111000000" and
              ypos >= "0001110000" and ypos <= "0101110000") then
            if mouse_data_packet(1) = '1' and mouse_data_packet(2) = '1' then
              click <= mouse_data_packet(1) & "0000000";
            else
              click <= mouse_data_packet(1) & "000000" & mouse_data_packet(2);            
            end if;
          else
            click <= "00000000";
          end if;
          data_read <= '0';
        else
          click <= "00000000";
        end if;
                                                                
        xvel <= (mouse_data_packet(5) & mouse_data_packet(5) & mouse_data_packet(19 downto 12));
        yvel <= (mouse_data_packet(6) & mouse_data_packet(6) & mouse_data_packet(30 downto 23));

        if xpos + xvel > "1001111111"  then
          if xvel(9) = '1' then
            xpos <= (others => '0');
          else
            xpos <= "1001111111";
          end if;
        else
          xpos <= xpos + xvel;
        end if;

        if ypos - yvel > "0111011111"  then
          if yvel(9) = '1' then
            ypos <= "0111011111";
          else
            ypos <= (others => '0');
          end if;
        else
          ypos <= ypos - yvel;
        end if;        
        
        mouse_data_packet <= (others => '0');

        state <= wait_clk_high_2;

      elsif state = wait_clk_high_2 then
        led(2 to 5) <= "0111";

        if clk_fall = '1' then
          mouse_data_packet <= data_sync_reg(3) & mouse_data_packet(32 downto 1);
          mouse_data_counter <= mouse_data_counter + 1;
          state <= wait_clk_low_3;
        end if;
        
      elsif state = wait_clk_low_3 then
        led(2 to 5) <= "1000";

        if clk_rise = '1' then
          if mouse_data_counter = "100001" then
            state <= done;
            mouse_data_counter <= "000000";
          else
            state <= wait_clk_high_2;
          end if;
        end if;
      end if;

      
      
    end if;
  end process;

  x_position <= xpos;
  y_position <= ypos;

  x_tile_temp <= (xpos - "0011000000") when xpos >= "0011000000" and xpos <= "0111000000" else "1111111111";

  x_tile_pos <= "0000" & x_tile_temp(7 downto 4);

  y_tile_temp <= (ypos - "0001110000") when ypos >= "0001110000" and ypos <= "0101110000" else "1111111111";

  y_tile_pos <= "0000" & y_tile_temp(7 downto 4);

end ps2_behv;
