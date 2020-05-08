----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2020 15:36:36
-- Design Name: 
-- Module Name: PAR2SER - Behavioral
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

entity PAR2SER is
    GENERIC ( NN : INTEGER := 10);
    
    Port ( DIN_I : in STD_LOGIC_VECTOR (NN - 1 downto 0);
           MODE_I : in STD_LOGIC_VECTOR (1 downto 0);
           CLK_I : in STD_LOGIC;
           RESET_I : in STD_LOGIC;
           SDOUT_O : out STD_LOGIC);
end PAR2SER;

architecture Behavioral of PAR2SER is
    SIGNAL IDATA_S : std_logic_vector (NN - 1 downto 0);

begin

    PROCESS(CLK, RESET)
    BEGIN
        IF RESET_I = '1' THEN
            SDOUT_O <= '0';
            IDATA_S <= (OTHERS => '0');
        ELSIF rising_edge(CLK) THEN -- activities triggered by rising edge of clock
            CASE MODE_I IS
                WHEN "00" => -- no operation null
                WHEN "01" => -- load operation
                    IDATA_S <= DIN;
                WHEN "10" => -- shift left
                    SDOUT_O <= IDATA_S(NN - 1);
                    IDATA_S(IDATA_S'length - 1 DOWNTO 1) <= IDATA_S(IDATA_S'length - 2 DOWNTO 0);
                    IDATA_S(0) <= '0';
                WHEN OTHERS => -- no operation otherwise
            END CASE;
        END IF;
    END PROCESS;

end Behavioral;
