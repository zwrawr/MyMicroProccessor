library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.DigEng.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_param is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           X : in  STD_LOGIC_VECTOR (7 downto 0);
           ctrl : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           O : out  STD_LOGIC_VECTOR (7 downto 0);
           flags : out  STD_LOGIC_VECTOR (7 downto 0));
end ALU_param;

architecture Behavioral of ALU_param is

begin


end Behavioral;

