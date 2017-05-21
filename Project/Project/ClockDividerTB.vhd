--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:23:49 05/21/2017
-- Design Name:   
-- Module Name:   E:/University/_Second Year/Computer Architectures/assesment/MyMicroProccessor/Project/Project/ClockDividerTB.vhd
-- Project Name:  Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ClockDivider
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
 
ENTITY ClockDividerTB IS
END ClockDividerTB;
 
ARCHITECTURE behavior OF ClockDividerTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ClockDivider
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         en : IN  std_logic;
         clk_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal clk_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ClockDivider PORT MAP (
	  clk => clk,
	  rst => rst,
	  en => en,
	  clk_out => clk_out
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
	  wait until rising_edge(clk);
	  rst <= '1';
	  en <= '1';
	  wait until rising_edge(clk);
	  
	  rst <= '0';
		
      wait;
   end process;

END;
