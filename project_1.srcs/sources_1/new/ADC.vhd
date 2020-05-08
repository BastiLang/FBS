----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2020 12:21:46
-- Design Name: 
-- Module Name: ADC - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADC is
    Port (  CLK100MHZ  :  in STD_LOGIC;
            vauxn2 :  IN STD_LOGIC;
            vauxp2 :  IN STD_LOGIC;
            SW     :  in STD_LOGIC_VECTOR (15 downto 0);
            LED    :  out STD_LOGIC_VECTOR (15 downto 0)
        );
end ADC;

architecture Behavioral of ADC is

   COMPONENT xadc_wiz_0
   PORT
   (
    daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
    den_in          : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
    di_in           : in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
    dwe_in          : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
    do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
    dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
    reset_in        : in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
    --vauxp3          : in  STD_LOGIC;                         -- Auxiliary Channel 3
    --vauxn3          : in  STD_LOGIC;
    vauxp2          : in  STD_LOGIC;                         -- Auxiliary Channel 2
    vauxn2          : in  STD_LOGIC;
    busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
    channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
    eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
    eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
    --ot_out          : out  STD_LOGIC;                        -- Over-Temperature alarm output
    --vccaux_alarm_out : out  STD_LOGIC;                        -- VCCAUX-sensor alarm output
    --vccint_alarm_out : out  STD_LOGIC;                        -- VCCINT-sensor alarm output
    --user_temp_alarm_out : out  STD_LOGIC;                     -- Temperature-sensor alarm output
    --alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
    vp_in           : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
    vn_in           : in  STD_LOGIC
);
end COMPONENT;
    
    signal drdy_s : std_logic;
    signal busy_s : std_logic;
    signal eoc_s : std_logic;
    signal eos_s : std_logic;
    
    signal channel_s : std_logic_vector (4 downto 0);
    
    signal do_out_s : std_logic_vector(15 downto 0);
    signal daten_out_s : std_logic_vector(15 downto 0);
    
begin
    
    XADC : xadc_wiz_0
    PORT MAP (
        daddr_in                 => SW (6 downto 0),                          -- Address bus for the dynamic reconfiguration port
        den_in                   => eoc_s,                          -- Enable Signal for the dynamic reconfiguration port
        di_in                    => x"137F",                          -- Input data bus for the dynamic reconfiguration port
        dwe_in                   => '0',                          -- Write Enable for the dynamic reconfiguration port
        do_out                   => do_out_s,                          -- Output data bus for dynamic reconfiguration port
        drdy_out                 => drdy_s,                          -- Data ready signal for the dynamic reconfiguration port
        dclk_in                  => CLK100MHZ,                          -- Clock input for the dynamic reconfiguration port
        reset_in                 => '0',                          -- Reset signal for the System Monitor control logic
        --vauxp3                   => vauxp3,                          -- Auxiliary Channel 3
        --vauxn3                   => vauxn3,
        vauxp2                   => vauxp2,                          -- Auxiliary Channel 2
        vauxn2                   => vauxn2,
        busy_out                 => busy_s,                          -- ADC Busy signal
        channel_out              => channel_s,                          -- Channel Selection Outputs
        eoc_out                  => eoc_s,                         -- End of Conversion Signal
        eos_out                  => eos_s,                          -- End of Sequence Signal
        --ot_out                   =>                           -- Over-Temperature alarm output
        --vccaux_alarm_out         =>                           -- VCCAUX-sensor alarm output
        --vccint_alarm_out         =>                           -- VCCINT-sensor alarm output
        --user_temp_alarm_out      =>                           -- Temperature-sensor alarm output
        --alarm_out                =>                           -- OR'ed output of all the Alarms
        vp_in                    => '0',                          -- Dedicated Analog Input Pair
        vn_in                    => '0'
    );
    
    
    process(CLK100MHZ) is
    begin
        if rising_edge(CLK100MHZ) then
            if drdy_s = '1' then
                daten_out_s <= do_out_s;
            end if;
        end if;
    end process;
    
    LED <= daten_out_s;

end Behavioral;
