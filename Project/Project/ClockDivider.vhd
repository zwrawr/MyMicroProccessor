----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:02 05/21/2017 
-- Design Name: 
-- Module Name:    ClockDivider - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

entity ClockDivider is
    Port ( 
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		en : in  STD_LOGIC;
		clk_out : out  STD_LOGIC
	);
end ClockDivider;

architecture Behavioral of ClockDivider is

	signal count : integer := 0;
	signal rollover : STD_LOGIC := '0';

begin

	clk_out <= '1' when rollover = '1' and en = '1' else '0';

	rollover <= '1' when rst = '1' or count >= 4 else '0';

	process(clk,rollover)
	begin
		if rising_edge(clk) then
			if rollover = '1' then
				count <= 0;
			elsif en = '1' then
				count <= count + 1;
			end if;
		end if;
	end process;

end Behavioral;

