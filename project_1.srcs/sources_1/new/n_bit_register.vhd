----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2020 06:40:21
-- Design Name: 
-- Module Name: n_bit_register - Behavioral
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

entity n_bit_register is
    GENERIC (NN : integer := 8);
    PORT (
        D_INPUTS_I : IN STD_LOGIC_VECTOR (NN - 1 downto 0);
        CLK_I : IN STD_LOGIC;
        RESET_I : IN STD_LOGIC;
        PRESET_I : IN STD_LOGIC;
        Q_O : OUT STD_LOGIC_VECTOR (NN - 1 downto 0);
        Q_NOT_O : OUT STD_LOGIC_VECTOR (NN - 1 downto 0)
    );
end n_bit_register;

architecture Behavioral of n_bit_register is
    
    SIGNAL register_s : STD_LOGIC_VECTOR (NN - 1 downto 0);
    
begin

    PROCESS(CLK_I, RESET_I)
    BEGIN
        IF RESET_I = '1' THEN
            register_s <= (others => '0');
        ELSIF rising_edge(CLK_I) THEN -- activities triggered by rising edge of clock
            IF PRESET_I = '1' then
                register_s <= D_INPUTS_I;
            END IF; 
        END IF;
    END PROCESS;
    
    Q_O <= register_s(NN - 1 downto 0);
    Q_NOT_O <= not register_s(NN - 1 downto 0);
end Behavioral;
