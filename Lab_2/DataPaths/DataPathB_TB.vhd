--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:13:39 03/03/2017
-- Design Name:   
-- Module Name:   E:/University/_Second Year/Computer Architectures/assesment/MyMicroProccessor/Lab_2/DataPaths/DataPathB_TB.vhd
-- Project Name:  DataPaths
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DataPath_B
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
USE work.DigEng.ALL;
USE work.easyprint.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY DataPathB_TB IS
END DataPathB_TB;
 
ARCHITECTURE behavior OF DataPathB_TB IS 

	-- Constants
	constant data_size : NATURAL := 16;
	constant num_registers : NATURAL := 5;

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

   -- Clock period definitions
   constant clk_period 	: time 	:= 10 ns;
   constant wait_time 	: time 	:= clk_period;

	
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
	end RECORD;
	
	
	type TEST_VECTOR_ARRAY is ARRAY(NATURAL RANGE <>) of TEST_VECTOR;
	
	constant test_vectors : TEST_VECTOR_ARRAY := (
		--W_EN,	AL,		R_A,		R_B,		W_A,		IMM,						SH,		M_A,						S,			M_in,		flags,		M_B,						M_DA	
		(	'1',	"1000",	"000",	"---",	"001",	"----------------",	"----",	"----------------",	"0--0",	X"0000",	"01010110",	"----------------",	"----------------" ),
		(	'1',	"1000",	"000",	"---",	"001",	"----------------",	"----",	"----------------",	"0--0",	X"0000",	"01010110",	"----------------",	"----------------" )
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

      wait for clk_period*10;

      -- insert stimulus here

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

			-- wait long enough for the Data path to process the inputs
			wait for wait_time;

			assert flags = test_vectors(i).flags
			report " [ERR!] Test " & integer'image(i)& 
				" Actual flags did not equal expected flags."&
				" Actual [ " & to_bstring(flags) & " ]" &
				" Expected [ " & to_bstring(test_vectors(i).flags) & " ]"
			severity error;
			
			assert std_match(test_vectors(i).M_B, M_B) -- have to use std_match when comparing meta values like '-'
			report " [ERR!] Test " & integer'image(i)& 
				" Actual value to memory did not equal expected value to memory."&
				" Actual [ " & u_tostr(M_B) & " ]" &
				" Expected [ " & u_tostr(test_vectors(i).M_B) & " ]"
			severity error;
			
			assert std_match(M_DA , test_vectors(i).M_DA)
			report " [ERR!] Test " & integer'image(i)& 
				" Actual memory address did not equal expected memory address."&
				" Actual [ " & u_tostr(M_DA) & " ]" &
				" Expected [ " & u_tostr(test_vectors(i).M_DA) & " ]"
			severity error;
			
			-- if there were no isses report that the test was successful
			assert not (flags = test_vectors(i).flags and 
				std_match(M_B, test_vectors(i).M_B) and 
				std_match(M_DA, test_vectors(i).M_DA))
			report " [ OK ] Test " & integer'image(i)& " was successful!"
			severity note;

			wait for wait_time;

		end loop;


      wait;
   end process;

END;
