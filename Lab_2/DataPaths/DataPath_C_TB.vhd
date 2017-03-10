LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.DigEng.ALL;
USE work.easyprint.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY DataPath_C_TB IS
END DataPath_C_TB;
 
ARCHITECTURE behavior OF DataPath_C_TB IS 
 
    -- Constants
	constant data_size : NATURAL := 16;
	constant num_registers : NATURAL := 32;
	
	-- Clock period definitions
	constant clk_period : time := 10 ns;

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT DataPath_C
		GENERIC(
			data_size : natural;
			num_registers : natural
		);
		PORT(
			clk 	: IN  	std_logic;
			
			R_A 	: IN  	std_logic_vector	(log2(num_registers)-1 downto 0);
			R_B 	: IN  	std_logic_vector	(log2(num_registers)-1 downto 0);
			W_EN 	: IN  	std_logic;
			W_A 	: IN  	std_logic_vector	(log2(num_registers)-1 downto 0);
			IMM 	: IN  	std_logic_vector	(data_size-1 downto 0);
			M_A 	: IN  	std_logic_vector	(data_size-1 downto 0);
			M_in 	: IN  	std_logic_vector	(data_size-1 downto 0);
			PC 		: IN  	std_logic_vector	(15 downto 0);
			S 		: IN  	std_logic_vector	(4 downto 1);
			AL 		: IN  	std_logic_vector	(3 downto 0);
			SH 		: IN  	std_logic_vector	(log2(data_size)-1 downto 0);
			
			PC_plus : OUT  	std_logic_vector	(15 downto 0);
			Flags 	: OUT  	std_logic_vector	(7 downto 0);
			M_DA 	: OUT  	std_logic_vector	(data_size-1 downto 0);
			M_out 	: OUT  	std_logic_vector	(data_size-1 downto 0)
		);
    END COMPONENT;
    

	--Inputs
	signal clk 	: std_logic 											:= '0';
	signal R_A 	: std_logic_vector	(log2(num_registers)-1 downto 0)	:= (others => '0');
	signal R_B 	: std_logic_vector	(log2(num_registers)-1 downto 0)	:= (others => '0');
	signal W_EN	: std_logic 											:= '0';
	signal W_A 	: std_logic_vector	(log2(num_registers)-1 downto 0 )	:= (others => '0');
	signal IMM 	: std_logic_vector	(data_size-1 downto 0) 				:= (others => '0');
	signal M_A 	: std_logic_vector	(data_size-1 downto 0) 				:= (others => '0');
	signal M_in : std_logic_vector	(data_size-1 downto 0) 				:= (others => '0');
	signal PC 	: std_logic_vector	(15 downto 0) 						:= (others => '0');
	signal S 	: std_logic_vector	(4 downto 1) 						:= (others => '0');
	signal AL 	: std_logic_vector	(3 downto 0) 						:= (others => '0');
	signal SH 	: std_logic_vector	(log2(data_size)-1 downto 0)		:= (others => '0');

	--Outputs
	signal PC_plus 	: std_logic_vector	(15 downto 0);
	signal Flags 	: std_logic_vector	(7 downto 0);
	signal M_DA 	: std_logic_vector	(data_size-1 downto 0);
	signal M_out 	: std_logic_vector	(data_size-1 downto 0);

	-- Test data definitions
	type TEST_VECTOR is RECORD
		 R_A 	: STD_LOGIC_VECTOR(log2(num_registers)-1 downto 0);
		 R_B 	: std_logic_vector(log2(num_registers)-1 downto 0);
		 
		 W_EN 	: std_logic;
		 W_A 	: std_logic_vector(log2(num_registers)-1 downto 0);

		 IMM 	: std_logic_vector(data_size-1 downto 0);
		 M_A 	: std_logic_vector(data_size-1 downto 0);
		 M_in 	: std_logic_vector(data_size-1 downto 0);
		 PC 	: std_logic_vector(15 downto 0);
		 S 		: std_logic_vector(4 downto 1);
		 AL 	: std_logic_vector(3 downto 0);
		 SH 	: std_logic_vector(log2(data_size)-1 downto 0) ;
		
		 PC_plus: std_logic_vector(15 downto 0);
		 flags 	: std_logic_vector(7 downto 0);
		 M_DA 	: std_logic_vector(data_size-1 downto 0);
		 M_out 	: std_logic_vector(data_size-1 downto 0);
	end RECORD;
	type TEST_VECTOR_ARRAY is ARRAY(NATURAL RANGE <>) of TEST_VECTOR;
	
	-- TODO:: Add some test data.
	-- Test Data 
	constant test_vectors : TEST_VECTOR_ARRAY := (
		--R_A,		R_B,		W_EN,	W_A,		IMM,				M_A,				M_in,				PC,			S,		AL,		SH,		PC_plus,			flags,		M_DA,				M_out
		( "-----",	"-----",	'0',	"-----",	"----------------",	"----------------",	"----------------",	X"00FF",	"--1-",	"1000",	"----",	"----------------",	"01010110",	"----------------",	"----------------" ),
		( "00000",	"-----",	'0',	"-----",	"----------------",	"----------------",	"----------------",	X"00FF",	"----",	"----",	"----",	X"0100",			"--------",	"----------------",	"----------------" ),
		( "-----",	"-----",	'0',	"-----",	"----------------",	"----------------",	"----------------",	X"00FF",	"--0-",	"1000",	"----",	"----------------",	"01010110",	"----------------",	"----------------" ),
		( "-----",	"-----",	'1',	"00001",	"----------------",	"----------------",	"----------------",	X"00FF",	"----",	"----",	"----",	"----------------",	"--------",	"----------------",	"----------------" )
	);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: DataPath_C 
	Generic Map(
		data_size => data_size,
		num_registers => num_registers
	)
	PORT MAP (
		clk => clk,
		
		-- Inputs
		R_A => R_A,
		R_B => R_B,
		
		W_EN => W_EN,
		W_A => W_A,
		
		IMM => IMM,
		M_A => M_A,
		M_in => M_in,
		PC => PC,
		S => S,
		AL => AL,
		SH => SH,
		
		-- Outputs
		PC_plus => PC_plus,
		Flags => Flags,
		M_DA => M_DA,
		M_out => M_out
	);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		-- hold reset state for 100 ns.
		wait for 100 ns;	
		wait until rising_edge(clk);
		
		-- run the test for every set of data
		for i in test_vectors'range loop
			
			-- assign test inputs
			R_A <= test_vectors(i).R_A;
			R_B <= test_vectors(i).R_B;
			
			W_EN <= test_vectors(i).W_EN;
			W_A <= test_vectors(i).W_A;
			
			IMM <= test_vectors(i).IMM;
			M_A <= test_vectors(i).M_A;
			M_in <= test_vectors(i).M_in;
			PC <= test_vectors(i).PC;
			S <= test_vectors(i).S;
			AL <= test_vectors(i).AL;
			SH <= test_vectors(i).SH;

			-- wait long enough for the Data path to process the inputs
			wait for clk_period/2;

			-- Check to see if the out put was what we were expecting
			-- Have to use std_match() instead of = when comparing meta values like '-'
			assert std_match(test_vectors(i).flags, flags)
			report " [ERR!] Test " & integer'image(i)& 
				" Actual flags did not equal expected flags."&
				" Actual [ " & to_bstring(flags) & " ]" &
				" Expected [ " & to_bstring(test_vectors(i).flags) & " ]"
			severity error;
			
			assert std_match(test_vectors(i).M_out, M_out) 
			report " [ERR!] Test " & integer'image(i)& 
				" Actual value to memory did not equal expected value to memory."&
				" Actual [ " & u_tostr(M_out) & " ]" &
				" Expected [ " & u_tostr(test_vectors(i).M_out) & " ]"
			severity error;
			
			assert std_match(M_DA , test_vectors(i).M_DA)
			report " [ERR!] Test " & integer'image(i)& 
				" Actual memory address did not equal expected memory address."&
				" Actual [ " & u_tostr(M_DA) & " ]" &
				" Expected [ " & u_tostr(test_vectors(i).M_DA) & " ]"
			severity error;
			
			assert std_match(PC_plus, test_vectors(i).PC_plus)
			report " [ERR!] Test " & integer'image(i)& 
				" Actual program counter did not equal expected program counter."&
				" Actual [ " & u_tostr(PC_plus) & " ]" &
				" Expected [ " & u_tostr(test_vectors(i).PC_plus) & " ]"
			severity error;
			
			-- if there were no isses report that the test was successful
			assert not (
				std_match(flags, test_vectors(i).flags) and 
				std_match(M_out, test_vectors(i).M_out) and 
				std_match(M_DA, test_vectors(i).M_DA) and
				std_match(PC_plus, test_vectors(i).PC_plus)
			)
			report " [ OK ] Test " & integer'image(i)& " was successful!"
			severity note;

			wait for clk_period/2;

		end loop;
		
		-- End of test
		wait;
	end process;


END;
