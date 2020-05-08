----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2020 12:34:59
-- Design Name: 
-- Module Name: TB_AD_Gensimu - Behavioral
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
use IEEE.STD_LOGIC_Arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_AD_Gensimu is
--  Port ( );
end TB_AD_Gensimu;

architecture Behavioral of TB_AD_Gensimu is

    COMPONENT AD_gensimu is
        GENERIC (NN : integer := 3);
        
        Port ( CLK_I : in STD_LOGIC;
               UIN_I : in real;
               UREF_I : in real;
               YOUT_O : out STD_LOGIC_VECTOR (NN - 1 downto 0));
    end COMPONENT AD_gensimu;
    
    CONSTANT NN : INTEGER := 3; -- AD- Wandler Bitbreite
    SIGNAL clk : std_logic := '0'; -- Taktsignal
    SIGNAL Uin : real := 0.0; --used for ramp signal
    --signal Uin : real:=2.0; -- single values test
    SIGNAL Ustep : real := 0.5; -- Schrittweite der Rampe
    SIGNAL Uref : real := 5.0; --Referenzspannung
    --AD-Wandler Ausgang
    SIGNAL Yout : STD_LOGIC_VECTOR(NN - 1 DOWNTO 0);
    SIGNAL clk_counter : INTEGER := 0; -- Untersetzerzähler

begin
    
    clk <= NOT clk after 10ns;
    
    AD: AD_gensimu --Instanz des AD-Wandlers
        
        GENERIC MAP ( NN => NN)
        
        PORT MAP(   CLK_I => clk,
                    UIN_I => UIN,
                    UREF_I => Uref,
                    YOUT_O => Yout
        );
    
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (clk_counter mod 8 = 0) then
                --Die Rampe wird bei jedem 8. Takt weitergeschaltet
            
                Uin <= Uin + Ustep;
                
                if ((Uin > Uref) or (Uin < 0.0)) then
                    Uin <= Uin - Ustep;
                    Ustep <= - Ustep;
                end if;
            end if;
            
            -- Zähler zum Untersetzen der Rampenfortschaltung
            clk_counter <= clk_counter + 1;
        end if;
    end process;

end Behavioral;
