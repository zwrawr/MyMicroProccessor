library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity param_reg is
	Generic
	(
		data_size : natural := 16
	);
	Port ( 
		data_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		load : in  STD_LOGIC;
		clk : in  STD_LOGIC;
		data_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0)
	);
end param_reg;

architecture Behavioral of param_reg is
	signal internal : STD_LOGIC_VECTOR(data_size-1 downto 0);
begin

	data_out <= internal;

	reg_proc : process (clk, load) is
	begin
	
		if (rising_edge(clk) and load = '1') then
			internal <= data_in; 
		end if;
	
	end process;

end Behavioral;

