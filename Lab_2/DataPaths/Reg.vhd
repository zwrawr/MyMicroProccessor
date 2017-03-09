library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
	Generic(
		data_size: natural := 8
	);
	Port ( 
		clk : in  STD_LOGIC;
		data_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		data_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0)
	);
end Reg;

architecture Behavioral of Reg is
	signal internal : STD_LOGIC_VECTOR (data_size-1 downto 0);
begin

	internal <= data_in when clk = '1' else internal;
	data_out <= internal;
	
end Behavioral;

