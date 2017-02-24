----------------------------------------------------------------------------------
-- 
-- Uni			:	University of York
-- Course		:	Electronic Engineering
-- Module  		:	Computer Architectures 
-- Engineers	:	Y3839090 & Y3840426
-- 
-- Create Date	:	23:08:04 02/23/2017
-- Design Name	:	Param_Registers_TB - TestBench 
-- Description	:	A 16 bit 8 register dual read single write register array. 		
--
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.DigEng.ALL;
 
ENTITY Param_Registers_TB IS
END Param_Registers_TB;
 
ARCHITECTURE behavior OF Param_Registers_TB IS 


	-- Constants
	constant num_reg : natural := 8;
	constant data_size : natural := 16;

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT Pram_Registers
		GENERIC(
			num_reg : natural;
			data_size : natural
		);
		PORT(
			addr_A : IN  std_logic_vector(log2(num_reg)-1 downto 0);
			addr_B : IN  std_logic_vector(log2(num_reg)-1 downto 0);
			addr_C : IN  std_logic_vector(log2(num_reg)-1 downto 0); -- Address to write to
			data_in : IN  std_logic_vector(data_size-1 downto 0); -- Data to write
			wr_en : IN  std_logic;
			clk : IN  std_logic;
			A_out : OUT  std_logic_vector(data_size-1 downto 0);
			B_out : OUT  std_logic_vector(data_size-1 downto 0)
		);
    END COMPONENT;
    

   --Inputs
   signal addr_A : std_logic_vector(log2(num_reg)-1 downto 0) := (others => '0');
   signal addr_B : std_logic_vector(log2(num_reg)-1 downto 0) := (others => '0');
   signal addr_C : std_logic_vector(log2(num_reg)-1 downto 0) := (others => '0');
	signal data_in : std_logic_vector(data_size-1 downto 0) := (others => '0');
	signal wr_en : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal A_out : std_logic_vector(data_size-1 downto 0);
   signal B_out : std_logic_vector(data_size-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	type TEST_VECTOR is RECORD
		wr_en   : std_logic; -- Write enable
		addr_A  : std_logic_vector(log2(num_reg)-1 downto 0); -- A address to read from
      addr_B  : std_logic_vector(log2(num_reg)-1 downto 0); -- B address to read from
      addr_C  : std_logic_vector(log2(num_reg)-1 downto 0); -- C address to write to
      data_in : std_logic_vector(data_size-1 downto 0); -- Data to write at addr_C
		A_out   : std_logic_vector(data_size-1 downto 0); -- Expected data to be read from addr_A
      B_out   : std_logic_vector(data_size-1 downto 0); -- Expected data to be read from addr_B
	end RECORD;
	
	type TEST_VECTOR_ARRAY is ARRAY(NATURAL range <>) of TEST_VECTOR;
	
	constant test_vectors : TEST_VECTOR_ARRAY := 
	(
	-- wr_en,     addr_A,    addr_B,    addr_C,    data_in,      A_out,        B_out
		('0',      "000",      "000",      "000",      X"0000",      X"0000",      X"0000"),
		('1',      "000",      "000",      "001",      X"FFFF",      X"0000",      X"0000"),
		('1',      "000",      "000",      "010",      X"1111",      X"0000",      X"0000"),
		('0',      "001",      "010",      "000",      X"0000",      X"FFFF",      X"1111"),
		('1',      "000",      "000",      "111",      X"0011",      X"0000",      X"0000"),
		('1',      "111",      "111",      "110",      X"8800",      X"0011",      X"0011"),
		('1',      "111",      "110",      "000",      X"AAAA",      X"0011",      X"8800"),
		('0',      "000",      "000",      "000",      X"0000",      X"0000",      X"0000"),
		
		('1',      "000",      "001",      "010",      X"1111",      X"0000",      X"FFFF"),
		('1',      "001",      "010",      "011",      X"2222",      X"FFFF",      X"1111"),
		('1',      "010",      "011",      "100",      X"3333",      X"1111",      X"2222"),
		('1',      "011",      "100",      "101",      X"4444",      X"2222",      X"3333"),
		('1',      "100",      "101",      "110",      X"5555",      X"3333",      X"4444"),
		('1',      "101",      "110",      "111",      X"6666",      X"4444",      X"5555"),
		('0',      "110",      "111",      "000",      X"0000",      X"5555",      X"6666")

		
	);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: Pram_Registers 
	GENERIC MAP(
		num_reg => num_reg,
		data_size => data_size
	)
	PORT MAP (
		addr_A => addr_A,
		addr_B => addr_B,
		addr_C => addr_C,
		wr_en => wr_en,
		clk => clk,
		data_in => data_in,
		A_out => A_out,
		B_out => B_out
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

		-- Loop over all of our test data sets
		for i in test_vectors'range loop
		
			-- assign test inputs
			wr_en <= test_vectors(i).wr_en;
			addr_A <= test_vectors(i).addr_A;
			addr_B <= test_vectors(i).addr_B;
			addr_C <= test_vectors(i).addr_C;
			data_in <= test_vectors(i).data_in;
			
			
			-- wait for a clock cycle
			wait for clk_period;
			
			
			-- check that output A is the same as the expected
			assert A_out = test_vectors(i).A_out
			report " [ERR!] Test " & integer'image(i) & " : A output is not what was expected!"
			severity error;
			
			-- check that output A is the same as the expected
			assert B_out = test_vectors(i).B_out
			report " [ERR!] Test " & integer'image(i) & " : B output is not what was expected!"
			severity error;
			
			-- check that output A is the same as the expected
			assert (B_out /= test_vectors(i).B_out or A_out /= test_vectors(i).A_out)
			report " [ OK ] Test " & integer'image(i) & " passed!"
			severity note;
			
			wait for clk_period;
			
		end loop;
		
   wait;
   end process;

END;
