----------------------------------------------------------------------------------
-- 
-- Uni			:	University of York
-- Course		:	Electronic Engineering
-- Module  		:	Computer Architectures 
-- Engineers	:	Y3839090 & Y3840426
-- 
-- Create Date	:	14:47:27 02/17/2017 
-- Design Name	:	ALU_param_TB - TestBench 
-- Description	:	A testbench for a 16 bit integer ALU. 		
--
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.DigEng.ALL;

entity ALU_param_TB is
end ALU_param_TB;
 
architecture behavior of ALU_param_TB is 

	-- ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====  
	-- From http://stackoverflow.com/a/24336034 By Morten Zilmer
	-- Allows printing a std_logic_vector as a string that represents it's binary form.
	-- ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====  
	function to_bstring(sl : std_logic) return string is
		variable sl_str_v : string(1 to 3);  -- std_logic image with quotes around
	begin
		sl_str_v := std_logic'image(sl);
		return "" & sl_str_v(2);  -- "" & character to get string
	end function;
	
	function to_bstring(slv : std_logic_vector) return string is
		alias    slv_norm : std_logic_vector(1 to slv'length) is slv;
		variable sl_str_v : string(1 to 1);  -- String of std_logic
		variable res_v    : string(1 to slv'length);
	begin
		for idx in slv_norm'range loop
			sl_str_v := to_bstring(slv_norm(idx));
			res_v(idx) := sl_str_v(1);
		end loop;
		return res_v;
	end function;
	-- ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====  

	
	-- converts an std_logic_vector to a string that represents it's signed value
	function s_tostr(val : std_logic_vector) return string is
	begin
		return integer'image( to_integer(signed(val)) );
	end function;


	-- Constants
	constant M : NATURAL := 16; -- We are testing a 16 bit ALU
	constant wait_time : TIME := 10 ns;
	
	-- Component Declaration for the Unit Under Test (UUT)
	component ALU_param
		generic 
		( 
			N : NATURAL -- The number of bits this alu will operate on
		);
		port
		(
			A : IN  STD_LOGIC_VECTOR(M-1 downto 0);
			B : IN  STD_LOGIC_VECTOR(M-1 downto 0);
			X : IN  STD_LOGIC_VECTOR(log2(M)-1 downto 0);
			ctrl : IN  STD_LOGIC_VECTOR(3 downto 0);
			O : OUT  STD_LOGIC_VECTOR(M-1 downto 0);
			flags : OUT  STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;
    

   --Inputs
   signal A : STD_LOGIC_VECTOR(M-1 downto 0) := (others => '0');
   signal B : STD_LOGIC_VECTOR(M-1 downto 0) := (others => '0');
   signal X : STD_LOGIC_VECTOR(log2(M)-1 downto 0) := (others => '0');
   signal ctrl : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

 	--Outputs
   signal O : STD_LOGIC_VECTOR(M-1 downto 0);
   signal flags : STD_LOGIC_VECTOR(7 downto 0);

 
	type TEST_VECTOR is RECORD
		ctrl : STD_LOGIC_VECTOR(3 downto  0);
		A : STD_LOGIC_VECTOR(M-1 downto 0);
		B : STD_LOGIC_VECTOR(M-1 downto  0);
		X : STD_LOGIC_VECTOR(log2(M)-1 downto  0);
		O : STD_LOGIC_VECTOR(M-1 downto 0); -- The expected output of the alu
		flags : STD_LOGIC_VECTOR(7 downto 0); -- The expected flags
	end RECORD;

	type TEST_VECTOR_ARRAY is ARRAY(NATURAL range <>) of TEST_VECTOR;

	constant test_vectors : TEST_VECTOR_ARRAY := (
		-- CTRL, A ,      B ,      X ,      O ,      FLAGS
		
		-- A
		("0000", X"0000", X"0000", X"0", X"0000", "01100001"), 
		("0000", X"FF9C", X"0000", X"0", X"FF9C", "00101010"), 
		("0000", X"03E8", X"0000", X"0", X"03E8", "01010010"), 
		("0000", X"0001", X"0000", X"0", X"0001", "01010110"), 

		-- A and B
		("0100", X"0000", X"0000", X"0", X"0000", "01100001"), 
		("0100", X"FF94", X"FC17", X"0", X"FC14", "00101010"), 
		("0100", X"03E8", X"5213", X"0", X"0200", "01010010"), 
		("0100", X"FFFF", X"10E0", X"0", X"10E0", "01010010"), 
		("0100", X"55FF", X"AAAA", X"0", X"00AA", "01010010"), 
		
		-- A or B
		("0101", X"0000", X"0000", X"0", X"0000", "01100001"), 
		("0101", X"FF94", X"FC17", X"0", X"FF97", "00101010"), 
		("0101", X"03E8", X"5213", X"0", X"53FB", "01010010"), 
		("0101", X"FFFF", X"10E0", X"0", X"FFFF", "00101010"),
		("0101", X"5555", X"AAAA", X"0", X"FFFF", "00101010"), 
		
		-- A xor B
		("0110", X"0000", X"0000", X"0", X"0000", "01100001"), 
		("0110", X"FF94", X"FC17", X"0", X"0383", "01010010"), 
		("0110", X"03E8", X"5213", X"0", X"51FB", "01010010"), 
		("0110", X"FFFF", X"10E0", X"0", X"EF1F", "00101010"),
		("0110", X"5555", X"AAAA", X"0", X"FFFF", "00101010"), 
		
		-- not A
		("0111", X"0000", X"0000", X"0", X"FFFF", "00101010"), 
		("0111", X"FFFF", X"0000", X"0", X"0000", "01100001"), 
		("0111", X"8111", X"0000", X"0", X"7EEE", "01010010"), 
		("0111", X"0001", X"0000", X"0", X"FFFE", "00101010"), 
		
		-- A + 1
		("1000", X"0000", X"0000", X"0", X"0001", "01010110"), 
		("1000", X"FFFF", X"0000", X"0", X"0000", "01100001"), 
		("1000", X"7fff", X"0000", X"0", X"8000", "10101010"), 

		-- A - 1
		("1001", X"0000", X"0000", X"0", X"ffff", "00101010"), 
		("1001", X"0001", X"0000", X"0", X"0000", "01100001"), 
		("1001", X"8000", X"0000", X"0", X"7fff", "11010010"), 
		
		-- A + B
		("1010", X"0000", X"0000", X"0", X"0000", "01100001"), 
		("1010", X"0310", X"0a00", X"0", X"0D10", "01010010"), 
		("1010", X"09E2", X"f43e", X"0", X"FE20", "00101010"), 
		("1010", X"7fff", X"0001", X"0", X"8000", "10101010"), 

		-- A - B
		("1011", X"0000", X"0000", X"0", X"0000", "01100001"), 
		("1011", X"0310", X"0a00", X"0", X"F910", "00101010"), 
		("1011", X"09E2", X"0BC2", X"0", X"FE20", "00101010"), 
		("1011", X"8000", X"0001", X"0", X"7fff", "11010010"), 


		-- A sla x
		("1100", X"0000", X"0000", X"0", X"0000", "01100001"), 
		("1100", X"0000", X"0000", X"4", X"0000", "01100001"), 
		("1100", X"1111", X"0000", X"1", X"2222", "01010010"), 
		("1100", X"1111", X"0000", X"3", X"8888", "00101010"), 
		("1100", X"5555", X"0000", X"9", X"AA00", "00101010"), 
		
		-- A sra x
		("1101", X"0000", X"0000", X"0", X"0000", "01100001"), 
		("1101", X"0000", X"0000", X"4", X"0000", "01100001"), 
		("1101", X"8888", X"0000", X"1", X"C444", "00101010"), 
		("1101", X"8888", X"0000", X"3", X"f111", "00101010"), 
		("1101", X"AAAA", X"0000", X"9", X"FFD5", "00101010"), 
		
		-- A rotl x 
		("1110", X"0000", X"0000", X"2", X"0000", "01100001"),  
		("1110", X"8888", X"0000", X"1", X"1111", "01010010"), 
		("1110", X"8101", X"0000", X"1", X"0203", "01010010"), 

		-- A rotr x
		("1111", X"0000", X"0000", X"2", X"0000", "01100001"), 
		("1111", X"1111", X"0000", X"1", X"8888", "00101010"),  
		("1111", X"1081", X"0000", X"1", X"8840", "00101010"), 
		
		-- THIS TEST WILL FAIL
		("1010", X"0000", X"0000", X"0", X"FFFF", "10000001") 

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

		-- run the test for every set of data
		for i in test_vectors'range loop

			-- assign test inputs
			ctrl <= test_vectors(i).ctrl;
			A <= test_vectors(i).A;
			B <= test_vectors(i).B;
			X <= test_vectors(i).X;

			-- wait long enough for the ALU to process
			wait for wait_time;

			-- check that the actual output is the same as the expect output
			assert O = test_vectors(i).O
			report " [ERR!] Test " & integer'image(i)& 
				" Actual output did not equal expected output: Actual " & s_tostr(O) & 
				" , Expected " & s_tostr(test_vectors(i).O)
			severity error;
			
			-- check that the actual flags is the same as the expect flags
			assert flags = test_vectors(i).flags
			report " [ERR!] Test " & integer'image(i)& 
				" Actual flags did not equal expected flags : Actual " & to_bstring(flags) & 
				" , Expected " & to_bstring(test_vectors(i).flags)
			severity error;
			
			-- if there were no isses report that the test was successful
			assert not ( O = test_vectors(i).O and  flags = test_vectors(i).flags )
			report " [ OK ] Test " & integer'image(i)& " was successful!"
			severity note;

			wait for wait_time;

		end loop;

	wait;
	end process;

end;
