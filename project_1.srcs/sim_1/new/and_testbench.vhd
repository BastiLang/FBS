----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2020 13:27:13
-- Design Name: 
-- Module Name: and_testbench - Behavioral
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

entity and_testbench is
--  Port ( );
end and_testbench;

architecture Behavioral_b of and_testbench is
    COMPONENT a_component IS
        PORT (
            a: IN STD_LOGIC;
            b: IN STD_LOGIC;
            y: OUT STD_LOGIC
        );
    END COMPONENT;
    
    SIGNAL a: STD_LOGIC := '0';
    SIGNAL b: STD_LOGIC := '0';
    SIGNAL y: STD_LOGIC := '0';
    
begin

    aand: a_component
    PORT MAP(
        a => a,
        b => b,
        y => y
    );
    
    a <=        '0' AFTER 0ms,
                '0' AFTER 10ms,
                '1' AFTER 20ms,
                '1' AFTER 30ms,
                '0' AFTER 40ms;
                
    b <=        '0' AFTER 0ms,
                '1' AFTER 10ms,
                '0' AFTER 20ms,
                '1' AFTER 30ms;

end Behavioral_b;
