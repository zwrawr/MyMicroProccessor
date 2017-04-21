LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.DigEng.ALL;
USE work.easyprint.ALL;
USE ieee.numeric_std.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ControlFSM_TB IS
END ControlFSM_TB;
 
ARCHITECTURE behavior OF ControlFSM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlFSM
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         opcode : IN  std_logic_vector(5 downto 0);
         S : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal opcode : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	-- Test Data
	type TEST_RECORD is record
		opcode  : std_logic_vector(5 downto 0);
		S : std_logic_vector(4 downto 1);
	end record TEST_RECORD;

	type TEST_RECORD_ARRAY is array (NATURAL range <>) of TEST_RECORD;

	constant test_data : TEST_RECORD_ARRAY := (
		-- Register
		("000100", "--1-"), --add rt, ra, rb 
		("000100", "----"),
		("000100", "--00"),
		("000100", "0---"),
		
		("010000", "--1-"), -- and rt, ra, rb
		("010000", "----"), 
		("010000", "--00"),
		("010000", "0---"),
		-- Memory
		("100111", "--1-"), -- stor
		("100111", "----"),
		("100111", "--01"),
		("100111", "-0--"),

		("100101", "--1-"), -- load
		("100101", "----"),
		("100101", "--01"),
		("100101", "-0--"),
		("100101", "1---")
		-- Branch
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlFSM PORT MAP (
          clk => clk,
          rst => rst,
          opcode => opcode,
          S => S
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
		
		rst <= '1';
		wait for 2*clk_period;
		rst <= '0';

		for i in test_data'range loop
      
			
			-- assign test inputs
			opcode <= test_data(i).opcode;
			
			wait until falling_edge(clk);
			
			-- Check to see if the out put was what we were expecting
			assert std_match(S, test_data(i).S)
			report lf & " [ERR!] Test " & integer'image(i)& 
				" Actual STATE did not equal expected STATE."&
				" Actual [ " & to_bstring(S) & " ]" &
				" Expected [ " & to_bstring(test_data(i).S) & " ]" & lf
			severity error;
			
			-- if there were no isses report that the test was successful
			assert not (std_match(S, test_data(i).S))
			report lf & " [ OK ] Test " & integer'image(i)& " was successful!" & lf
			severity note;
			wait until rising_edge(clk);

		end loop;

		-- End of test
      wait;
   end process;

END;
