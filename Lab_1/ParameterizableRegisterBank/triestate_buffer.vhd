----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:02:48 02/23/2017 
-- Design Name: 
-- Module Name:    triestate_buffer - Behavioral 
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

entity triestate_buffer is
	Generic
	(
		data_size : natural := 8
	);
	Port ( 
		data_in : in  STD_LOGIC_VECTOR(data_size-1 downto 0);
		en : in  STD_LOGIC;
		data_out : out  STD_LOGIC_VECTOR(data_size-1 downto 0)
	);
end triestate_buffer;

architecture Behavioral of triestate_buffer is
begin

	DATA_OUT <= 
		DATA_IN when (En = '1') else
		(others => 'Z'); -- Z = high-impedance

end Behavioral;

