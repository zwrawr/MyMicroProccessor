
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.DigEng.ALL;
USE work.easyprint.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY DataPathB_TB IS
END DataPathB_TB;
 
ARCHITECTURE behavior OF DataPathB_TB IS 

	-- Constants
	constant data_size : NATURAL := 16;
	constant num_registers : NATURAL := 32;

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT DataPath_B
		GENERIC(
			data_size : natural;
			num_registers : natural
		);
		PORT(
			R_A : IN  std_logic_vector(log2(num_registers)-1 downto 0);
			R_B : IN  std_logic_vector(log2(num_registers)-1 downto 0);
			W_EN : IN  std_logic;
			W_A : IN  std_logic_vector(log2(num_registers)-1 downto 0);
			clk : IN  std_logic;
			IMM : IN  std_logic_vector(data_size-1 downto 0);
			AL : IN  std_logic_vector(3 downto 0);
			SH : IN  std_logic_vector(log2(data_size)-1 downto 0);
			M_A : IN  std_logic_vector(data_size-1 downto 0);
			S : IN  std_logic_vector(4 downto 1);
			flags : OUT  std_logic_vector(7 downto 0);
			M_B : OUT  std_logic_vector(data_size-1 downto 0);
			M_DA : OUT  std_logic_vector(data_size-1 downto 0);
			M_in : IN  std_logic_vector(data_size-1 downto 0)
		);
	END COMPONENT;
    

   --Inputs
   signal R_A 	: std_logic_vector	(log2(num_registers)-1 downto 0) := (others => '0');
   signal R_B 	: std_logic_vector	(log2(num_registers)-1 downto 0) := (others => '0');
   signal W_EN : std_logic 														:= '0';
   signal W_A 	: std_logic_vector	(log2(num_registers)-1 downto 0) := (others => '0');
   signal clk 	: std_logic 														:= '0';
   signal IMM 	: std_logic_vector	(data_size-1 downto 0) 				:= (others => '0');
   signal AL 	: std_logic_vector	(3 downto 0) 							:= (others => '0');
   signal SH 	: std_logic_vector	(log2(data_size)-1 downto 0) 		:= (others => '0');
   signal M_A 	: std_logic_vector	(data_size-1 downto 0) 				:= (others => '0');
   signal S 	: std_logic_vector	(4 downto 1) 							:= (others => '0');
   signal M_in : std_logic_vector	(data_size-1 downto 0) 				:= (others => '0');

 	--Outputs
   signal flags 	: std_logic_vector	(7 downto 0);
   signal M_B 		: std_logic_vector	(data_size-1 downto 0);
   signal M_DA 	: std_logic_vector	(data_size-1 downto 0);
   signal OEN : std_logic := '0';
   
   -- Clock period definitions
   constant clk_period 	: time 	:= 10 ns;
   constant wait_time 	: time 	:= clk_period;

	-- Test data for self checking test bench
	type TEST_VECTOR is RECORD
		 W_EN : std_logic;
		 AL : std_logic_vector(3 downto 0);
		 R_A : STD_LOGIC_VECTOR(log2(num_registers)-1 downto 0);
		 R_B : std_logic_vector(log2(num_registers)-1 downto 0);
		 W_A : std_logic_vector(log2(num_registers)-1 downto 0);
		 IMM : std_logic_vector(data_size-1 downto 0);
		 SH : std_logic_vector(log2(data_size)-1 downto 0) ;
		 M_A : std_logic_vector(data_size-1 downto 0);
		 S : std_logic_vector(4 downto 1);
		 M_in : std_logic_vector(data_size-1 downto 0);
		
		 flags : std_logic_vector(7 downto 0);
		 M_B : std_logic_vector(data_size-1 downto 0);
		 M_DA : std_logic_vector(data_size-1 downto 0);
		 
		 OEN : std_logic;
	end RECORD;
	
	type TEST_VECTOR_ARRAY is ARRAY(NATURAL RANGE <>) of TEST_VECTOR;
	
	constant test_vectors : TEST_VECTOR_ARRAY := (
		--W_EN,		AL,		R_A,		R_B,		W_A,		IMM,				SH,		M_A,				S,		M_in,				flags,		M_B,				M_DA,				OEN	
		(	'1',	"1000",	"00000",	"-----",	"00001",	"----------------",	"----",	"----------------",	"0---",	"----------------",	"01010110",	"----------------",	"----------------",	'0'),
		(	'1',	"1010",	"00000",	"-----",	"00010",	X"0005",			"----",	"----------------",	"0--1",	"----------------",	"01010010",	"----------------",	"----------------",	'0'),
		(	'1',	"1100",	"00001",	"-----",	"00011",	"----------------",	"0011",	"----------------",	"0---",	"----------------",	"01010010",	"----------------",	"----------------",	'0'),
		(	'0',	"0000",	"00011",	"00010",	"-----",	"----------------",	"----",	"----------------",	"0---",	"----------------",	"01010010",	X"0005",			X"0008",			'1'),
		(	'1',	"----",	"-----",	"-----",	"00101",	"----------------",	"----",	X"1f1f",			"11--",	X"CCCC",			"--------",	"----------------",	X"1f1f",			'0')
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataPath_B 
	Generic Map(
		data_size => data_size,
		num_registers => num_registers	
	)
	PORT MAP (
          R_A => R_A,
          R_B => R_B,
          W_EN => W_EN,
          W_A => W_A,
          clk => clk,
          IMM => IMM,
          AL => AL,
          SH => SH,
          M_A => M_A,
          S => S,
          flags => flags,
          M_B => M_B,
          M_DA => M_DA,
          M_in => M_in
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

		-- run the test for every set of data
		for i in test_vectors'range loop
			
			-- assign test inputs
			R_A <= test_vectors(i).R_A;
			R_B <= test_vectors(i).R_B;
			W_EN <= test_vectors(i).W_EN;
			W_A <= test_vectors(i).W_A;
			IMM <= test_vectors(i).IMM;
			AL <= test_vectors(i).AL;
			SH <= test_vectors(i).SH;
			M_A <= test_vectors(i).M_A;
			S <= test_vectors(i).S;
			M_in <= test_vectors(i).M_in;

			OEN <= test_vectors(i).OEN;
			
			wait until rising_edge(clk);
			
			-- Check that the actual outputs are the same as were expecting
			-- Have to use std_match when comparing meta values like '-'
			assert std_match(flags, test_vectors(i).flags)
			report lf & " [ERR!] Test " & integer'image(i)& lf &
				" Actual flags did not equal expected flags."&
				" Actual [ " & to_bstring(flags) & " ]" &
				" Expected [ " & to_bstring(test_vectors(i).flags) & " ]"
			severity error;
			
			assert std_match(test_vectors(i).M_B, M_B) 
			report lf &" [ERR!] Test " & integer'image(i)& lf &
				" Actual value to memory did not equal expected value to memory."&
				" Actual [ " & u_tostr(M_B) & " ]" &
				" Expected [ " & u_tostr(test_vectors(i).M_B) & " ]"
			severity error;
			
			assert std_match(M_DA , test_vectors(i).M_DA)
			report lf &" [ERR!] Test " & integer'image(i)& lf &
				" Actual memory address did not equal expected memory address."&
				" Actual [ " & u_tostr(M_DA) & " ]" &
				" Expected [ " & u_tostr(test_vectors(i).M_DA) & " ]"
			severity error;
			
			-- If there were no isses report that the test was successful
			assert not (
				std_match(flags, test_vectors(i).flags) and 
				std_match(M_B, test_vectors(i).M_B) and 
				std_match(M_DA, test_vectors(i).M_DA))
			report lf &" [ OK ] Test " & integer'image(i)& " was successful!" 
			severity note;

			wait until falling_edge(clk);

		end loop;
		
		wait;
		
	end process;

END;
