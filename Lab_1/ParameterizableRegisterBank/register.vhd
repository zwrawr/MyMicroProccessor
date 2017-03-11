----------------------------------------------------------------------------------
-- 
-- Uni			:	University of York
-- Course		:	Electronic Engineering
-- Module  		:	Computer Architectures 
-- Engineers	:	Y3839090 & Y3840426
-- 
-- Create Date	:	20:12:10 02/23/2017
-- Design Name	:	register - Behavioral 
-- Description	:	A parameteriable synchronous write asynchronous read register. 		
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity param_reg is
	Generic
	(
		data_size : natural := 16 -- The data size of the value stored in bits
	);
	Port ( 
		data_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0); -- Data input
		load : in  STD_LOGIC; -- Loads the data from data_in and stores it
		clk : in  STD_LOGIC; 
		data_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0) -- The currently stored value
	);
end param_reg;

architecture Behavioral of param_reg is
begin

	reg_proc : process (clk, load) is
	begin
		
		-- synchronously write data_in to data_out if load is high
		if (rising_edge(clk) and load = '1') then
			data_out <= data_in; 
		end if;
	
	end process;

end Behavioral;

