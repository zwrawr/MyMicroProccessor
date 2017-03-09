----------------------------------------------------------------------------------
-- 
-- Uni			:	University of York
-- Course		:	Electronic Engineering
-- Module  		:	Computer Architectures 
-- Engineers	:	Y3839090 & Y3840426
-- 
-- Create Date	:	13:19:20 02/17/2017 
-- Design Name	:	ALU_param - Behavioral 
-- Description	:	A paramateriable integer ALU. 		
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.DigEng.ALL;

entity ALU_param is
	Generic (
		N : natural := 8 -- data size in bits
	);
	Port ( 
		A : in  STD_LOGIC_VECTOR (N-1 downto 0);
		B : in  STD_LOGIC_VECTOR (N-1 downto 0);
		X : in  STD_LOGIC_VECTOR (log2(N)-1 downto 0); -- shift/rotate amount input
		ctrl : in  STD_LOGIC_VECTOR (3 downto 0); -- control signals from opcode
		O : out  STD_LOGIC_VECTOR (N-1 downto 0);
		flags :out  STD_LOGIC_VECTOR (7 downto 0) -- flags
	);
end ALU_param;

architecture Behavioral of ALU_param is

	-- internal signed signal for A and B inpy=uts
	signal A_itrn : SIGNED (N-1 downto 0); 
	signal B_itrn : SIGNED (N-1 downto 0);
	
	-- internal integer for X
	signal X_itrn : integer; 
	
	-- internal signed signal for output
	signal O_itrn : SIGNED (N-1 downto 0); 
	

	-- max positive and negitive N bit signed numbers
	constant max_pos : SIGNED (N-1 downto 0) := to_signed(( 2 ** (N-1) ) - 1, N); 
	constant max_neg : SIGNED (N-1 downto 0) := to_signed( -2 ** (N-1) , N);
	
begin

		A_itrn <= signed(A); -- converts A to signed and maps the result to A_itrn
		B_itrn <= signed(B); -- converts A to signed and maps the result to B_itrn
		
		-- converts X to integer and maps the result to X_itrn
		X_itrn <= to_integer(unsigned(X));

		-- converts O_itrn to a plain std_logic_vector and maps it to O
		O <= std_logic_vector(O_itrn);
	
		-- Main ALU multiplexer for each possible command
		O_itrn <= 
			A_itrn 					when ctrl = "0000" else 	-- Output A
			A_itrn and B_itrn 		when ctrl = "0100" else		-- Output A & B
			A_itrn or B_itrn 		when ctrl = "0101" else		-- Output A || B
			A_itrn xor B_itrn 		when ctrl = "0110" else		-- Output A xor B
			not A_itrn 				when ctrl = "0111" else		-- Output not A
			A_itrn + 1 				when ctrl = "1000" else		-- Output A + 1
			A_itrn - 1 				when ctrl = "1001" else		-- Output A - 1
			A_itrn + B_itrn 		when ctrl = "1010" else		-- Output A + B
			A_itrn - B_itrn 		when ctrl = "1011" else		-- Output A - B
			SHIFT_LEFT (A_itrn , X_itrn)  	when ctrl = "1100" else -- Output A sla X
			SHIFT_RIGHT (A_itrn , X_itrn) 	when ctrl = "1101" else -- Output A sra X
			ROTATE_LEFT (A_itrn , X_itrn) 	when ctrl = "1110" else -- Output A rotl X
			ROTATE_RIGHT (A_itrn , X_itrn)	when ctrl = "1111" else -- Output A rotr X
			(others =>'U');

	-- Overflow flag
	flags(7) <= 
		-- Will overflow if you add one to the max positive value
		'1' when ctrl = "1000" and A_itrn = max_pos else 

		-- Will overflow if you minus one to the max negitive value
		'1' when ctrl = "1001" and A_itrn = max_neg else
		
		-- Will overflow if two neg values added give a pos result
		'1' when ctrl = "1010" and A_itrn(N-1) = '1' and  B_itrn(N-1) = '1' and O_itrn(N-1) = '0' else 
		-- Will overflow if two pos values added give a neg result
		'1' when ctrl = "1010" and A_itrn(N-1) = '0' and  B_itrn(N-1) = '0' and O_itrn(N-1) = '1' else 
		
		-- Will overflow if a pos value is subtracted from a neg value gives a pos result
		'1' when ctrl = "1011" and A_itrn(N-1) = '1' and  B_itrn(N-1) = '0' and O_itrn(N-1) = '0' else 
		-- Will overflow if a neg value is subtracted from a pos value gives a neg result
		'1' when ctrl = "1011" and A_itrn(N-1) = '0' and  B_itrn(N-1) = '1' and O_itrn(N-1) = '1' 
		
		-- If none of the above are true then the result hasn't overflown
		else '0';
	
	-- Other flags
	flags(6) <= '1' 	when O_itrn >= 0 	else '0'; -- grater than or equal to zero
	flags(5) <= '1' 	when O_itrn <= 0 	else '0'; -- less than or equal to zero
	flags(4) <= '1' 	when O_itrn >  0 	else '0'; -- grater than zero
	flags(3) <= '1' 	when O_itrn <  0 	else '0'; -- less than zero
	flags(2) <= '1' 	when O_itrn =  1 	else '0'; -- one flag
	flags(1) <= '1' 	when O_itrn /= 0 	else '0'; -- not zero flag
	flags(0) <= '1' 	when O_itrn =  0 	else '0'; -- zero flag


end Behavioral;

