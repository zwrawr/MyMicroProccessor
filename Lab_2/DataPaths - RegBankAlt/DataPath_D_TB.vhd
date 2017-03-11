--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:38:31 03/11/2017
-- Design Name:   
-- Module Name:   E:/University/_Second Year/Computer Architectures/assesment/MyMicroProccessor/Lab_2/DataPaths/DataPath_D_TB.vhd
-- Project Name:  DataPaths
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DataPath_D
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DataPath_D_TB IS
END DataPath_D_TB;
 
ARCHITECTURE behavior OF DataPath_D_TB IS 
 
     -- Constants
	constant data_size : NATURAL := 16;
	constant num_registers : NATURAL := 32;
	
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT DataPath_D
	GENERIC(
		data_size : natural;
		num_registers : natural
	);
    PORT(
		clk : in  STD_LOGIC;
		rst : in STD_LOGIC;
		en : in STD_LOGIC;
		
		R_A : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		R_B : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		W_EN : in  STD_LOGIC;
		W_A : in  STD_LOGIC_VECTOR (log2(num_registers)-1 downto 0);
		IMM : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_A : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_in : in  STD_LOGIC_VECTOR (data_size-1 downto 0);
		SEL : in  STD_LOGIC_VECTOR (7 downto 0);
		AL : in  STD_LOGIC_VECTOR (3 downto 0);
		SH : in  STD_LOGIC_VECTOR (log2(data_size)-1 downto 0);
		
		Flags : out  STD_LOGIC_VECTOR (7 downto 0);
		M_DA : out  STD_LOGIC_VECTOR (data_size-1 downto 0);
		M_out : out  STD_LOGIC_VECTOR (data_size-1 downto 0)
	);
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal en : std_logic :=  '0';
   
   signal R_A : std_logic_vector(log2(num_registers)-1 downto 0) := (others => '0');
   signal R_B : std_logic_vector(log2(num_registers)-1 downto 0) := (others => '0');
   signal W_EN : std_logic := '0';
   signal W_A : std_logic_vector(log2(num_registers)-1 downto 0) := (others => '0');
   signal IMM : std_logic_vector(data_size-1 downto 0) := (others => '0');
   signal M_A : std_logic_vector(data_size-1 downto 0) := (others => '0');
   signal M_in : std_logic_vector(data_size-1 downto 0) := (others => '0');
   signal SEL : std_logic_vector(7 downto 0) := (others => '0');
   signal AL : std_logic_vector(3 downto 0) := (others => '0');
   signal SH : std_logic_vector(log2(data_size)-1 downto 0) := (others => '0');

 	--Outputs
   signal Flags : std_logic_vector(7 downto 0);
   signal M_DA : std_logic_vector(data_size-1 downto 0);
   signal M_out : std_logic_vector(data_size-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   
   	-- Test data definitions
	type TEST_VECTOR is RECORD
		 R_A 	: STD_LOGIC_VECTOR(log2(num_registers)-1 downto 0);
		 R_B 	: std_logic_vector(log2(num_registers)-1 downto 0);
		 
		 W_EN 	: std_logic;
		 W_A 	: std_logic_vector(log2(num_registers)-1 downto 0);

		 IMM 	: std_logic_vector(data_size-1 downto 0);
		 M_A 	: std_logic_vector(data_size-1 downto 0);
		 M_in 	: std_logic_vector(data_size-1 downto 0);
		 SEL 	: std_logic_vector(7 downto 0);
		 AL 	: std_logic_vector(3 downto 0);
		 SH 	: std_logic_vector(log2(data_size)-1 downto 0) ;
		
	end RECORD;
	type TEST_VECTOR_ARRAY is ARRAY(NATURAL RANGE <>) of TEST_VECTOR;
	
	-- Test Data 
	constant test_vectors : TEST_VECTOR_ARRAY := (
	--R_A,		R_B,		W_EN,	W_A,		IMM,				M_A,				M_in,				SEL,		AL,		SH
	( "00000",	"-----",	'0',	"-----",	"----------------",	"----------------",	"----------------",	"0-------",	"----",	"----" ),
	( "00000",	"-----",	'0',	"-----",	"----------------",	"----------------",	"----------------",	"0---01--",	"1000",	"----" ),
	( "-----",	"-----",	'0',	"-----",			   X"0005", "----------------", "----------------", "----0110", "1010", "----" ),
	( "-----",	"-----",	'1',	"00001",	"----------------", "----------------", "----------------", "--1-----", "----", "----" ),
	( "-----",  "-----", 	'1',	"00010",	"----------------", "----------------", "----------------", "-11-11--", "1100", "0011" ),
	( "-----",	"-----",	'0',	"-----",	"----------------",	"----------------", "----------------", "--1-11--", "0000", "----" ),
	( "-----",	"-----",	'0',	"-----",	"----------------", "----------------", "----------------", "---0----", "----", "----" ),
	( "-----", 	"-----", 	'0', 	"-----",	"----------------", X"1F1F",			X"CCCC",			"---1----", "----", "----" ),
	( "-----",	"-----",	'1',	"00101",	"----------------", "----------------", "----------------", "--0-----", "----", "----" )
	
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataPath_D 
	Generic Map(
		data_size => data_size,
		num_registers => num_registers
	)
   PORT MAP (
          clk => clk,
          R_A => R_A,
          R_B => R_B,
          W_EN => W_EN,
          W_A => W_A,
          IMM => IMM,
          M_A => M_A,
          M_in => M_in,
          SEL => SEL,
          AL => AL,
          SH => SH,
          Flags => Flags,
          M_DA => M_DA,
          M_out => M_out,
		  rst => rst,
		  en => en
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
		
		rst <= '0';
		en <= '1';
		wait for 2*clk_period;

		-- run the test for every set of data
		for i in test_vectors'range loop
			
			--wait for clk_period/2;
			wait until rising_edge(clk);
			
			-- assign test inputs
			R_A <= test_vectors(i).R_A;
			R_B <= test_vectors(i).R_B;
			
			W_EN <= test_vectors(i).W_EN;
			W_A <= test_vectors(i).W_A;
			
			IMM <= test_vectors(i).IMM;
			M_A <= test_vectors(i).M_A;
			M_in <= test_vectors(i).M_in;

			SEL <= test_vectors(i).SEL;
			AL <= test_vectors(i).AL;
			SH <= test_vectors(i).SH;
			
			--wait for clk_period/2;
			wait until falling_edge(clk);

		end loop;
		
		-- End of test
		wait;
	end process;


END;
