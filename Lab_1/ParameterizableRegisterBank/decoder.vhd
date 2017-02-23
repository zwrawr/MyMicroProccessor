library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.DigEng.ALL;
entity decoder is
	Generic
	(
		num_reg : natural := 8
	);
	Port ( 
		addr : in  STD_LOGIC_VECTOR (log2(num_reg)-1 downto 0);
		en : in STD_LOGIC;
		enables : out  STD_LOGIC_VECTOR (num_reg-1 downto 0)
	 );
end decoder;

architecture Behavioral of decoder is

begin
	process(addr, en) is
	begin
		for i in 0 to num_reg-1 loop
		 
         if (i = to_integer(unsigned(addr))) then
           enables(i) <= '1';
         else
           enables(i) <= '0';
         end if;
			
		end loop;
		
	end process;
		
end Behavioral;

