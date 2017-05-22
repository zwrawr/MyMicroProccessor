LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.easyprint.ALL;
 
ENTITY OutputRegTB IS
END OutputRegTB;
 
ARCHITECTURE behavior OF OutputRegTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT OutputReg
    PORT(
         clk : IN  std_logic;
         data_in : IN  std_logic_vector(15 downto 0);
         WE : IN  std_logic;
         data_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal data_in : std_logic_vector(15 downto 0) := (others => '0');
   signal WE : std_logic := '0';
   signal data_out : std_logic_vector(15 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: OutputReg PORT MAP (
          clk => clk,
          data_in => data_in,
          WE => WE,
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

      wait for clk_period*10;

      -- insert stimulus here 
	  WE <= '1';
	  data_in <= "1100110011001100";
	  wait for clk_period;
	  
	  assert std_match(data_out, "1100110011001100")
	  report lf &
	  "DATA IN/DATA OUT BROKED"
	  severity error;
	  
	  assert not std_match(data_out, "1100110011001100")
	  report lf &
	  "DATA IN/DATA OUT WORKS"
	  severity note;
	  
	  WE <= '0';
	  data_in <= "0011100000111111";
	  wait for clk_period;
	  
	  assert std_match(data_out, "1100110011001100")
	  report lf &
	  "WE BROKED"
	  severity error;
	  
	  assert not std_match(data_out, "1100110011001100")
	  report lf &
	  "WE Works"
	  severity note;
	  
      wait;
   end process;

END;
