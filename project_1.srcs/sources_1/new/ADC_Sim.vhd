----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2020 12:17:57
-- Design Name: 
-- Module Name: ADC_Sim - Behavioral
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

entity AD_gensimu is
    GENERIC (NN : integer := 3);
    
    Port ( CLK_I : in STD_LOGIC;
           UIN_I : in real;
           UREF_I : in real;
           YOUT_O : out STD_LOGIC_VECTOR (NN - 1 downto 0));
end AD_gensimu;

architecture Behavioral of AD_gensimu is
    
    signal Z : integer := 0;
    signal testi : integer := 0;
    signal testr : real;
    signal anzstep : integer;
    signal Ulsb : real;
begin
    
    anzstep <= 2 ** NN - 1;
    Ulsb <= UREF_I / real(anzstep);
    
    process (CLK_I)
    begin
        if (rising_edge(CLK_I)) then
            Z <= integer(UIN_I / Ulsb);
        end if;
    end process;
    
    YOUT_O <= conv_std_logic_vector(Z, NN);

end Behavioral;
