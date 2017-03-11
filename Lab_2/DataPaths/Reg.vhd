library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
	Generic(
		data_size: natural := 8
	);
	Port ( 
		clk : in  STD_LOGIC;
		rst : in STD_LOGIC;
		en : in STD_LOGIC;
		data_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		data_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0)
	);
end Reg;

architecture Behavioral of Reg is
begin
	
	process(clk)
	begin
	
		if (rising_edge(clk)) then
			if (rst = '1') then
				data_out <= (others => '0');
			elsif (en = '1') then
				data_out <= data_in;
			end if;
		end if;
		
	end process;
	
	
end Behavioral;

