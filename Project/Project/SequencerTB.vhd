LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 USE ieee.numeric_std.ALL;
 
ENTITY SequencerTB IS
END SequencerTB;
 
ARCHITECTURE behavior OF SequencerTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sequencer
    PORT(
         clk : IN  std_logic;
         PC_plus : IN  std_logic_vector(7 downto 0);
         instr : IN  std_logic_vector(31 downto 0);
         flags : IN  std_logic_vector(7 downto 0);
         PC : OUT  std_logic_vector(7 downto 0);
         MIA : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal PC_plus : std_logic_vector(7 downto 0) := (others => '0');
   signal instr : std_logic_vector(31 downto 0) := (others => '0');
   signal flags : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal PC : std_logic_vector(7 downto 0);
   signal MIA : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   
   -- Test Data
	type TEST_RECORD is record
		
		instr : std_logic_vector(31 downto 0);
		PC_plus  : std_logic_vector(5 downto 0);
		flags : std_logic_vector(6 downto 0);
		
		PC : std_logic_vector(4 downto 1);
		MIA : std_logic_vector(7 downto 0);
		
	end record;

	type TEST_RECORD_ARRAY is array (NATURAL range <>) of TEST_RECORD;

	constant test_data : TEST_RECORD_ARRAY := (
		(X"00000000", "000000", "0000000", "000000", X"00"),
		(X"00000000", "000000", "0000000", "000000", X"00")
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sequencer PORT MAP (
          clk => clk,
          PC_plus => PC_plus,
          instr => instr,
          flags => flags,
          PC => PC,
          MIA => MIA
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
