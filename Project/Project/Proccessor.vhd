
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processor is
    Port ( clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (15 downto 0));
end Processor;

architecture Behavioral of Processor is

begin


end Behavioral;

