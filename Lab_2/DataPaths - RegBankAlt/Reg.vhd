library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- A paramateriable synchronous reset D-type registers with enable
entity Reg is
	Generic(
		data_size: natural := 8	-- How many bits will the register deal with
	);
	Port ( 
		clk : in  STD_LOGIC;	
		rst : in STD_LOGIC;	-- synchronus reset
		en : in STD_LOGIC; -- synchronus reset
		data_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0); -- input
		data_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0) -- output
	);
end Reg;

architecture Behavioral of Reg is
begin
	
	process(clk)
	begin
		-- Synchronise to the clock
		if (rising_edge(clk)) then
			if (rst = '1') then
				-- Reset to zero
				data_out <= (others => '0');
			elsif (en = '1') then
				-- Pass the input to the output
				data_out <= data_in;
			end if;
		end if;
		
	end process;
	
	
end Behavioral;

