----------------------------------------------------------------------------------
-- 
-- Uni		:		 University of York
-- Course	:		 Electronic Engineering
-- Module   :		 Computer Architectures 
-- Engineers:		 [Zak West] & [Thomas Meadows]
-- 
-- Create Date:    13:19:20 02/17/2017 
-- Design Name:    ALU_param - Behavioral 
-- Description:	 A paramateriable integer ALU. 		
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_param is
	Generic (
		N : natural := 8 -- data size in bits
	);
	Port ( 
		A : in  STD_LOGIC_VECTOR (N-1 downto 0);
		B : in  STD_LOGIC_VECTOR (N-1 downto 0);
		X : in  STD_LOGIC_VECTOR (N-1 downto 0); -- shift/rotate amount input
		ctrl : in  STD_LOGIC_VECTOR (3 downto 0); -- control signals from opcode
		O : out  STD_LOGIC_VECTOR (N-1 downto 0);
		flags :out  STD_LOGIC_VECTOR (7 downto 0) -- flags
	);
end ALU_param;

architecture Behavioral of ALU_param is
	signal O_itrn : SIGNED (N downto 0); -- internal signed signal for output
	signal A_itrn : SIGNED (N downto 0); -- internal signed signal for A
	signal B_itrn : SIGNED (N downto 0); -- internal signed signal for B
	signal X_itrn : integer; -- internal integer for X
begin
		A_itrn <= RESIZE(signed(A) , N+1); -- connects A to A_itrn as well as converting it to signed
		B_itrn <= RESIZE(signed(B) , N+1); -- connects B to B_itrn as well as converting it to signed
		X_itrn <= to_integer(unsigned(X)); -- converts X to integer and connects to X_itrn

		
		O <= std_logic_vector(O_itrn(N-1 downto 0)); -- connects O_itrn to O
	
		-- Main ALU multiplexer for each possible command
		O_itrn <= 
			A_itrn 					when ctrl = "0000" else -- Output A
			A_itrn and B_itrn 	when  ctrl = "0100" else-- Output A & B
			A_itrn or B_itrn 		when  ctrl = "0101"  else-- Output A || B
			A_itrn xor B_itrn 	when  ctrl = "0110"  else-- Output A xor B
			not A_itrn 				when  ctrl = "0111"  else-- Output not A
			A_itrn + 1 				when  ctrl = "1000"  else-- Output A+1
			A_itrn - 1 				when  ctrl = "1001"  else-- Output A-1
			A_itrn + B_itrn 		when  ctrl = "1010"  else-- Output A+B
			A_itrn - B_itrn 		when  ctrl = "1011"  else-- Output A-B
			SHIFT_LEFT (A_itrn , X_itrn)  		when  ctrl = "1100"  else-- Output A sl X
			SHIFT_RIGHT (A_itrn , X_itrn) 		when  ctrl = "1101"  else-- Output A sr X
			ROTATE_LEFT (A_itrn , X_itrn) 		when  ctrl = "1110"  else-- Output A rotl X
			ROTATE_RIGHT (A_itrn , X_itrn)		when  ctrl = "1111"  else-- Output A rotr X
		(others =>'U');

	flags(0) <= '1' when O_itrn = 0 else '0'; -- Zero flag
	flags(1) <= '1' when O_itrn /= 0 else '0'; -- not Zero flag
	flags(2) <= '1' when O_itrn = 1 else '0'; -- one flag
	flags(3) <= '1' when O_itrn < 0 else '0'; -- less than zero
	flags(4) <= '1' when O_itrn > 0 else '0'; -- grater than zero
	flags(5) <= '1' when O_itrn <= 0 else '0'; -- less than or equal to zero
	flags(6) <= '1' when O_itrn >= 0 else '0'; -- grater than or equal to zero
	flags(7) <= '1' when not((not A_itrn(N)='1') xnor (not B_itrn(N)='1')) and O_itrn(N)='1' else '0'; -- overflow


end Behavioral;

