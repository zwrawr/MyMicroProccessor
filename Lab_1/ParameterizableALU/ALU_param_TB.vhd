--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:47:27 02/17/2017
-- Design Name:   
-- Module Name:   C:/Temp/CompArchLab1/ALU_param_TB.vhd
-- Project Name:  CompArchLab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU_param
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
entity ALU_param_TB is
end ALU_param_TB;
 
architecture behavior of ALU_param_TB is 

	-- constants
	constant M : NATURAL := 16;
	constant wait_time : TIME := 10 ns;
	
	-- Component Declaration for the Unit Under Test (UUT)
	component ALU_param
		generic 
		( 
			N : NATURAL
		);
		port
		(
			A : IN  STD_LOGIC_VECTOR(M-1 downto 0);
			B : IN  STD_LOGIC_VECTOR(M-1 downto 0);
			X : IN  STD_LOGIC_VECTOR(M-1 downto 0);
			ctrl : IN  STD_LOGIC_VECTOR(3 downto 0);
			O : OUT  STD_LOGIC_VECTOR(M-1 downto 0);
			flags : OUT  STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;
    

   --Inputs
   signal A : STD_LOGIC_VECTOR(M-1 downto 0) := (others => '0');
   signal B : STD_LOGIC_VECTOR(M-1 downto 0) := (others => '0');
   signal X : STD_LOGIC_VECTOR(M-1 downto 0) := (others => '0');
   signal ctrl : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

 	--Outputs
   signal O : STD_LOGIC_VECTOR(M-1 downto 0);
   signal flags : STD_LOGIC_VECTOR(7 downto 0);

 
	type TEST_VECTOR is RECORD
		ctrl : STD_LOGIC_VECTOR(3 downto  0);
		A : STD_LOGIC_VECTOR(M-1 downto 0);
		B : STD_LOGIC_VECTOR(M-1 downto  0);
		X : STD_LOGIC_VECTOR(M-1 downto  0);
		O : STD_LOGIC_VECTOR(M-1 downto 0);
		flags : STD_LOGIC_VECTOR(7 downto 0);
	end RECORD;

	type TEST_VECTOR_ARRAY is ARRAY(NATURAL range <>) of TEST_VECTOR;

	constant test_vectors : TEST_VECTOR_ARRAY := (
		-- CTRL,  A ,     B ,      X ,      O ,      FLAGS
		("0000", X"0000", X"0000", X"0000", X"0000", "01100001"), -- identity of A=0
		("0000", X"FF9C", X"0000", X"0000", X"FF9C", "00101010"), -- identity of A=-108
		("0000", X"03E8", X"0000", X"0000", X"03E8", "01010010") -- identity of A=1000
	);

begin

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU_param 
	generic map 
	(
		N => M
	)
	port map 
	(
		A => A,
		B => B,
		X => X,
		ctrl => ctrl,
		O => O,
		flags => flags
	);

	-- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 100 ns.
		wait for 100 ns;	

		for i in test_vectors'range loop

			ctrl <= test_vectors(i).ctrl;
			A <= test_vectors(i).A;
			B <= test_vectors(i).B;
			X <= test_vectors(i).X;

			wait for wait_time;

			assert O = test_vectors(i).O
			report "Actual output did not equal expected output"
			severity error;
			assert flags = test_vectors(i).flags
			report "Actual flags did not equal expected flags"
			severity error;

			wait for wait_time;

		end loop;

	wait;
	end process;

end;
