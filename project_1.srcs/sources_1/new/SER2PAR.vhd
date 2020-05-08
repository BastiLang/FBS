----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2020 06:02:47
-- Design Name: 
-- Module Name: SER2PAR - Behavioral
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

entity SER2PAR is
    Generic(    NN          : integer := 8 );
    Port(       SHIFT_IN_I  : in STD_LOGIC;
                CLK_I       : in STD_LOGIC;
                RESET_I     : in STD_LOGIC;
                PRESET_I    : in STD_LOGIC;
                Q_SHIFT_O   : OUT STD_LOGIC_VECTOR (NN - 1 downto 0)
   );
end SER2PAR;

architecture Behavioral of SER2PAR is
    
    COMPONENT n_bit_register
        GENERIC (NN : integer := 8);
        PORT (
            D_INPUTS_I : IN STD_LOGIC_VECTOR (NN - 1 downto 0);
            CLK_I : IN STD_LOGIC;
            RESET_I : IN STD_LOGIC;
            PRESET_I : IN STD_LOGIC;
            Q_O : OUT STD_LOGIC_VECTOR (NN - 1 downto 0);
            Q_NOT_O : OUT STD_LOGIC_VECTOR (NN - 1 downto 0)
        );
    END COMPONENT;
    
    SIGNAL sig_s : STD_LOGIC_VECTOR (NN downto 0);
    SIGNAL dummy_s : STD_LOGIC_VECTOR (NN - 1 downto 0);

begin
    sig_s(0) <= SHIFT_IN_I;
    
    reg : n_bit_register
    GENERIC MAP ( NN => NN )
    PORT MAP (
        D_INPUTS_I => sig_s(NN - 1 downto 0),
        CLK_I => CLK_I,
        RESET_I => RESET_I,
        PRESET_I => PRESET_I,
        Q_O => sig_s(NN downto 1),
        Q_NOT_O => dummy_s
    );
    
    
    Q_SHIFT_O <= sig_s(NN downto 1);

end Behavioral;
