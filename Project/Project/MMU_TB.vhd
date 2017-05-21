LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.easyprint.ALL;
 
ENTITY MMU_TB IS
END MMU_TB;
 
ARCHITECTURE behavior OF MMU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MMU
    PORT(
         clk : IN  std_logic;
         I_addr : IN  std_logic_vector(7 downto 0);
         OEn : IN  std_logic;
         D_in : IN  std_logic_vector(15 downto 0);
         D_out : OUT  std_logic_vector(15 downto 0);
         D_addr : IN  std_logic_vector(15 downto 0);
         start : IN  std_logic;
         oWE : OUT  std_logic;
         oD_out : OUT  std_logic_vector(15 downto 0);
         mWE : OUT  std_logic;
         mD_addr : OUT  std_logic_vector(6 downto 0);
         mD_in : IN  std_logic_vector(31 downto 0);
         mD_out : OUT  std_logic_vector(31 downto 0);
         mI_addr : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal I_addr : std_logic_vector(7 downto 0) := (others => '0');
   signal OEn : std_logic := '0';
   signal D_in : std_logic_vector(15 downto 0) := (others => '0');
   signal D_addr : std_logic_vector(15 downto 0) := (others => '0');
   signal start : std_logic := '0';
   signal mD_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal D_out : std_logic_vector(15 downto 0);
   signal oWE : std_logic;
   signal oD_out : std_logic_vector(15 downto 0);
   signal mWE : std_logic;
   signal mD_addr : std_logic_vector(6 downto 0);
   signal mD_out : std_logic_vector(31 downto 0);
   signal mI_addr : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
	-- Test Data
	type TEST_RECORD is record
	
		--Inputs
		I_addr : std_logic_vector(7 downto 0);
		OEn : std_logic;
		D_in : std_logic_vector(15 downto 0);
		D_addr : std_logic_vector(15 downto 0);
		start : std_logic;
		mD_in : std_logic_vector(31 downto 0);

		--Outputs
		D_out : std_logic_vector(15 downto 0);
		oWE : std_logic;
		oD_out : std_logic_vector(15 downto 0);
		mWE : std_logic;
		mD_addr : std_logic_vector(6 downto 0);
		mD_out : std_logic_vector(31 downto 0);
		mI_addr : std_logic_vector(6 downto 0);
		
	end record TEST_RECORD;
	
	type TEST_RECORD_ARRAY is array (NATURAL range <>) of TEST_RECORD;

	constant test_data : TEST_RECORD_ARRAY := (
	--	 I_addr,	 Oen,  D_in,              	D_addr,   Start, mD_in,       D_out,   oWE, oD_out,             mWE, mD_addr, 	mD_out,								mI_addr
		("01010101", '0' , "----------------", 	X"007e", '0',   X"00FF00FF", X"00FF", 			 '0', "----------------", '0', "1111111",  "--------------------------------", "1010101"),
		("11010101", '1' , "----------------", 	X"007e", '0',   X"00FF00FF", "----------------", '0', "----------------", '1', "1111111",  X"00FF00EE", 						"1010101"),
		
	--	 I_addr,	 Oen,	D_in,    			D_addr,  Start,	mD_in,       						D_out,   							oWE, oD_out,  mWE, mD_addr,	   mD_out,			  mI_addr
		("11011111", '1',	X"00CC", 			X"01F8", '0',	"--------------------------------", "----------------", '1', X"00CC", '0', "-------", "--------------------------------", "1011111"),
	--	 I_addr,	 Oen, D_in,    			  D_addr,  Start,	mD_in,       						D_out,   oWE, oD_out,  			  mWE, mD_addr,	  mD_out,							  mI_addr	
		("01110111", '0', "----------------", X"01F0", '1', 	"--------------------------------", X"FFFF", '0', "----------------", '0', "-------", "--------------------------------", "1110111"),
		("01110111", '0', "----------------", X"01F0", '0', 	"--------------------------------", X"0000", '0', "----------------", '0', "-------", "--------------------------------", "1110111")
		);


BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MMU PORT MAP (
          clk => clk,
          I_addr => I_addr,
          OEn => OEn,
          D_in => D_in,
          D_out => D_out,
          D_addr => D_addr,
          start => start,
          oWE => oWE,
          oD_out => oD_out,
          mWE => mWE,
          mD_addr => mD_addr,
          mD_in => mD_in,
          mD_out => mD_out,
          mI_addr => mI_addr
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

	  wait until rising_edge(clk);

	  for i in test_data'range loop

		-- assign test inputs
		I_addr <= test_data(i).I_addr;
		OEn <= test_data(i).OEn;
		D_in <= test_data(i).D_in;
		D_addr <= test_data(i).D_addr;
		start <= test_data(i).start;
		mD_in <= test_data(i).mD_in;

		wait until falling_edge(clk);

		-- Check to see if the out put was what we were expecting
		
		assert std_match(D_out, test_data(i).D_out)
		report lf & " [ERR!] Test " & integer'image(i)& 
		" Actual D_out did not equal expected D_out."&
		" Actual [ " & to_bstring(D_out) & " ]" &
		" Expected [ " & to_bstring(test_data(i).D_out) & " ]" & lf
		severity error;
		
		assert std_match(oWE, test_data(i).oWE)
		report lf & " [ERR!] Test " & integer'image(i)& 
		" Actual oWE did not equal expected oWE."&
		" Actual [ " & to_bstring(oWE) & " ]" &
		" Expected [ " & to_bstring(test_data(i).oWE) & " ]" & lf
		severity error;
		
		assert std_match(mWE, test_data(i).mWE)
		report lf & " [ERR!] Test " & integer'image(i)& 
		" Actual mWE did not equal expected mWE."&
		" Actual [ " & to_bstring(mWE) & " ]" &
		" Expected [ " & to_bstring(test_data(i).mWE) & " ]" & lf
		severity error;
		
		assert std_match(mD_addr, test_data(i).mD_addr)
		report lf & " [ERR!] Test " & integer'image(i)& 
		" Actual mD_addr did not equal expected mD_addr."&
		" Actual [ " & to_bstring(mD_addr) & " ]" &
		" Expected [ " & to_bstring(test_data(i).mD_addr) & " ]" & lf
		severity error;
		
		assert std_match(mD_out, test_data(i).mD_out)
		report lf & " [ERR!] Test " & integer'image(i)& 
		" Actual mD_out did not equal expected mD_out."&
		" Actual [ " & to_bstring(mD_out) & " ]" &
		" Expected [ " & to_bstring(test_data(i).mD_out) & " ]" & lf
		severity error;
		
		assert std_match(mI_addr, test_data(i).mI_addr)
		report lf & " [ERR!] Test " & integer'image(i)& 
		" Actual mI_addr did not equal expected mI_addr."&
		" Actual [ " & to_bstring(mI_addr) & " ]" &
		" Expected [ " & to_bstring(test_data(i).mI_addr) & " ]" & lf
		severity error;
		
		-- if there were no isses report that the test was successful
		assert not (
			std_match(D_out, test_data(i).D_out) and
			std_match(oWE, test_data(i).oWE) and
			std_match(oD_out, test_data(i).oD_out) and
			std_match(mWE, test_data(i).mWE) and
			std_match(mD_addr, test_data(i).mD_addr) and
			std_match(mD_out, test_data(i).mD_out) and
			std_match(mI_addr, test_data(i).mI_addr)
		)
		report lf & " [ OK ] Test " & integer'image(i)& " was successful!" & lf
		severity note;
		wait until rising_edge(clk);

		end loop;
      wait;
   end process;

END;
