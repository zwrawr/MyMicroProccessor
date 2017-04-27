LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
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
		clk : std_logic;
		
		instr : std_logic_vector(31 downto 0);
		PC_plus  : std_logic_vector(5 downto 0);
		flags : std_logic_vector(6 downto 0)
		
		PC : std_logic_vector(4 downto 1);
		MIA : std_logic_vector(7 downto 0);
		
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

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
