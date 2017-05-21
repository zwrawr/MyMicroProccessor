LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.easyprint.ALL;

ENTITY ProcessorTB IS
END ProcessorTB;
 
ARCHITECTURE behavior OF ProcessorTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Processor
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
         rst : IN  std_logic;
         start : IN  std_logic;
         data_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal rst : std_logic := '0';
   signal start : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
          clk => clk,
          en => en,
          rst => rst,
          start => start,
          data_out => data_out
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
	  
	 rst <= '1';
	 
	 wait until rising_edge(clk);

	 rst <= '0';
	 
	 en <= '1';
	 
      wait;
   end process;

END;
