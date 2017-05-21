
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.easyprint.ALL;

 
ENTITY DualPortMemoryTB IS
END DualPortMemoryTB;
 
ARCHITECTURE behavior OF DualPortMemoryTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DualPortMemory
    PORT(
         clk : IN  std_logic;
         I_addr : IN  std_logic_vector(6 downto 0);
         D_addr : IN  std_logic_vector(6 downto 0);
         D_in : IN  std_logic_vector(31 downto 0);
         WE : IN  std_logic;
         D_out : OUT  std_logic_vector(31 downto 0);
         I_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal I_addr : std_logic_vector(6 downto 0) := (others => '0');
   signal D_addr : std_logic_vector(6 downto 0) := (others => '0');
   signal D_in : std_logic_vector(31 downto 0) := (others => '0');
   signal WE : std_logic := '0';

 	--Outputs
   signal D_out : std_logic_vector(31 downto 0);
   signal I_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DualPortMemory PORT MAP (
          clk => clk,
          I_addr => I_addr,
          D_addr => D_addr,
          D_in => D_in,
          WE => WE,
          D_out => D_out,
          I_out => I_out
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
	  
	  I_addr <= "0000100";
	  
	  wait for clk_period;
	  
	  assert std_match(I_out, X"00000100")
	  report lf &"BROKED"
	  severity error;
	  
	  
	  wait for clk_period;
	  
	  D_addr <= "0000010";
	  WE  <= '1';
	  D_in <= "00011000110011001100110101011110";

	  wait for clk_period;
	  
	  assert std_match(D_out, "00011000110011001100110101011110")
	  report lf & "BROKED"
	  severity error;
	  
      wait;
   end process;

END;
