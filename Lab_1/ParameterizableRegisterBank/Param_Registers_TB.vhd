--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:08:04 02/23/2017
-- Design Name:   
-- Module Name:   E:/University/_Second Year/Computer Architectures/assesment/MyMicroProccessor/Lab_1/ParameterizableRegisterBank/Param_Registers_TB.vhd
-- Project Name:  ParameterizableRegisterBank
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Pram_Registers
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
			addr_C : IN  std_logic_vector(log2(num_reg)-1 downto 0);
			wr_en : IN  std_logic;
			clk : IN  std_logic;
			data_in : IN  std_logic_vector(data_size-1 downto 0);
			A_out : OUT  std_logic_vector(data_size-1 downto 0);
			B_out : OUT  std_logic_vector(data_size-1 downto 0)
		);
    END COMPONENT;
    

   --Inputs
   signal addr_A : std_logic_vector(log2(num_reg)-1 downto 0) := (others => '0');
   signal addr_B : std_logic_vector(log2(num_reg)-1 downto 0) := (others => '0');
   signal addr_C : std_logic_vector(log2(num_reg)-1 downto 0) := (others => '0');
   signal wr_en : std_logic := '0';
   signal clk : std_logic := '0';
   signal data_in : std_logic_vector(data_size-1 downto 0) := (others => '0');

 	--Outputs
   signal A_out : std_logic_vector(data_size-1 downto 0);
   signal B_out : std_logic_vector(data_size-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	type TEST_VECTOR is RECORD
		wr_en   : std_logic;
		addr_A  : std_logic_vector(log2(num_reg)-1 downto 0);
      addr_B  : std_logic_vector(log2(num_reg)-1 downto 0);
      addr_C  : std_logic_vector(log2(num_reg)-1 downto 0);
      data_in : std_logic_vector(data_size-1 downto 0);
		A_out   : std_logic_vector(data_size-1 downto 0);
      B_out   : std_logic_vector(data_size-1 downto 0);
	end RECORD;
	
	type TEST_VECTOR_ARRAY is ARRAY(NATURAL range <>) of TEST_VECTOR;
	
	constant test_vectors : TEST_VECTOR_ARRAY := 
	(
-- wr_en,     addr_A,    addr_B,    addr_C,    data_in,      A_out,        B_out
	('0',      "000",      "000",      "000",      X"0000",      X"0000",      X"0000"),
	('1',      "000",      "000",      "001",      X"FFFF",      X"0000",      X"0000"),
	('1',      "000",      "000",      "010",      X"1111",      X"0000",      X"0000"),
	('0',      "001",      "010",      "000",      X"0000",      X"FFFF",      X"1111")--,

--	('0',      "000",      "000",      "000",      X"0000",      X"0000",      X"0000"),

	
	
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

			-- insert stimulus here 
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
			report "ERROR! A IS BROKEN!"
			severity error;
			
			-- check that output A is the same as the expected
			assert B_out = test_vectors(i).B_out
			report "ERROR! B IS BROKEN!"
			severity error;
			
			wait for clk_period;
			
		end loop;
		
   wait;
   end process;

END;
