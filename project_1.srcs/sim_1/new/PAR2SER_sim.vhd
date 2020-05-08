----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2020 16:17:26
-- Design Name: 
-- Module Name: PAR2SER_sim - Behavioral
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

entity PAR2SER_sim is
--  Port ( );
end PAR2SER_sim;

architecture Behavioral of PAR2SER_sim is

    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL RESET : STD_LOGIC := '0';
    SIGNAL MODE : STD_LOGIC_VECTOR (1 downto 0) := (others=> '0');
    SIGNAL SDOUT : STD_LOGIC := '0';
    
    COMPONENT PAR2SER IS
        GENERIC ( NN : INTEGER := 8);
        
        Port ( DIN : in STD_LOGIC_VECTOR (NN - 1 downto 0);
               MODE : in STD_LOGIC_VECTOR (1 downto 0);
               CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               SDOUT : out STD_LOGIC
       );
    END COMPONENT;
    
begin

    PAR2SER_comp: PAR2SER
    GENERIC MAP ( NN => 10 )
    PORT MAP (
        DIN => "0110101011",
        MODE => MODE,
        CLK => CLK,
        RESET => RESET,
        SDOUT => SDOUT
    );
    
    CLK <= not CLK after 500ns;
    
    MODE <= "00",
            "01" after 1ms,
            "10" after 2ms,
            "01" after 3ms,
            "10" after 4ms;


end Behavioral;
