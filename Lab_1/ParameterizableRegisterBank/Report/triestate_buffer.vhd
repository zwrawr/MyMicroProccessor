----------------------------------------------------------------------------------
-- 
-- Uni			:	University of York
-- Course		:	Electronic Engineering
-- Module  		:	Computer Architectures 
-- Engineers	:	Y3839090 & Y3840426
-- 
-- Create Date	:	21:02:48 02/23/2017 
-- Design Name	:	triestate_buffer - Behavioral 
-- Description	:	A parameteriable tristate buffer array. 		
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity triestate_buffer is
	Generic
	(
		data_size : natural := 8 -- number of trie state buffers
	);
	Port ( 
		data_in : in  STD_LOGIC_VECTOR(data_size-1 downto 0); -- data input
		en : in  STD_LOGIC; -- tristate enable
		data_out : out  STD_LOGIC_VECTOR(data_size-1 downto 0) -- data out
	);
end triestate_buffer;

architecture Behavioral of triestate_buffer is
begin
	
	-- Tristate buffer implimentation from lab script
	DATA_OUT <= 
		DATA_IN when (En = '1') else
		(others => 'Z'); -- Z = high-impedance

end Behavioral;

