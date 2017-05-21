----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:24:42 05/19/2017 
-- Design Name: 
-- Module Name:    OutputReg - Behavioral 
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


entity OutputReg is
    Port ( 
	    clk : in STD_LOGIC;
		data_in : in  STD_LOGIC_VECTOR (15 downto 0);
		WE : in  STD_LOGIC;
		data_out : out  STD_LOGIC_VECTOR (15 downto 0)
	);
end OutputReg;

architecture Behavioral of OutputReg is

begin

	update : process(clk, WE)
	begin
		if (rising_edge(clk) and WE = '1') then
			data_out <= data_in;
		end if;
	end process;

end Behavioral;

