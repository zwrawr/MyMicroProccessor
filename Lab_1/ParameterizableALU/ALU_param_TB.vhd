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
 
ENTITY ALU_param_TB IS
END ALU_param_TB;
 
ARCHITECTURE behavior OF ALU_param_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	 
	 Constant M : natural := 16;
    COMPONENT ALU_param
	 GENERIC ( N : natural);
    PORT(
         A : IN  std_logic_vector(M-1 downto 0);
         B : IN  std_logic_vector(M-1 downto 0);
         X : IN  std_logic_vector(M-1 downto 0);
         ctrl : IN  std_logic_vector(3 downto 0);
         O : OUT  std_logic_vector(M-1 downto 0);
         flags : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(M-1 downto 0) := (others => '0');
   signal B : std_logic_vector(M-1 downto 0) := (others => '0');
   signal X : std_logic_vector(M-1 downto 0) := (others => '0');
   signal ctrl : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal O : std_logic_vector(M-1 downto 0);
   signal flags : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 type test_vector is record
   ctrl : std_logic_vector(3 downto  0);
	A : std_logic_vector(M-1 downto 0);
	B : std_logic_vector(M-1 downto  0);
	X : std_logic_vector(M-1 downto  0);
	O : std_logic_vector(M-1 downto 0);
	flags : std_logic_vector(7 downto 0);
	
 end record;
 
 type test_vector_array is array
	(natural range <>) of test_vector;

 constant test_vectors : test_vector_array := (
 
 -- CTRL,  A ,         B ,         X ,         O ,         FLAGS
 ("0000", "00000000", "00000000", "00000000", "00000000", "00000000"),
 ("0000", "00000000", "00000000", "00000000", "00000000", "00000000"),
 ("0000", "00000000", "00000000", "00000000", "00000000", "00000000"),
 ("0000", "00000000", "00000000", "00000000", "00000000", "00000000"),
 ("0000", "00000000", "00000000", "00000000", "00000000", "00000000"),
 ("0000", "00000000", "00000000", "00000000", "00000000", "00000000"),
 ("0000", "00000000", "00000000", "00000000", "00000000", "00000000"),
 ("0000", "00000000", "00000000", "00000000", "00000000", "00000000");
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU_param Generic MAP (N => M)
		PORT MAP (
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
		

      -- insert stimulus here 

      wait;
   end process;

END;
