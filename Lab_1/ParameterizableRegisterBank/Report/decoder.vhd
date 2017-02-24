----------------------------------------------------------------------------------
-- 
-- Uni			:	University of York
-- Course		:	Electronic Engineering
-- Module  		:	Computer Architectures 
-- Engineers	:	Y3839090 & Y3840426
-- 
-- Create Date	:	21:02:48 02/23/2017 
-- Design Name	:	decoder - Behavioral 
-- Description	:	A parameteriable address decoder. 		
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.DigEng.ALL;

entity decoder is
	Generic
	(
		num_reg : natural := 8 -- number of address locations
	);
	Port ( 
		addr : in  STD_LOGIC_VECTOR (log2(num_reg)-1 downto 0); -- input address
		en : in STD_LOGIC; -- enable
		enables : out  STD_LOGIC_VECTOR (num_reg-1 downto 0) -- decoded output.
	 );
end decoder;

architecture Behavioral of decoder is
begin

	-- decodes the addresses
	process(addr, en) is
	begin
	
		-- loop over every bit in the output
		for i in 0 to num_reg-1 loop
			-- if it this bit corrosponds to the input address set it high otherwise set it low.
         if (i = to_integer(unsigned(addr)) and en = '1') then
           enables(i) <= '1';
         else
           enables(i) <= '0';
         end if;
			
		end loop;
		
	end process;
		
end Behavioral;

