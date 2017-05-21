LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.easyprint.ALL;
 
ENTITY SequencerTB IS
END SequencerTB;
 
ARCHITECTURE behavior OF SequencerTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sequencer
    PORT(
         clk : IN  std_logic;
		 rst : IN  std_logic;
		 en : IN std_logic;
		 FETCH : in STD_LOGIC;
         PC_plus : IN  std_logic_vector(7 downto 0);
         instr : IN  std_logic_vector(31 downto 0);
         flags : IN  std_logic_vector(7 downto 0);
         PC : OUT  std_logic_vector(7 downto 0);
         MIA : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal en : std_logic := '0';
   signal FETCH : std_logic := '0';
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
		PC_plus  : std_logic_vector(7 downto 0);
		flags : std_logic_vector(7 downto 0);
		
		PC : std_logic_vector(7 downto 0);
		MIA : std_logic_vector(7 downto 0);
		
	end record;

	type TEST_RECORD_ARRAY is array (NATURAL range <>) of TEST_RECORD;

	constant test_data : TEST_RECORD_ARRAY := (
	-- Instruction	, PCplus		, Flags		, PC	, MIA
		(X"01010101", "--------", "--------", X"00", X"00"),
		(X"200000A5", "--------", "--------", X"01", X"01"),
		(X"100C00A8", "--------", "--------", X"02", X"02"),
		(X"C40A00C0", X"0C"		, "------1-", X"03", X"03"),
		(X"00000000", "--------", "--------", X"0C", X"0C")
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: Sequencer PORT MAP (
		clk => clk,
		rst => rst,
		en => en,
		FETCH => FETCH,
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
	  wait for 100 ns;
	  rst <= '1';
	  en <= '1';	  
	  wait until rising_edge(clk);

		for i in test_data'range loop
		
			rst <= '0';
	
			-- assign test inputs
			instr <= test_data(i).instr;
			PC_plus <= test_data(i).PC_plus;
			flags <= test_data(i).flags;
			FETCH <= '1';

			wait for clk_period;
			FETCH <= '0';
			wait for 5*clk_period;

			-- Check to see if the out put was what we were expecting
			assert std_match(PC, test_data(i).PC)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual PC did not equal expected PC."&
			" Actual [ " & to_bstring(PC) & " ]" &
			" Expected [ " & to_bstring(test_data(i).PC) & " ]" & lf
			severity error;

			assert std_match(MIA, test_data(i).MIA)
			report lf & " [ERR!] Test " & integer'image(i)& 
			" Actual MIA did not equal expected MIA."&
			" Actual [ " & to_bstring(MIA) & " ]" &
			" Expected [ " & to_bstring(test_data(i).MIA) & " ]" & lf
			severity error;
			
			-- if there were no isses report that the test was successful
			assert not (std_match(PC, test_data(i).PC) and std_match(MIA, test_data(i).MIA))
			report lf & " [ OK ] Test " & integer'image(i)& " was successful!" & lf
			severity note;
			

		end loop;

		-- End of test
      wait;
   end process;

END;
